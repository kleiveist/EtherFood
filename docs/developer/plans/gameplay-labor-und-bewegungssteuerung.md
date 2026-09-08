<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Arbeitsplan: Gameplay-Labor und Bewegungssteuerung

## Zweck und Gesamtbild

Das visuelle Testlabor erhält einen sechsten, scrollbar aufgebauten
`Gameplay`-Tab. Darin lassen sich sichere Testwerte für Schleichen, Gehen,
Laufen, Rennen, Sprinten sowie die zugehörigen Sprünge unmittelbar erproben.
Lokale Testwerte verändern den versionierten Spielstandard erst nach einer
ausdrücklichen Übernahme. Die überholte gebündelte Maßstabsauswahl entfällt
zugunsten der bereits vorhandenen Einzeleinstellungen.

## Ausgangslage

`HeroCharacter` kennt Schleichen, normales Laufen, Schnelllauf und einen auf
fünf Sekunden begrenzten Boost sowie drei Sprungprofile. Das F5-Menü enthält
fünf Tabs und kann drei Maßstabsprofile als Bündel anwenden. Seine lokalen
Einstellungen werden mit Schema-Version 2 gespeichert. Die Bewegungsressource
des Laborhelden ist dieselbe geladene Ressource wie der Spielstandard und darf
deshalb nicht direkt durch Testregler verändert werden.

Im Arbeitsbaum liegen vor Beginn bereits Änderungen an vier versionierten
Standardressourcen. Sie gehören dem Benutzer, werden nicht zurückgesetzt und
nicht in den Commit dieses Arbeitspakets aufgenommen.

## Umfang und Nicht-Ziele

Im Umfang liegen die neue Zustandsfolge, Feststelltasten-Gehen,
richtungsübergreifend fortgesetztes Rennen, gehaltenes Shift-Sprinten, ein
reiner Stehsprung, vier Bewegungssprünge, sichere numerische Regler,
Laufzeitkopie und lokale Speicherung der Testwerte, fokussierte Übernahme in
die Bewegungsressource, Diagnosewerte, ausgegraute Platzhalter, Tests und
deutsche Dokumentation.

Nicht enthalten sind Ausdauer, Sprungangriffe, Ausweichen, Schleichrolle,
Ausweich-Backflip, freie Tastenbelegung oder neue Controllerregeln. Diese
Mechaniken erscheinen nur als deaktivierte Platzhalter.

## Konkrete Schritte

1. Die Änderungen am angenommenen Maßstabs- und Bewegungskanon durch
   Folgeentscheidungen dokumentieren.
2. Bewegungsressource und Heldenzustandsmaschine auf Schleichen, Gehen,
   Laufen, Rennen und Sprinten sowie fünf Sprungarten umstellen.
3. Die gebündelte Maßstabsauswahl samt Laufzeitpfaden entfernen und die
   Einzeleinstellungen erhalten.
4. Einen scrollbar aufgebauten Gameplay-Tab mit begrenzten Reglern,
   Standardmarkierung und deaktivierten Zukunftsplatzhaltern ergänzen.
5. Im Labor eine tiefe Bewegungsressourcen-Kopie verwenden, Testwerte lokal
   speichern und nur den fokussierten Wert ausdrücklich übernehmen.
6. Diagnose, Tests und passende deutsche Dokumentation aktualisieren.
7. Erst schnelle Prüfungen, danach Godot-Integration und den vollständigen
   Standardlauf ausführen; anschließend nur das Arbeitspaket committen.

## Fortschritt

- [x] 2026-09-08: Repository-Regeln, Kanon, bestehende Pläne, Laufzeitcode,
  Tests und vorbestehende Änderungen geprüft.
- [x] 2026-09-08: Zielverhalten und Reglergrenzen mit dem Benutzer bestätigt.
- [x] 2026-09-08: Kanonentscheidungen und technische Dokumentation
  aktualisiert.
- [x] 2026-09-08: Bewegungslogik und versionierte Ressource umgestellt.
- [x] 2026-09-08: F5-Menü und lokale Gameplay-Einstellungen umgesetzt.
- [x] 2026-09-08: Tests aktualisiert und um Gameplay-Laborregressionen
  ergänzt.
- [x] 2026-09-08: Schnelle Prüfungen, Godot-Integration und vollständigen
  Standardlauf erfolgreich ausgeführt.
- [x] 2026-09-08: Abgeschlossenes Arbeitspaket isoliert zum Commit
  vorbereitet.

