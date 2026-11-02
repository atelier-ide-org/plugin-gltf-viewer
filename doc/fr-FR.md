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

La visionneuse est un **plugin natif** : une bibliothèque compilée pour chaque release d'Atelier, qui ne se charge que dans cette version. Téléchargez `gltf-viewer.atelier-plugin` dans la release `plugins/gltf-viewer/vX.Y.Z` du [dépôt des téléchargements](https://github.com/atelier-ide-org/releases/releases), où X.Y.Z est **la version de l'IDE que vous utilisez**. Cliquez ensuite sur **Plugins**, **Installer un plugin depuis un fichier** (le bouton +), et choisissez-le : la visionneuse est installée une fois, pour tous les projets, et activée. Voir [Plugins natifs](./index.md#plugins-natifs).

Le code est dans [atelier-ide-org/plugin-gltf-viewer](https://github.com/atelier-ide-org/plugin-gltf-viewer).
