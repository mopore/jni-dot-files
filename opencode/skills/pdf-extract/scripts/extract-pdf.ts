#!/usr/bin/env bun

/**
 * pdf-extract: Offline PDF data extraction via Ollama vision models.
 *
 * Converts PDF pages to PNGs (pdftoppm), sends them to a local Ollama
 * vision model, and outputs structured JSON to stdout.
 *
 * Zero npm dependencies — uses only Bun builtins and `pdftoppm` (poppler).
 *
 * Environment variables:
 *   OLLAMA_MODEL      - Vision model to use (default: gemma4:26b)
 *   OLLAMA_BASE_URL   - Ollama OpenAI-compat base URL (default: http://localhost:11434/v1)
 *   EXTRACT_PROMPT    - Custom extraction prompt (default: general-purpose)
 *   EXTRACT_DPI       - Rasterization DPI (default: 200)
 */

import { mkdtemp, readdir, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";

// ---------------------------------------------------------------------------
// Config
// ---------------------------------------------------------------------------

const MODEL = process.env.OLLAMA_MODEL ?? "gemma4:26b";
const BASE_URL = (process.env.OLLAMA_BASE_URL ?? "http://localhost:11434/v1").replace(/\/+$/, "");
const DPI = process.env.EXTRACT_DPI ?? "200";

const DEFAULT_PROMPT = `Extract all text and structured information from this document image.
For invoices/receipts, return: vendor name, date, invoice/receipt number, line items (description, quantity, unit price, total), subtotal, tax, and grand total.
For other documents, return the full text content preserving structure (headings, lists, tables).
Respond with the extracted data only — no commentary.`;

const EXTRACT_PROMPT = process.env.EXTRACT_PROMPT ?? DEFAULT_PROMPT;

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

async function ensurePdftoppm(): Promise<void> {
	const proc = Bun.spawn(["which", "pdftoppm"], { stdout: "pipe", stderr: "pipe" });
	const code = await proc.exited;
	if (code !== 0) {
		console.error("Error: pdftoppm not found. Install poppler:");
		console.error("  Arch/Manjaro : sudo pacman -S poppler");
		console.error("  Debian/Ubuntu: sudo apt install poppler-utils");
		console.error("  macOS        : brew install poppler");
		process.exit(1);
	}
}

async function pdfToImages(pdfPath: string): Promise<string[]> {
	const tempDir = await mkdtemp(join(tmpdir(), "pdf-extract-"));
	const prefix = join(tempDir, "page");

	const proc = Bun.spawn(["pdftoppm", "-png", "-r", DPI, pdfPath, prefix], {
		stdout: "pipe",
		stderr: "pipe",
	});

	const code = await proc.exited;
	if (code !== 0) {
		const stderr = await new Response(proc.stderr).text();
		throw new Error(`pdftoppm failed for ${pdfPath}: ${stderr.trim()}`);
	}

	const files = await readdir(tempDir);
	const pngs = files
		.filter((f) => f.endsWith(".png"))
		.sort()
		.map((f) => join(tempDir, f));

	return pngs;
}

async function imageToBase64(imagePath: string): Promise<string> {
	const file = Bun.file(imagePath);
	const buffer = await file.arrayBuffer();
	return Buffer.from(buffer).toString("base64");
}

interface OllamaResponse {
	choices?: { message?: { content?: string } }[];
	error?: string;
}

async function extractFromImage(base64Png: string): Promise<string> {
	const body = {
		model: MODEL,
		messages: [
			{
				role: "user" as const,
				content: [
					{
						type: "text" as const,
						text: EXTRACT_PROMPT,
					},
					{
						type: "image_url" as const,
						image_url: {
							url: `data:image/png;base64,${base64Png}`,
						},
					},
				],
			},
		],
		temperature: 0.1,
		max_tokens: 4096,
	};

	const resp = await fetch(`${BASE_URL}/chat/completions`, {
		method: "POST",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(body),
	});

	if (!resp.ok) {
		const text = await resp.text();
		throw new Error(`Ollama API error (${resp.status}): ${text}`);
	}

	const data = (await resp.json()) as OllamaResponse;

	if (data.error) {
		throw new Error(`Ollama error: ${data.error}`);
	}

	const raw = data.choices?.[0]?.message?.content?.trim() ?? "";
	return stripThinkingTokens(raw);
}

/** Strip Gemma 4 thinking channel tokens from output */
function stripThinkingTokens(text: string): string {
	// Gemma 4 wraps thinking in <|channel>thought\n...\n<channel|> blocks
	return text
		.replace(/<\|channel>thought[\s\S]*?<channel\|>\s*/g, "")
		.trim();
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

const pdfPaths = process.argv.slice(2);

if (pdfPaths.length === 0) {
	console.error("Usage: bun run extract-pdf.ts <file1.pdf> [file2.pdf ...]");
	console.error("");
	console.error("Environment variables:");
	console.error("  OLLAMA_MODEL      Vision model (default: gemma4:26b)");
	console.error("  OLLAMA_BASE_URL   Ollama endpoint (default: http://localhost:11434/v1)");
	console.error("  EXTRACT_PROMPT    Custom extraction prompt");
	console.error("  EXTRACT_DPI       Rasterization DPI (default: 200)");
	process.exit(1);
}

await ensurePdftoppm();

const results: { file: string; pages: { page: number; content: string }[] }[] = [];

for (const pdfPath of pdfPaths) {
	const file = Bun.file(pdfPath);
	if (!(await file.exists())) {
		console.error(`Warning: ${pdfPath} not found, skipping.`);
		continue;
	}

	console.error(`Processing: ${pdfPath}`);
	let imagePaths: string[] = [];

	try {
		imagePaths = await pdfToImages(pdfPath);
		console.error(`  → ${imagePaths.length} page(s) rasterized at ${DPI} DPI`);

		const pages: { page: number; content: string }[] = [];

		for (let i = 0; i < imagePaths.length; i++) {
			const imgPath = imagePaths[i];
			console.error(`  → Extracting page ${i + 1}/${imagePaths.length} via ${MODEL}...`);
			const base64 = await imageToBase64(imgPath);
			const content = await extractFromImage(base64);
			pages.push({ page: i + 1, content });
		}

		results.push({ file: pdfPath, pages });
	} finally {
		// Clean up temp images
		if (imagePaths.length > 0) {
			const tempDir = join(imagePaths[0], "..");
			await rm(tempDir, { recursive: true, force: true }).catch(() => {});
		}
	}
}

// Output JSON to stdout (progress goes to stderr)
console.log(JSON.stringify(results, null, 2));
