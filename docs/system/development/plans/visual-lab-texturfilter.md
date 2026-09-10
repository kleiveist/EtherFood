<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Arbeitsplan: Texturfilter-Vergleich im visuellen Testlabor

## Zweck und Gesamtbild

Das visuelle Testlabor vervollständigt den bereits vorbereiteten Vergleich
zwischen Nearest-Neighbor und weicher linearer Filterung. Beide Varianten
lassen sich während des laufenden Tests auswählen, werden eindeutig
diagnostiziert und im vorhandenen Testwert-Preset gespeichert. Anschließend
wird für die Pixelart-Spielwelt nach einer gültigen Pixel-Snap-Abnahme eine
verbindliche Standardvariante festgelegt.

## Ausgangslage

Held, Größenreferenzen sowie beschädigte und wiederhergestellte Weltobjekte
verwenden bereits ausdrücklich Nearest-Neighbor. Ein gemeinsamer
Laufzeitschalter, Diagnosewert und Preset-Schlüssel fehlen. Das Testlabor
besitzt drei Zoomstufen, Kameraverfolgung, zwei Weltzustände und seit Aufgabe
17 ein eingeklapptes `F5`-Menü mit einem Pixel-Snap-Schalter.

Zu Beginn liegen zwei fremde, nicht mit dieser Aufgabe zusammenhängende
Dokumentationsänderungen zur Zeitdarstellung im Arbeitsbaum. Sie werden weder
verändert noch in den Aufgaben-Commit aufgenommen.

## Umfang und Nicht-Ziele

Im Umfang liegen ein bedienbarer Filter-Schalter im vorhandenen Menü, ein
konfliktfreies Tastenkürzel, Diagnose und rückwärtskompatible
Preset-Persistenz. Der Schalter erfasst ausschließlich texturierte Sprites der
laufenden Testlabor-Welt. Die Testmatrix umfasst Held, texturierten Boden,
Referenz- und Weltobjekte, beide Weltzustände, Bewegung, Kameraverfolgung und
alle drei Zoomstufen.

Nicht geändert werden Grafiken, Importeinstellungen, Heldenraum,
Dialogsystem, Bewegung, Physik, Kollisionsformen, Kameragrenzen, Pixel-Snap-
Entscheidung oder atmosphärische Systeme. Nebel und Licht bleiben Aufgabe 19.

## Konkrete Schritte

1. Das vorhandene `F5`-Menü platzsparend um einen fokussier- und anklickbaren
   Filter-Schalter ergänzen und ein freies Tastenkürzel konfigurieren.
2. Alle texturierten `Sprite2D`-Instanzen unter `TestWorld` erfassen und nur
   dort zwischen Nearest-Neighbor und linearer Filterung umschalten.
3. Filter-ID im vorhandenen Version-1-Preset speichern, beim Öffnen anwenden
   und fehlende oder ungültige Werte sicher auf Nearest-Neighbor zurückführen.
4. Diagnose um den exakten aktiven Filter ergänzen und Regressionstests für
   Menü, Eingabe, Persistenz, Bewegung, Kamera, Kollision und Szenenisolation
   hinzufügen.
5. Nach Abschluss von Aufgabe 17 die vollständige Testmatrix mit echten
   Renderaufnahmen bei allen Zooms, beiden Fenstergrößen und beiden
   Weltzuständen erneut auswerten.
6. Erst danach Standardfilter, Skalierungsverhalten, Ausnahmen und bekannte
   Probleme verbindlich festhalten und den vollständigen Standardlauf
   ausführen.

## Fortschritt

- [x] Repository-Stand, Regeln, visuellen Kanon, Teilimplementierung und Tests
  geprüft.
- [x] Menü, Laufzeitumschaltung, Diagnose und Persistenz vervollständigt.
- [x] Aufgabenbezogene Laufzeit- und Isolationstests ergänzt.
- [x] Vorläufige Testmatrix bei 1280 × 720 gerendert und ausgewertet.
- [x] 2026-09-03: Testmatrix nach der Pixel-Snap-Korrektur laut abgenommenem
  Projektstatus abgeschlossen.
- [x] 2026-09-03: Nearest-Neighbor als bevorzugte Variante dokumentiert.
- [x] 2026-09-03: Erneute Abnahme und Standardlauf abgeschlossen.

## Erkenntnisse und Überraschungen

- Der Teilstand ist nicht als Umschalter umgesetzt: Sämtliche vorhandenen
  Pixelart-Sprites setzen Nearest-Neighbor bereits lokal und ausdrücklich.
- Eine Änderung der globalen Projekteinstellung wäre für den Vergleich weder
  erforderlich noch ausreichend isoliert. Die laufenden Testlabor-Instanzen
  können stattdessen gezielt umgestellt und beim Verlassen wiederhergestellt
  werden.
- Das `F5`-Panel nutzt die verfügbare Bildschirmhöhe bereits aus. Beide
  Darstellungsschalter werden deshalb in einer gemeinsamen Zeile angeordnet,
  anstatt das Menü nach unten zu verlängern.
- Bei 1280 × 720 bildet der nahe Zoom mit 1,50× die Texturpixel ganzzahlig auf
  die Ausgabe ab. Die ausgerichteten Nearest- und Weich-Aufnahmen waren dort
  pixelgleich. Beim mittleren Zoom führte die nicht ganzzahlige Ausgabe je
  nach Motiv zu rund 13.000 geänderten Pixeln und deutlich mehr Mischfarben
  mit weicher Filterung.
