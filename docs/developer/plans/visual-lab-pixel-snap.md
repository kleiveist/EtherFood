<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# Arbeitsplan: Pixel-Snap-Vergleich im visuellen Testlabor

## Zweck und Gesamtbild

Das visuelle Testlabor besitzt einen umschaltbaren Pixel-Snap-Vergleich. Der
Plan wurde am 2. September 2026 erneut geöffnet, nachdem der praktische
Nachtest die erste Korrektur widerlegt hatte: Der Held war zwar stabiler, die
Welt schimmerte mit Pixel-Snap bei `1,00 ×` und `1,50 ×` aber deutlich stärker.
Die Rasterung wird deshalb auf kleinste Ausgabepixelschritte umgestellt, ohne
Physik oder Kollision zu runden. Held, Kamera und Welt bleiben getrennt
beobachtbar.

## Ausgangslage

Schalter, Tastenkürzel, Diagnose und Preset-Persistenz waren bereits
umgesetzt. Die erste Korrektur koppelte Kamera und Heldenbild auf einem groben
Weltpixelraster und aktivierte zusätzlich Godots globales Transform-Snap. Der
Nachtest zeigte zwei Probleme: Die Kamera sprang je nach Zoom in unnötig
großen Schritten, und verschachtelte Weltobjekte wurden getrennt gerundet.
Pixel-Snap AN wirkte dadurch unruhiger als AUS. Bei AUS blieb das ursprüngliche
Kantenflackern bestehen.

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
2. Pixel-Snap als gemeinsamen visuellen Kameraanker umschalten, globales
   Transform- und Vertex-Snap im Testlabor ausgeschaltet lassen und die
   vorherigen Viewport-Zustände beim Verlassen wiederherstellen.
3. Den booleschen Wert rückwärtskompatibel im vorhandenen Version-1-Preset
   speichern und beim Öffnen anwenden.
4. Diagnose um rohe und gerasterte Heldenanzeige, rohes und gerastertes
   Kameraziel, tatsächliches Kamerazentrum, Kameraprofil, beide
   Viewport-Snap-Zustände, Darstellungsraster und Fensterskalierung ergänzen.
5. Kamera und Heldenbild im Modus AN im gemeinsamen Weltzweig auf ein Raster
   von genau einem Ausgabepixel ausrichten, während der `CharacterBody2D`
   seine Fließkommaposition behält.
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
- [x] Vollständigen Standardlauf nach der ersten Korrektur ausgeführt.
- [x] Dokumentation und Aufgabenstatus der ersten Korrektur geprüft.
- [x] Ersten Korrektur-Commit erstellt.
- [x] Praktischen Gegenbefund zur ersten Korrektur aufgenommen und Aufgabe
  erneut geöffnet.
- [x] Grobes Weltpixelraster und globales Transform-Snap durch ein
  Ausgabepixelraster ersetzt.
- [x] Automatisierte Bewegungsbilder und Laufzeittests erneut ausgeführt.
- [x] Vollständigen Standardlauf der zweiten Korrektur auf sauberem
  Commit-Stand ausgeführt.
- [ ] Korrigierte Variante praktisch bei `1,00 ×` und `1,50 ×` nachprüfen.
- [ ] Aufgabe erst nach bestätigtem Sichttest wieder abschließen.

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
- Der erste gemeinsame Darstellungsanker stabilisierte zwar die Figur, zwang
  die Kamera bei `1,50 ×` aber in eine sichtbare `6/6/3`-Pixel-Kadenz. Der
  praktische Nachtest bewertete dieses Ergebnis zu Recht als Verschlechterung.
- Das globale Transform-Snap rundet lokale CanvasItem-Transformationen
  einzeln. Es eignet sich hier nicht zusätzlich zur eigenen Kamerarasterung,
  weil die Welt aus mehreren verschachtelten Ebenen besteht.
- Ein Weltschritt muss nicht ganzzahlig sein. Entscheidend ist, dass er nach
  Kamerazoom und Fensterskalierung genau einem Ausgabepixel entspricht.
- Eine feste Viertelpixelphase verhindert, dass Gleitkomma-Rundungsfehler eine
  exakt auf der Pixelgrenze liegende Kontur abwechselnd auf beide Seiten
  rastern. Bei Nearest-Neighbor entstehen dadurch keine weichen Zwischenpixel.

## Entscheidungen

