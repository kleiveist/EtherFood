<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# Arbeitsplan: Grafik-Polish und Diagnose im visuellen Testlabor

## Zweck und Gesamtbild

Das visuelle Testlabor erhält eine detailliertere, weiterhin originale
Top-down-Pixelgrafik und anschließend eine flüchtige Diagnoseanzeige. Der
Größenvergleich und beide Weltzustände sollen wie derselbe spielbare
EtherFood-Prototyp wirken. F3 blendet Statuswerte ein; F4 zeichnet die
vorhandenen Kollisionsformen, ohne die Physik zu verändern.

## Ausgangslage

Die Größenreihe verwendet bereits reproduzierbare PNG-Prototypassets mit
korrekten Höhen und Bodenankern, ist gegenüber der bestätigten Stilreferenz
aber noch zu grob. Die Weltzustandsvorschau besteht weiterhin aus einfachen
`Polygon2D`- und `Line2D`-Formen. Diagnoseeingaben, Diagnosepanel und eine
eigene Kollisionszeichnung fehlen. Die lokale GUI kann mangels Display und
X11-/Wayland-Bibliotheken nicht gestartet werden; die interaktive Abnahme
erfolgt deshalb wie vereinbart extern.

## Umfang und Nicht-Ziele

Im Umfang liegen ausschließlich das visuelle Detailniveau vorhandener
Testassets, die Darstellung beider bestehenden Weltzustände, Diagnosepanel,
F3/F4-Eingaben, eine nicht-invasive Kollisionsüberlagerung sowie passende
Tests und knappe Dokumentation. Maße, Anker, Presets, Bewegung, tatsächliche
Kollisionsformen, Kameragrenzen, Speicherschema, Weltzustandslogik und
Menüführung bleiben unverändert.

Nicht enthalten sind externe oder KI-generierte Grafiken, kopierte
Spielassets, Animationen, neue Spielsysteme, Navigation-Debugging,
Leistungsmessungen jenseits der FPS und Produktionsgrafik.

## Konkrete Schritte

1. Den lokalen Standardbibliothek-Generator um feinere originale Figuren-,
   Material- und Bodendetails sowie paarige Weltzustandsassets erweitern.
2. Weltzustandsvorschau bei identischen Positionen und Grundflächen auf
   Nearest-Neighbor-Sprites umstellen; Zustandsunterschiede klar sichern.
3. Perspektiv-, Größen-, Anker-, Textur- und Umschalttests anpassen und den
   Grafikstand getrennt committen.
4. F3/Controller-Back und F4 ergänzen, Diagnosepanel alle 0,2 Sekunden aus
   den aktiven Laufzeitwerten aktualisieren und nie speichern.
5. Vorhandene Helden-, Hindernis- und Randformen über eine eigene Ebene
   halbtransparent zeichnen und beim Laufen aktualisieren.
6. Runtime- und Integrationstests ergänzen, Standardprüfung ausführen,
   Dokumentation aktualisieren und Diagnoseänderung committen.

## Fortschritt

- [x] Git-Stand, Repository-Regeln, Referenzbild und aktuelle Szenen geprüft.
- [x] Detaillierte Größen- und Weltzustandsassets erzeugt und eingebunden.
- [x] Grafiktests und automatische Prüfungen erfolgreich.
- [ ] Grafik-Polish committed.
- [ ] Diagnosepanel, Eingaben und Kollisionsüberlagerung implementiert.
- [ ] Diagnose- und Regressionstests erfolgreich.
- [ ] Dokumentation und Abschlussprüfung aktualisiert.
- [ ] Diagnoseänderung mit vorgegebener Nachricht committed.

## Erkenntnisse und Überraschungen

- Das Referenzbild liegt als ungetrackte lokale Datei `testImage.png` vor. Es
  dient nur zur Beurteilung von Detailgrad und Materialsprache und wird weder
  verändert noch ins Repository aufgenommen.
- Die beiden Weltzustände besitzen bereits paarige Positionen, nutzen aber
  primitive Einzelgeometrie. Paarige Sprite-Leinwände können dieselben Anker
  zuverlässiger sichern und den Zustand ausschließlich visuell variieren.
- Der erste Headless-Import übernahm für alle 14 neuen Weltzustands-PNGs die
  gewünschte Einstellung ohne Mipmaps. Die bestehenden Größen-, Speicher-,
  Umschalt-, Menü- und RouteHost-Tests blieben nach dem Spriteumbau grün.

## Entscheidungen

- Alle neuen Rasterbilder entstehen deterministisch ohne Netzwerk mit dem
  vorhandenen Python-Hilfsskript. Die Referenz wird nicht nachgezeichnet;
  Formen, Figuren und Details bleiben originale EtherFood-Prototypgrafik.
- Diagnose und Kollisionsüberlagerung starten bei jeder Szeneninstanz aus und
  werden nicht Teil von `visual_lab_settings.cfg`.
- Die Kollisionsansicht liest die realen `RectangleShape2D`-Ressourcen nur
  aus. Sie verändert weder Formen noch `SceneTree.debug_collisions_hint`.

## Prüfungen

- `python game/tools/generate_scale_reference_assets.py --check`:
  erfolgreich, 21 Assets bytegenau bestätigt.
- `godot4 --headless --path game --script
  res://tests/bootstrap_integration_test.gd`: erfolgreich.
- `python tools/control.py check`: erfolgreich; Doctor 12/12,
  Quellstilprüfung, 175 Python-Tests und Godot-Integration bestanden.
- `git diff --check`: erfolgreich.
- Die interaktive GUI-Prüfung bleibt aufgrund der dokumentierten
  Containergrenze extern.

## Wiederholbarkeit und Wiederherstellung

Der Generator schreibt nur fest benannte PNGs unter
`game/assets/prototypes/`. `--check` vergleicht sie bytegenau. Godots lokaler
Importcache bleibt ignoriert; keine ungetrackte Benutzerdatei wird angefasst.
Alle Änderungen erfolgen gezielt per Patch ohne destruktive Git-Befehle.

## Ergebnis und Rückblick

Noch offen.
