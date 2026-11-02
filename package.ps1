# Builds Atelier and this plugin together, then makes the file Atelier installs:
# target/<profile>/gltf-viewer.atelier-plugin (the manifest and the library of this system).
# In Atelier: Plugins, Install a plugin from a file (the + button).
param(
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
    # The IDE and the plugin at once: the IDE only loads a library built like itself.
    if ($Dev) { cargo build --workspace } else { cargo build --release --workspace }
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    $version = (Select-String -Path Cargo.toml -Pattern '^version = "(.*)"' | Select-Object -First 1).Matches.Groups[1].Value
} finally {
    Pop-Location
}
$profileDir = if ($Dev) { 'debug' } else { 'release' }
$out = Join-Path $root "target/$profileDir"
$stage = Join-Path $out 'gltf-viewer.stage'
Remove-Item -Recurse -Force $stage -ErrorAction SilentlyContinue
$platform = "windows-$($env:PROCESSOR_ARCHITECTURE -replace 'AMD64','x86_64' -replace 'ARM64','aarch64')"
New-Item -ItemType Directory -Force (Join-Path $stage $platform) | Out-Null
$manifest = Get-Content (Join-Path $PSScriptRoot 'plugin.json') -Raw | ConvertFrom-Json
$manifest | Add-Member -NotePropertyName atelier -NotePropertyValue $version -Force
$manifest | ConvertTo-Json | Set-Content (Join-Path $stage 'plugin.json')
Copy-Item (Join-Path $out 'gltf_viewer.dll') (Join-Path $stage $platform)
$file = Join-Path $out 'gltf-viewer.atelier-plugin'
Remove-Item -Force $file -ErrorAction SilentlyContinue
Compress-Archive -Path (Join-Path $stage '*') -DestinationPath "$file.zip"
Move-Item -Force "$file.zip" $file
Remove-Item -Recurse -Force $stage
Write-Host "$file`nIn Atelier: Plugins, Install a plugin from a file (the + button)."
