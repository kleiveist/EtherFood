<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# Arbeitsplan: Pixel-Snap-Vergleich im visuellen Testlabor

## Zweck und Gesamtbild

Das visuelle Testlabor besitzt einen umschaltbaren Pixel-Snap-Vergleich. Der
Plan wurde am 2. September 2026 wieder geöffnet, nachdem die erste Abnahme den
Kamerazoom `1,50 ×` nur im effektiv ganzzahlig skalierten Fenster geprüft
hatte. Der reproduzierte Phasenwechsel der Heldenfigur bei `1920 × 1080` wird
behoben, ohne Physik oder Kollision zu runden. Held, Kamera und Welt bleiben
getrennt beobachtbar.

## Ausgangslage

Schalter, Tastenkürzel, Diagnose und Preset-Persistenz waren bereits
umgesetzt. Bei `1,00 ×` zeigte sich kein Flackern. Bei `1,50 ×` wechselte die
Heldenfigur während echter Bewegung bei `1920 × 1080` jedoch zwischen
mehreren Pixelmustern. Im Fenster `1280 × 720` wurde dieser Fehler verdeckt,
weil die Fensterskalierung von zwei Dritteln zusammen mit dem Kamerazoom eine
Ausgabeskalierung von `1,00 ×` ergab.

## Umfang und Nicht-Ziele

Im Umfang liegen der bestehende Pixel-Snap-Schalter, Preset-Persistenz, eine
erweiterte Diagnose mit rohen und gerasterten Positionen, eine rein visuelle
Rasterausrichtung für Kamera und Heldenbild sowie passende Laufzeit- und
Integrationstests. Beide Darstellungsvarianten werden bei `1,00 ×` und
`1,50 ×`, in beiden vorgesehenen Fenstergrößen und in drei Bewegungsrichtungen
neu gerendert.

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
4. Diagnose um rohe und gerundete Heldenposition, rohes und gerastertes
   Kameraziel, tatsächliches Kamerazentrum, Kameraprofil, Vertex-Snap,
   Darstellungsraster und Fensterskalierung ergänzen.
5. Kamera und Heldenbild im Modus AN auf dasselbe rationale Raster ausrichten,
   während der `CharacterBody2D` seine Fließkommaposition behält.
6. Menü-, Eingabe-, Speicher-, Bewegungs-, Kollisions-, Kamera- und
   Regressionstests ergänzen und die schnellsten Prüfungen zuerst ausführen.
7. Beide Varianten bei `1,00 ×` und `1,50 ×` sowie 1280 × 720 und
   1920 × 1080 rendern, beurteilen, dokumentieren und den vollständigen
   Standardlauf ausführen.

## Fortschritt

- [x] Aktuellen Repository-Stand, Regeln, Dokumentation, Szene und Tests
  geprüft.
- [x] Laufzeitfunktion, echtes Menüelement, Diagnose und Persistenz umgesetzt.
- [x] Aufgabenbezogene Tests ergänzt und erfolgreich ausgeführt.
- [x] Fehler bei 1,50 × und 1920 × 1080 reproduziert und Ursache eingegrenzt.
- [x] Rein visuelle Rasterausrichtung ohne Änderung der Physik umgesetzt.
- [x] Diagnose und aufgabenbezogene Laufzeittests erweitert.
- [x] Held, Tiles und Weltobjekte bei echter Bewegung getrennt geprüft.
- [x] Vollständigen Standardlauf nach der Korrektur erfolgreich ausgeführt.
- [x] Dokumentation und Aufgabenstatus abschließend geprüft.
- [x] Vorgesehenen Korrektur-Commit erstellt.

## Erkenntnisse und Überraschungen

- Der neue Ausgangsstand besitzt inzwischen eine standardmäßig eingeklappte
  `F5`-Bedienhilfe. Der Pixel-Snap-Schalter muss deshalb als echtes
  Bedienelement in diese vorhandene Struktur integriert werden.
- `P` ist bereits der allgemeinen Pause-Aktion zugeordnet. Die neue
  Testfunktion darf diese Belegung nicht wiederverwenden.
- Der erste Vergleich bei 1280 × 720 konnte den Fehler nicht zeigen:
  `1,50 ×` Kamerazoom und `0,67 ×` Fensterskalierung ergaben zusammen eine
  ganzzahlige Ausgabe.
- Bei 1920 × 1080 wechselte der Held mit Pixel-Snap und `1,50 ×` während
  horizontaler Bewegung zwischen fünf messbar unterschiedlichen
  Rastermustern.
