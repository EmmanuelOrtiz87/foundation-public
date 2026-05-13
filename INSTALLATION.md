# Foundation — Installation Guide

## Distribution Model

Foundation is distributed as a **single installer**: `Foundation.exe`.

This file contains the **entire** stack (scripts, configurations, skills, launcher) **encrypted with AES-256** inside a professional NSIS installer wizard.

> 🔒 Without the **master.key**, encrypted scripts cannot be executed. Request it from the private repository `gentleman-foundation`.

---

## Installation (single step)

### Prerequisites

1. **`Foundation.exe`** — Download from the root of this repository
2. **`master.key`** — AES-256 key from the private repository (request access)

### Step 1: Download

Download `Foundation.exe` from the root of this repository:
https://github.com/EmmanuelOrtiz87/foundation-public

### Step 2: Run the Installer

1. **Right-click** → **Run as Administrator**
2. Follow the NSIS installer wizard
3. Default destination: `C:\Program Files\Foundation\`
4. The installer creates **Start Menu** and **Desktop** shortcuts

### Step 3: Obtain Master Key

Copy `keys/master.key` from the private repository to:
`C:\Program Files\Foundation\keys\master.key`

> 💡 If you run the launcher without the key, it will prompt you to paste the Base64 key and cache it automatically.

### Step 4: Run Foundation

Use the **Desktop** or **Start Menu** shortcut, or from the terminal:

```powershell
wf start-session     # Start session with persistent memory
wf judgment-day      # Verify everything is OK (14 gates)
wf version           # Show version and available skills
```

---

## Manual Bootstrap (Alternative)

For environments where the `.exe` cannot be run:

```powershell
git clone https://github.com/EmmanuelOrtiz87/foundation-public.git
cd foundation-public
.\scripts\foundation\bootstrap.ps1
```

> ℹ️ Manual bootstrap only sets up the basics. For the full stack, use `Foundation.exe`.

---

## Repository Structure

```
foundation-public/
├── Foundation.exe              # ← SINGLE installer (AES-256 encrypted, NSIS wizard)
├── protected/                  # Encrypted scripts (.enc)
│   ├── scripts/                #   Orchestrators, utilities, agents (.ps1.enc)
│   ├── config/                 #   Routing and agent configs (.json.enc)
│   └── skills/                 #   Complete skills (SKILL.md + .enc)
├── public/                     # Public skill stubs
│   └── skills/                 #   SKILL.md only (theory, no implementation)
├── scripts/foundation/         # Bootstrap scripts (open source)
│   ├── bootstrap.ps1
│   ├── bootstrap-machine.ps1
│   └── setup-multi-machine.ps1
├── docs/                       # Public documentation
├── demos/                      # Demonstration material
├── config/                     # Example configs (no secrets)
├── README.md                   # This file
├── INSTALLATION.md             # This guide
├── CHANGELOG.md
└── LICENSE                     # MIT
```

---

## Verification

```powershell
# Verify Foundation.exe exists
Test-Path "Foundation.exe"

# After installation, verify the launcher
Test-Path "C:\Program Files\Foundation\Foundation-Launcher.exe"

# Verify master.key (after copying)
Test-Path "C:\Program Files\Foundation\keys\master.key"

# Run health check
wf judgment-day
```

---

## Troubleshooting

| Error | Solution |
|-------|----------|
| **"Administrator required"** | Right-click → Run as Administrator |
| **"Master key not found"** | Copy `keys/master.key` from the private repo to `C:\Program Files\Foundation\keys\` |
| **Credential popups** | Outdated launcher (< v2.0). Download the latest `Foundation.exe` |
| **No shortcuts** | Re-run the installer as Administrator |
| **PowerShell 7+ required** | Download from https://aka.ms/powershell |
| **Git 2.50+ required** | Download from https://git-scm.com |

---

## Important Notes

- **Protected distribution**: All source code travels encrypted with AES-256 inside the installer
- **No visible source code**: The public repository only exposes what's needed for distribution
- **Master key**: It's the only secret required. Without it, encrypted scripts cannot be executed
- **Single file**: `Foundation.exe` is the ONLY file you need to download — includes launcher, scripts, and stubs

---

## Changelog

### v2.9.1 (Latest)
- **Full unification**: `Foundation.exe` is now the SINGLE installer (professional NSIS wizard)
- Removed from public repository: `Foundation-Launcher.exe` and `Foundation-Setup.exe`
- Simplified installation: download → run as Admin → done

### v2.8.0
- Launcher v2.0 with complete AES-256 pipeline
- No credential popups (removed ConvertTo-SecureString)
- Interactive fallback: paste key if master.key not found

---

## Checklist

- [ ] Download `Foundation.exe` from this repository
- [ ] Run as Administrator
- [ ] Obtain `master.key` from the private repo (or paste on first launch)
- [ ] ✅ `wf judgment-day` — all OK
