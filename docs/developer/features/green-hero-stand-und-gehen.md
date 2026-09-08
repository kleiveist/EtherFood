<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Funktion: Green Hero – Stehen und Gehen

## Ziel und Umsetzungsstand

Der spielbare `HeroCharacter` verwendet seit dem 8. September 2026
standardmäßig den Green Hero anstelle der bisherigen Platzhaltergrafik.
Eingebunden sind die Ultra-Folgen für Stehen und Gehen: acht Richtungen, 16
Frames je Folge und damit insgesamt 256 Frames aus 16 optimierten PNG-Sheets.
Nur im visuellen Testlabor kann diese Instanz zusätzlich auf eine
einrahmige Pixelart-Vergleichsvariante umgeschaltet werden.

Die vorhandenen Bewegungswerte, Kollision, Interaktion, Kamera und Sprungkurven
bleiben davon getrennt. Lange und genervte Wartefolgen sowie eigene Grafiken
für Schleichen, Laufen, Rennen, Sprinten und Sprünge sind noch nicht
eingebunden. Solange diese Folgen fehlen, verwenden alle Bodenbewegungsstufen
die Gehfolge; ein Sprung zeigt vorläufig das erste Standbild der Blickrichtung.

## Laufzeitassets und Richtungen

Die Laufzeitdateien liegen unter:

```text
game/assets/characters/heroes/green_hero/ultra/
├── stand/                       acht optimierte 4×4-Sheets
├── walk/                        acht optimierte 4×4-Sheets
├── stand_walk_manifest.json     geprüfte Quelldaten
└── green_hero_stand_walk_ultra.tres
```

Die Quelldateien wurden aus dem lokalen Arbeitsbereich kopiert, nicht
verschoben. Unoptimierte Sheets, Einzelframes, GIFs und Wartefolgen sind keine
Laufzeitassets. Die Tastenkürzel der Quelldateien werden ausdrücklich in
Spielrichtungen übersetzt:

| Quellkürzel | Spielrichtung | Animationssuffix |
|---|---|---|
| `w` | Norden | `n` |
| `wd` | Nordosten | `ne` |
| `d` | Osten | `e` |
| `sd` | Südosten | `se` |
| `s` | Süden | `s` |
| `sa` | Südwesten | `sw` |
| `a` | Westen | `w` |
| `wa` | Nordwesten | `nw` |

Die Godot-Namen folgen daraus als `stand_n` bis `stand_nw` und `walk_n` bis
`walk_nw`. Das Kürzel `w` bezeichnet in den Quelldateien die W-Taste und darf
nicht als Westen gelesen werden.

## Geprüfte Bild- und Zeitdaten

Alle 16 Referenz-GIFs besitzen 16 Frames, eine Endlosschleife und eine
Einzelbilddauer von 120 Millisekunden. Godot spielt die Folgen deshalb mit
`8,333…` Frames pro Sekunde ab. Die Frames werden zeilenweise von links nach
rechts aus dem 4×4-Raster gelesen.

Die unoptimierten Referenz-Sheets bestehen aus 16 Feldern zu je 640 × 640 px.
Jedes optimierte Sheet ist ein gemeinsamer Zuschnitt aller 16 Frames seiner
Folge. Die Prüfung hat für alle 256 Felder eine pixelgleiche Übereinstimmung
mit dem entsprechenden Ausschnitt des Referenz-Sheets ergeben:

| Animation | Ausschnitt im 640-px-Bezugsfeld `(x, y, b, h)` |
|---|---|
| `stand_n` | `(168, 23, 305, 585)` |
| `stand_ne` | `(143, 10, 339, 609)` |
| `stand_e` | `(134, 32, 350, 582)` |
| `stand_se` | `(113, 24, 371, 596)` |
| `stand_s` | `(158, 7, 405, 618)` |
| `stand_sw` | `(145, 7, 418, 621)` |
| `stand_w` | `(151, 14, 432, 606)` |
| `stand_nw` | `(182, 33, 346, 578)` |
| `walk_n` | `(163, 16, 398, 612)` |
| `walk_ne` | `(81, 9, 447, 626)` |
| `walk_e` | `(44, 15, 528, 615)` |
| `walk_se` | `(66, 27, 459, 608)` |
| `walk_s` | `(82, 7, 487, 633)` |
| `walk_sw` | `(108, 6, 488, 631)` |
| `walk_w` | `(111, 16, 487, 605)` |
| `walk_nw` | `(134, 29, 426, 597)` |

`AtlasTexture.margin` stellt für jeden Ausschnitt das gemeinsame
640 × 640-px-Bezugsfeld wieder her. Dadurch bleiben Körper- und Fußposition
beim Wechsel zwischen unterschiedlich großen Sheets stabil, ohne die
entfernten transparenten Ränder erneut in den PNGs zu speichern.

