---
title: ADR-0011 – Maßstab V0
status: accepted
updated: 2026-09-03
---
<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# ADR-0011 – Maßstab V0

## Kontext

Das visuelle Testlabor stellt drei bereits vorhandene Heldenhöhen,
Tilegrößen und Kamera-Zoomstufen gegenüber. Für die weitere Produktion
benötigen Heldenraum, Außenwelt, Tilesets, Figuren und Weltobjekte eine
gemeinsame Darstellungsgrundlage. Dabei darf ein globaler Standard passende
Kameraeinstellungen für kleine Räume oder besondere Situationen nicht
verhindern.

## Entscheidung

Der bisherige Kandidat B wird als `Maßstab V0` angenommen:

| Eigenschaft | Verbindlicher Wert |
|---|---|
| Heldenhöhe | 80 Weltpixel |
| Tilegröße | 32 × 32 Weltpixel |
| normale Spielansicht | 1,00× |
| Referenzauflösung | 1920 × 1080 |
| Seitenverhältnis | 16:9 |
| Pixel-Snap | aktiv; gemeinsames Raster auf ganzen Ausgabepixeln |
| Texturfilter | Nearest-Neighbor für Pixelart |

Der Zoom `1,00×` ist die normale Spielansicht und keine ausnahmslose globale
Kamerasperre. Szenen dürfen über ein ausdrücklich zugewiesenes Kameraprofil
abweichen. Kleine Räume verwenden zunächst `1,50×`; auch andere Settings
dürfen später einen begründeten Profilwert erhalten. Temporäre
Kameraüberlagerungen wie der Schleichzoom bleiben davon getrennt.

Die Vergleichsvarianten A (`64 px`, `32 px`, `0,75×`) und C (`96 px`,
`48 px`, `1,50×`) bleiben ausschließlich im Testlabor verfügbar. Sie sind
keine Produktionsstandards.

## Folgen

- Neue Pixelart-Figuren und Weltobjekte werden gegen die Heldenhöhe von
  80 Pixeln und das 32er Weltraster entworfen.
- Welt- und Dungeonszenen beginnen bei `1,00×`; kleine Innenräume dürfen das
  bestehende Profil mit `1,50×` verwenden.
- Pixelart wird standardmäßig mit Nearest-Neighbor dargestellt.
  Atmosphärische Texturen dürfen weiterhin bewusst weich gestaltet werden.
- Pixel-Snap verändert nur die sichtbare Ausrichtung. Logische Bewegung,
  Kollisionen und Kartenkoordinaten bleiben ungerundet.
- Die Entscheidung veranlasst keinen großflächigen Umbau vorhandener Karten
  oder Prototypgrafiken. Solche Anpassungen erfolgen in ihren vorgesehenen
  Folgeaufgaben.
