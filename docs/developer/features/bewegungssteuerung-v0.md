<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Funktion: Bewegungssteuerung V0

## Ziel

Die gemeinsame Heldenfigur stellt die für den erneuten Pixel-Snap-Test
benötigten Tastaturzustände bereit: normales Laufen, Schnelllauf, Boostlauf,
Schleichen und drei Top-down-Sprungstufen. Die verbindlichen Spielregeln stehen
im Konzept unter [Bewegungssteuerung V0](../../concept/30-spielmechanik/bewegungssteuerung-v0.md).

## Umfang

Enthalten sind WASD und Pfeiltasten, aktionsbasierte Doppel-Taps,
Shift-Boost, Strg-Schleichen, Sprünge mit Leertaste, sofortiger Schleichzoom,
Kollisions- und Dialogsperren sowie Diagnosewerte im visuellen Testlabor.

Freie Tastenbelegung, vollständige Controllerunterstützung,
Barrierefreiheitsoptionen und niedrige überspringbare Hindernisse gehören nicht
zu V0. Die Geschwindigkeiten und Sprungprofile bleiben abstimmbare Testwerte.

## Entwurf

`HeroCharacter` wertet die bestehenden vier Bewegungsaktionen aus. Ein zweiter
echter Tastendruck innerhalb des konfigurierten Fensters aktiviert den
Schnelllauf; Echo-Ereignisse zählen nicht. Der Schnelllaufzustand ist von der
auslösenden Richtung getrennt und endet erst nach vollständigem Loslassen plus
kurzer Wechseltoleranz. Der Boost besitzt einen unabhängigen, während des
Schleichens weiterlaufenden Timer.

Die Werte liegen in
`res://shared/resources/hero_movement_v0.tres` auf Grundlage von
`HeroMovementConfig`. `Input.get_vector()` liefert den auf Länge eins
begrenzten Richtungsvektor für alle Geschwindigkeitsstufen.

Beim Sprung bleibt `CharacterBody2D` der kollidierende Bodenanker. Der äußere
`Visual`-Knoten bleibt für Pixel-Snap zuständig, während `JumpVisual` Figur und
Richtungsmarker entlang einer Parabel versetzt. Der Schatten bleibt außerhalb
von `JumpVisual` am Boden. Die Bewegungsrichtung am Absprung ist maßgeblich;
eine begrenzte Luftkorrektur dreht diesen Vektor nur leicht.

Der Held sendet ausschließlich `sneak_state_changed(active)`. Der gemeinsame
`PlayerCameraController` kombiniert dieses temporäre Signal mit einem
szeneneigenen `CameraProfile`: Welt und Dungeon beginnen bei 1,00×, der kleine
Heldenraum bei 1,50×. Beide Zoomachsen erhalten immer denselben Wert.

## Prüfung

Die Godot-Integration prüft alle acht Tastaturbelegungen für Doppel-Taps,
Echo- und Zeitfenster, Richtungswechsel, Geschwindigkeitsprioritäten,
Boostlaufzeit, Schleichkamera, alle Sprungprofile, Luftkorrektur, Kollisionen,
Dialogsperre und die bestehende Ratgeber-Interaktion. Die Input-Map-Regression
prüft Leertaste sowie linke und rechte Strg- und Shift-Taste ausdrücklich.

Die visuelle Pixel-Snap-Abnahme mit allen Zuständen bleibt der getrennten
Aufgabe 17.2 vorbehalten.
