#!/bin/sh
# Builds this plugin, then makes the file Atelier installs: target/<profile>/gltf-viewer.atelier-plugin
# (the manifest and the library of this system). In Atelier: Plugins, the + button.
set -e
here="$(cd "$(dirname "$0")" && pwd)"
cd "$here"
if [ "$1" = "--debug" ]; then
    profile=debug
    cargo build
else
    profile=release
    cargo build --release
fi
version="$(sed -n 's/^version = "\(.*\)"/\1/p' Cargo.toml | head -1)"
case "$(uname -s)" in
    Darwin) os=macos; library=libgltf_viewer.dylib ;;
    *) os=linux; library=libgltf_viewer.so ;;
esac
arch="$(uname -m)"
[ "$arch" = arm64 ] && arch=aarch64
out="$here/target/$profile"
stage="$out/gltf-viewer.stage"
rm -rf "$stage" && mkdir -p "$stage/$os-$arch"
sed "s/\"version\": \"[^\"]*\"/\"version\": \"$version\"/" plugin.json > "$stage/plugin.json"
cp "$out/$library" "$stage/$os-$arch/"
rm -f "$out/gltf-viewer.atelier-plugin"
(cd "$stage" && zip -qr "$out/gltf-viewer.atelier-plugin" .)
rm -rf "$stage"
echo "$out/gltf-viewer.atelier-plugin"
echo "In Atelier: Plugins, Install a plugin from a file (the + button)."