Als festes Referenzmaß dient Frame 0 von `stand_s`. Seine sichtbare Höhe beträgt
618 Grafikpixel und entspricht 80 Weltpixeln. Der Fußanker liegt im
rekonstruierten Feld bei `(320, 625)`. Daraus folgen die einmalig gespeicherte
Texturskalierung `80 / 618 = 0,12944984` und der Sprite-Offset `(0, -305)`.
Die bestehende `Appearance`-Skalierung arbeitet weiterhin oberhalb dieses
Auflösungsfaktors.

## Technischer Aufbau

```text
HeroCharacter
├── Visual
│   ├── Shadow
│   └── JumpVisual
│       ├── Appearance
│       │   └── TextureScale
│       │       └── HeroSprite (AnimatedSprite2D)
│       └── FacingMarker
├── CollisionShape2D
├── InteractionDetector
├── PlayerCamera
└── AnimationController
```

`HeroCharacter` gewinnt aus dem bereits normalisierten Bewegungsvektor eine
achtteilige Animationsrichtung, bevor er seine ältere vierteilige
Interaktionsrichtung bestimmt. Bei Stillstand bleibt die letzte
Animationsrichtung erhalten.

Der getrennte `AnimationController` liest nur Zustand und tatsächliche,
kollisionsbereinigte Bodenbewegung des Helden. Er liest keine Tasten und
verändert weder Geschwindigkeit noch Weltposition. Daher zeigt eine gegen eine
Wand laufende Figur die passende Standfolge. Bei einem Richtungswechsel während
des Gehens werden Frame und Teilfortschritt übernommen, statt die Schrittfolge
neu zu starten. Bewegungssperren wechseln auf Stehen; während des bestehenden
Sprungs wird Frame 0 der richtungsbezogenen Standfolge eingefroren.

## Pixelart-Vergleich im Testlabor

Das [visuelle Testlabor](visuelles-testlabor.md#hero-grafikvergleich) kann die
Ultra-Ressource der dortigen Heldeninstanz gegen eine zweite
`SpriteFrames`-Ressource austauschen. Sie enthält dieselben 16 Namen für
Stehen und Gehen in acht Richtungen, aber jeweils genau ein Pixelart-Standbild
auf einem transparenten `265 × 265`-Canvas.

Die sichtbare Höhe von 245 Quellpixeln wird auf dieselben 80 Weltpixel wie die
Ultra-Referenz normiert; ein gemeinsamer Fußanker verhindert einen Sprung der
Weltposition. Die Auswahl wird nur lokal gespeichert. Der gemeinsame
`HeroCharacter`, sein Controller und der Heldenraum behalten standardmäßig die
Ultra-Ressource, bis eine spätere Entscheidung ausdrücklich etwas anderes
festlegt.

## Reproduzierbarer Import

`game/tools/generate_green_hero_animations.py` liest ausschließlich das
versionierte Manifest. Es prüft Namen, Richtungszuordnung, Raster, Framefolge,
Zeitdaten, sichere relative Pfade, Dateihashes und PNG-/GIF-Eigenschaften. Mit
angegebenem lokalen Quellordner werden zusätzlich die geprüften Arbeitsdateien
validiert und nur die 16 optimierten PNGs synchronisiert. Fehlende oder
widersprüchliche Daten brechen den Vorgang ab; es gibt keinen stillen Ersatz.

```bash
python game/tools/generate_green_hero_animations.py \
  --source-root .workspace/hero/greenhero/Animatzion

python game/tools/generate_green_hero_animations.py \
  --check \
  --source-root .workspace/hero/greenhero/Animatzion
```

Der Prüfmodus verändert keine Datei. Ohne `--source-root` lässt sich ein
frischer Checkout allein anhand der versionierten Laufzeitassets prüfen. Die
PNG-Importe verwenden verlustfreie Komprimierung, unveränderte Auflösung und
keine Mipmaps; der `AnimatedSprite2D` verwendet `Nearest` und keine
Texturwiederholung.

## Prüfvertrag

Automatische Tests sichern Manifest und Generator, alle 16 Animationsnamen,
256 `AtlasTexture`-Frames, Timings, Ausschnitte, Ränder, Importoptionen und
Texturpfade. Die Laufzeitprüfung deckt Startzustand, alle acht Richtungen,
Anhalten, eine vollständig blockierte Bewegung, Richtungswechsel mit erhaltener
Phase, Bewegungssperre, Größenreferenz und die vorläufige Sprungdarstellung ab.

Die öffentliche Übersicht der bereits vorhandenen Grafiken steht getrennt
unter [Green Hero – Animationen](../../reference/animations/heroes/green-hero.md).
