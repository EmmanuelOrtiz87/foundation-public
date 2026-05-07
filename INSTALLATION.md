# Foundation - Guía de Instalación (Paso a Paso)

## Para una Máquina Nueva

### Lo que Necesitas
1. Descargar desde: https://github.com/EmmanuelOrtiz87/foundation-public
2. `master.key` del repo privado (requiere acceso)

### Paso 1: Descargar
Ir a: https://github.com/EmmanuelOrtiz87/foundation-public
- Descargar `Foundation-Setup.exe` (39KB)
- Descargar `Foundation-Launcher.exe` (34KB) [se copia solo]

### Paso 2: Preparar Archivos
Crear una carpeta: `C:\Foundation-Installer\`
- Colocar `Foundation-Setup.exe` ahí
- (Opcional) Colocar `Foundation-Launcher.exe` ahí

### Paso 3: Ejecutar Instalador como Administrador
1. **Right-click** en `Foundation-Setup.exe`
2. Seleccionar **"Run as Administrator"**
3. Esperar completación (crea `C:\Program Files\Foundation\`)

### Paso 4: Obtener Master Key
Del repo privado (`gentleman-foundation`):
- Copiar `keys/master.key` (32 bytes, AES-256)
- Colocar en: `C:\Program Files\Foundation\keys\master.key`

### Paso 5: Ejecutar Foundation
**Opción A** - Shortcut de desktop (creado por instalador):
- Doble-click en **Foundation** en el desktop

**Opción B** - Menú Start:
- Start Menu → Foundation → Foundation

**Opción C** - Manual:
```powershell
"C:\Program Files\Foundation\Foundation-Launcher.exe"
```

## Qué se Instala
```
C:\Program Files\Foundation\
├── protected/              # 188 scripts encriptados (.enc)
│   ├── scripts/utilities/*.ps1.enc
│   ├── config/*.json.enc
│   └── skills/*/SKILL.md.enc
├── public/                 # 126 skill stubs (sin implementación)
├── Foundation-Launcher.exe # Launcher compilado
└── keys/                  # Colocar master.key ahí
    └── master.key          # (Tú provees esto)
```

## Verificación
```powershell
# Verificar instalación
cd "C:\Program Files\Foundation"
Get-ChildItem -Recurse | Measure-Object | Select-Object Count

# Verificar master.key
Test-Path "C:\Program Files\Foundation\keys\master.key"

# Ejecutar launcher
.\Foundation-Launcher.exe
```

## Solución de Problemas

**¿Error "Administrator required"?**
- Right-click → **Run as Administrator**
- O usar directorio no-Program Files: `Foundation-Setup.exe -InstallDir "C:\Foundation"`

**¿Error "Master key not found"?**
- Obtener `keys/master.key` del repo privado
- Copiar a: `C:\Program Files\Foundation\keys\master.key`

**¿No se crearon shortcuts?**
- Ejecutar instalador nuevamente como Administrador
- O ejecutar manualmente: `C:\Program Files\Foundation\Foundation-Launcher.exe`

## Notas Importantes
- Esta es una **distribución protegida** - no incluye código fuente
- Los scripts están encriptados con AES-256 - necesitas `master.key` para usarlos
- Repo privado: https://github.com/EmmanuelOrtiz87/gentleman-foundation
- **`Foundation-Launcher.exe`** está en el repo público y se copia solo durante instalación
- Si haces doble-click al launcher y dice "master.key not found", coloca el archivo en la carpeta correcta

## Checklist de Instalación
- [ ] Descargar `Foundation-Setup.exe`
- [ ] Ejecutar como **Administrator**
- [ ] Obtener `master.key` del repo privado
- [ ] Colocar en `C:\Program Files\Foundation\keys\master.key`
- [ ] Ejecutar desde shortcut de desktop
- [ ] ✅ Foundation funcionando!
