# Quick Start Guide - New Developer Setup

**Version:** 1.2.0  
**Last Updated:** 2025-12-10  
**Purpose:** Complete zero-to-hero guide for setting up the JL Dev Environment  
**Time Required:** ~45 minutes  

---

## Before You Begin

> ⚠️ **IMPORTANT:** Complete the Pre-Setup Checklist (sent via email - see `docs/PRE-SETUP-EMAIL.md`) before starting this guide. You should already have Cursor Pro, Docker Desktop, and GitHub org access.

### System Requirements

| Requirement | Minimum | How to Check |
|-------------|---------|--------------|
| macOS | 14.0+ (Sonoma) | `sw_vers` |
| Apple Silicon | M1/M2/M3 | `uname -m` (should show `arm64`) |
| Admin access | Required | Can you run `sudo`? |
| Disk space | 20GB free | Check in System Settings |
| Internet | Stable connection | For downloads |

### Required Accounts (Get These First!)

| Service | Requirement | How to Get Access |
|---------|-------------|-------------------|
| **Cursor Pro** | **REQUIRED** ($20/mo) | cursor.sh → Sign up → Upgrade to Pro |
| GitHub | Org membership | Accept invite to `Absolute-Space-GHCP` org |
| Google Cloud | Project access | Request access to `jlai-gm-v3` project |
| Slack | Workspace access | Join Johannes Leonardo workspace |

---

## Step 1: Install Prerequisites

Open **Terminal** (Applications → Utilities → Terminal) and run these commands.

### 1.1 Install Xcode Command Line Tools

**Check if already installed:**

```bash
xcode-select -p
```

If you see `/Library/Developer/CommandLineTools` or `/Applications/Xcode.app/Contents/Developer`, you're good. Skip to verification.

**If not installed (or you see an error):**

```bash
xcode-select --install
```

A popup will appear - click **Install** and wait for it to complete (~5-10 minutes).

**Verify installation:**

```bash
xcode-select -p && git --version
```

Should show the developer path and Git version.

**Update to latest (if already installed):**

```bash
softwareupdate --list
```

If you see Command Line Tools updates available:

```bash
softwareupdate --install "Command Line Tools for Xcode-XX.X"
```

(Replace XX.X with the version number shown)

---

