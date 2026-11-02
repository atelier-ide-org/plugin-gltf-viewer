# 3D Model Viewer (`gltf-viewer`)

A native plugin of [Atelier IDE](https://atelier-ide-org.github.io/docs/): glTF and GLB files (`.gltf`, `.glb`) open in a 3D viewer instead of the text editor, with an orbit camera and a player for their animations. See `doc/en-US.md` for what it does.

It was a built-in plugin of the IDE; this repository keeps its history.

## Install

Each release of Atelier carries this plugin, built with it: take `gltf-viewer-<os>-<arch>` from **the release of the IDE you run**, in [atelier-ide-org/releases](https://github.com/atelier-ide-org/releases/releases), and extract it into `<project>/.atelier/plugins/gltf-viewer/`. In Atelier, open **Plugins**, click **Reload** and enable **3D Model Viewer**.

A library built anywhere else is refused by the IDE: Rust has no stable ABI, so the plugin must be built by the same compiler, with the same crates and features as the IDE (see [plugin-api](https://github.com/atelier-ide-org/plugin-api)).

## Develop

The plugin is a git submodule of the IDE, at `plugins/gltf-viewer` of `atelier-ide-org/app`, and a member of its workspace: the IDE's CI builds it and publishes it with each release. Work on it there:

```sh
git clone --recursive git@github.com:atelier-ide-org/app.git
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

On its own, this repository only runs its tests (`cargo test`, and the CI). A new version is a tag (`vX.Y.Z`); the IDE moves its submodule to it.

## Layout

- `src/lib.rs`: the plugin (`declare_plugin!`), the camera, the animation player and the view.
- `src/scene.rs`: reading the model, its node tree, skins and animations, on the CPU.
- `src/render.rs`: drawing it with OpenGL, in a paint callback of egui_glow.
- `locales/`: its texts, in the language of the IDE.
- `plugin.json`: the manifest, next to the library in `.atelier/plugins/gltf-viewer/`.
