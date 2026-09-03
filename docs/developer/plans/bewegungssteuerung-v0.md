<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# Arbeitsplan: Bewegungssteuerung V0

## Zweck und Gesamtbild

Aufgabe 17.1 zieht eine klar begrenzte Tastatursteuerung vor die erneute
Pixel-Snap-Abnahme. Der gemeinsame Held erhält normales Laufen, aktionsbasierte
Doppel-Taps für Schnelllauf, einen nicht verlängerbaren Fünf-Sekunden-Boost,
Schleichen mit temporärem Kamerazoom und drei Top-down-Sprungstufen. Aufgabe
17.2 prüft diese Zustände anschließend getrennt mit Pixel-Snap.

## Ausgangslage

`HeroCharacter` bewegt einen `CharacterBody2D` mit einem einzelnen Wert von
220 Weltpixeln pro Sekunde und `move_and_slide()`. Der Heldenraum und das
visuelle Testlabor aktivieren dieselbe Kindkamera, setzen deren Zoom jedoch
direkt. Der Held besitzt eine visuelle Gruppe mit Figur und Schatten, aber
keinen Sprungzustand. Die Ratgeber-Nachricht sperrt die vorhandene Bewegung.

## Umfang und Nicht-Ziele

Im Umfang liegen die drei neuen Tastaturaktionen, eine datenbasierte
Bewegungskonfiguration, Laufzustände und Prioritäten, aktionsbasierte
Doppel-Tap-Erkennung ohne Tastatur-Echos, Sprungdarstellung bei unveränderter
Bodenkollision, Szenen-Kameraprofile, Schleichzoom, Diagnosewerte sowie
deterministische Laufzeit- und Regressionstests.

Nicht enthalten sind freie Tastenbelegung, vollständige Controllersteuerung,
Barrierefreiheitsoptionen, niedrige überspringbare Hindernisse, Animationen,
Balance-Freigabe oder Änderungen am Pixel-Snap-Verfahren. Diese Punkte bleiben
Aufgabe 83, Aufgabe 84 beziehungsweise späteren Mechanikaufgaben vorbehalten.

## Konkrete Schritte

1. V0-Regeln im Spielkonzept und die Vorziehung gegenüber Aufgabe 83 als
   Entscheidung festhalten.
2. `HeroMovementConfig`, das V0-Resource und Kamera-Profile ergänzen.
3. `HeroCharacter` um Doppel-Taps, Bewegungspriorität, Boosttimer,
   Schleichsignal und kollisionsgebundene Top-down-Sprünge erweitern.
4. Heldenraum und Testlabor an den gemeinsamen Kamera-Controller anbinden.
5. Testlabor-Diagnose um Bewegung, Sprung sowie Basis- und Aktivzoom ergänzen.
6. Input-, Zustands-, Sprung-, Kamera-, Kollisions-, Dialog- und
   Interaktionsregressionen ergänzen.
7. Schnelle Prüfungen, Godot-Integration, Projektstart und vollständigen
   Standardlauf ausführen; danach ausschließlich Aufgabe 17.1 committen.

## Fortschritt

- [x] 2026-09-03: Repository-Regeln, Kanon, Fahrplan, bestehende Pläne und
  Laufzeitcode geprüft.
- [x] 2026-09-03: Relevante Godot-4.7-Verträge für Aktionen,
  Echo-Ereignisse, Eingabevektoren, Kamera-Zoom und `move_and_slide()`
  verifiziert.
- [x] 2026-09-03: Konzeptentscheidung und technische Dokumentation ergänzt.
- [x] 2026-09-03: Ressourcen, Heldenzustände und Kamera-Controller
  implementiert.
- [x] 2026-09-03: Diagnose und Szenenintegration umgesetzt.
- [x] 2026-09-03: Automatische Tests ergänzt und ausgeführt.
- [x] 2026-09-03: Technische V0-Umsetzung und automatisierte Prüfungen
  abgeschlossen.
- [ ] Praktische Gesamtfreigabe der Bewegungssteuerung V0 nach aktuellem
  Projektstatus noch offen.

## Erkenntnisse und Überraschungen

