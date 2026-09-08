<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Arbeitsplan: Green Hero mit Stehen und Gehen in acht Richtungen

## Zweck und Gesamtbild

Der spielbare Held verwendet im Heldenraum die fertigen Ultra-Spritesheets des
Green Hero. Acht Stand- und acht Gehfolgen mit je 16 Frames ersetzen die
bisherige Platzhaltergrafik, ohne Bewegung, Sprünge, Kollision, Interaktion,
Kamera oder den bestehenden Weltmaßstab zu verändern. Ein reproduzierbarer
Generator und eine geprüfte Animationsbeschreibung bilden die Grundlage für
spätere Aktionen und Texturqualitäten.

## Ausgangslage

`HeroCharacter` besitzt einen getrennten Grafikzweig, verwendet dort aber noch
ein einzelnes `Sprite2D`. Die 16 optimierten `_spritesheet_4x4_o.png`-Quellen
liegen ausschließlich im ignorierten Arbeitsbereich
`.workspace/hero/greenhero/Animatzion/`; die öffentliche Referenz enthält nur
GIF-Vorschauen. Die Laufzeitquellen müssen deshalb gezielt kopiert und dürfen
nicht aus der Arbeitsablage verschoben werden.

Die geprüften Original-Sheets bestehen jeweils aus 16 Feldern zu 640 × 640 px.
Die optimierten 4×4-Sheets besitzen je Folge unterschiedliche, aber innerhalb
der Folge gemeinsame Zuschnitte. Alle zugehörigen Stand- und Geh-GIFs verwenden
16 Frames mit 12 Hundertstelsekunden je Frame.

## Umfang und Nicht-Ziele

Zum Umfang gehören die exakte Auswahl der 16 Ultra-Sheets, ein versioniertes
Manifest mit Raster-, Timing-, Zuschnitt-, Ausrichtungs- und Referenzdaten, ein
deterministischer Generator für eine gemeinsame `SpriteFrames`-Ressource, die
Einbindung als `AnimatedSprite2D`, acht Darstellungsrichtungen, Stand-/Geh-
Umschaltung, Phasenerhalt, vorläufige Sprungdarstellung, Tests und deutsche
Entwicklungsdokumentation.

Nicht zum Umfang gehören lange oder genervte Wartefolgen, eigene Grafiken für
Schleichen, Laufen, Rennen, Sprinten oder Sprünge, kleinere Texturqualitäten,
ein Grafikmenü, Streaming sowie Änderungen an Geschwindigkeiten, Kollision,
Interaktion, Kamera, Fenstergröße oder Maßstab.

## Konkrete Schritte

1. Alle 16 Quellen gegen Dateinamen, PNG-Lesbarkeit, 4×4-Raster, GIF-Reihenfolge
   und GIF-Zeiten prüfen; gemeinsame Zuschnitte aus den 640-px-Quellfeldern
   rekonstruieren und gegen die optimierten Sheets vergleichen.
2. Ausschließlich die geprüften `_o.png`-Dateien nach
   `game/assets/characters/heroes/green_hero/ultra/` kopieren und verlustfreie
   Godot-Importe ohne Mipmaps sicherstellen.
3. Ein Manifest und ein idempotentes Erzeugungsskript ergänzen, das Eingaben
   hart validiert und die gemeinsame `SpriteFrames`-Ressource deterministisch
   erzeugt beziehungsweise im Prüfmodus vergleicht.
4. Den Grafikzweig des Helden um `TextureScale`, `AnimatedSprite2D` und einen
   getrennten Animationscontroller erweitern. Die achtteilige Richtung wird aus
   dem bestehenden Bewegungsvektor abgeleitet und bei Stillstand erhalten.
5. Stand, Bodenbewegung, Richtungswechsel, Bewegungssperre und bestehenden
   Sprung an die Darstellung anbinden, ohne die Bewegungsmechanik zu duplizieren.
