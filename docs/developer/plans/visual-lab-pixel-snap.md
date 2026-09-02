<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# Arbeitsplan: Pixel-Snap-Vergleich im visuellen Testlabor

## Zweck und Gesamtbild

Das visuelle Testlabor erhält einen neu umgesetzten Pixel-Snap-Vergleich.
Pixel-Snap lässt sich im eingeblendeten Steuerungsmenü und per eigenem
Tastenkürzel während des laufenden Tests umschalten. Menü, Diagnose und das
vorhandene Testwert-Preset zeigen beziehungsweise speichern denselben Zustand.
Held, Kamerazentrum und Weltanker bleiben getrennt beobachtbar.

## Ausgangslage

Das Testlabor besitzt bereits ein mit `F5` einblendbares Steuerungsmenü,
gespeicherte Kamera-, Figuren-, Tile- und Weltzustandswerte sowie eine
flüchtige Diagnoseanzeige. Der aktuelle Viewport verwendet noch keinen
umschaltbaren Transform-Snap. Die Bedienhilfe besteht bislang nur aus Text und
enthält kein interaktives Testelement.

## Umfang und Nicht-Ziele

Im Umfang liegen genau ein bedienbarer Pixel-Snap-Schalter, ein konfliktfreies
Tastenkürzel, Preset-Persistenz, ein eindeutiger Diagnosewert, getrennte
Positionswerte für Held, Kamera und Welt sowie passende Laufzeit- und
Integrationstests. Beide Darstellungsvarianten werden neu gerendert und das
Ergebnis wird in der bestehenden Testlabor-Dokumentation festgehalten.

Nicht geändert werden Heldenraum, Ratgeber-Interaktion, Dialogverhalten,
Bewegungsgeschwindigkeit, Physikpositionen, Kollisionsformen, Kameragrenzen,
Texturfilter oder Grafiken. Maßstab, Zoom und Pixelart-Regeln werden in dieser
Aufgabe noch nicht verbindlich festgelegt.

## Konkrete Schritte

1. Im `F5`-Menü einen fokussier- und anklickbaren AN/AUS-Schalter ergänzen und
   ein freies Tastenkürzel konfigurieren.
2. Ausschließlich den Transform-Snap des aktiven Viewports umschalten und den
   vorherigen Viewport-Zustand beim Verlassen wiederherstellen.
3. Den booleschen Wert rückwärtskompatibel im vorhandenen Version-1-Preset
   speichern und beim Öffnen anwenden.
4. Diagnose um den exakten Pixel-Snap-Zustand sowie Held-, Kamera- und
   Weltpositionen ergänzen.
5. Menü-, Eingabe-, Speicher-, Bewegungs-, Kollisions-, Kamera- und
   Regressionstests ergänzen und die schnellsten Prüfungen zuerst ausführen.
6. Beide Varianten bei den vorhandenen Zoomstufen rendern, beurteilen,
   dokumentieren und den vollständigen Standardlauf ausführen.

## Fortschritt

- [x] Aktuellen Repository-Stand, Regeln, Dokumentation, Szene und Tests
  geprüft.
- [x] Laufzeitfunktion, echtes Menüelement, Diagnose und Persistenz umgesetzt.
- [x] Aufgabenbezogene Tests ergänzt und erfolgreich ausgeführt.
- [x] Gerenderten Vergleich durchgeführt und Ergebnis dokumentiert.
- [x] Vollständigen Standardlauf erfolgreich ausgeführt.
- [x] Vorgesehenen Commit vorbereitet.

## Erkenntnisse und Überraschungen

- Der neue Ausgangsstand besitzt inzwischen eine standardmäßig eingeklappte
  `F5`-Bedienhilfe. Der Pixel-Snap-Schalter muss deshalb als echtes
  Bedienelement in diese vorhandene Struktur integriert werden.
- `P` ist bereits der allgemeinen Pause-Aktion zugeordnet. Die neue
  Testfunktion darf diese Belegung nicht wiederverwenden.
- Die erste echte Renderaufnahme zeigte, dass der neue Knopf wegen seiner
  horizontalen Größenregel über die Menüfläche hinauswuchs. Eine feste
  Mindestbreite ohne horizontales Aufspannen hält ihn innerhalb des Panels.
- Im Arbeitsverzeichnis liegt eine ignorierte lokale Obsidian-Konfiguration
  unter `docs/concept/.obsidian/`. Sie verletzt eine allgemeine
  Dokumentationsprüfung, gehört aber nicht zum versionierten Projekt und
  wurde nicht verändert. Der vollständige Standardlauf erfolgte deshalb
  zusätzlich in einer sauberen Kopie des exakten Änderungsstands.
