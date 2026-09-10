<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Arbeitsplan: Dokumentationsstruktur System, Game und Release

## Zweck und Gesamtbild

Die aktive Dokumentation wird unter den drei verständlichen Oberbereichen
`docs/system/`, `docs/game/` und `docs/release/` zusammengeführt. Technische
Dokumente, Spielwissen und veröffentlichungsnahe Inhalte erhalten dadurch
eindeutige Zuständigkeiten. Innerhalb des Spielbereichs bleiben Kanon,
Gamedesign, unverbindliche Konzepte, Entscheidungen und nachweisbare
Referenzen getrennt.

## Ausgangslage

Die Dokumentation verteilt sich derzeit auf `concept`, `developer`,
`reference`, `assets`, `player-guide`, `.case-studies` und die geerbte
`.forge2d-template`. Mehrere Konzeptordner mischen Kanon, Spielmechanik,
Vorschläge und Produktionsplanung. Medien liegen getrennt von ihren
Referenzseiten. Außerdem schreiben Einstiegstexte, Tests und einzelne
Werkzeuge die alten Pfade fest. Die ungetrackte Datei `docs/Unbenannt.md`
gehört dem Benutzer und bleibt unangetastet.

## Umfang und Nicht-Ziele

Zum Umfang gehören die neue Ordnerstruktur, die inhaltliche Zuordnung aller
getrackten Dokumente und Dokumentationsmedien, konsistente Einstiegsseiten,
relative Links, Pfadverträge in Werkzeugen und Tests sowie eine einmalige
Neuerzeugung der Indizes mit PyGitIndex, sofern das Werkzeug in der Sitzung
auffindbar ist. Spielcode, Kanonaussagen, Binärinhalte und die englischen Texte
der Forge2D-Grundlage werden nicht inhaltlich verändert.

## Konkrete Schritte

1. Bestehende Pfade, Regeln, Verweise und PyGitIndex-Verfügbarkeit erfassen.
2. Zielstruktur und Dokumentationsregeln festhalten.
3. Entwicklung und Forge2D-Grundlage nach `system` verschieben.
4. Spielinhalte nach Kanon, Design, Konzept, Entscheidungen und Referenz
   aufteilen.
5. Spielerhandbuch, Studien und Roadmap unter `release` zusammenführen.
6. Medien nach ihrer tatsächlichen Rolle zuordnen.
7. alle Einstiegstexte, Links, Werkzeuge und Tests aktualisieren.
8. Indizes erzeugen und ihre Ausgabe redaktionell prüfen.
9. schnelle Pfad-, Link- und Formatprüfungen ausführen und Fehler beheben.
10. den vollständigen Standardlauf ausführen und das Ergebnis dokumentieren.

## Fortschritt

- 2026-09-10: Ausgangslage, Arbeitsregeln und bekannte Pfadabhängigkeiten
  erfasst.
- 2026-09-10: PyGitIndex 2.1.0 unter
  `/opt/pytools/PyGit/PyGitIndex.py` gefunden. Der spätere Lauf schließt
  `docs/Unbenannt.md` ausdrücklich aus und lässt versteckte Pfade aus, damit
  die Benutzerdatei und die englische Forge2D-Grundlage unverändert bleiben.
- 2026-09-10: Aktive Entwicklung und geerbte Forge2D-Grundlage unter
  `docs/system/` zusammengeführt.
- 2026-09-10: Bestehende Spieltexte nach Kanon, Design, Konzept,
  Entscheidungen und Referenz eingeordnet. Vorschläge wurden dabei nicht als
  angenommener Kanon behandelt.
- 2026-09-10: Roadmap, Spielerhandbuch und Fallstudien nach `docs/release/`
  verschoben.
- 2026-09-10: Dokumentationsbilder, Karten, Animationen und Audioquellen ihren
  neuen Spielbereichen zugeordnet; keine Binärdatei wurde verändert.
- 2026-09-10: Zentrale Einstiege, relative Verweise, Werkzeugpfade und
  Strukturtests auf die drei Oberbereiche umgestellt.
