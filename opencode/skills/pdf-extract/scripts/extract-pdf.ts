#!/usr/bin/env bun
// pdf-extract: PDF → PNG (pdftoppm) → Ollama vision → JSON to stdout

import { mkdtemp, readdir, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";

const log = console.error;
const MODEL = process.env.OLLAMA_MODEL ?? "gemma4:26b";
const BASE_URL = (process.env.OLLAMA_BASE_URL ?? "http://localhost:11434/v1").replace(/\/+$/, "");
const DPI = process.env.EXTRACT_DPI ?? "200";
const EXTRACT_PROMPT = process.env.EXTRACT_PROMPT ?? "Extract all text and structured information from this document image. For invoices/receipts, return: vendor name, date, invoice/receipt number, line items (description, quantity, unit price, total), subtotal, tax, and grand total. For other documents, return the full text content preserving structure (headings, lists, tables). Respond with the extracted data only — no commentary.";

async function ensurePdftoppm() {
	const code = await Bun.spawn(["which", "pdftoppm"], { stdout: "pipe", stderr: "pipe" }).exited;
	if (code !== 0) { log("Error: pdftoppm not found (install poppler)"); process.exit(1); }
}

async function pdfToImages(pdfPath: string): Promise<string[]> {
	const tempDir = await mkdtemp(join(tmpdir(), "pdf-extract-"));
	const proc = Bun.spawn(["pdftoppm", "-png", "-r", DPI, pdfPath, join(tempDir, "page")], { stdout: "pipe", stderr: "pipe" });
	const code = await proc.exited;
	if (code !== 0) throw new Error(`pdftoppm failed: ${await new Response(proc.stderr).text()}`);
	return (await readdir(tempDir)).filter(f => f.endsWith(".png")).sort().map(f => join(tempDir, f));
}

function stripThinking(text: string) {
	return text.replace(/<\|channel>thought[\s\S]*?<channel\|>\s*/g, "").trim();
}

async function extractFromImage(base64Png: string): Promise<string> {
	const resp = await fetch(`${BASE_URL}/chat/completions`, {
		method: "POST",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify({
			model: MODEL, temperature: 0.1, max_tokens: 4096,
			messages: [{ role: "user", content: [
				{ type: "text", text: EXTRACT_PROMPT },
				{ type: "image_url", image_url: { url: `data:image/png;base64,${base64Png}` } },
			]}],
		}),
	});
	if (!resp.ok) throw new Error(`Ollama API error (${resp.status}): ${await resp.text()}`);
	const data = await resp.json() as any;
	if (data.error) throw new Error(`Ollama error: ${data.error}`);
	return stripThinking(data.choices?.[0]?.message?.content?.trim() ?? "");
}

const pdfPaths = process.argv.slice(2);
if (pdfPaths.length === 0) { log("Usage: bun run extract-pdf.ts <file.pdf> [...]"); process.exit(1); }
await ensurePdftoppm();

const results: { file: string; pages: { page: number; content: string }[] }[] = [];

for (const pdfPath of pdfPaths) {
	if (!(await Bun.file(pdfPath).exists())) { log(`Warning: ${pdfPath} not found, skipping.`); continue; }
	log(`Processing: ${pdfPath}`);
	let imagePaths: string[] = [];
	try {
		imagePaths = await pdfToImages(pdfPath);
		log(`  → ${imagePaths.length} page(s) at ${DPI} DPI`);
		const pages: { page: number; content: string }[] = [];
		for (let i = 0; i < imagePaths.length; i++) {
			log(`  → Page ${i + 1}/${imagePaths.length} via ${MODEL}...`);
			const base64 = Buffer.from(await Bun.file(imagePaths[i]).arrayBuffer()).toString("base64");
			pages.push({ page: i + 1, content: await extractFromImage(base64) });
		}
		results.push({ file: pdfPath, pages });
	} finally {
		if (imagePaths.length > 0) await rm(join(imagePaths[0], ".."), { recursive: true, force: true }).catch(() => {});
	}
}

console.log(JSON.stringify(results, null, 2));