6. Generator-, Ressourcen-, Laufzeit- und Regressionsprüfungen sowie passende
   deutsche Entwicklungs- und Referenzdokumentation ergänzen.
7. Erst fokussierte Prüfungen und Sichtkontrollen, danach den vollständigen
   Standardlauf ausführen und nur das abgeschlossene Arbeitspaket committen.

## Fortschritt

- [x] 2026-09-08: Repository-Regeln, Dokumentationsstruktur, Animationsreferenz
  und bestehende Heldenschnittstellen gelesen.
- [x] 2026-09-08: Genau acht Stand- und acht Geh-Sheets sowie die zugehörigen
  GIFs im ignorierten Arbeitsbereich identifiziert.
- [x] 2026-09-08: PNG-Abmessungen, Alphaformat, 4×4-Teilbarkeit und GIF-Zeiten
  geprüft; unterschiedliche gemeinsame Zuschnitte bestätigt.
- [x] 2026-09-08: Manifest, 16 Laufzeitassets und deterministischen Generator
  umgesetzt; dessen Prüfmodus bestätigt 16 Animationen und 256 Frames.
- [x] 2026-09-08: Heldenszene, Auflösungsnormalisierung, achtteilige Richtung
  und getrennte Animationssteuerung umgesetzt.
- [x] 2026-09-08: Generator-, Ressourcen-, Laufzeit- und betroffene
  Regressionstests sowie Entwicklungs- und Referenzdokumentation aktualisiert.
- [x] 2026-09-08: Fokussierte Prüfungen und Sichtkontrolle abgeschlossen.
- [x] 2026-09-08: Vollständigen Standardlauf ausgeführt; die
  aufgabenbezogenen Python-, Stil-, Import- und Animationstests bestehen, die
  bereits vorhandenen Standardwertabweichungen sind getrennt dokumentiert.
- [x] 2026-09-08: Abgeschlossenes Arbeitspaket isoliert zum Commit vorbereitet.

## Erkenntnisse und Überraschungen

- Die optimierten Sheets verwenden nicht die Beispielgröße 405 × 618 px pro
  Frame für alle Richtungen. Die Feldgrößen reichen bei den geprüften Dateien
  in der Breite von 305 bis 528 px und in der Höhe von 578 bis 633 px; sie
  müssen je Sheet aus dem Manifest kommen.
- Die unoptimierten 10.240 × 640-px-Sheets bewahren für alle Frames ein
  einheitliches 640 × 640-px-Bezugsfeld. Die optimierten Sheets entsprechen
  einem gemeinsamen Union-Zuschnitt je Folge; dadurch bleiben interne
  Bewegungen erhalten und die entfernten Ränder sind rekonstruierbar.
- ImageMagick meldet über die jeweilige GIF-Framesicht 16 Bilder mit konstant
  12 Hundertstelsekunden Verzögerung. Eine reine Dateiliste hätte diese
  Wiedergabezeit nicht belegt.
- Der aktuelle Stand von `main` enthält gegenüber seinen Runtime-Tests bereits
  abweichende versionierte Standards für Außenweltzoom, Nebel sowie Jog- und
  Sprintgeschwindigkeit. Die fokussierte Green-Hero-Suite ist davon unabhängig
  fehlerfrei; der vollständige Lauf führt diese Ausgangsabweichungen weiterhin
  auf.

## Entscheidungen

- Die Dateikürzel werden ausdrücklich als Tastenzuordnung übersetzt:
  `w→n`, `wd→ne`, `d→e`, `sd→se`, `s→s`, `sa→sw`, `a→w`, `wa→nw`.
- Andere vorhandene Bodenbewegungsstufen verwenden in diesem Schritt
  übergangsweise die Gehfolge ihrer Richtung; ihre Geschwindigkeiten und
  Zustände bleiben unverändert.
