# Änderungsprotokoll

Bedeutende Änderungen an diesem Projekt werden in dieser Datei festgehalten.

## Unveröffentlicht

### Hinzugefügt

- `python tools/control.py godot4 import` führt einen expliziten kopflosen
  Godot-Ressourcenimport aus.

### Geändert

- Run, Test und Release-Gate bereiten Godot-Ressourcen vor dem jeweiligen
  Zielprozess automatisch auf.
- Frische Checkouts erzeugen ihren ignorierten Cache selbst, sodass fehlende
  `.ctex`-Dateien nicht mehr zu einer Kaskade irreführender Folgefehler führen.

## Forge2D-Template v0.1.0 - 2026-08-28

### Hinzugefügt

- Erste Repository-Grundlage mit Godot-Projekt, Python-Befehlszeile, Tests und
  Dokumentation.
- Installations-, Prüf-, Export- und Veröffentlichungswerkzeuge für Linux,
  Windows und macOS.
- CI-Prüfungen für Python, Godot und native Exporte.
- Grundlegende Laufzeitstruktur, Eingabebelegung und kopflose
  Integrationstests.
- Verbindliche Python- und GDScript-Stilregeln.
- MIT-Lizenz sowie Vorlagen für Mitarbeit und Sicherheitsmeldungen.

### Geändert

- Die Installation prüft Python, `venv`, `pip`, Godot und deklarierte
  Python-Pakete und beschränkt Paketänderungen auf `.venv`.
- Trockenläufe verändern das System nicht; `--yes` ermöglicht bestätigte
  unbeaufsichtigte Schritte.
- Die ursprüngliche Forge2D-Identität wurde als technische Herkunft bewahrt,
  während das aktive Projekt `EtherFood` heißt.
