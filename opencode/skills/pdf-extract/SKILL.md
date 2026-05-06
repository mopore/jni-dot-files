---
name: pdf-extract
description: >
  Extract structured information from PDF files (invoices, receipts, contracts, reports) using a
  local vision LLM via Ollama. Fully offline. Use this skill whenever the user asks to read, parse,
  extract, or analyze content from one or more PDF files — especially when they mention invoices,
  receipts, bills, or any scanned/image-heavy documents. Also trigger when the user wants to
  summarize, compare, or tabulate data across multiple PDFs.
---

# PDF Extract (Offline, Bun + Ollama Vision)

Extracts text and structured data from PDFs by converting pages to images and sending them to a
local Ollama vision model. Zero npm dependencies — uses `pdftoppm` (poppler) and Bun builtins.

## Prerequisites

- **Bun** runtime
- **poppler** installed (`pdftoppm` must be on PATH)
  - Arch/Manjaro: `sudo pacman -S poppler`
  - Debian/Ubuntu: `sudo apt install poppler-utils`
  - macOS: `brew install poppler`
- **Ollama** running locally with a vision-capable model pulled:
  - `ollama pull gemma4:26b` (recommended) or `ollama pull qwen3-vl:32b`

## Usage

The extraction script lives at `scripts/extract-pdf.ts` relative to this skill's directory.

```bash
# Single PDF — returns extracted text/data to stdout as JSON
bun run <skill-dir>/scripts/extract-pdf.ts invoice.pdf

# Multiple PDFs
bun run <skill-dir>/scripts/extract-pdf.ts receipt1.pdf receipt2.pdf

# Custom prompt (override default extraction prompt)
EXTRACT_PROMPT="List all line items with amounts" \
  bun run <skill-dir>/scripts/extract-pdf.ts invoice.pdf

# Choose model (default: gemma4:26b)
OLLAMA_MODEL="qwen3-vl:32b" \
  bun run <skill-dir>/scripts/extract-pdf.ts invoice.pdf

# Custom Ollama endpoint (default: http://localhost:11434/v1)
OLLAMA_BASE_URL="http://192.168.1.50:11434/v1" \
  bun run <skill-dir>/scripts/extract-pdf.ts invoice.pdf

# DPI for rasterization (default: 200, increase for tiny text)
EXTRACT_DPI="300" \
  bun run <skill-dir>/scripts/extract-pdf.ts invoice.pdf
```

## Output Format

The script writes JSON to stdout — one object per PDF. Progress logs go to stderr.

```json
[
  {
    "file": "invoice.pdf",
    "pages": [
      { "page": 1, "content": "..." },
      { "page": 2, "content": "..." }
    ]
  }
]
```

Pipe or capture as needed:

```bash
# Save to file
bun run <skill-dir>/scripts/extract-pdf.ts *.pdf > results.json

# Pipe into jq
bun run <skill-dir>/scripts/extract-pdf.ts invoice.pdf | jq '.[0].pages[0].content'
```

## How It Works

1. For each PDF, runs `pdftoppm -png -r <DPI>` to rasterize pages into a temp directory.
2. Reads each PNG as base64.
3. Sends each image to the Ollama OpenAI-compatible vision endpoint (`/v1/chat/completions`).
4. Strips Gemma 4 thinking-channel tokens from output (transparent for other models).
5. Collects responses and outputs structured JSON.
6. Cleans up temp images.

## Integration Tips for the Agent

When the user asks to extract data from PDFs:

1. Run the script with the PDF path(s).
2. Capture the JSON output.
3. Post-process as needed (summarize, compare, tabulate, convert to CSV, etc.).

For structured extraction (e.g., "get invoice number, date, total, line items"), set `EXTRACT_PROMPT`
to a task-specific instruction — the default prompt is general-purpose.
