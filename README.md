# EtherFood

<!-- PYGINDEX:README START -->
## Dokumentation
- [Dokumentationsübersicht](docs/index.md)
- [Dokumentationsmedien](docs/assets/README.md)
- [EtherFood – Spielkonzept](docs/concept/index.md)
- [Entwicklungsdokumentation](docs/developer/index.md)
- [Entwicklungswerkzeuge](docs/developer/tooling/index.md)
- [Spielerhandbuch](docs/player-guide/index.md)

## Projektdateien
- [Repository-Regeln für EtherFood](AGENTS.md)
- [Änderungsprotokoll](CHANGELOG.md)
- [Mitarbeit an EtherFood](CONTRIBUTING.md)
- [Sicherheitsrichtlinie](SECURITY.md)
<!-- PYGINDEX:README END -->

Ein Top-down-Action-RPG über den Wiederaufbau einer verlorenen Welt, die
Rückkehr ihrer Zivilisationen und vergessene Erinnerungen. `EtherFood`
befindet sich in der Konzept- und Vorproduktionsphase.

## Dokumentation

- [Dokumentationsübersicht](docs/index.md)
- [Deutsches Spielkonzept](docs/concept/index.md)
- [Entwicklungsdokumentation](docs/developer/index.md)
- [Godot-Ressourcenimporte](docs/developer/tooling/godot-resource-imports.md)
- [Spielerhandbuch](docs/player-guide/index.md)
- [Dokumentationsmedien](docs/assets/README.md)
- [Geerbte Forge2D-Grundlage](docs/.forge2d-template/index.md)

Das Spielkonzept unter `docs/concept/` ist die einzige aktuelle Quelle für
Kanon, Handlung, Welt und Spielmechanik. Die übrige Projektdokumentation wird
ebenfalls auf Deutsch geführt. Nur die unverändert bewahrte Forge2D-Vorlage
bleibt als englische technische und historische Referenz erhalten.

## Technischer Einstieg

Das Repository verwendet Godot 4 und die geerbten Forge2D-Werkzeuge. Die
wichtigsten Befehle sind:

- Version: `0.1.0`

```text
python tools/control.py install --dry-run
python tools/control.py install --yes
python tools/control.py doctor
python tools/control.py style
python tools/control.py check
python tools/control.py godot4 import
python tools/control.py godot4 run
python tools/control.py godot4 test
```

`godot4 import` erzeugt den ignorierten Godot-Ressourcen-Cache aus den
getrackten Quell-Assets. `run`, `test` und `check` führen diese Vorbereitung
automatisch aus; ein frischer Checkout benötigt deshalb keinen eingecheckten
`game/.godot`-Ordner. Details und Fehlerdiagnose stehen unter
[Godot-Ressourcenimporte](docs/developer/tooling/godot-resource-imports.md).

Auf Systemen ohne `python` kann `python3` beziehungsweise unter Windows
`py -3.11` verwendet werden. Abhängigkeiten gehören in die lokale `.venv` und
nicht in die systemweite Python-Installation.

## Mitarbeit

Kanon- und Handlungsdokumentation wird während der Konzeptphase direkt auf
`main` gepflegt. Spätere Spielentwicklung erfolgt über Arbeitszweige und Pull
Requests mit CI-Prüfungen. Details stehen in [CONTRIBUTING.md](CONTRIBUTING.md).
Sicherheitsprobleme gehören nicht in öffentliche Issues; der vertrauliche Weg
ist in [SECURITY.md](SECURITY.md) beschrieben.

Das Projekt steht unter der [MIT-Lizenz](LICENSE).
