<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

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
- [x] Grafik-Polish als `f9d382b` committed.
- [x] Diagnosepanel, Eingaben und Kollisionsüberlagerung implementiert.
- [x] Diagnose- und Regressionstests erfolgreich.
- [x] Dokumentation und Abschlussprüfung aktualisiert.
- [x] Diagnoseänderung mit vorgegebener Nachricht zum Commit vorbereitet.

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
- Die Repository-Hygiene verlangt für jedes GDScript eine versionierte UID und
  verbietet konkrete Tastenevent-Klassen im Laufzeitcode. Godot erzeugte die
  zwei neuen UIDs; die Echo-Erkennung liest die optionale Eigenschaft deshalb
  generisch aus dem bereits aktionsgebundenen Ereignis.

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
- Derselbe vollständige Kontrolllauf war nach Diagnoseimplementierung erneut
  erfolgreich; der Integrationstest enthält nun die neue Diagnosesuite.
- `git diff --check`: erfolgreich.
- `godot4 --path game`: ausgeführt und mit Exitcode 1 beendet, weil
  `libXcursor.so.1`, `libwayland-client.so.0` und ein Displayserver fehlen.
  Die interaktive GUI-Prüfung bleibt wie vereinbart extern.

## Wiederholbarkeit und Wiederherstellung

Der Generator schreibt nur fest benannte PNGs unter
`game/assets/prototypes/`. `--check` vergleicht sie bytegenau. Godots lokaler
Importcache bleibt ignoriert; keine ungetrackte Benutzerdatei wird angefasst.
Alle Änderungen erfolgen gezielt per Patch ohne destruktive Git-Befehle.

## Ergebnis und Rückblick

Die Größenreferenzen und beide Debug-Weltzustände verwenden nun dieselbe
detaillierte, originale Top-down-Pixelsprache. Die Diagnose zeigt ihre
Laufzeitwerte flüchtig im kantigen HUD; die unabhängige Kollisionsansicht
zeichnet die unveränderten Physikformen des Helden, des Hindernisses und der
vier Weltgrenzen. Alle automatischen Prüfungen sind erfolgreich, während die
echte GUI-Abnahme transparent extern bleibt.
