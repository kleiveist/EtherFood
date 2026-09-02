# Originale Größenreferenz-Prototypassets

Die PNG-Dateien in diesem Ordner sind originale EtherFood-Prototypgrafiken.
Sie werden ausschließlich aus fest definierten Pixelprimitiven erzeugt:

```bash
python game/tools/generate_scale_reference_assets.py
python game/tools/generate_scale_reference_assets.py --check
python game/tools/generate_scale_reference_assets.py --preview-output /tmp/scale-row.png
```

Das Hilfsskript verwendet nur die Python-Standardbibliothek, greift nicht auf
das Netzwerk zu und erzeugt bei identischen Eingaben bytegleiche Dateien. Die
Figuren und Weltobjekte werden zunächst auf einem groben Raster gezeichnet und
ohne Kantenglättung vierfach vergrößert. Die sichtbare Alpha-Höhe endet jeweils
am unteren mittigen Bodenanker. Das Skript ist kein Bestandteil der
Spiel-Laufzeit.
