<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Arbeitsplan zur Vereinfachung der Dokumentation

## Zweck und Zielbild

Die doppelte Konzeptablage wird zu einer einzigen, deutschsprachigen
Dokumentation zusammengeführt. Der verbindliche Spielkanon liegt künftig
direkt unter `docs/concept/`. Der Zwischenbereich `docs/content/`, der
Sprachordner `game(de)` und der englische Konzeptspiegel entfallen.

## Ausgangslage

Der deutsche Kanon liegt ausführlich unter `docs/concept/game(de)/`, während
`docs/content/de/` eine zweite, stärker geregelte Fassung enthält. Daneben
existiert ein veralteter englischer Spiegel. Vor Beginn dieser Arbeit hatte der
Benutzer bereits drei generierte Dateien unter `docs/content/` entfernt; diese
Löschungen bleiben erhalten und gehen in der vollständigen Entfernung des
Bereichs auf.

## Umfang und Nicht-Ziele

Zum Umfang gehören die neue Konzeptstruktur, die Übernahme der vier zuletzt
ergänzten Fachseiten, deutsche Dokumenttexte außerhalb des Forge2D-Templates,
alle betroffenen Links, Navigationsdateien und Pfadprüfungen. Das versteckte
Verzeichnis `docs/.forge2d-template/`, Spielcode, Grafiken und technische
Bezeichner im Code werden nicht inhaltlich verändert.

Die stabilen technischen Pfade `docs/assets/`, `docs/developer/` und
`docs/player-guide/` bleiben bestehen. Ihre lesbaren Inhalte werden deutsch;
die Unterteilung von `docs/developer/` bleibt unverändert.

## Konkrete Schritte

1. Alle Pfadverweise und Überschneidungen erfassen.
2. Den deutschen Kanon direkt nach `docs/concept/` verschieben und seine
   Fachordner deutsch benennen.
3. Ratgeber, Talisman, Spielablauf und die Entscheidung zum achtteiligen Ablauf
   in die einfache Konzeptstruktur übernehmen.
4. `docs/content/` und `docs/concept/game(en)/` vollständig entfernen.
5. Dokumenttexte außerhalb des Forge2D-Templates ins Deutsche übertragen.
6. Regeln, Navigation und Pfadprüfungen auf die neue Ablage ausrichten.
7. Links, Format, Generatorausgaben und verfügbare Repository-Prüfungen
   ausführen.

## Fortschritt

- 2026-08-30: Arbeitsbaum, Dokumentationsregeln, Verzeichnisumfang und
  repositoryweite Pfadabhängigkeiten erfasst.
- 2026-08-30: Zielstruktur und Ausnahmen aus dem Auftrag abgeleitet.
- 2026-08-30: Deutschen Kanon direkt nach `docs/concept/` verschoben,
  Fachordner deutsch benannt und den Content-Bereich sowie beide alten
  Sprachordner entfernt.
- 2026-08-30: Ratgeber, Talisman, achtteiligen Spielablauf und ADR-0008 in die
  neue Konzeptstruktur übernommen und alle zugehörigen Medienlinks angepasst.
- 2026-08-30: Repository-, GitHub-, Medien-, Entwicklungs- und
  Spielerhandbuchtexte auf Deutsch umgestellt. Die Forge2D-Referenz blieb
  unverändert.
- 2026-08-30: Navigation und Konzeptzusammenfassungen neu erzeugt,
  Pfadverträge aktualisiert und alle verfügbaren Prüfungen ausgeführt.

## Beobachtungen

- Das bewahrte Forge2D-Template liegt tatsächlich unter
  `docs/.forge2d-template/`; mehrere ältere Links zeigen noch auf den nicht
  vorhandenen Pfad `docs/forge2d-template/`.
- Mehrere Tests schreiben die bisherige doppelte Struktur fest und müssen mit
  der neuen, einfacheren Ablage aktualisiert werden.
- Die vier zuletzt ergänzten Seiten besitzen bereits passende Gegenstücke im
  ausführlichen Konzept. Sie werden dort zusammengeführt, nicht als dritte
  parallele Fassung fortgeführt.
- Der vorhandene Indexgenerator besitzt keine Sprachoption. Für diesen Lauf
  wurde deshalb eine flüchtige, nicht ins Repository übernommene deutsche
  Ausgabevariante verwendet; die markierten Blöcke bleiben generatorverwaltet.

## Entscheidungen

- `docs/concept/` ist künftig die einzige Quelle für Spielkonzept und Kanon.
- Deutsche Fachordner ersetzen die englisch gemischten Ordnernamen unterhalb
  des Konzepts.
- Technische Pfadnamen außerhalb des Konzepts bleiben stabil; ihre
  Dokumenttexte werden deutsch.
- Historische Forge2D-Dokumentation bleibt unverändert englisch.
- Die Dokumentation beschreibt Entscheidungen knapp und nachvollziehbar;
  zusätzliche Freigabebürokratie aus `docs/content/` wird nicht übernommen.

## Validierung

- Der lokalisierte Dokumentationsgenerator lief zunächst als Trockenlauf und
  anschließend schreibend; alle sichtbaren Indizes und Rückverweise wurden
  aktualisiert.
- `PySummary.py --py --ini --md --snippet --all` erzeugte die drei
  Konzeptzusammenfassungen neu; gespeicherte Rechnerpfade wurden entfernt.
- Die Suche nach alten Ablage- und Dateinamen findet außerhalb dieses
  historischen Plans nur die absichtlichen Negativprüfungen.
- `python3 -m unittest discover -s tools/tests -q` bestand mit 174 Tests.
- `python3 tools/control.py style` bestand für 44 Python- und GDScript-Dateien.
- `git diff --check` bestand ohne Meldung.
- `python3 tools/control.py check` lief vollständig an, bestand in dieser
  Umgebung aber nicht: Godot 4, `pytest` und eine verwendbare lokale `.venv`
  fehlen. Die innerhalb des Gates ausgeführte Stilprüfung bestand.
- Der Arbeitsbaum enthält keine Änderung unter `docs/.forge2d-template/`, und
  die entfernten Content- und Sprachverzeichnisse sind nicht mehr vorhanden.

## Wiederaufnahme und Wiederholbarkeit

Verschiebungen erfolgen mit Git und bleiben bis zu einem späteren Commit über
die Historie wiederherstellbar. Generatoren dürfen nach jeder Strukturänderung
erneut ausgeführt werden. Bereits vorhandene Änderungen werden nicht mit
destruktiven Git-Befehlen zurückgesetzt.

## Ergebnis

Das Repository besitzt nun eine einzige deutsche Konzeptquelle unter
`docs/concept/`. Die vier zuletzt ergänzten Handlungsseiten sind dort
eingegliedert; Ratgeber, Talisman und achtteiliger Ablauf bleiben vollständig
erreichbar. Die aktive Projektdokumentation ist deutsch, während die geerbte
Forge2D-Referenz unverändert englisch bleibt. Es wurden weder Spielcode noch
Grafiken inhaltlich geändert. Die Änderungen bleiben auf Wunsch ohne Commit
und Push im Arbeitsbaum.
