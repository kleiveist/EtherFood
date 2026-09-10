<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Arbeitsplan: Themenmenü und Spielstandards im visuellen Testlabor

## Zweck und Gesamtbild

Das visuelle Testlabor erhält ein erweiterbares, nach Themen gegliedertes
`F5`-Menü. Alle veränderlichen Testparameter werden darin ohne eigene
Direktkürzel bedient. `F3` für Diagnose, `F4` für Kollisionsflächen und `F5`
für das Menü bleiben erhalten.

Jede übernehmbare Auswahl unterscheidet einen sofort sichtbaren lokalen
Testwert von einem versionierten Spielstandard. Der Spielstandard bleibt mit
goldenem Rahmen und Stern sichtbar, während weitere Varianten ausprobiert
werden. Ein sichtbarer Knopf oder `Strg + Alt + E` übernimmt ausschließlich
den fokussierten Wert beziehungsweise ein vorher bestätigtes Bündel. Kamera-
Zooms werden getrennt für Außenwelt, Dorf, Dungeon und kleinen Innenraum
geführt und von passenden Spielszenen als Basisprofil gelesen.

## Ausgangslage

Die freigegebene Zielspezifikation steht in
`docs/system/development/features/visuelles-testlabor.md`. Die aktuelle Szene besitzt
ein langes, links eingeblendetes Bedienpanel, zahlreiche direkte Input-
Actions und fünf anklickbare Schalter. Testwerte werden bei jeder Änderung in
`user://visual_lab_settings.cfg` gespeichert. Diese lokale Datei ist laut
vorhandener Architektur keine Produktionsquelle.

Der angenommene Maßstab liegt bereits in
`game/shared/resources/visual_baseline_v0.tres`. Die Kamera verwendet
`CameraProfile`-Ressourcen für Welt beziehungsweise Dungeon mit `1,00×` und
kleine Innenräume mit `1,50×`. Ein eigenes Dorfprofil und eine zentrale
Zuordnung aller vier Zielbereiche fehlen. Nebel- und Lichtstandards liegen
derzeit als Konstanten in der Testvorschau, nicht in gemeinsam genutzten
Produktionsressourcen.

`game/scenes/dev/visual_lab.gd` und `visual_lab.tscn` sind bereits groß und
werden von zwölf spezialisierten Laufzeittests abgedeckt. Der Container besitzt
zurzeit weder Godot 4 noch `pytest`; statische und Python-Unittest-Prüfungen
sind verfügbar, Laufzeittests müssen bis zu einer Umgebung mit Godot als nicht
ausgeführt ausgewiesen werden.

## Umfang und Nicht-Ziele

Im Umfang liegen das kompakte Themenmenü, die Neuordnung aller vorhandenen
Laborsteuerungen, die Entfernung ihrer direkten Testkürzel, die ausdrückliche
Erhaltung von `F3` und `F4`, getrennte Test- und Spielwerte, sichere
Übernahme, Goldmarkierung, vier Zoomkontexte, lokale Migration, gemeinsame
Produktionsressourcen sowie aktualisierte Laufzeit- und Dokumentationstests.

Das Menü bleibt eine entwicklungsinterne Funktion. Es führt keine Git-Commits
aus, macht keine offenen Designwerte ohne Benutzeraktion verbindlich und
ändert weder Bewegung, Physik, Sprunglogik, temporären Schleichzoom noch die
inhaltliche Bedeutung beschädigter und wiederhergestellter Weltzustände.
Grafikassets und Produktionskarten werden nicht neu gestaltet.

## Konkrete Schritte

1. Vorhandene Tests, Input-Verträge, Szenenpfade und Ressourcenverbraucher
   vollständig erfassen; die Zielzustände als neue oder angepasste Tests
   formulieren.
2. Eine typisierte Quelle für übernommene Darstellungswerte und eine Zuordnung
   der vier Kamera-Zielbereiche schaffen. Bestehende V0-Werte ohne
   Kanonänderung übernehmen; das Dorf erbt anfangs den Außenweltwert.
3. Das `F5`-Panel in eine kompakte Menüszene mit Themenleiste,
   scrollbarem Inhalt, eindeutiger Fokusführung und wiederverwendbaren
   Auswahlzeilen umbauen.
