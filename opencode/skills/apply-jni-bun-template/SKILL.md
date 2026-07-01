---
name: apply-jni-bun-template
description: >
  Create a new Bun/TypeScript project from the jni-bun-template
  (https://github.com/mopore/jni-bun-template) in the current directory. Derives the project
  name from the current folder name, applies the template, replaces all template references,
  initializes git, then asks whether to push to GitHub (private), to the self-hosted Forgejo
  instance at forgejo.mopore.org (private), or to keep it local only. Use when the user says
  "create bun project", "new project from template", "apply template", "bootstrap from
  jni-bun-template", "init bun project", "create forgejo repo from template",
  "create local bun project", or similar.
---

# Apply JNI's Bun Template

Creates a new project based on https://github.com/mopore/jni-bun-template in the current
directory. The current folder name becomes the project name.

## Prerequisites

**Common (all paths)**
- `git` and `bun` are available on PATH.
- The current directory should be empty (or nearly empty). Warn if it contains existing files.

**GitHub path only**
- `gh` (GitHub CLI) is installed and authenticated.

**Forgejo path only**
- `curl` and `jq` are available on PATH.
- The machine is on the LAN or connected via WireGuard (must reach `quieter2:2222`).
- The environment variable `FORGEJO_APPLY_BUN_TEMPLATE_TOKEN` is set.
  If it is not set, **stop immediately** and tell the user:
  1. Create a token in Forgejo: *Settings → Applications → Generate Token*
     with scopes `write:repository`, `read:organization`, `read:user`.
  2. Add it to `$ZSH_CUSTOM/extra_envs.zsh`:
     ```zsh
     export FORGEJO_APPLY_BUN_TEMPLATE_TOKEN='<paste token here>'
     ```
  3. Restart the shell (or `source $ZSH_CUSTOM/extra_envs.zsh`), then retry.

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

### 10. Choose git host

Ask the user where to push the project (use the `question` tool):

- **GitHub** — create a private repo on github.com/mopore and push.
- **Forgejo (self-hosted)** — create a private repo on forgejo.mopore.org and push.
- **Local only** — no remote; stay local.

### 11. Create remote repo and push

Proceed based on the choice in step 10.

---

#### Branch A — GitHub

**Before pushing, confirm with the user** (per policy: always request approval before pushing).

```bash
gh repo create "$PROJECT_NAME" --private --source=. --remote=origin
git push --set-upstream origin main
```

---

#### Branch B — Forgejo (self-hosted)

**B1. Token guard**

```bash
if [ -z "${FORGEJO_APPLY_BUN_TEMPLATE_TOKEN}" ]; then
  echo "ERROR: FORGEJO_APPLY_BUN_TEMPLATE_TOKEN is not set."
  # Stop and show setup instructions (see Prerequisites above).
fi
```

**B2. Connectivity guard**

```bash
nc -vz quieter2 2222
```

If this fails, tell the user the machine cannot reach `quieter2:2222` — check LAN or WireGuard.

**B3. Owner prompt**

Ask the user which Forgejo owner to use (default: **`mopore`** org):
- `mopore` (org) — default
- `jni` (personal user)

Set `OWNER` to the chosen value.

**B4. Create private repo via Forgejo REST API**

Set the API endpoint based on owner type:
- org (`mopore`): `API_URL="https://forgejo.mopore.org/api/v1/orgs/${OWNER}/repos"`
- user (`jni`):   `API_URL="https://forgejo.mopore.org/api/v1/user/repos"`

```bash
HTTP_CODE=$(curl -s -o /tmp/forgejo-create-resp.$$ -w '%{http_code}' \
  -X POST \
  -H "Authorization: token ${FORGEJO_APPLY_BUN_TEMPLATE_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"${PROJECT_NAME}\",\"private\":true,\"default_branch\":\"main\"}" \
  "$API_URL")

case "$HTTP_CODE" in
  201) echo "Repo created." ;;
  409) echo "Repo already exists on Forgejo — will add remote and push to it." ;;
  *)
    echo "ERROR: Forgejo API returned HTTP ${HTTP_CODE}:"
    cat /tmp/forgejo-create-resp.$$
    exit 1
    ;;
esac
rm -f /tmp/forgejo-create-resp.$$
```

**B5. Add remote and push**

**Before pushing, confirm with the user** (per policy: always request approval before pushing).

```bash
# IMPORTANT: always use the full ssh:// URL — the quieter2 ssh-config alias
# uses port 992 (shell access), NOT the git-over-SSH port 2222.
git remote add origin "ssh://git@quieter2:2222/${OWNER}/${PROJECT_NAME}.git"
git push --set-upstream origin main
```

---

#### Branch C — Local only

No remote is created. The `git init` and initial commit from steps 2 and 9 are already done.
Tell the user the project is local-only and they can add a remote manually later when needed.

---

### 12. Report

Print a summary matching the chosen path:

**GitHub:**
```
=== Project created ===
Project:   $PROJECT_NAME
GitHub:    https://github.com/mopore/$PROJECT_NAME
```

**Forgejo:**
```
=== Project created ===
Project:   $PROJECT_NAME
Forgejo:   https://forgejo.mopore.org/$OWNER/$PROJECT_NAME
Clone:     ssh://git@quieter2:2222/$OWNER/$PROJECT_NAME.git
```

**Local only:**
```
=== Project created (local) ===
Project:   $PROJECT_NAME
Remote:    none — add one manually when needed
```

## Post-creation checklist (tell the user)

Remind the user to:

1. **Update `package.json` description** to match the project's purpose.
2. **Update `README.md`** — still contains the template's documentation.
3. **Update `AGENTS.md`** — the `Project Overview` section still describes the template.
4. **Update `docker-compose.yaml`** — verify the registry path (`forgejo.mopore.org/mopore/…`).
5. **Verify** with `bun run lint && bun run test`.

## Important notes

- The template uses **tabs (width 4)** for indentation — see `.editorconfig`.
- Strict TypeScript with `noUncheckedIndexedAccess`.
- Error handling uses `Option<T>` and `Result<T,E>` monads — no raw `try/catch`.
- ESM only (`"type": "module"`) — no CommonJS.
- Do **not** add `.js` extensions to relative imports.
- Always use `bun` as the package manager, never npm/yarn/pnpm.
- Forgejo git-over-SSH **always** uses the explicit URL `ssh://git@quieter2:2222/<owner>/<repo>.git`.
  Never use the bare `quieter2` ssh-config alias for git — that alias resolves to port 992
  (shell access as user `jni`), not the Forgejo SSH port 2222 (git user).