- Godots Transform-Snap rundet lokale CanvasItem-Transformationen einzeln.
  Bei nicht ganzzahligem Zoom können Kameraübersetzung und gerundete
  Weltposition dadurch verschiedene Rasterphasen verwenden.
- Ein gemeinsamer rationaler Darstellungsanker stabilisierte die Figur. Eine
  seltene Abweichung auf exakten Halbpositionen verschwand erst, nachdem
  Kamera und Heldenbild im Pixel-Snap-Modus als Top-Level-Darstellungsanker
  von der weiterhin fraktionalen Elternposition getrennt wurden.
- Die getrennten Bildfolgen für Held, Tilefläche und Weltobjekte zeigen nach
  der Korrektur bei Pixel-Snap AN eine konstante Rasterphase. Ohne Pixel-Snap
  bleibt der ursprüngliche Vergleich sichtbar.

## Entscheidungen

- Der Schalter verwendet Godots Viewport-Transform-Snap. Logische Knoten- und
  Physikpositionen werden nicht gerundet, damit dieselbe Bewegung in beiden
  Darstellungsvarianten vergleichbar bleibt.
- Vertex-Snap bleibt während des gesamten Vergleichs AUS. Sein vorheriger
  Viewport-Zustand wird wie der Transform-Snap beim Verlassen wiederhergestellt.
- Der gemeinsame Darstellungsanker verwendet das kleinste gemeinsame Raster
  aus Kamerazoom und Fensterskalierung. Bei 1,50 × und 1920 × 1080 sind das
  zwei Weltpixel, die exakt drei Ausgabepixel ergeben.
- Nur Kamera und der Knoten `HeroCharacter/Visual` werden dafür visuell vom
  fraktionalen Körperanker getrennt. Geschwindigkeit, `move_and_slide()`,
  Kollisionsformen und die Position des `CharacterBody2D` bleiben unverändert.
- Der fehlende Preset-Schlüssel bedeutet AUS; vorhandene Version-1-Dateien
  bleiben dadurch gültig.
- Diagnose- und Menü-Sichtbarkeit bleiben flüchtig. Nur Pixel-Snap selbst wird
  als Testwert gespeichert.
- `X` ist das konfliktfreie Tastenkürzel. Es ergänzt den anklickbaren und per
  Fokus auswählbaren Schalter im `F5`-Menü.
- Pixel-Snap wird nach der Korrektur für Held, Kamera und Welt empfohlen. Der
  Zoom `1,50 ×` bleibt bis Aufgabe 20 ein Kameraprofil-Kandidat, weil sein
  Zwei-Weltpixel-Raster eine sichtbare 3-/6-Ausgabepixel-Kadenz erzeugt.

## Prüfungen

Aktuelle Wiederaufnahme:

- `python3 tools/control.py style`: erfolgreich, 68 Dateien.
- `git diff --check`: erfolgreich.
- Godot-Integration mit der offiziellen Godot-4.7.2-Binärdatei: erfolgreich;
  einschließlich Raster-, Hierarchie-, Preset-, Bewegungs-, Kamera-,
  Kollisions- und Diagnoseprüfungen.
- 288 echte OpenGL-Aufnahmen mit horizontaler, vertikaler und diagonaler
  Bewegung bei 1280 × 720 und 1920 × 1080: Fehler reproduziert und
  korrigierte Heldenfolgen rasterstabil geprüft.
- 160 zusätzliche verfolgte OpenGL-Ausschnitte: Tilefläche und beschädigte
  Weltobjekte getrennt bei 1,00 × und 1,50 × sowie AN und AUS geprüft.
- `python3 tools/control.py check` im sauberen, abgetrennten Worktree des
  exakten Commits nach einem Godot-Importlauf: erfolgreich; Doctor 12/12,
  Stil 68 Dateien, 175 Python-Tests und Godot-Integration.

Erste Umsetzung vor der Wiederaufnahme:

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

Der wiederholte gerenderte Vergleich bewertet AN insgesamt als ruhiger. Der
Phasenwechsel des Helden bei `1,50 ×` ist beseitigt; Tiles und Weltobjekte
bleiben beim Kameraschwenk auf derselben Rasterphase. Die logische Bewegung
und Kollision laufen weiter mit Fließkommawerten. Beim nahen Zoom bleibt eine
diskrete 3-/6-Ausgabepixel-Kadenz sichtbar, aber kein zusätzliches
Hin-und-Her-Springen oder wechselndes Heldenmuster. Die endgültige Freigabe
des Kamerazooms gehört weiterhin in Aufgabe 20 und nimmt die erneute
Texturfilter-Abnahme nicht vorweg.