### 1.2 Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**⚠️ APPLE SILICON REQUIRED STEP:** After install completes, run these two commands:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
```

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

**Verify it works:**

```bash
brew --version
```

You should see `Homebrew 5.x.x`. If you see "command not found", repeat the Apple Silicon step above.

### 1.3 Install Google Cloud CLI and GitHub CLI

```bash
brew install google-cloud-sdk gh
```

**Verify both installed:**

```bash
gcloud --version
```

```bash
gh --version
```

### 1.4 Verify Python

macOS 14+ includes Python 3. Verify it's available:

```bash
python3 --version
```

Should show Python 3.9+. If not found or you need a specific version:

```bash
brew install python@3.11
```

### 1.5 Authenticate GitHub (Do This Before Cloning!)

```bash
gh auth login
```

When prompted, select:
- **GitHub.com**
- **HTTPS**
- **Yes** (authenticate Git with GitHub credentials)
- **Login with a web browser**

Complete the browser flow, then verify:

```bash
gh auth status
```

### 1.6 Install IDE: Cursor (Recommended) or VS Code

> **💡 Recommendation:** After testing 5+ different workflows, we recommend **Cursor with Claude Opus 4.5** for the optimal development experience. However, VS Code is fully supported if you prefer it.

**Option A: Cursor (Recommended)**

```bash
brew install --cask cursor
```

Or download from: https://cursor.sh

**After install:**
- Launch Cursor
- Sign up / Sign in
- **Upgrade to Pro tier** ($20/mo) - required for Claude Opus 4.5 access

**Verify:**

```bash
ls /Applications/Cursor.app && echo "Cursor: ✓ Installed"
```

**Option B: VS Code (Alternative)**

```bash
brew install --cask visual-studio-code
```

Or download from: https://code.visualstudio.com

**Verify:**

```bash
ls /Applications/Visual\ Studio\ Code.app && echo "VS Code: ✓ Installed"
```

> **Note:** If using VS Code, replace `cursor` with `code` in all extension install commands throughout this guide. AI features will depend on extensions you install (Continue, GitHub Copilot, etc.) rather than built-in Claude access.

---

### 1.7 Install and Configure Docker Desktop

**Install Docker Desktop:**

```bash
brew install --cask docker
```

Or download from: https://www.docker.com/products/docker-desktop/

**First-time setup:**

1. Launch Docker Desktop from Applications
2. Accept the Terms of Service
3. Grant system permissions when prompted (Docker needs privileged access)
4. Wait for Docker to start (whale icon in menu bar stops animating)

**Sign in (Recommended):**

1. Click the Docker whale icon in menu bar → **Sign in**
2. Create a Docker Hub account or sign in: https://hub.docker.com
3. This enables pulling private images and higher rate limits

**Verify Docker is running:**

```bash
docker --version
```

```bash
docker run hello-world
```

Should show Docker version and successfully pull/run the hello-world container.

**Configure Docker resources (Optional but recommended for dev work):**

1. Click Docker whale icon → **Settings** (gear icon)
2. Go to **Resources** → **Advanced**
3. Recommended settings for M-series Macs:
   - CPUs: 4+
   - Memory: 8GB+
   - Swap: 1GB
   - Disk image size: 60GB+
4. Click **Apply & Restart**

---

### 1.8 Install Kubernetes Tools (kubectl)

kubectl comes bundled with Docker Desktop. Enable it:

1. Click Docker whale icon → **Settings**
2. Go to **Kubernetes**
3. Check **Enable Kubernetes**
4. Click **Apply & Restart** (this takes a few minutes)

**Verify kubectl:**

```bash
kubectl version --client
```

```bash
kubectl config current-context
```

Should show client version and `docker-desktop` context.

> **Note:** Full Kubernetes configuration will be covered separately. This just ensures the tools are installed.

---

## Step 2: Clone the Repository

> **⚠️ IMPORTANT:** Use the standard project path structure below. The validation script checks for this path.

```bash
mkdir -p ~/dev/ai-agents-and-apps-dev && cd ~/dev/ai-agents-and-apps-dev
```

```bash
git clone https://github.com/Absolute-Space-GHCP/jl-dev-environment-gm-v1.0.git
```

```bash
cd jl-dev-environment-gm-v1.0
```

**Verify you're in the correct location:**

```bash
pwd
# Expected: /Users/<your-username>/dev/ai-agents-and-apps-dev/jl-dev-environment-gm-v1.0
```

**Verify you're on the correct version:**

```bash
git log --oneline -1
```

---

## Step 3: Run Bootstrap Script

This script installs: nvm, Node.js, SDKMAN, Java, and configures your shell.

```bash
./scripts/bootstrap.sh
```

Follow any prompts. When complete:

**⚠️ REQUIRED: Reload your shell configuration:**

```bash
source ~/.zshrc
```

**Verify everything installed:**

```bash
nvm --version
```

```bash
node --version
```

```bash
sdk version
```

```bash
java -version
```

Expected: nvm 0.40+, Node v22+, SDKMAN 5.x, Java 21

> **Tip:** If you have issues with nvm, `fnm` (Fast Node Manager) is an alternative: `brew install fnm`

---

## Step 4: Install Cursor Extensions

**For Cursor users:**

```bash
grep -v '^#' config/cursor/extensions.txt | grep -v '^$' | xargs -L1 cursor --install-extension
```

**For VS Code users:**

```bash
grep -v '^#' config/cursor/extensions.txt | grep -v '^$' | xargs -L1 code --install-extension
```

This installs all 17 required extensions (some are bundles that install additional tools). You'll see output for each one.

---

## Step 5: Authenticate Google Cloud

```bash
gcloud auth login
```

Browser will open - sign in with your **@johannesleonardo.com** account.

```bash
gcloud config set project jlai-gm-v3
```

```bash
gcloud auth application-default login --project=jlai-gm-v3
```

**Verify:**

```bash
gcloud auth list
```

```bash
gcloud config get-value project
```

Should show your email and `jlai-gm-v3`.

---

## Step 6: Configure Continue (Gemini AI)

Update the Continue config with your project ID:

```bash
sed -i '' 's/YOUR_PROJECT_ID/jlai-gm-v3/g' ~/.continue/config.json
```

**Verify the update:**

```bash
grep projectId ~/.continue/config.json
```

Should show `jlai-gm-v3` in all four places (Gemini 3 Pro, Gemini 2.5 Pro, Gemini 2.5 Flash, and autocomplete model).

---

## Step 7: Clone the AI Agents Repository

```bash
cd ~/dev/ai-agents-and-apps-dev
```

```bash
git clone https://github.com/Absolute-Space-GHCP/ai-agents-gmaster-build.git
```

---

## Step 8: Set Up Multi-Root Workspace

Create the workspace file:

```bash
cd ~/dev/ai-agents-and-apps-dev
```

```bash
cat > absolute-space-ghcp.code-workspace << 'ENDOFFILE'
{
  "folders": [
    {
      "name": "jl-dev-environment-gm-v1.0",
      "path": "jl-dev-environment-gm-v1.0"
    },
    {
      "name": "ai-agents-gmaster-build",
      "path": "ai-agents-gmaster-build"
    }
  ],
  "settings": {
    "window.title": "Absolute-Space-GHCP | ${activeEditorShort}${separator}${rootName}",
    "workbench.colorCustomizations": {
      "titleBar.activeBackground": "#1a1a2e",
      "titleBar.activeForeground": "#ffffff"
    },
    "continue.enableTabAutocomplete": true,
    "editor.formatOnSave": true,
    "files.autoSave": "afterDelay"
  },
  "extensions": {
    "recommendations": [
      "Continue.continue",
      "anthropic.claude-code",
      "eamodio.gitlens",
      "ms-python.python",
      "dbaeumer.vscode-eslint",
      "humao.rest-client"
    ]
  }
}
ENDOFFILE
```

**Verify it was created:**

```bash
ls -la ~/dev/ai-agents-and-apps-dev/absolute-space-ghcp.code-workspace
```

---

## Step 9: Validate Your Setup

```bash
cd ~/dev/ai-agents-and-apps-dev/jl-dev-environment-gm-v1.0
```

```bash
./scripts/validate.sh
```

**Expected result:** 19 passed, 0 failed

### Troubleshooting Failed Checks

| Failed Check | Solution |
|--------------|----------|
| Workspace path | Re-clone to `~/dev/ai-agents-and-apps-dev/` |
| Homebrew | Run: `eval "$(/opt/homebrew/bin/brew shellenv)"` |
| nvm | Run: `source ~/.zshrc` |
| Node.js | Run: `source ~/.nvm/nvm.sh && nvm install --lts` |
| Java | Run: `source ~/.sdkman/bin/sdkman-init.sh` |
| Docker | Launch Docker Desktop app from Applications |
| gcloud | Re-run: `gcloud auth login` |
| GCP ADC | Re-run: `gcloud auth application-default login` |
| Continue config | Check `~/.continue/config.json` exists |

---

## Step 10: Open Workspace and Test

```bash
open ~/dev/ai-agents-and-apps-dev/absolute-space-ghcp.code-workspace
```

Cursor will launch with both projects loaded.

> **Note:** If you see a "Reopen in Container" prompt, click **"Don't Show Again"** or close it. Dev container setup is an optional alternative (see below).

### Test Claude (Primary AI)

1. Press `Cmd+L` to open AI chat
2. Type: "Hello, what files are in this project?"
3. Claude Opus 4.5 should respond with project contents

### Test Gemini (via Continue - Optional)

1. Look for the Continue icon in the left sidebar (or `Cmd+Shift+P` → "Continue: Focus")
2. Select a Gemini model from the dropdown
3. Test with: "Hello, what model are you?"

### Alternative: Dev Container Setup

If you prefer a fully containerized development environment, see `docs/DOCKER.md` for dev container instructions. This provides an identical environment that runs inside Docker.

---

## You're Done! 🎉

Your environment now includes:

- **IDE:** Cursor with 17+ extensions
- **AI:** Claude Opus 4.5 (primary), Gemini models (via Continue)
- **Runtimes:** Node.js 22+ LTS, Java 21 LTS, Python 3.9+
- **DevOps:** Docker, kubectl, gcloud, gh CLI
- **Projects:** jl-dev-environment-gm-v1.0, ai-agents-gmaster-build

### Daily Workflow

Open the workspace:

```bash
open ~/dev/ai-agents-and-apps-dev/absolute-space-ghcp.code-workspace
```

### Optional: Shell Aliases

See `config/shell/.zshrc.template` for useful shell aliases and environment variables you can add to your `~/.zshrc`.

### Getting Help

- **AI Assistance:** `Cmd+L` in Cursor → Ask Claude
- **Build details:** `docs/BUILD.md`
- **Auth reference:** `docs/AUTH.md`
- **Docker setup:** `docs/DOCKER.md`
- **Roadmap:** `TODO.md`
- **Changelog:** `CHANGELOG.md`

---

## Quick Reference Card

```bash
# Open workspace
open ~/dev/ai-agents-and-apps-dev/absolute-space-ghcp.code-workspace

# Validate setup
./scripts/validate.sh

# Start dashboard
./scripts/utils/dashboard.sh

# Update extensions (Cursor)
grep -v '^#' config/cursor/extensions.txt | grep -v '^$' | xargs -L1 cursor --install-extension

# Update extensions (VS Code)
grep -v '^#' config/cursor/extensions.txt | grep -v '^$' | xargs -L1 code --install-extension

# Refresh GCP auth
gcloud auth login && gcloud auth application-default login

# Check GitHub auth
gh auth status

# Reload shell config
source ~/.zshrc
```

---

**Maintained by:** JL Engineering Team  
**Last Validated:** 2025-12-10 on MacBook Air M3
