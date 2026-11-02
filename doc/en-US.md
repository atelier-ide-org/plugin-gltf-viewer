---
name: 3D Model Viewer
category: viewers
summary: glTF and GLB models shown in 3D, with their animations.
tags: [gltf, glb, 3d, model, mesh, animation]
---

# 3D Model Viewer

glTF and GLB files (`.gltf`, `.glb`) open in a 3D viewer instead of the text editor, with their materials, textures, skins and animations.

- **Drag** to turn around the model, **right drag** or **Shift and drag** to move it, the **wheel** to zoom, a **double click** to frame it again.
- The bar below plays the animations: play and pause (**Space**), the time slider, the speed, the loop, and the animation to play. The **arrows** step by a tenth of a second.
- The ground grid can be hidden.

## Install

The viewer is a **native plugin**: a library that each release of Atelier builds with the IDE. Take `gltf-viewer-<os>-<arch>` from **the release of the IDE you run**, in the [repository of the downloads](https://github.com/atelier-ide-org/releases/releases), and extract it into `.atelier/plugins/gltf-viewer/` of your project. Then click **Plugins**, **Reload**, and enable **3D Model Viewer**. See [Native plugins](./index.md#native-plugins).

The code is in [atelier-ide-org/plugin-gltf-viewer](https://github.com/atelier-ide-org/plugin-gltf-viewer).
