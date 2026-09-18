# Enlaza las skills de este repo a ~/.claude/skills/, para que estén vivas en
# todos los proyectos sin copiarlas a ninguno.
#
# Usa JUNCTIONS y no symlinks: en Windows un symlink pide Developer Mode o
# admin, y `ln -s` desde Git Bash sin eso hace una COPIA en silencio -- que es
# exactamente la deriva que este repo viene a eliminar. Las junctions de
# directorio no piden ningún permiso especial.
#
# Una junction por skill y no una sola sobre `skills/` porque Claude Code busca
# ~/.claude/skills/<nombre>/SKILL.md a un nivel, no anidado.
#
# Los agentes son distinto: son archivos sueltos en ~/.claude/agents/*.md, no
# carpetas, asi que va UNA sola junction sobre el directorio entero. Un agente
# que no esta ahi no se puede invocar por nombre desde ningun proyecto -- es la
# misma leccion que la bitacora que nadie cargaba.
#
# Volvé a correrlo después de agregar, renombrar o borrar una skill o un agente.

$ErrorActionPreference = "Stop"

$repo = Split-Path -Parent $PSScriptRoot
$origen = Join-Path $repo "skills"
$destino = Join-Path $env:USERPROFILE ".claude\skills"

if (-not (Test-Path $origen)) {
    Write-Host "No existe $origen" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $destino)) {
    New-Item -ItemType Directory -Path $destino -Force | Out-Null
    Write-Host "Creado $destino"
}

$enlazadas = 0
$saltadas = 0

foreach ($skill in Get-ChildItem -Path $origen -Directory) {
    $link = Join-Path $destino $skill.Name
    $existe = Get-Item -Path $link -Force -ErrorAction SilentlyContinue

    if ($existe) {
        # ReparsePoint = ya es una junction o symlink nuestro: se rehace.
        # Directorio real = algo que no pusimos nosotros: NO se toca.
        if ($existe.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            # Remove-Item sobre una junction borra el enlace, no el contenido
            # apuntado, pero -Recurse sobre un reparse point es justamente lo
            # que en algunas versiones sí baja al target: se usa .Delete().
            $existe.Delete()
        }
        else {
            Write-Host "  SALTADA  $($skill.Name) -- ya existe un directorio real ahí, no lo piso" -ForegroundColor Yellow
            $saltadas++
            continue
        }
    }

    New-Item -ItemType Junction -Path $link -Target $skill.FullName | Out-Null
    Write-Host "  enlazada $($skill.Name)" -ForegroundColor Green
    $enlazadas++
}

Write-Host ""
Write-Host "$enlazadas enlazadas, $saltadas saltadas -> $destino"

if ($saltadas -gt 0) {
    Write-Host "Revisá las saltadas a mano: o las movés al repo, o las borrás y volvés a correr esto." -ForegroundColor Yellow
}

# --- Agentes -----------------------------------------------------------------

$origenAgentes = Join-Path $repo "agents"
$destinoAgentes = Join-Path $env:USERPROFILE ".claude\agents"

if (Test-Path $origenAgentes) {
    $existeAg = Get-Item -Path $destinoAgentes -Force -ErrorAction SilentlyContinue

    if ($existeAg -and -not ($existeAg.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
        Write-Host ""
        Write-Host "  SALTADO  ~/.claude/agents ya existe como directorio real, no lo piso." -ForegroundColor Yellow
        Write-Host "  Mové su contenido a $origenAgentes, borralo, y volvé a correr esto." -ForegroundColor Yellow
    }
    else {
        if ($existeAg) { $existeAg.Delete() }
        New-Item -ItemType Junction -Path $destinoAgentes -Target $origenAgentes | Out-Null
        $cuantos = (Get-ChildItem -Path $origenAgentes -Filter *.md).Count
        Write-Host ""
        Write-Host "  enlazados $cuantos agentes -> $destinoAgentes" -ForegroundColor Green
    }
}

# --- La raiz del repo, para que las skills no lleven rutas de esta maquina ----
# `skills/bitacora` necesita leer `bitacora/`, que es una carpeta hermana y por lo
# tanto queda fuera del alcance de su junction. Con este enlace, cualquier skill
# puede decir ~/.claude/metodo/<lo que sea> y funcionar en la maquina de cualquiera.

$destinoRepo = Join-Path $env:USERPROFILE ".claude\metodo"
$existeRepo = Get-Item -Path $destinoRepo -Force -ErrorAction SilentlyContinue

if ($existeRepo -and -not ($existeRepo.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
    Write-Host "  SALTADO  ~/.claude/metodo ya existe como directorio real, no lo piso." -ForegroundColor Yellow
}
else {
    if ($existeRepo) { $existeRepo.Delete() }
    New-Item -ItemType Junction -Path $destinoRepo -Target $repo | Out-Null
    Write-Host "  enlazado  el repo -> $destinoRepo" -ForegroundColor Green
}
