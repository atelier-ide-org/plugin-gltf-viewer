---
name: Visionneuse de modèles 3D
summary: Les modèles glTF et GLB affichés en 3D, avec leurs animations.
---

# Visionneuse de modèles 3D

Les fichiers glTF et GLB (`.gltf`, `.glb`) s'ouvrent dans une vue 3D au lieu de l'éditeur de texte, avec leurs matériaux, textures, squelettes et animations.

- **Glisser** pour tourner autour du modèle, **glisser avec le bouton droit** ou **Maj et glisser** pour le déplacer, la **molette** pour zoomer, un **double clic** pour le recadrer.
- La barre du bas joue les animations : lecture et pause (**Espace**), le curseur du temps, la vitesse, la boucle et l'animation à jouer. Les **flèches** avancent d'un dixième de seconde.
- La grille du sol peut être masquée.

## Installation

La visionneuse est un **plugin natif** : une bibliothèque que chaque release d'Atelier compile avec l'IDE. Prenez `gltf-viewer-<os>-<arch>` dans **la release de l'IDE que vous utilisez**, dans le [dépôt des téléchargements](https://github.com/atelier-ide-org/releases/releases), et extrayez-le dans `.atelier/plugins/gltf-viewer/` de votre projet. Cliquez ensuite sur **Plugins**, **Recharger**, et activez **Visionneuse de modèles 3D**. Voir [Plugins natifs](./index.md#plugins-natifs).

Le code est dans [atelier-ide-org/plugin-gltf-viewer](https://github.com/atelier-ide-org/plugin-gltf-viewer).
