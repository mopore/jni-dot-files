---
name: make-bun-project
description: >
  Create a new Bun/TypeScript project from the jni-bun-template
  (https://github.com/mopore/jni-bun-template) in the current directory. Derives the project
  name from the current folder name, applies the template, replaces all template references,
  initializes git, creates a private GitHub repo via `gh`, and pushes. Use when the user says
  "create bun project", "new project from template", "apply template", "bootstrap from
  jni-bun-template", "init bun project", or similar.
---

# Make Bun Project

Creates a new project based on https://github.com/mopore/jni-bun-template in the current
directory. The current folder name becomes the project name.

## Prerequisites

- `git`, `bun`, and `gh` (GitHub CLI, authenticated) are available on PATH.
- The current directory should be empty (or nearly empty). Warn if it contains existing files.

## Steps

### 1. Determine the project name from the current directory

```bash
PROJECT_NAME=$(basename "$(pwd)")
echo "Project name: $PROJECT_NAME"
```

If it contains spaces or uppercase, warn the user and suggest renaming the folder first.

### 2. Initialize git

```bash
git init
```

### 3. Clone the template into a temp directory

```bash
TEMPLATE_DIR=$(mktemp -d)
git clone --depth 1 https://github.com/mopore/jni-bun-template.git "$TEMPLATE_DIR"
rm -rf "$TEMPLATE_DIR/.git"
```

### 4. Copy template files

```bash
rsync -a --exclude='.git' "$TEMPLATE_DIR/" .
```

### 5. Replace `jni-bun-template` → `$PROJECT_NAME`

#### 5a. Bulk text replacement in all relevant files

```bash
find . -type f \
  \( -name '*.json' -o -name '*.yaml' -o -name '*.yml' \
     -o -name '*.md' -o -name '*.ts' -o -name '*.js' \
     -o -name 'Dockerfile' -o -name '.editorconfig' \) \
  ! -path './.git/*' \
  -exec sed -i "s/jni-bun-template/${PROJECT_NAME}/g" {} +
```

#### 5b. Rename the `.code-workspace` file

```bash
mv "jni-bun-template.code-workspace" "${PROJECT_NAME}.code-workspace"
```

### 6. Create `.env` file

```bash
cat > .env << 'EOF'
TEST_VAR='Test value'
TZ='UTC'
LOG_SETUP='dev'
EOF
```

Tell the user the `.env` file was created with default values.

### 7. Install dependencies

```bash
bun install
```

### 8. Clean up temp directory

```bash
rm -rf "$TEMPLATE_DIR"
```

### 9. Initial commit

```bash
git add -A
git commit -m "Initial commit from jni-bun-template"
```

### 10. Create GitHub repo and push

```bash
gh repo create "$PROJECT_NAME" --private --source=. --remote=origin
git push --set-upstream origin main
```

### 11. Report

Print a summary:

```
=== Project created ===
Project:   $PROJECT_NAME
GitHub:    https://github.com/mopore/$PROJECT_NAME
```

## Post-creation checklist (tell the user)

Remind the user to:

1. **Update `package.json` description** to match the project's purpose.
2. **Update `README.md`** — still contains the template's documentation.
3. **Update `AGENTS.md`** — the `Project Overview` section still describes the template.
4. **Update `docker-compose.yaml`** — verify the registry path (`registry.mopore.org/jni/…`).
5. **Verify** with `bun run lint && bun run test`.

## Important notes

- The template uses **tabs (width 4)** for indentation — see `.editorconfig`.
- Strict TypeScript with `noUncheckedIndexedAccess`.
- Error handling uses `Option<T>` and `Result<T,E>` monads — no raw `try/catch`.
- ESM only (`"type": "module"`) — no CommonJS.
- Do **not** add `.js` extensions to relative imports.
- Always use `bun` as the package manager, never npm/yarn/pnpm.
