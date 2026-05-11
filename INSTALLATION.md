# Foundation — Guía de Instalación

## ¿Cómo se Distribuye Foundation?

Foundation usa un modelo de **distribución encriptada**. El código fuente completo (scripts, configuraciones, skills) reside en el repositorio privado `gentleman-foundation`. El repositorio público `foundation-public` contiene solo:

- **`Foundation-Setup.exe`** — Instalador NSIS que despliega todo el stack encriptado
- **`protected/`** — Scripts y configs encriptados con AES-256 (requieren `master.key`)
- **`public/`** — Stubs públicos de los skills (solo para descubrimiento)
- **`scripts/foundation/`** — Scripts de bootstrap (código abierto, necesarios para onboarding)
- **Documentación, demos y ejemplos**

> ⚠️ **No clonar el repo no es suficiente** — El stack completo solo se activa mediante el instalador.
> El repo público es el **hub de distribución** del `.exe`.

---

## Opción 1: Usar el Instalador (Recomendado)

### Lo que Necesitas

1. **`Foundation-Setup.exe`** — Descárgalo de la raíz de este repositorio
2. **`master.key`** — Llave AES-256 del repositorio privado (solicitar acceso)

### Paso 1: Descargar

Descarga `Foundation-Setup.exe` desde:
https://github.com/EmmanuelOrtiz87/foundation-public

El instalador incluye el launcher compilado `Foundation-Launcher.exe` y todos los scripts encriptados.

### Paso 2: Ejecutar Instalador

1. **Right-click** → **Run as Administrator**
2. Sigue el asistente (destino: `C:\Program Files\Foundation\`)
3. El instalador crea accesos directos en Start Menu y Desktop

### Paso 3: Obtener Master Key

**Opción A — Desde repo privado:**
- Copiar `keys/master.key` del repositorio `gentleman-foundation`
- Colocar en: `C:\Program Files\Foundation\keys\master.key`

**Opción B — Pegar al launch (v2.0+):**
- Ejecuta el launcher desde el acceso directo
- Te pedirá que pegues la key en Base64 si no la encuentra
- La key se guarda automáticamente en `keys/master.key`

### Paso 4: Ejecutar Foundation

¡Listo! Usa el acceso directo en el Desktop o Start Menu.

---

## Opción 2: Bootstrap Manual (Sin Instalador)

Para entornos donde no se puede ejecutar el `.exe`:

```powershell
# Clonar el repositorio
git clone https://github.com/EmmanuelOrtiz87/foundation-public.git
cd foundation-public

# Ejecutar bootstrap portable
.\scripts\foundation\bootstrap.ps1
```

> ℹ️ El bootstrap manual solo configura el workspace y skills públicos.
> Para el stack completo (skills encriptados + orquestación), usa el instalador `.exe`.

---

## Estructura del Repositorio Público

```
foundation-public/
├── Foundation-Setup.exe       # Instalador NSIS (everything included)
├── Foundation-Launcher.exe    # Launcher compilado (AES-256 decryption)
├── protected/                 # Scripts encriptados (.enc)
│   ├── scripts/               #   Orchestradores, utilities, agentes (.ps1.enc)
│   ├── config/                #   Configs de routing y agentes (.json.enc)
│   └── skills/                #   Skills completos (SKILL.md + .enc)
├── public/                    # Skill stubs públicos
│   └── skills/                #   Solo SKILL.md (teoría, sin implementación)
├── scripts/foundation/        # Bootstrap scripts (código abierto)
│   ├── bootstrap.ps1
│   ├── bootstrap-machine.ps1
│   └── setup-multi-machine.ps1
├── docs/                      # Documentación pública
├── demos/                     # Material de demostración
├── config/                    # Configs de ejemplo (sin secretos)
├── README.md                  # Este archivo
├── INSTALLATION.md            # Esta guía
├── CHANGELOG.md
└── LICENSE                    # MIT
```

---

## Verificación

```powershell
# Verificar que el instalador existe
Test-Path "Foundation-Setup.exe"

# Después de instalar, verificar launcher
Test-Path "C:\Program Files\Foundation\Foundation-Launcher.exe"

# Verificar master.key (después de copiarlo)
Test-Path "C:\Program Files\Foundation\keys\master.key"
```

---

## Solución de Problemas

| Error | Solución |
|-------|----------|
| **"Administrator required"** | Right-click → Run as Administrator |
| **"Master key not found"** | Opción 1: Copiar `keys/master.key` del repo privado. Opción 2: Pega la key en Base64 cuando el launcher la pida |
| **Popups de credenciales** | Versión antigua del launcher (< v2.0). Descarga la última versión de `Foundation-Setup.exe` |
| **No shortcuts** | Re-ejecutar el instalador como Administrador |

---

## Notas Importantes

- **Distribución protegida**: Todo el código fuente viaja encriptado con AES-256
- **Sin código fuente visible**: El repositorio público solo expone lo necesario para distribución y documentación
- **Master key**: Es el único secreto necesario. Sin ella, los scripts encriptados no pueden ejecutarse
- **Launcher v2.0+**: Sin popups de credenciales, con fallback interactivo para la key

---

## Changelog

### v2.8.0 (Latest)
- Launcher v2.0 con pipeline AES-256 completo
- Sin popups de credenciales (eliminado ConvertTo-SecureString)
- Fallback interactivo: pega la key si no tienes master.key
- Repositorio público limpio: solo bootstrap scripts en texto plano, todo lo demás encriptado en `protected/`

### v2.7.0
- Installer v4 production-ready
- 188+ scripts encriptados

---

## Checklist

- [ ] Descargar `Foundation-Setup.exe` de este repositorio
- [ ] Ejecutar como Administrator
- [ ] Obtener `master.key` del repo privado (o pegarlo al primer launch)
- [ ] ✅ Foundation funcionando
