**ScaleBarDM4**

ScaleBarDM4 est une macro Fiji/ImageJ qui automatise le traitement des fichiers d'images DM4. Elle permet de :
- Convertir les fichiers DM4 en format TIFF
- Améliorer automatiquement le contraste
- Mettre à l'échelle les images en fonction des métadonnées de taille de pixel
- Ajouter automatiquement des barres d'échelle appropriées

| Taille de l'image | Barre d'échelle |
|-------------------|-----------------|
| < 800 nm          | 100 nm         |
| 800 - 1600 nm     | 200 nm         |
| 1.6 - 3.5 µm      | 500 nm         |
| 3.5 - 6 µm        | 1 µm           |
| 6 - 20 µm         | 2 µm           |
| 20 - 44 µm        | 5 µm           |
| 44 - 80 µm        | 10 µm          |
| 80 - 210 µm       | 20 µm          |
| 210 - 350 µm      | 50 µm          |
| > 350 µm          | 100 µm         |

## Utilisation
1. Lancez Fiji/ImageJ
2. Installez la macro
3. Sélectionnez le dossier contenant vos fichiers DM4
4. Les images converties seront sauvegardées dans un sous-dossier "output_Tiff_scaleBar"