- Der weite Zoom verkleinert auf ungefähr die halbe Ausgabegröße. Dort war der
  Filterunterschied kleiner, weil beide Varianten bereits feine Details
  zusammenfassen; Nearest-Neighbor behielt die härteren Kanten.
- Die gemessene Kamerakadenz war für beide Filter identisch: nah überwiegend
  2 bis 3, mittel 1 bis 2 und weit teilweise 0 gefolgt von 2 Ausgabepixeln.
  Weiche Filterung ändert die Bewegung nicht, sondern mischt nur Kantenfarben.
- Der nachträgliche Befund aus Aufgabe 17 zeigt, dass `1,50 ×` bei der ersten
  Filtermatrix im Fenster mit 1280 × 720 effektiv ganzzahlig ausgegeben wurde.
  Diese Matrix reicht deshalb nicht für eine verbindliche Filterentscheidung
  bei 1920 × 1080 aus.

## Entscheidungen

- `CanvasItem.TEXTURE_FILTER_LINEAR` bildet die Variante „Weich“ ab;
  Nearest-Neighbor verwendet `CanvasItem.TEXTURE_FILTER_NEAREST`.
- Der Preset-Standard bleibt Nearest-Neighbor, weil dies dem bisherigen
  expliziten Zustand entspricht und durch die ausgeführte Render-Testmatrix
  bestätigt wurde.
- Vektorgezeichnete Rasterlinien und Kollisionsgeometrie werden nicht
  künstlich verändert. Der Vergleich bewertet bei „Tiles und Kanten“ den
  texturierten Boden und hält fest, dass reine Vektorkanten filterunabhängig
  bleiben.
- Nearest-Neighbor bleibt der bevorzugte Kandidat für Pixelart-Figuren,
  texturierte Tiles und Pixelart-Weltobjekte. Die Entscheidung ist bis zur
  wiederholten vollständigen Matrix nicht verbindlich.
- Mögliche Ausnahmen für nicht-pixelige Atmosphäreneffekte werden erst nach
  dieser Wiederholung entschieden. Die Umschaltung bleibt bis dahin auf das
  Testlabor begrenzt.

## Prüfungen

- `python3 tools/control.py style`: erfolgreich, 68 Dateien.
- `git diff --check`: erfolgreich.
- `godot4 --headless --path game --script
  res://tests/bootstrap_integration_test.gd`: erfolgreich; einschließlich der
  neuen Filter-, Preset-, Zoom-, Bewegungs-, Kamera-, Kollisions- und
  Szenenisolationstests.
- `.venv/bin/python game/tools/generate_scale_reference_assets.py --check`:
  21 deterministische Testlabor-Assets unverändert verifiziert.
- `.venv/bin/python -m pytest tools/tests/test_source_hygiene.py
  tools/tests/test_godot_project.py tools/tests/test_repository_metadata.py -k
  'not test_concept_directories_have_simple_index_pages'`: 37 erfolgreich,
  eine wegen der bereits vorhandenen ignorierten lokalen
  Obsidian-Konfiguration abgewählte Prüfung.
- 124 echte OpenGL-Aufnahmen bei 1280 × 720: beide Filter, drei Zoomstufen,
  Stillstand, zwei kontrollierte Kamerafahrten, Tiles beziehungsweise
  texturierter Boden, Referenzobjekte sowie beide Weltzustände erfolgreich
  geprüft.
- `python tools/control.py check` in einer sauberen Kopie von `HEAD` plus
  ausschließlich Aufgabe 18: erfolgreich; Doctor 12/12, Stil 68 Dateien, 175
  Python-Tests und Godot-Integration.

## Wiederholbarkeit und Wiederherstellung

Automatische Tests verwenden einen isolierten `user://`-Pfad und entfernen
ihre Preset-Dateien wieder. Alle zur Filterumschaltung erfassten Sprites
behalten ihren ursprünglichen Filter pro Instanz und werden beim Verlassen des
Testlabors zurückgesetzt. Renderaufnahmen und Engine-Caches bleiben außerhalb
des Repositorys.

## Vorläufiges Ergebnis und weiterer Bedarf

Das vorhandene Nearest-Setup ist nun ein vollständiger, isolierter
Laufzeitvergleich. Menüknopf und `N` schalten alle texturierten Sprites der
Testwelt zwischen Nearest-Neighbor und Weich um. Diagnose und Preset zeigen
beziehungsweise speichern dieselbe Filter-ID; alte und fehlerhafte Werte
fallen auf Nearest-Neighbor zurück. Beim Verlassen werden die vorherigen
Instanzfilter wiederhergestellt. Eine parallel instanziierte Heldenraum-Figur
behielt während des gesamten Tests ihren eigenen Nearest-Filter.

Die abgeschlossene Render-Testmatrix bevorzugt Nearest-Neighbor: Weiche Filterung
brachte bei ganzzahliger Ausgabe keinen Vorteil und verwischte bei
nicht-ganzzahliger Ausgabe Konturen, Materialpixel und kleine Details. Sie
änderte weder Kamerafolge noch deren Rasterkadenz. Nach der korrigierten
Pixel-Snap-Abnahme gilt Aufgabe 18 als abgeschlossen. Der globale
Projektstandard wird weiterhin erst mit der Darstellungsgrundlage in Aufgabe
20 festgelegt.