- 2026-09-10: PyGitIndex 2.1.0 einmal schreibend ausgeführt. Das Werkzeug hat
  44 Übersichten aktualisiert und die zwei fehlenden Indizes unter
  `game/concept/gameplay/` und `game/concept/handlung/` angelegt.
- 2026-09-10: Link-, Struktur-, Release-, Stil- und Community-Health-Tests
  erfolgreich ausgeführt; Python-Kompilierung und `git diff --check` sind
  ebenfalls sauber.
- 2026-09-10: Der vollständige Standardlauf fand zwei verbliebene alte Pfade
  im Metadaten-Test. Nach deren Korrektur bestehen alle 193 Python-Tests und
  die Stilprüfung; nur die Godot-Schritte können ohne installiertes Godot 4
  nicht starten.

## Erkenntnisse und Überraschungen

- Der Forge2D-Dokumentationspfad wird nicht nur verlinkt, sondern auch von
  Release- und Stilwerkzeugen sowie Tests ausgewertet.
- `docs/assets/` enthält sowohl Dokumentationsvorschauen als auch umfangreiche
  Audioquellen; bei diesem Strukturumbau werden Dateien nur zugeordnet und
  nicht konvertiert oder entfernt.
- Der Gesamtfahrplan verbindet Produktmeilensteine und technische Aufgaben.
  Sein Inhalt bleibt erhalten, wird aber im Release-Bereich klar als
  Projektroadmap eingeordnet.
- Der Standardlauf ist in dieser Sitzung unabhängig von den Änderungen durch
  die fehlende Godot-4-Installation begrenzt. Seine Python- und Stilanteile
  lassen sich vollständig ausführen.

## Entscheidungen

- `docs/index.md` bleibt der einzige zentrale Einstieg und zeigt genau die
  drei Oberbereiche.
- Der Spielbereich trennt `canon`, `design`, `concept`, `decisions` und
  `reference`.
- Die geerbte Forge2D-Grundlage bleibt unverändert englisch und behält ihren
  Namen `.forge2d-template` unter `docs/system/`.
- Vorhandene Medien werden ohne Qualitätsverlust verschoben. Produktions- und
  Speicherstrategie großer Quelldateien ist nicht Teil dieses Umbaus.
- Historische ADR-Nummern und Plandateien werden nicht neu nummeriert.

## Prüfungen

- `python3 -m unittest tools.tests.test_source_hygiene -v`: 16 Tests
  bestanden.
- `python3 -m unittest discover -s tools/tests -p 'test_release.py' -v`: 15
  Tests bestanden.
- `python3 -m unittest discover -s tools/tests -p 'test_style.py' -v`: 10
  Tests bestanden.
- `python3 -m unittest discover -s tools/tests -p 'test_community_health.py' -v`:
  10 Tests bestanden.
- `python3 -m py_compile ...`: geänderte Python-Dateien erfolgreich geprüft.
- `git diff --check`: keine Whitespace-Fehler.
- `python3 tools/control.py check`: Stilprüfung für 82 Dateien und alle 193
  Python-Tests bestanden. Der Gesamtlauf endet mit Status 1, weil Godot 4 in
  der Sitzung fehlt; Ressourcenimport und Headless-Integrationstest konnten
  deshalb nicht starten.

## Wiederholbarkeit und Wiederherstellung

Verschiebungen erfolgen als nachvollziehbare Git-Renames. Bestehende
Benutzeränderungen werden nicht zurückgesetzt. Indexerzeugung wird erst nach
den manuellen Struktur- und Linkänderungen ausgeführt und anschließend über
den Git-Diff geprüft.

## Ergebnis und Rückblick

Die aktive Dokumentation besitzt nun genau die Oberbereiche `system`, `game`
und `release`. Der Spielbereich trennt verbindlichen Kanon und Gamedesign von
Konzepten, Entscheidungen und Referenzen. Forge2D, aktive Entwicklung,
Roadmap, Spielerhandbuch, Studien sowie sämtliche vorhandenen
Dokumentationsmedien liegen bei ihrem jeweiligen Zweck. PyGitIndex hat die
Navigation nach den Verschiebungen neu aufgebaut. Werkzeuge und Tests folgen
den neuen Pfaden, und `docs/Unbenannt.md` blieb unverändert.
