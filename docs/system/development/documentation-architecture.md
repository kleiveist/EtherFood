<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Dokumentationsstruktur

Die aktive Dokumentation besitzt genau drei Oberbereiche.

| Bereich | Pfad | Aufgabe |
|---|---|---|
| System | [`docs/system/`](../index.md) | Entwicklung, Godot, Architektur, Werkzeuge und technische Geschichte |
| Game | [`docs/game/`](../../game/index.md) | Kanon, Gamedesign, Konzepte, Entscheidungen und Referenzen |
| Release | [`docs/release/`](../../release/index.md) | Roadmap, Spielerhilfe, veröffentlichte Studien und Versionen |

## Spielbereich

| Unterbereich | Aufgabe |
|---|---|
| [`canon`](../../game/canon/index.md) | Maßgebliche Quelle für Welt, Begriffe und Handlung |
| [`design`](../../game/design/index.md) | Maßgebliche Quelle für Spielregeln, Systeme, Inhalte und Gestaltung |
| [`concept`](../../game/concept/index.md) | Unverbindliche Ideen, Alternativen und offene Vorschläge |
| [`decisions`](../../game/decisions/index.md) | Begründete Änderungen an angenommenem Kanon oder Design |
| [`reference`](../../game/reference/index.md) | Nachweisbare Bestände, Karten, Vorschauen und Inspirationsmaterial |

Eine Referenz führt keine neue Spielregel ein. Ein Konzept wird erst
verbindlich, wenn sein Ergebnis in Kanon oder Design eingearbeitet wurde.
Dabei wird keine zweite aktuelle Fassung derselben Aussage behalten.

## Sprache und Status

Die aktive Projektdokumentation ist deutsch. Code, Befehle, Pfade und
technische Bezeichner dürfen Englisch bleiben. Nur die geerbte
[Forge2D-Grundlage](../.forge2d-template/index.md) bleibt unverändert
englisch.

Dokumentart und Reifegrad werden getrennt behandelt. Als Reifegrade genügen
`proposal`, `working`, `accepted` und `deprecated`. Assistentenvorschläge unter
`game/concept/` bleiben ausdrücklich unverbindlich.

## Navigation und Medien

- `docs/index.md` ist der zentrale Einstieg.
- Jeder Dokumentationsordner besitzt höchstens eine `index.md` als Einstieg.
- Relative Markdown-Links halten die Dokumentation lokal und auf GitHub
  navigierbar.
- PyGitIndex verwaltet nur die markierten Navigationsblöcke und Rückverweise.
- Dokumentationsmedien liegen bei dem Bereich, dem sie dienen.
- Animationsvorschauen liegen bei ihrer Animationsreferenz. Laufzeitassets
  bleiben unter `game/assets/` außerhalb der Dokumentation.
- Bearbeitbare oder große Produktionsquellen benötigen weiterhin eine eigene
  geprüfte Assetstrategie.