## Erkenntnisse und Überraschungen

- Der bestehende Laufzeitpfad lädt `hero_movement_v0.tres` direkt in die
  Figur. Das Labor muss die Ressource vor jeder Regleränderung tief duplizieren.
- Die gebündelte Maßstabsübernahme besitzt eigene UI-, Speicher-, Diagnose-
  und Testpfade; ihre Entfernung ist mehr als das Ausblenden einer Zeile.
- Vier Standardressourcen sind bereits vor dieser Arbeit lokal geändert. Die
  spätere Commit-Auswahl muss sie ausdrücklich ausschließen.
- Eine automatisch umbrechende Statuszeile vergrößerte bei geschlossenem
  Menü zunächst dessen Mindesthöhe. Eine feste einzeilige Mindestfläche hält
  das Werkzeugfenster wieder innerhalb seiner bisherigen `600 × 684` Pixel.
- Ein über `GODOT4_BIN` gesetzter Testpfad beeinflusst absichtlich auch
  Werkzeugtests, die die Engine-Suche isoliert prüfen. Der vollständige Lauf
  verwendet deshalb die offizielle Binärdatei über einen temporären
  `PATH`-Eintrag.

## Entscheidungen

- Anfangsgeschwindigkeiten: Schleichen `60`, Gehen `100`, Laufen `220`,
  Rennen `310`, Sprinten `400` Weltpixel pro Sekunde.
- Geschwindigkeitsregler reichen von `40` bis `500 px/s` in Fünferschritten.
- Sprunghöhen reichen von `8` bis `64 px`, Bewegungssprungweiten von `16` bis
  `160 px`, jeweils in Einerschritten.
- Der Stehsprung besitzt einen eigenen Höhenwert von zunächst `24 px` und
  immer `0 px` Weite.
- Ein Schleichsprung ist ein Stehsprung. Schleichen pausiert in der Luft und
  wird nach der Landung wieder aktiv, wenn Strg weiterhin gehalten wird.
- Rennen endet erst nach vollständigem Stillstand; Sprinten ist Rennen bei
  gehaltenem Shift und fällt beim Loslassen auf Rennen zurück.

## Prüfungen

- `python tools/control.py style`: konnte nicht starten, weil in dieser
  Sitzung kein Befehl `python` vorhanden ist.
- `python3 tools/control.py style`: erfolgreich; 78 Quelldateien bestanden.
- `python3 -m unittest tools.tests.test_godot_project
  tools.tests.test_source_hygiene -v`: erfolgreich; 37 Tests bestanden.
- Godot 4.7.2, gezielte Runtime-Suites für Bewegungssteuerung,
  Gameplay-Labor und F5-Menüvertrag: jeweils ohne Fehler bestanden.
- `PATH=/tmp/etherfood-godot-4.7.2-test:$PATH .venv/bin/python
  tools/control.py check` in einem isolierten Worktree mit ausschließlich
  diesem Arbeitspaket: erfolgreich; Doctor 12/12, Stilprüfung für 78 Dateien,
  189 Python-Tests, Ressourcenimport und vollständige Godot-Integration
  bestanden.
- `git diff --check`: erfolgreich.

## Wiederholbarkeit und Wiederherstellung

Reglerwerte werden begrenzt und in einer versionierten lokalen
`ConfigFile`-Struktur gespeichert. Ungültige oder veraltete Werte fallen auf
den geladenen Spielstandard zurück. Die tiefe Ressourcenkopie hält Vorschau
und Standard getrennt. Änderungen erfolgen gezielt mit Patches; vorbestehende
Dateiänderungen bleiben unangetastet.

## Ergebnis und Rückblick

Das Testlabor besitzt nun einen sechsten, scrollbar aufgebauten
Gameplay-Bereich mit sicheren Reglern, unmittelbarer Laufzeitvorschau und
fokussierter Einzelwertübernahme. Die fünf Bewegungs- und fünf Sprungzustände
folgen der neuen Tastaturregel. Die gebündelten Maßstabsprofile und ihre
Ressourcen sind entfernt; die manuellen Einzelwerte bleiben erhalten.

Die tiefe Vorschaukopie verhindert unbeabsichtigte Standardänderungen. Der
vollständige Prüflauf erfolgte in einem isolierten Worktree, damit die vier
vorbestehenden, nicht zum Arbeitspaket gehörenden Ressourcenänderungen weder
verändert noch in das Ergebnis eingemischt wurden.
