<!-- PYGINDEX:NAVIGATION START -->
[Übergeordnete Übersicht](../index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Animationsreferenz

<!-- PYGINDEX:INDEX START -->
## Inhalt

### Bereiche
- [Bossanimationen](bosses/index.md)
- [Heldenanimationen](heroes/index.md)
- [Monsteranimationen](monsters/index.md)
- [NPC-Animationen](npcs/index.md)
<!-- PYGINDEX:INDEX END -->

Diese Übersicht katalogisiert alle Einheiten, für die fertige animierte
GIF-Vorschauen in der öffentlichen Dokumentation vorhanden sind. Sie lädt
selbst keine GIFs; die Vorschauen stehen ausschließlich auf den Detailseiten.

| Typ | Figur | Kurzbeschreibung | Animationen | Detailseite |
|---|---|---|---:|---|
| Held | Green Hero | Spielbarer grüner Held | 7 / 25 (6 vollständig) | [Green Hero](heroes/green-hero/index.md) |

`7 / 25 (6 vollständig)` bedeutet: Für sieben Animationstypen liegt mindestens
eine GIF-Vorschau vor. Stehen, langes Warten, Gehen, Laufen, Rennen und Sprinten
besitzen je acht Richtungsvorschauen; genervtes Warten liegt derzeit nur nach
Süden vor. Der vollständige Heldenstandard sieht 25 Animationstypen vor.

Neue Figuren erhalten genau eine Zeile in diesem Katalog und eine eigene
Detailseite in ihrer Kategorie. NPCs, Monster und Bosse müssen nicht den
Animationsumfang eines Helden besitzen; dokumentiert wird stets ihr
tatsächlich geltender Bestand.

## Assetkonvention

Dokumentations-GIFs liegen unter
`docs/game/reference/animations/<entity-type>/<entity-id>/previews/<animation>/<direction>.gif`.
Verzeichnis- und Dateinamen verwenden englisches Kebab-Case. Die acht
Richtungskürzel sind `n`, `ne`, `e`, `se`, `s`, `sw`, `w` und `nw`.

Arbeits-PNGs, Spritesheets und Godot-Ressourcen sind nicht Bestandteil dieses
Katalogs.
