# 3D Model Viewer (`gltf-viewer`)

A native plugin of [Atelier IDE](https://atelier-ide-org.github.io/docs/): glTF and GLB files (`.gltf`, `.glb`) open in a 3D viewer instead of the text editor, with an orbit camera and a player for their animations. It draws with OpenGL, in the window of the IDE. See `doc/en-US.md` for what it does.

It was a built-in plugin of the IDE; this repository keeps its history. It is a plugin so that the IDE does not carry its dependencies (gltf and glam (reading and posing the models), glow (OpenGL)): only those who install it download and run them.

## Install

In Atelier (0.4 or later), open **Plugins**, then **Marketplace**, and click **Install**: it is installed once, for every project, and turned on. The releases are also in [atelier-ide-org/releases](https://github.com/atelier-ide-org/releases/releases) (`plugins/gltf-viewer/vX.Y.Z`): download `gltf-viewer.atelier-plugin` and, in **Plugins**, click **Install a plugin from a file** (the + button). The file holds the library of every system.

## How it works

The plugin is a dynamic library (`gltf_viewer`) that talks to the IDE through a C interface only ([atelier-ide-org/api](https://github.com/atelier-ide-org/api)): it draws with its own egui, and the IDE paints what it gives back. So it builds alone, with any Rust compiler, and loads in every version of Atelier that reads the version of the interface its `plugin.json` gives (`abi`).

- `plugin.json`: its identifier, name, description, library, interface (`abi`) and the extensions of the files it handles (`extensions`).
- `extensions/`: the icons of those files, one SVG per group of extensions (`a+b.svg`).
- `src/`: the plugin; `locales/`, `doc/`: its texts and its page of the documentation.

## Develop

With [`atelier-cli`](https://github.com/atelier-ide-org/api) (`cargo install --git https://github.com/atelier-ide-org/api atelier-cli`):

```sh
cargo test
atelier-cli plugin compile           # target/release/gltf-viewer.atelier-plugin, for this system
atelier-cli plugin compile --debug   # target/debug/gltf-viewer.atelier-plugin
```

Then install the file in Atelier (Plugins, the + button). It is also the submodule `plugins/gltf-viewer` of [atelier-ide-org/app](https://github.com/atelier-ide-org/app).

## Releases

Raise the version of `Cargo.toml` and push it to `main`: the **Release** workflow builds the library for Windows, Linux and macOS (x86_64 and aarch64) with `atelier-cli`, then publishes `gltf-viewer.atelier-plugin`, `plugin.json` and `gltf-viewer-SHA256SUMS` as the release `plugins/gltf-viewer/vX.Y.Z` of `atelier-ide-org/releases`, where the IDE finds it. Started by hand, it builds the version again and replaces its files. It needs one secret of the organization: `ATELIER_RELEASES`.
