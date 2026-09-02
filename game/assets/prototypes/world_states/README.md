# Originale Weltzustands-Prototypassets

Diese PNG-Dateien bilden den beschädigten und den wiederhergestellten
Debug-Vergleich in derselben schrägen Top-down-Perspektive ab. Paarige Assets
verwenden identische Leinwandgrößen, Positionen und Grundsilhouetten; nur
Material, Bewuchs, Schäden und Nebeldichte unterscheiden sich.

Die Dateien werden zusammen mit den Größenreferenzen deterministisch und ohne
Netzwerkzugriff erzeugt:

```bash
python game/tools/generate_scale_reference_assets.py
python game/tools/generate_scale_reference_assets.py --check
```

Das Hilfsskript verwendet ausschließlich die Python-Standardbibliothek. Die
Grafiken sind originale EtherFood-Prototypassets und keine Produktionsassets.