- Der Schalter verwendet eine eigene Ausgabepixel-Rasterung für Kamera und
  Heldenbild. Logische Knoten- und Physikpositionen werden nicht gerundet,
  damit dieselbe Bewegung in beiden Darstellungsvarianten vergleichbar bleibt.
- Viewport-Transform-Snap und Vertex-Snap bleiben während des Vergleichs AUS.
  Ihre vorherigen Zustände werden beim Verlassen wiederhergestellt.
- Die Rasterweite beträgt `1 / (Kamerazoom × Fensterskalierung)` Weltpixel.
  Eine Kamerabewegung kann dadurch höchstens um einen Ausgabepixel von der
  idealen kontinuierlichen Bewegung abweichen.
- Kamera und `HeroCharacter/Visual` bleiben im vorhandenen Weltzweig. Nur ihre
  lokalen Darstellungsversätze ändern sich; Geschwindigkeit,
  `move_and_slide()`, Kollisionsformen und die Position des `CharacterBody2D`
  bleiben unverändert.
- Der fehlende Preset-Schlüssel bedeutet AUS; vorhandene Version-1-Dateien
  bleiben dadurch gültig.
- Diagnose- und Menü-Sichtbarkeit bleiben flüchtig. Nur Pixel-Snap selbst wird
  als Testwert gespeichert.
- `X` ist das konfliktfreie Tastenkürzel. Es ergänzt den anklickbaren und per
  Fokus auswählbaren Schalter im `F5`-Menü.
- Eine Empfehlung für Held, Kamera und Welt wird erst nach dem erneuten
  praktischen Sichttest festgehalten. Der Zoom `1,50 ×` bleibt unabhängig
  davon bis Aufgabe 20 ein Kameraprofil-Kandidat.

## Prüfungen

Zweite Korrektur nach dem praktischen Gegenbefund:

- `python3 tools/control.py style`: erfolgreich, 68 Dateien.
- Godot-Integration mit der offiziellen Godot-4.7.2-Binärdatei: erfolgreich;
  einschließlich Ausgabepixelraster, Viewport-Zuständen, Preset, Bewegung,
  Kamera, Kollision und Diagnose.
- 288 echte OpenGL-Aufnahmen bei festen 60 Bildern pro Sekunde: Pixel-Snap AN
  zeigt bei horizontaler, vertikaler und diagonaler Bewegung in beiden
  Fenstergrößen und bei `1,00 ×` sowie `1,50 ×` jeweils eine konstante
  Heldenkontur.
- 160 verfolgte OpenGL-Ausschnitte: Tilefläche und feste Weltobjekte behalten
  mit Pixel-Snap AN in beiden Fenstergrößen und Zoomstufen jeweils exakt ein
  Rastermuster.
- Die Kamera bewegt den Canvas mit Pixel-Snap AN nur noch in ganzen
  Ausgabepixeln. Die frühere grobe `6/6/3`-Kadenz bei `1,50 ×` ist durch die
  kleinstmögliche `5/6`-Kadenz ersetzt.
- `python3 tools/control.py check` im sauberen, abgetrennten Worktree des
  exakten Korrektur-Commits nach einem Godot-Importlauf: erfolgreich; Doctor
  12/12, Stil 68 Dateien, 175 Python-Tests und Godot-Integration.

Erste Korrektur vor dem praktischen Gegenbefund:

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

## Aktueller Stand – praktische Abnahme offen

Schalter, Kürzel und Preset bleiben unverändert bedienbar. Die zweite
Korrektur entfernt das globale Transform-Snap und ersetzt das zu grobe Raster
durch den kleinstmöglichen Schritt von einem Ausgabepixel. Automatisierte
OpenGL-Bildfolgen zeigen konstante Helden-, Tile- und Weltobjektmuster; die
Kamerakadenz weicht nur noch um den unvermeidbaren einzelnen Ausgabepixel ab.
Bewegung und Kollision laufen weiter mit Fließkommawerten.

Dieser technische Befund ersetzt nicht den praktischen Nachtest, weil die
vorherige Abnahme das wahrgenommene Weltflackern übersehen hat. Aufgabe 17
bleibt deshalb 🔵, bis die Bewegung bei `1,00 ×` und `1,50 ×` erneut direkt
beurteilt wurde. Aufgabe 18 und die Freigabe des Kamerazooms werden dadurch
nicht vorweggenommen.