4. Alle vorhandenen Laborparameter in Kamera, Maßstab, Darstellung, Welt und
   Atmosphäre sowie Diagnose und Hilfe einsortieren. Direkte Parameter-
   Actions aus Eingabelogik und Projektkonfiguration entfernen; `F3`, `F4`,
   `F5`, normale Spielsteuerung und `Esc` erhalten.
5. Lokalen Testzustand und versionierten Spielstandard voneinander trennen,
   alte lokale Version-1-Werte migrieren und ungültige Werte auf den
   Spielstandard zurückfallen lassen.
6. Goldrahmen, Stern, Statusanzeige, sichtbaren Übernahmeknopf,
   `Strg + Alt + E`, Fokusbegrenzung, Bestätigung gebündelter Werte und
   verlässliche Fehlermeldungen umsetzen.
7. Spielszenen und Kamera so anbinden, dass sie ausschließlich die
   versionierten Zielbereichsprofile als Basiswerte verwenden. Temporäre
   Kameraüberlagerungen bleiben davon unabhängig.
8. Tests und deutsche Dokumentation an den tatsächlichen Endzustand anpassen,
   schnelle Prüfungen zuerst und anschließend den vollständigen
   Repository-Standardlauf ausführen, soweit die Umgebung ihn erlaubt.

## Fortschritt

- [x] 2026-09-07: Repository-Regeln, freigegebene Funktionsspezifikation,
  bestehende Szene, Persistenz, Ressourcen und relevante Tests gesichtet.
- [x] 2026-09-07: Fortlaufenden Arbeitsplan angelegt.
- [x] 2026-09-07: Zieltests für Menü, Eingaben, Markierungen, Übernahme und Zoomkontexte
  festgelegt.
- [x] 2026-09-07: Produktionsressourcen und lokale Migration umgesetzt.
- [x] 2026-09-07: Themenmenü und alle Einstellungszeilen umgesetzt.
- [x] 2026-09-07: Direkte Parameterkürzel entfernt; `F3`, `F4` und `F5`
  durch Quell- und Laufzeitverträge abgesichert.
- [x] 2026-09-07: Vorhandenen Spielverbraucher auf die zentrale Zuordnung
  der angenommenen Ressourcen ausgerichtet.
- [x] 2026-09-07: Tests und Dokumentation an den Endzustand angepasst.
- [x] 2026-09-07: Abschlussprüfungen ausgeführt und Ergebnis festgehalten.
- [x] 2026-09-07: Nachtrag umgesetzt: F5 als schmales Werkzeugfenster,
  Bewegung bei geöffnetem Menü und kompakte transparente Diagnose.

## Erkenntnisse und Überraschungen

- Die bestehende Trennung zwischen lokaler Testdatei und versionierter
  Maßstabsressource entspricht bereits dem neuen Zustandsmodell und wird
  ausgebaut statt ersetzt.
- Diagnose und Kollisionsanzeige sind reine Werkzeuge. Sie bleiben direkt
  erreichbar, erhalten aber weder Goldmarkierung noch Persistenz.
- Der vorhandene Schleichzoom ist eine temporäre Überlagerung des
  Basisprofils und darf durch die neuen Bereichswerte nicht ersetzt werden.
- Ein statischer Python-Projektvertrag erwartete noch eigene Nebel- und
  Lichtkürzel. Er wurde an die beschlossene Menübedienung und die verbliebenen
  globalen Kürzel angepasst.
- Der lokale Standardlauf kann die Godot-Ressourcen und Laufzeittests nicht
  starten, weil im Container keine Godot-4-Engine vorhanden ist. `pytest`
  fehlt ebenfalls; dieselben 189 Tooltests liefen erfolgreich über
  `unittest`.
- Drei statt fünf Tabellenspalten halten die Themenwahl schmal, ohne einen
  Themenbereich zu verstecken. Die fünf Bereiche verteilen sich auf zwei
  Zeilen.

## Entscheidungen

- Die freigegebene Funktionsseite ist die verbindliche Zielreferenz dieses
  Plans. Abweichungen werden dort und hier nachvollziehbar festgehalten.
- Gold kennzeichnet ausschließlich den versionierten Spielstandard; Fokus und
  aktuelle Testauswahl verwenden getrennte visuelle Zustände und zusätzlichen
  Text.
- `Strg + Alt + E` ist nur bei offenem Menü und fokussiertem übernehmbarem
  Eintrag wirksam. Das Menü bietet dieselbe Aktion ohne Tastatur an.