- Fehlende oder widersprüchliche Manifestdaten führen zu einem harten
  Generatorfehler. Es gibt keinen Rückfall auf unoptimierte Dateien oder eine
  andere Richtung.
- Diese Einbindung ändert keinen angenommenen Kanon; eine neue
  Konzeptentscheidung ist daher nicht erforderlich.

## Prüfungen

- `identify` für die 16 optimierten PNGs — bestanden: alle lesbar, RGBA und in
  beiden Abmessungen durch vier teilbar.
- `identify` für die 16 zugehörigen GIFs — bestanden: je 16 Frames mit konstant
  12 Hundertstelsekunden Verzögerung.
- Pixelvergleich der 256 optimierten Felder mit den angegebenen Ausschnitten
  der 640-px-Referenzfelder — bestanden: keine Abweichung.
- Kontaktbogen aus dem ersten Frame aller 16 Folgen — geprüft: alle acht
  Richtungen sind richtig zugeordnet und vollständig sichtbar.
- `python game/tools/generate_green_hero_animations.py --check --source-root
  .workspace/hero/greenhero/Animatzion` — bestanden: 16 Animationen und
  256 Frames, Quellen und Ausgabe stimmen überein.
- `python -m unittest discover -s tools/tests -p
  'test_green_hero_animation_generator.py' -v` — bestanden: vier Tests.
- `python tools/control.py style` — bestanden für 82 Dateien.
- `python tools/control.py godot4 import` mit Godot 4.7.2 — bestanden.
- `python tools/control.py godot4 test` mit Godot 4.7.2 — die neue
  `GreenHeroAnimation`-Suite führt keinen Fehler auf; der Gesamtlauf meldet die
  zuvor beschriebenen Ausgangsabweichungen.
- Dedizierter Aufruf der `GreenHeroAnimation`-Suite mit Godot 4.7.2 —
  bestanden mit `Green Hero animation integration test: passed`.
- `.venv/bin/python tools/control.py check` — Doctor ohne Fehler, Stilprüfung
  bestanden und 193 Python-Tests bestanden; der Godot-Gesamtlauf endet wegen
  der bereits vorhandenen Standardwertabweichungen mit Exit-Code 1.
- `python tools/control.py export linux --dry-run` — nicht ausführbar, weil das
  offizielle Exporttemplate `linux_release.x86_64` für Godot 4.7.2 in dieser
  Sitzung fehlt. Es wurde deshalb kein exportierter Testbuild behauptet.

## Wiederholbarkeit und Wiederherstellung

Die Arbeitsquellen bleiben unverändert im ignorierten Bereich. Das Kopier- und
Erzeugungsskript darf mit identischen Eingaben beliebig oft laufen und erzeugt
dieselben versionierten Laufzeitdateien, ohne Duplikate anzulegen. Godots
`.godot`-Importcache bleibt generiert und ungetrackt; ein frischer Checkout
wird über den bestehenden Importablauf vorbereitet.

## Ergebnis und Rückblick

Die 16 geprüften Ultra-Sheets ersetzen die Platzhaltergrafik im gemeinsamen
Helden. Das wiederhergestellte 640-px-Bezugsfeld und der feste Fußanker halten
die Weltposition trotz unterschiedlicher Zuschnitte stabil. Bewegung und
Darstellung bleiben getrennt; dadurch ließ sich die achtteilige Animation ohne
Änderung an Geschwindigkeiten, Kollision oder Kamera ergänzen.

Die aufgabenbezogenen Prüfungen sind grün. Der vollständige Repository-Gate
wurde tatsächlich ausgeführt, bleibt aber wegen zuvor eingecheckter Änderungen
an Kamera-, Nebel- und Bewegungsstandards rot. Diese Werte wurden bewusst weder
zurückgesetzt noch als neuer Kanon übernommen. Ein Exportbuild konnte mangels
installiertem offiziellen Godot-Exporttemplate nicht erzeugt werden.
