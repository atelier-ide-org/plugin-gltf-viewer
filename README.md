# 3D Model Viewer (`gltf-viewer`)

A native plugin of [Atelier IDE](https://atelier-ide-org.github.io/docs/): glTF and GLB files (`.gltf`, `.glb`) open in a 3D viewer instead of the text editor, with an orbit camera and a player for their animations. See `doc/en-US.md` for what it does.

It was a built-in plugin of the IDE; this repository keeps its history.

## Install

Each release of Atelier (from 0.2.0) gets this plugin, built like it: download `gltf-viewer.atelier-plugin` from the release `plugins/gltf-viewer/vX.Y.Z` of [atelier-ide-org/releases](https://github.com/atelier-ide-org/releases/releases), where X.Y.Z is **the version of the IDE you run**. In Atelier, open **Plugins**, click **Install a plugin from a file** (the + button) and choose it: it is installed once, for every project, and turned on. The file holds the library of every system.

A library built anywhere else is refused by the IDE: Rust has no stable ABI, so the plugin must be built by the same compiler, with the same crates and features as the IDE (see [plugin-api](https://github.com/atelier-ide-org/api)).

## Releases

The IDE never waits for this plugin: its releases are published without it. Each release of the IDE shares its build kit (its Cargo.toml, Cargo.lock and rust-toolchain.toml, no code) in `vX.Y.Z/` of the `kits` branch of [atelier-ide-org/api](https://github.com/atelier-ide-org/api). Then the **Release** workflow of this repository (`.github/workflows/release.yml`, every six hours or by hand for a version) makes an empty package of that kit, puts the plugin in its `plugins/` folder and runs the command that built the IDE, then publishes `gltf-viewer.atelier-plugin` (the manifest, with the version of Atelier, and the library of each system in `<os>-<arch>/`) and `gltf-viewer-SHA256SUMS` as the release `plugins/gltf-viewer/vX.Y.Z` (the IDE's being `app/vX.Y.Z`), never marked as the latest one of the repository. The crates the IDE and the plugin share come out the same, so the library loads in that IDE.

It needs one secret of the organization: `ATELIER_RELEASES`, which writes the releases of `atelier-ide-org/releases`.

## Develop

Clone the plugin into the `plugins/` folder of the IDE (ignored by its git, a member of its workspace):

```sh
git clone git@github.com:atelier-ide-org/app.git
git clone git@github.com:atelier-ide-org/plugin-gltf-viewer.git app/plugins/gltf-viewer
cd app/plugins/gltf-viewer
cargo test
```

To try it, build the IDE and the plugin together and make the file to install, for this system (`target/<profile>/gltf-viewer.atelier-plugin`), then install it in the IDE you built (Plugins, the + button):

```powershell
./plugins/gltf-viewer/package.ps1          # release
./plugins/gltf-viewer/package.ps1 -Dev     # for `cargo run`
```

```sh
./plugins/gltf-viewer/package.sh           # release
./plugins/gltf-viewer/package.sh --debug   # for `cargo run`
```

On its own, this repository runs its tests (`cargo test`, and the CI).

## Layout

- `src/lib.rs`: the plugin (`declare_plugin!`), the camera, the animation player and the view.
- `src/scene.rs`: reading the model, its node tree, skins and animations, on the CPU.
- `src/render.rs`: drawing it with OpenGL, in a paint callback of egui_glow.
- `locales/`: its texts, in the language of the IDE.
- `plugin.json`: the manifest, next to the library in `.atelier/plugins/gltf-viewer/`.
