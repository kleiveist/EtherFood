<!-- AUTO-GENERATED:backlink START -->
[← Zurück](README.md)
<!-- AUTO-GENERATED:backlink END -->
# Mitarbeit an EtherFood

Danke, dass du `EtherFood` verbesserst. Änderungen sollen nachvollziehbar,
überschaubar und sicher bleiben.

## Passenden Arbeitsweg wählen

- Reproduzierbare Fehler und konkrete Funktionswünsche gehören in die passenden
  GitHub-Formulare.
- Vermutete Sicherheitslücken dürfen nicht öffentlich gemeldet werden. Verwende
  den vertraulichen Weg aus [SECURITY.md](SECURITY.md).
- Suche vor einem neuen Issue nach vorhandenen Meldungen.
- Größere Architekturänderungen beginnen mit einem abgestimmten Arbeitsplan
  unter `docs/developer/plans/`.

## Arbeitsumgebung vorbereiten

Das Projekt benötigt Python 3.11 oder neuer und verwendet Godot 4. Prüfe die
Installation zunächst ohne Änderungen:

```text
python tools/control.py install --dry-run
python tools/control.py install --yes
python tools/control.py doctor
```

Verwende `python3`, falls `python` nicht vorhanden ist, oder unter Windows
`py -3.11`. Python-Pakete gehören ausschließlich in die lokale `.venv`.

## Änderungen durchführen

1. Kanon und Handlung werden während der Konzeptphase als klar begrenzte
   Dokumentationsänderungen direkt auf `main` gepflegt.
2. Spielcode, Godot-Szenen und -Ressourcen, Laufzeitarchitektur und
   Entwicklungswerkzeuge werden später auf einem Arbeitszweig entwickelt und
   über einen Pull Request nach `main` übernommen.
3. Bewahre fremde oder nicht zum Auftrag gehörende Änderungen. Übernimm keine
   Caches, Exporte, lokalen Binärdateien, Zugangsdaten, Token oder
   rechnerspezifischen Pfade.
4. Beachte die geerbten
   [Python-Regeln](docs/.forge2d-template/tooling/python-style-guide.md) und
   [GDScript-Regeln](docs/.forge2d-template/tooling/gdscript-style-guide.md).
5. Aktualisiere passende Tests und Dokumentation, wenn sich Verhalten ändert.
6. Beginne jede Commit-Zeile mit einem passenden Emoji; der anschließende
   kurze Text wird weiterhin auf Englisch und im Imperativ geschrieben.

Neue Abhängigkeiten benötigen vorherige Prüfung. Halte Zweck,
Wartungsrisiko, Lizenz und geprüfte Alternativen in einem Plan oder einer
Entscheidung fest.

## Änderungen prüfen

Führe zuerst die schnellste passende Prüfung aus. Anschließend gelten:

```text
python tools/control.py style
python tools/control.py check
```

`python tools/control.py check` prüft Umgebung, Quellstil, Python-Tests und
die kopflose Godot-Integration. Für Spielentwicklung sollen Pull Requests
zusätzlich automatisierte Godot- und GDScript-Tests ausführen, soweit die
eingesetzten Werkzeuge das zulassen. Ist eine Prüfung technisch nicht
verfügbar, dokumentiert der Pull Request die Grenze, führt alle möglichen
Ersatzprüfungen aus und nennt die nötige manuelle Kontrolle. Eine ausgelassene
Prüfung darf nicht als bestanden bezeichnet werden.

## Pull Requests

Ein Pull Request beschreibt sichtbares Verhalten, Prüfungen, Dokumentation,
Risiken und Wiederherstellung. Halte ihn auf ein Thema begrenzt und löse alle
Prüf- und Reviewhinweise. Zusammenführung, Veröffentlichung und Umfangserweiterung
bleiben eine ausdrückliche Entscheidung der Projektpflege.
