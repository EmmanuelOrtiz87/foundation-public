# Foundation - Guía de Instalación (Paso a Paso)

## Para una Máquina Nueva

### Lo que Necesitas
1. Descargar desde: https://github.com/EmmanuelOrtiz87/foundation-public
2. `master.key` del repo privado (requiere acceso) — **o pégalo al primer launch**

### Paso 1: Descargar
Ir a: https://github.com/EmmanuelOrtiz87/foundation-public
- Descargar `Foundation-Setup.exe` (274KB) — incluye scripts encriptados + launcher v2.0
- **NO** descargar `Foundation-Launcher.exe` individual (obsoleto, usar el del installer)

### Paso 2: Ejecutar Instalador
1. **Right-click** en `Foundation-Setup.exe`
2. Seleccionar **"Run as Administrator"**
3. Esperar completación (crea `C:\Program Files\Foundation\`)

### Paso 3: Obtener Master Key (2 opciones)

**Opción A — Desde repo privado:**
- Copiar `keys/master.key` (32 bytes, AES-256) de `gentleman-foundation`
- Colocar en: `C:\Program Files\Foundation\keys\master.key`

**Opción B — Pegar al launch (nuevo en v2.0):**
- Ejecutar el launcher — te pedirá la key si no la encuentra
- Puedes pegar la key en formato Base64 directamente

### Paso 4: Ejecutar Foundation

**Opción A** — Shortcut de desktop:
- Doble-click en **Foundation** en el desktop

**Opción B** — Menú Start:
- Start Menu → Foundation → Foundation

**Opción C** — Manual:
```powershell
"C:\Program Files\Foundation\Foundation-Launcher.ps1"
```

## Qué se Instala
```
C:\Program Files\Foundation\
├── protected/              # Scripts encriptados (.enc)
│   ├── scripts/utilities/WORKFLOW-ORCHESTRATION/wf.ps1.enc
│   ├── scripts/utilities/foundation-installer-tui.ps1.enc
│   └── config/*.json.enc
├── public/                 # Skill stubs (sin implementación)
├── Foundation-Launcher.ps1 # Smart launcher v2.0
└── keys/
    ├── HOW_TO_GET_KEY.txt  # Instrucciones si no tienes la key
    └── master.key          # (Tú provees esto, o pégalo al launch)
```

## Verificación
```powershell
# Verificar instalación
cd "C:\Program Files\Foundation"
Test-Path "Foundation-Launcher.ps1"

# Verificar master.key (opcional)
Test-Path "keys\master.key"

# Ejecutar launcher
pwsh -NoProfile -ExecutionPolicy Bypass -File "Foundation-Launcher.ps1"
```

## Solución de Problemas

**¿Error "Administrator required"?**
- Right-click → **Run as Administrator**
- O usar directorio no-Program Files: `Foundation-Setup.exe -InstallDir "C:\Foundation"`

**¿Error "Master key not found"?**
- Opción 1: Obtener `keys/master.key` del repo privado
- Opción 2: El launcher te pedirá que pegues la key — simplemente pégala

**¿Aparecen popups de credenciales?**
- Si ves popups de Windows pidiendo credenciales, tienes una versión vieja del launcher
- Descarga la última versión de `Foundation-Setup.exe` (v2.8+, 274KB)

**¿No se crearon shortcuts?**
- Ejecutar instalador nuevamente como Administrador
- O ejecutar manualmente: `pwsh -NoProfile -File "C:\Program Files\Foundation\Foundation-Launcher.ps1"`

## Notas Importantes
- Esta es una **distribución protegida** — no incluye código fuente
- Los scripts están encriptados con AES-256 (IV + datos) — necesitas `master.key` para usarlos
- Repo privado: https://github.com/EmmanuelOrtiz87/gentleman-foundation
- **Launcher v2.0**: Sin popups de credenciales, con fallback interactivo para la key
- La versión del installer es **2.8.0** (274KB) — versiones anteriores (< 100KB) son obsoletas

## Changelog

### v2.8.0 (Latest)
- Launcher v2.0 con pipeline AES-256 completo
- Sin popups de credenciales (eliminado ConvertTo-SecureString)
- Fallback interactivo: pega la key si no tienes master.key
- Installer incluye scripts encriptados (274KB vs 39KB antes)
- Path corregido a WORKFLOW-ORCHESTRATION

### v2.7.0
- Installer v4 production-ready
- 188 scripts encriptados

## Checklist de Instalación
- [ ] Descargar `Foundation-Setup.exe` (274KB, v2.8+)
- [ ] Ejecutar como **Administrator**
- [ ] Obtener `master.key` del repo privado **O** pegarlo al primer launch
- [ ] Ejecutar desde shortcut de desktop
- [ ] ✅ Foundation funcionando!
