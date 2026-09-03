<!-- PYGINDEX:NAVIGATION START -->
[Übergeordnete Übersicht](../index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Entwicklungsdokumentation

<!-- PYGINDEX:INDEX START -->
## Inhalt

### Seiten
- [Dokumentationsstruktur](documentation-architecture.md)
- [Projektidentität](project-identity.md)

### Bereiche
- [Spielarchitektur](architecture/index.md)
- [Decisions](decisions/index.md)
- [Features](features/index.md)
- [Arbeitspläne](plans/index.md)
<!-- PYGINDEX:INDEX END -->

Dieser Bereich beschreibt die technische Arbeit an `EtherFood`. Er erklärt
Architektur und Umsetzung, ohne den Spielkanon neu auszulegen.

## Bereiche

- [Dokumentationsstruktur](documentation-architecture.md)
- [Projektidentität](project-identity.md)
- [Spielarchitektur](architecture/index.md)
- [Technische Entscheidungen](decisions/decisions.md)
- [Funktionen](features/features.md)
- [Arbeitspläne](plans/index.md)

## Grenze zum Konzept

Das [deutsche Spielkonzept](../concept/index.md) entscheidet über Spielidee,
Kanon, Handlung, Welt und Spielmechanik. Technische Seiten verweisen auf diese
Entscheidungen und beschreiben nur deren Umsetzung.

## Zweige und CI

Kanon und Handlung werden in der Konzeptphase direkt auf `main` dokumentiert.
Spätere Spielentwicklung läuft über Arbeitszweige und Pull Requests. CI führt
die schnellsten passenden Prüfungen sowie den vollständigen Lauf
`python tools/control.py check` aus. Godot- und GDScript-Tests werden
automatisiert, soweit Engine und Testwerkzeuge dies zulassen; technische
Grenzen und manuelle Ersatzprüfungen müssen im Pull Request stehen.

## Geerbte Grundlage

Die unveränderte englische
[Forge2D-Grundlage](../.forge2d-template/index.md) beschreibt Laufzeit,
Werkzeuge und deren Geschichte. Hier werden nur Ergänzungen und bewusste
Abweichungen für `EtherFood` dokumentiert.
