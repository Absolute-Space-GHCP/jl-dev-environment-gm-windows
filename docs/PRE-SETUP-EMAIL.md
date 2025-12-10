# Pre-Setup Email Template

**Version:** 1.0.0  
**Last Updated:** 2025-12-10  
**Subject Line:** Dev Environment Setup - Pre-Requisites (Action Required Before [DATE])

---

Hi [NAME],

Welcome to the team! Before your dev environment setup session on **[DATE]**, please complete the following prerequisites. This should take about 15-20 minutes and will make your setup go smoothly.

---

## 1. IDE: Cursor (Recommended) or VS Code

> **💡 We recommend Cursor with Pro tier** for the best AI-assisted development experience (Claude Opus 4.5). VS Code is supported if you prefer it.

**Option A: Cursor (Recommended)**

**Download & Install:**  
https://cursor.sh

**Create Account & Upgrade to Pro:**
- Sign up for a Cursor account
- Upgrade to **Pro tier** ($20/month) - required for Claude Opus 4.5 access
- Expense this to IT/Engineering

**Verify:** Open Cursor → Press `Cmd+L` → Confirm you see the AI chat panel

**Option B: VS Code (Alternative)**

**Download & Install:**  
https://code.visualstudio.com

**Verify:** Open VS Code → Confirm it launches

> Note: If using VS Code, you'll configure AI assistants via extensions during setup.

---

## 2. Docker Desktop (Required)

**Download & Install:**  
https://www.docker.com/products/docker-desktop/

**After Install - Complete These Steps:**
1. Launch Docker Desktop from Applications
2. Accept the Terms of Service when prompted
3. Grant system permissions (Docker needs privileged access)
4. Wait for Docker to fully start (whale icon in menu bar stops animating)
5. **Recommended:** Sign in to Docker Hub (create free account at https://hub.docker.com)

**Verify:** 
- Docker whale icon appears in your Mac's top menu bar
- Icon is steady (not animating)
- Open Terminal and run: `docker --version`

---

## 3. GitHub Access (Required)

**Send me your GitHub username** and I'll add you to our organization.

**Once you receive the invite:**
- Check your email for the GitHub org invite
- Accept the invite to `Absolute-Space-GHCP`

**Verify:** You can see https://github.com/Absolute-Space-GHCP (may show as private until you accept)

---

## 4. Google Cloud Access (Required)

**Request access to our GCP project:**
- Project name: `jlai-gm-v3`
- Use your **@johannesleonardo.com** email
- I'll grant you access - you'll get an email confirmation

---

## 5. Slack (If Not Already)

Join the Johannes Leonardo Slack workspace if you haven't already.

**Channel to join:** `#dev-environment` (for setup questions)

---

## System Requirements

Please confirm your Mac meets these requirements:

| Requirement | Check |
|-------------|-------|
| macOS 14.0+ (Sonoma or newer) | System Settings → General → About |
| Apple Silicon (M1/M2/M3) | Apple menu → About This Mac |
| 20GB free disk space | System Settings → General → Storage |
| Admin access | Can you install apps? |

---

## What to Expect on Setup Day

- **Time:** ~45 minutes
- **Location:** We can do this in person or via screen share
- **Bring:** Your Mac with all the above installed, stable internet connection

The setup guide will walk through:
1. Installing development tools (Homebrew, Node.js, Java, Python verification, etc.)
2. Cloning project repositories
3. Configuring AI assistants
4. Validating everything works

---

## Questions?

Slack me in `#dev-environment` or reply to this email.

Looking forward to getting you set up!

Best,  
[YOUR NAME]

---

## Quick Checklist

Before setup day, confirm:

- [ ] IDE installed (Cursor Pro recommended, or VS Code)
- [ ] Docker Desktop installed and running
- [ ] GitHub org invite accepted
- [ ] GCP project access confirmed
- [ ] Mac meets system requirements
- [ ] Xcode Command Line Tools (will be installed during setup if missing)

---

**Template maintained by:** JL Engineering Team