- Das Testlabor richtet den äußeren Helden-Visualknoten für Pixel-Snap aus.
  Die Sprunghöhe braucht deshalb einen inneren visuellen Knoten, damit beide
  Versätze unabhängig bleiben und Aufgabe 17.2 nicht vorweggenommen wird.
- Die Laufzeit-Hygiene verbietet konkrete Tastencodes und konkrete
  Tastatur-Ereignisklassen. Die Doppel-Tap-Erkennung bleibt vollständig an den
  vier Bewegungsaktionen und dem allgemeinen `InputEvent`-Vertrag.
- Die installierte Projektversion ist bereits auf Godot 4.7 ausgerichtet; die
  vom Benutzer genannten Engine-Verträge passen zum Repository.
- Godot unterscheidet die Position linker und rechter Modifikatortasten beim
  Action-Matching nur für physische Tastencodes. Logische Ctrl- oder
  Shift-Ereignisse mit zwei Positionen werden beim Laden zusammengeführt.
  Deshalb verwenden die neuen Modifier-Aktionen physische Tastencodes mit
  ausdrücklich linker und rechter Position.

## Entscheidungen

- Der äußere `Visual`-Knoten bleibt der vorhandene Pixel-Snap-Anker. Ein neuer
  innerer `JumpVisual` bewegt Figur und Richtungsmarker; der Schatten bleibt am
  äußeren Bodenanker.
- Sprünge verwenden Entfernung geteilt durch Dauer als horizontale
  Grundgeschwindigkeit. Der Absprungvektor bleibt maßgeblich und kann in der
  Luft nur begrenzt in Richtung der aktuellen Eingabe gedreht werden.
- Der Boosttimer läuft unabhängig von Schleichen weiter und wird bei einer
  erneuten Auslösung nicht gesetzt, solange Restzeit vorhanden ist.
- Szenen setzen keine Kamera-Zoomwerte mehr direkt. Sie geben dem
  Kamera-Controller ein Profil; der Controller überlagert es beim Schleichen
  sofort mit 1,50×.

## Prüfungen

- `python3 tools/control.py style`: erfolgreich, 72 Quelldateien geprüft.
- `.venv/bin/python -m pytest tools/tests/test_godot_project.py
  tools/tests/test_source_hygiene.py -q`: 33 Tests bestanden.
- `.venv/bin/python tools/control.py godot4 test` mit Godot 4.7.2 im
  temporären `PATH`: Bootstrap-Integration bestanden.
- Godot 4.7.2 mit `--headless --path game --quit-after 5`: Projektstart ohne
  Fehler beendet.
- `.venv/bin/python tools/control.py check` mit Godot 4.7.2 im temporären
  `PATH`: 12 Doctor-Prüfungen, Stilprüfung, 176 Python-Tests und
  Godot-Integration bestanden; Release Gate erfolgreich.

## Wiederholbarkeit und Wiederherstellung

Die V0-Werte liegen in versionierten Godot-Ressourcen. Tests lösen ausschließlich
benannte Aktionen aus, geben sie bei jeder Bereinigung frei und entfernen alle
erzeugten Szenen. Godot-Importcaches bleiben ignoriert. Änderungen erfolgen
gezielt ohne destruktive Git-Befehle.

## Ergebnis und Rückblick

Die gemeinsame Heldenklasse besitzt alle vereinbarten V0-Zustände und hält
Bewegungspriorität, Kameraüberlagerung, Sprungdarstellung und Bodenkollision
getrennt. Alle acht Richtungstasten teilen dieselbe aktionsbasierte
Doppel-Tap-Logik; Boost, Schleichen, Sprung und Dialogsperre sind durch
Laufzeittests abgesichert. Das Testlabor zeigt Basis- und Aktivzoom sowie
Bewegungs- und Sprungzustand.

Das Pixel-Snap-Verfahren blieb unverändert; Aufgabe 17.2 wurde anschließend
getrennt geprüft und abgeschlossen. Die praktische Gesamtfreigabe der
Bewegungssteuerung V0 bleibt laut aktuellem Projektstatus offen, weshalb das
Arbeitspaket weiterhin 🟡 geführt wird.
