<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Projektidentität

## Aktueller Stand

Repository und Spiel heißen verbindlich `EtherFood`. Das maßgebliche
Repository ist `kleiveist/EtherFood`. Das Projekt befindet sich in der
Konzept- und Vorproduktionsphase; der deutsche Kanon liegt unter
[`docs/concept/`](../concept/index.md).

Die Kurzbeschreibung des privaten Repositorys lautet:

> Ein Top-down-Action-RPG über den Wiederaufbau einer verlorenen Welt, die Rückkehr ihrer Zivilisationen und vergessene Erinnerungen.

Die versionierten GitHub-Metadaten stehen in
[`.github/repository-metadata.json`](../../.github/repository-metadata.json).
Eine Änderung der Datei verändert die GitHub-Einstellungen nicht automatisch.

## Lokale technische Identität

- `config/project.toml` verwendet `display_name = "EtherFood"` und behält
  die Herkunft `template_id = "forge2d-template"`.
- `game/project.godot` verwendet `config/name="EtherFood"`.
- Interne Namen wie `g2dtool`, `g2d` und bestehende
  Bootstrap-Klassen bleiben aus Kompatibilitätsgründen erhalten.

## Herkunft

`EtherFood` entstand aus Forge2D Template. Dessen Laufzeit, Werkzeuge und
historische Dokumentation bleiben in der
[englischen Forge2D-Referenz](../.forge2d-template/index.md) unverändert
erhalten. Eine spätere Umbenennung geerbter technischer Bezeichner ist eine
eigene technische Arbeit und benötigt einen gesonderten Plan.