- Außenwelt, Dorf, Dungeon und kleiner Innenraum besitzen stabile IDs. Eine
  geerbte Auswahl bleibt von einem ausdrücklich angenommenen eigenen Wert
  unterscheidbar.
- Lokale Testwerte und Produktionswerte dürfen nicht dieselbe Speicherquelle
  verwenden.
- `visual_lab_standards_v0.tres` ist die zentrale Zuordnung. Der bestehende
  Maßstab und die bestehenden Kamerawerte bleiben eigenständige referenzierte
  Ressourcen, damit vorhandene Spielverbraucher keine Wertkopien benötigen.
- Kandidat B besitzt eine unveränderliche Vergleichsressource. Dadurch bleibt
  die Reihe A/B/C aussagekräftig, wenn der beschreibbare Produktionsstandard
  später ausdrücklich geändert wird.
- Der vorhandene Heldenraum liest Heldenhöhe, Tilegröße und das Profil für
  kleine Innenräume über dieselbe zentrale Zuordnung. Dorf-, Dungeon- und
  Atmosphärenprofile stehen für die späteren passenden Spielszenen bereit.
- Das F5-Werkzeug misst im logischen Referenzraum `600 × 684` Pixel. Es
  verändert den Bewegungszustand der Figur nicht. Das F3-Panel misst
  `450 × 620` Pixel und verwendet einen Hintergrund mit `58 %` Deckkraft.

## Prüfungen

- `python3 tools/control.py style`: bestanden, 77 Dateien geprüft.
- `python3 -m unittest discover -s tools/tests -p 'test_*.py'`: bestanden,
  189 Tests.
- `python3 -m unittest tools.tests.test_source_hygiene`: bestanden, 16 Tests.
- Statische Szenen-, Ressourcen-, UID- und `res://`-Pfadprüfungen: bestanden.
- `git diff --check`: bestanden.
- `python3 tools/control.py check`: ausgeführt, aber nicht vollständig
  bestanden. Die enthaltene Stilprüfung bestand; Doctor, `pytest`,
  Godot-Ressourcenimport und Godot-Laufzeittests konnten wegen fehlendem
  Godot 4, fehlender `.venv` und fehlendem `pytest` nicht erfolgreich laufen.

## Wiederholbarkeit und Wiederherstellung

Tests erhalten isolierte Pfade für lokale Arbeitsstände und temporäre Kopien
versionierter Standardressourcen. Kein Test darf die echten angenommenen
Projektwerte verändern. Die alte lokale Einstellungsdatei wird nur gelesen und
kontrolliert migriert; bei ungültigem Inhalt bleibt der versionierte Standard
unverändert. Alle Produktionsänderungen bleiben als normale Git-Diffs
sichtbar und können dateiweise zurückgenommen werden.

## Ergebnis und Rückblick

Das visuelle Testlabor besitzt nun ein kompaktes, bei `1280 × 720`
bedienbares Fünf-Themen-Menü. Parameteränderungen erfolgen dort ohne eigene
globale Kürzel; `F3`, `F4` und `F5` bleiben erhalten. Die Figur bleibt bei
geöffnetem Menü beweglich. Lokale Vorschauwerte verwenden Schema 2 und vier
getrennte Kamerakontexte. Spielstandards werden unabhängig davon aus
versionierten Ressourcen gelesen, gold und zusätzlich textuell markiert und
nur über den sichtbaren Knopf oder `Strg + Alt + E` übernommen.
Maßstabsbündel benötigen eine Bestätigung mit allen betroffenen Werten.

Die vorhandenen V0-Werte wurden nicht geändert, daher war keine neue
Konzeptentscheidung erforderlich. Die geschriebenen Godot-Laufzeitverträge
müssen in einer Umgebung mit Godot 4 noch tatsächlich ausgeführt werden; der
verfügbare statische und Python-basierte Prüfstand ist vollständig grün.

Nachtrag vom 7. September 2026: Auf Wunsch bleibt das F5-Menü nicht
bildfüllend, sondern wird als kompaktes Werkzeugfenster über der weiterhin
sicht- und begehbaren Testwelt angeordnet. Die Diagnose wird ebenfalls
verkleinert und erhält einen halbtransparenten Hintergrund. Der Nachtrag ist
umgesetzt und durch statische sowie neue Godot-Laufzeitverträge abgesichert.
