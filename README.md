# Foundation - Public Distribution

> **Foundation Automation Framework** - Protected distribution for Windows.

## Quick Download & Install

### 1. Download Installer
Download `Foundation-Setup.exe` from this repository (see Releases or root folder).

### 2. Run Installer
Right-click `Foundation-Setup.exe` → **Run as Administrator**
- Installs to `C:\Program Files\Foundation\`
- Creates desktop and Start Menu shortcuts
- Copies encrypted components (AES-256)

### 3. Launch Foundation
- Double-click **Foundation** shortcut on desktop, or
- Start Menu → Foundation → Foundation
- Or run manually:
```powershell
"C:\Program Files\Foundation\Foundation-Launcher.exe"
```

## What's Inside `Foundation-Setup.exe`

```
Foundation-Setup.exe contains:
├── Encrypted Scripts (188 files, .enc extension)
│   ├── scripts/utilities/*.ps1.enc
│   ├── config/*.json.enc
│   └── skills/*/SKILL.md.enc
├── Public Stubs (126 skills, no implementation)
├── Foundation-Launcher.exe (compiled launcher)
└── Documentation (public only)
```

## Important Notes

- **Source code is NOT included** - All scripts are AES-256 encrypted
- **keys/master.key required** - Without it, scripts cannot be decrypted
- **Private repo**: https://github.com/EmmanuelOrtiz87/gentleman-foundation (requires access)
- This public repo contains only the installer and encrypted stubs

## Post-Installation Steps

1. **Place your master.key**:
   - Copy `master.key` to: `C:\Program Files\Foundation\keys\master.key`
   - (Get `master.key` from private repository)

2. **Run Foundation**:
   - Double-click desktop shortcut, or
   - Run: `C:\Program Files\Foundation\Foundation-Launcher.exe`

3. **Verify installation**:
```powershell
cd "C:\Program Files\Foundation"
.\Foundation-Launcher.exe
```

## Requirements

- Windows 10/11 (64-bit)
- PowerShell 7+ (optional, launcher is self-contained)
- Administrator privileges (for installation)
- ~200MB disk space

## Installation Step-by-Step (New Machine)

1. Go to: https://github.com/EmmanuelOrtiz87/foundation-public
2. Download `Foundation-Setup.exe` (39KB)
3. Right-click → **Properties** → Unblock → Apply (if blocked)
4. Right-click → **Run as Administrator**
5. Wait for installation to complete (shortcuts created)
6. Get `keys/master.key` from private repo
7. Copy to: `C:\Program Files\Foundation\keys\master.key`
8. Run Foundation from desktop shortcut

## Troubleshooting

**Installer won't run?**
- Right-click → Properties → Unblock → Apply
- Run as Administrator

**"Cannot decrypt" error?**
- You need `keys/master.key` from private repository
- Place it in: `C:\Program Files\Foundation\keys\master.key`

**Shortcuts not created?**
- Run installer again as Administrator
- Or run manually: `C:\Program Files\Foundation\Foundation-Launcher.exe`

## Links

- **Private Repo** (source): https://github.com/EmmanuelOrtiz87/gentleman-foundation
- **Issues**: https://github.com/EmmanuelOrtiz87/foundation-public/issues
- **Documentation**: `docs/` folder (public only)

---

**⚠️ This is a protected distribution. No source code included.**
