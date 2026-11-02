# 3D Model Viewer (`gltf-viewer`)

A native plugin of [Atelier IDE](https://atelier-ide-org.github.io/docs/): glTF and GLB files (`.gltf`, `.glb`) open in a 3D viewer instead of the text editor, with an orbit camera and a player for their animations. See `doc/en-US.md` for what it does.

It was a built-in plugin of the IDE; this repository keeps its history.

## Install

Each release of Atelier (from 0.2.0) gets this plugin, built like it: take `gltf-viewer-<os>-<arch>` from the release `plugins/gltf-viewer/vX.Y.Z` of [atelier-ide-org/releases](https://github.com/atelier-ide-org/releases/releases), where X.Y.Z is **the version of the IDE you run**, and extract it into `<project>/.atelier/plugins/gltf-viewer/`. In Atelier, open **Plugins**, click **Reload** and enable **3D Model Viewer**.

A library built anywhere else is refused by the IDE: Rust has no stable ABI, so the plugin must be built by the same compiler, with the same crates and features as the IDE (see [plugin-api](https://github.com/atelier-ide-org/plugin-api)).

## Releases

The IDE never waits for this plugin: its releases are published without it. Then the **Release** workflow of this repository (`.github/workflows/release.yml`, every six hours or by hand for a tag) takes the code of the IDE at the tag of the release, puts the plugin in its `plugins/` folder and runs the command that built the IDE, then publishes `gltf-viewer-<os>-<arch>` and `gltf-viewer-SHA256SUMS` as the release `plugins/gltf-viewer/vX.Y.Z` (the IDE's being `app/vX.Y.Z`), never marked as the latest one of the repository. The crates the IDE and the plugin share come out the same, so the library loads in that IDE.

It needs two secrets of the organization: `READ_TOKEN` (reads `atelier-ide-org/app`) and `RELEASES_TOKEN` (writes the releases of `atelier-ide-org/releases`).

## Develop

Clone the plugin into the `plugins/` folder of the IDE (ignored by its git, a member of its workspace):

```sh
git clone git@github.com:atelier-ide-org/app.git
git clone git@github.com:atelier-ide-org/plugin-gltf-viewer.git app/plugins/gltf-viewer
cd app/plugins/gltf-viewer
cargo test
```

To try it in a project, build the IDE and the plugin together, then install the plugin:

```powershell
./plugins/gltf-viewer/install.ps1 -Project C:\path\to\project            # release
./plugins/gltf-viewer/install.ps1 -Project C:\path\to\project -Dev       # for `cargo run`
```

```sh
./plugins/gltf-viewer/install.sh /path/to/project            # release
./plugins/gltf-viewer/install.sh /path/to/project --debug    # for `cargo run`
```

On its own, this repository runs its tests (`cargo test`, and the CI).

## Layout

- `src/lib.rs`: the plugin (`declare_plugin!`), the camera, the animation player and the view.
- `src/scene.rs`: reading the model, its node tree, skins and animations, on the CPU.
- `src/render.rs`: drawing it with OpenGL, in a paint callback of egui_glow.
- `locales/`: its texts, in the language of the IDE.
- `plugin.json`: the manifest, next to the library in `.atelier/plugins/gltf-viewer/`.
