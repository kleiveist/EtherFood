<!-- PYGINDEX:NAVIGATION START -->
[Zur Spiel- und Assetreferenz](../index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Animationsreferenz

Diese Übersicht katalogisiert alle Einheiten, für die fertige animierte
GIF-Vorschauen in der öffentlichen Dokumentation vorhanden sind. Sie lädt
selbst keine GIFs; die Vorschauen stehen ausschließlich auf den Detailseiten.

| Typ | Figur | Kurzbeschreibung | Animationen | Detailseite |
|---|---|---|---:|---|
| Held | Green Hero | Spielbarer grüner Held | 6 / 25 (5 vollständig) | [Green Hero](heroes/green-hero.md) |

`6 / 25 (5 vollständig)` bedeutet: Für sechs Animationstypen liegt mindestens
eine GIF-Vorschau vor. Stehen, langes Warten, Gehen, Laufen und Rennen besitzen
je acht Richtungsvorschauen; genervtes Warten liegt derzeit nur nach Süden vor.
Der vollständige Heldenstandard sieht 25 Animationstypen vor.

## Kategorien

- [Helden](heroes/index.md)
- [NPCs](npcs/index.md)
- [Monster](monsters/index.md)
- [Bosse](bosses/index.md)

Neue Figuren erhalten genau eine Zeile in diesem Katalog und eine eigene
Detailseite in ihrer Kategorie. NPCs, Monster und Bosse müssen nicht den
Animationsumfang eines Helden besitzen; dokumentiert wird stets ihr
tatsächlich geltender Bestand.

## Assetkonvention

Dokumentations-GIFs liegen unter
`docs/assets/images/animations/<entity-type>/<entity-id>/<animation>/<direction>.gif`.
Verzeichnis- und Dateinamen verwenden englisches Kebab-Case. Die acht
Richtungskürzel sind `n`, `ne`, `e`, `se`, `s`, `sw`, `w` und `nw`.

Arbeits-PNGs, Spritesheets und Godot-Ressourcen sind nicht Bestandteil dieses
Katalogs.