- Im gerenderten Vergleich blieb der ausgerichtete Weltausschnitt mit
  Pixel-Snap bei allen drei Zoomstufen unverändert. Ohne Pixel-Snap änderten
  sich je nach Zoom wiederholt bis zu 1.000 Pixel. Der ausgerichtete Held
  blieb mit Pixel-Snap im nahen und mittleren Zoom stabil; ohne Pixel-Snap
  änderten sich bis zu 182 Pixel.

## Entscheidungen

- Der Schalter verwendet Godots Viewport-Transform-Snap. Logische Knoten- und
  Physikpositionen werden nicht gerundet, damit dieselbe Bewegung in beiden
  Darstellungsvarianten vergleichbar bleibt.
- Der fehlende Preset-Schlüssel bedeutet AUS; vorhandene Version-1-Dateien
  bleiben dadurch gültig.
- Diagnose- und Menü-Sichtbarkeit bleiben flüchtig. Nur Pixel-Snap selbst wird
  als Testwert gespeichert.
- `X` ist das konfliktfreie Tastenkürzel. Es ergänzt den anklickbaren und per
  Fokus auswählbaren Schalter im `F5`-Menü.
- Pixel-Snap wird für Held und Welt empfohlen. Für die Kamera wird der
  Viewport-Snap ebenfalls empfohlen, während ihre logische Position bewusst
  ungerundet bleibt. Die im weiten Zoom sichtbare Rasterkadenz wird beim
  späteren gemeinsamen Festlegen von Filter, Maßstab und Zoom erneut geprüft.

## Prüfungen

- `python3 tools/control.py style`: erfolgreich, 67 Dateien.
- `git diff --check`: erfolgreich.
- `.venv/bin/python game/tools/generate_scale_reference_assets.py --check`:
  21 deterministische Testlabor-Assets verifiziert.
- `.venv/bin/python -m pytest tools/tests/test_source_hygiene.py
  tools/tests/test_godot_project.py tools/tests/test_repository_metadata.py -k
  'not test_concept_directories_have_simple_index_pages'`: 37 erfolgreich,
  eine wegen der ignorierten lokalen Obsidian-Konfiguration abgewählte
  Prüfung.
- `godot4 --headless --path game --script
  res://tests/bootstrap_integration_test.gd`: Godot-Integration erfolgreich.
- Reale OpenGL-Aufnahmen bei 1280 × 720 für AN und AUS sowie nahen, mittleren
  und weiten Zoom: erfolgreich erstellt und visuell sowie per Bilddifferenz
  ausgewertet.
- `python tools/control.py check` in einer sauberen Kopie des exakten
  Änderungsstands: erfolgreich; Doctor 12/12, Stil 67 Dateien, 175
  Python-Tests und Godot-Integration.

## Wiederholbarkeit und Wiederherstellung

Tests verwenden den vorhandenen isolierten `user://`-Pfad und stellen globale
Viewport- sowie Projekteinstellungen wieder her. Renderaufnahmen und lokale
Engine-Caches bleiben außerhalb des Repositorys.

## Ergebnis und Rückblick

Das Testlabor besitzt nun einen echten Pixel-Snap-Schalter im `F5`-Menü und
das zusätzliche Kürzel `X`. Menü, Diagnose, Viewport und Preset verwenden
denselben booleschen Zustand; alte und fehlerhafte Preset-Werte fallen sicher
auf AUS zurück. Die Diagnose trennt Held, tatsächliches Kamerazentrum und
Weltanker. Tests sichern außerdem, dass beide Varianten Bewegung, Kollision,
Kamerafolge und Kameragrenzen unverändert lassen und den vorherigen
Viewport-Zustand beim Verlassen wiederherstellen.

Der gerenderte Vergleich bewertet AN insgesamt als ruhiger. Das verbleibende
Abstufen entsteht beim Abbilden einer gleichmäßigen logischen Bewegung auf das
Pixelraster, besonders im weiten Zoom; ein zusätzliches logisches
Kameraruckeln wurde nicht beobachtet. Held und Welt sollen Pixel-Snap
verwenden. Für die Kamera soll der Viewport-Snap aktiv, ihre logische Bewegung
aber ungerundet bleiben. Die Empfehlung ist in der Testlabor-Dokumentation
festgehalten und nimmt die endgültige Texturfilter-Entscheidung nicht vorweg.
