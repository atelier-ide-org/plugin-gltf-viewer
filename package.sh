#!/bin/sh
# Builds Atelier and this plugin together, then makes the file Atelier installs:
# target/<profile>/gltf-viewer.atelier-plugin (the manifest and the library of this system).
# In Atelier: Plugins, Install a plugin from a file (the + button).
set -e
here="$(cd "$(dirname "$0")" && pwd)"
root="$(cd "$here/../.." && pwd)"
# The plugin is built in the workspace of the IDE: it is cloned into `plugins/gltf-viewer` of
# atelier-ide-org/app.
if ! grep -q '^name = "atelier-ide"' "$root/Cargo.toml" 2>/dev/null; then
    echo "Clone this repository into plugins/gltf-viewer of atelier-ide-org/app, then run it from there." >&2
    exit 1
fi
# The IDE and the plugin at once: the IDE only loads a library built like itself.
if [ "$1" = "--debug" ]; then
    profile=debug
    (cd "$root" && cargo build --workspace)
else
    profile=release
    (cd "$root" && cargo build --release --workspace)
fi
version="$(sed -n 's/^version = "\(.*\)"/\1/p' "$root/Cargo.toml" | head -1)"
case "$(uname -s)" in
    Darwin) os=macos; library=libgltf_viewer.dylib ;;
    *) os=linux; library=libgltf_viewer.so ;;
esac
arch="$(uname -m)"
[ "$arch" = arm64 ] && arch=aarch64
out="$root/target/$profile"
stage="$out/gltf-viewer.stage"
rm -rf "$stage" && mkdir -p "$stage/$os-$arch"
sed "s/^{/{\n  \"atelier\": \"$version\",/" "$here/plugin.json" > "$stage/plugin.json"
cp "$out/$library" "$stage/$os-$arch/"
rm -f "$out/gltf-viewer.atelier-plugin"
(cd "$stage" && zip -qr "$out/gltf-viewer.atelier-plugin" .)
rm -rf "$stage"
echo "$out/gltf-viewer.atelier-plugin"
echo "In Atelier: Plugins, Install a plugin from a file (the + button)."
