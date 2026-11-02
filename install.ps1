# Builds Atelier and this plugin together, then installs the plugin into a project:
# <project>/.atelier/plugins/gltf-viewer/{plugin.json, gltf_viewer.dll}.
param(
    [Parameter(Mandatory = $true)][string]$Project,
    [switch]$Dev
)
$ErrorActionPreference = 'Stop'
$root = Resolve-Path (Join-Path $PSScriptRoot '../..')
# The plugin is built in the workspace of the IDE: it is cloned into `plugins/gltf-viewer` of
# atelier-ide-org/app.
if (-not (Select-String -Quiet -Path (Join-Path $root 'Cargo.toml') -Pattern '^name = "atelier-ide"')) {
    throw 'Clone this repository into plugins/gltf-viewer of atelier-ide-org/app, then run it from there.'
}
Push-Location $root
try {
    # Both at once: the IDE only loads a library built with its own features.
    if ($Dev) { cargo build --workspace } else { cargo build --release --workspace }
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
} finally {
    Pop-Location
}
$profileDir = if ($Dev) { 'debug' } else { 'release' }
$target = Join-Path $Project '.atelier/plugins/gltf-viewer'
New-Item -ItemType Directory -Force $target | Out-Null
Copy-Item (Join-Path $PSScriptRoot 'plugin.json') $target -Force
Copy-Item (Join-Path $root "target/$profileDir/gltf_viewer.dll") $target -Force
Write-Host "Installed into $target. In Atelier: Plugins, Reload, then enable 3D Model Viewer."
