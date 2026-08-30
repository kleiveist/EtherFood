<!-- AUTO-GENERATED:backlink START -->
[← Zurück](plans.md)
<!-- AUTO-GENERATED:backlink END -->
# Historischer Arbeitsplan: erste Dokumentationsumstellung

Status: abgeschlossen und durch die spätere
[Vereinfachung](dokumentationsvereinfachung.md) teilweise ersetzt.

## Zweck und Gesamtbild

Am 29. August 2026 wurde das aus Forge2D entstandene Repository erstmals
sichtbar auf `ether-food` ausgerichtet. Dabei entstanden die ursprünglichen
Konzept-, Medien- und Entwicklungsbereiche.

## Ausgangslage

Projektname, Einstiegstexte und Dokumentationsstruktur zeigten noch überwiegend
die Forge2D-Vorlage. Gleichzeitig enthielt `game/project.godot` bereits
fremde lokale Änderungen, die erhalten bleiben mussten.

## Umfang und Nicht-Ziele

Geändert wurden Identität, Dokumentationsnavigation, Community-Texte und
zugehörige Strukturprüfungen. Spielmechanik, Abhängigkeiten und geerbte
Forge2D-Inhalte blieben unverändert.

## Konkrete Schritte

1. Ausgangslage und fremde Änderungen erfassen.
2. Projektidentität und Dokumentationsbereiche anlegen.
3. Navigation und Pfadprüfungen aktualisieren.
4. verfügbare Stil-, Test- und Linkprüfungen ausführen.

## Fortschritt

- 2026-08-29: Umstellung abgeschlossen und Generatorausgaben erneuert.
- 2026-08-30: Die dabei eingeführte doppelte Konzeptablage wurde mit dem
  aktuellen Vereinfachungsplan wieder entfernt.

## Erkenntnisse und Überraschungen

Der Indexgenerator liegt außerhalb des Repositorys, ist in der Arbeitsumgebung
aber verfügbar. Die vollständige Prüfung war damals ohne Godot 4 und `pytest`
nicht ausführbar.

## Entscheidungen

Geerbte technische Namen wie `g2d` und `g2dtool` bleiben aus
Kompatibilitätsgründen erhalten. Die spätere Entscheidung, nur noch ein
deutsches Konzept zu führen, ersetzt die damalige Sprach- und Ablagestruktur.

## Prüfungen

Damals bestanden Stilprüfung, eigenständige Unittests, Linkprüfung und
`git diff --check`. Der vollständige Repository-Lauf blieb wegen fehlender
lokaler Werkzeuge unvollständig.

## Wiederholbarkeit und Wiederherstellung

Die Änderungen bestanden überwiegend aus versioniertem Text und
deterministischer Navigation. Fremde Änderungen durften nicht zurückgesetzt
werden.

## Ergebnis und Rückblick

Die erste Umstellung gab dem Projekt seine sichtbare Identität. Ihre zu
aufwendige doppelte Konzeptstruktur wurde später bewusst vereinfacht.
