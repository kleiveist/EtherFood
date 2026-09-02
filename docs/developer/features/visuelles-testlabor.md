<!-- AUTO-GENERATED:backlink START -->
[← Zurück](features.md)
<!-- AUTO-GENERATED:backlink END -->
# Funktion: Visuelles Testlabor

## Zweck

Das visuelle Testlabor ist eine interne Entwicklungsszene. Dort werden
Grafik, Maßstab, Kamera und Weltzustände getestet, ohne den eigentlichen
Spielabschnitt ständig verändern zu müssen.

Die Versuche folgen der
[visuellen Richtung V0](../../concept/60-produktion/visuelle-richtung-v0.md).
Sie dienen dem sichtbaren Vergleich. Abgeschlossene Einzeltests halten ihre
bestätigten Entscheidungen hier fest, ohne offene Folgefragen vorwegzunehmen.

## Route und Zugang

```text
visual_lab
```

Die Route `visual_lab` darf nur in Entwicklungsbuilds erreichbar sein. In der
normalen Spielversion sind weder der Menüpunkt noch ein direkter Aufruf dieser
Route verfügbar. Das Testlabor ist eine reine Entwicklungsfunktion und kein
Bestandteil der Spielhandlung.

Die Bedienhilfe beginnt eingeklappt. `F5` blendet die Tastenübersicht sowie die
bedienbaren Schalter für Pixel-Snap und Texturfilter ein oder aus; ein kleiner
Hinweis auf `F5` bleibt im eingeklappten Zustand sichtbar. Aktuelle Größen-,
Zoom-, Welt- und Fensterwerte gehören nicht in diese Übersicht, sondern
ausschließlich in die Diagnoseanzeige. Der Zustand der Bedienhilfe wird nicht
gespeichert.

## Laufende Testergebnisse

### Pixel-Snap und Kamerazoom – 2. September 2026

Der folgende Ausgangsbefund hat die erste Abnahme von Aufgabe 17 aufgehoben:

| Einstellung | Ergebnis | Status |
|---|---|---|
| Figur | 80 px | vorläufig geeignet |
| Tiles | 32 × 32 px | vorläufig geeignet |
| Texturfilter | Nearest-Neighbor | bevorzugter Kandidat |
| Pixel-Snap bei 1,00× | kein sichtbares Flackern | bestanden |
| Pixel-Snap bei 1,50× | Held flackert bei Bewegung | nicht bestanden |
| Welt-/Dungeonkamera | 1,00× | bevorzugter Kandidat |
| Kleine Innenräume | 1,50× | gewünscht, aber noch nicht freigegeben |

Pixel-Snap war damit noch nicht abschließend abgenommen. Der Fehler trat bei
`1920 × 1080` reproduzierbar auf, während `1,50 ×` im Fenster mit
`1280 × 720` durch dessen Skalierung von zwei Dritteln effektiv auf
`1,00 ×` Ausgabeskalierung kam und ruhig wirkte.

Die Untersuchung zeigte zwei getrennte Raster. Godot rundete die lokalen
CanvasItem-Transformationen, der nicht ganzzahlige Kamerazoom bildete diese
gerundeten Weltpositionen jedoch abwechselnd auf ganze und halbe
Ausgabepixel ab. Kamera und Heldenbild verwendeten dadurch bei Bewegung nicht
immer dieselbe Rasterphase.

Die Korrektur rundet nicht die physische Position des `CharacterBody2D`.
Stattdessen erhalten Heldenbild und Kamera im Pixel-Snap-Modus einen
gemeinsamen, rein visuellen Anker. Dessen Schrittweite wird als kleinstes
gemeinsames Raster aus Kamerazoom und Fensterskalierung bestimmt. Vertex-Snap
bleibt dabei ausdrücklich AUS und Kamera-Smoothing bleibt AUS.

Die Wiederholungsprüfung umfasste echte horizontale, vertikale und diagonale
Bewegung sowie getrennt verfolgte Ausschnitte für Held, Tilefläche und
Weltobjekte:

| Einstellung | Ergebnis nach Korrektur | Status |
|---|---|---|
| `1,00×`, Pixel-Snap AN, Nearest | Held und Weltmuster bleiben rasterstabil | bestanden |
| `1,00×`, Pixel-Snap AUS, Nearest | freier Vergleich bleibt möglich | bestanden |
| `1,50×`, Pixel-Snap AN, Nearest | kein wechselndes Heldenmuster mehr | bestanden |
| `1,50×`, Pixel-Snap AUS, Nearest | Flackern bei 1920 × 1080 reproduzierbar | Vergleich bestätigt |
| Fenster 1920 × 1080 | rationales Zwei-Weltpixel-Raster bei 1,50× | bestanden |
| Fenster 1280 × 720 | interne und ausgegebene Rasterphase stabil | bestanden |

Pixel-Snap AN ist nach der technischen Wiederholung die ruhigere Variante.
Bei `1,50 ×` entstehen durch das notwendige Zwei-Weltpixel-Raster weiterhin
diskrete 3- beziehungsweise 6-Ausgabepixel-Schritte. Es gibt kein zusätzliches
Hin-und-Her-Springen der Kamera und keine wechselnde Heldenkontur; die
Rasterkadenz selbst bleibt als erwartete Folge des nicht ganzzahligen Zooms
sichtbar. Ob `1,50 ×` als Profil für kleine Innenräume endgültig freigegeben
wird, entscheidet erst Aufgabe 20 zusammen mit Maßstab und Referenzauflösung.

Der angezeigte Weltzustand `Beschädigt` bezeichnet ausschließlich den Zustand
des jeweiligen Tests. Beschädigte und wiederhergestellte Welt bleiben
gleichberechtigte Spiel- und Testzustände; keiner von beiden ist eine globale
Darstellungsregel.

## Übergabe an Maßstab V0

Die getesteten Werte haben unterschiedliche Geltungsbereiche und werden nicht
in einer gemeinsamen Einstellungsdatei verbindlich gemacht:

| Wert | Bedeutung | Vorgesehene Ablage |
|---|---|---|
| Figur `80 px` | globaler Figurenmaßstab | Darstellungsgrundlage V0 in Aufgabe 20 |
| Tiles `32 × 32 px` | globales Weltraster | Darstellungsgrundlage V0 in Aufgabe 20 |
| Pixel-Snap `AN` | globale Renderingregel | später `project.godot` |
| Nearest-Neighbor | bevorzugter Filterkandidat | nach Abschluss von Aufgabe 18 später `project.godot` |
| Kamera `1,00×` / `1,50×` | szenenabhängiges Kameraprofil | CameraProfile-Ressourcen in Aufgabe 20 |
| Welt `Beschädigt` | aktueller Spiel- oder Testzustand | keine feste Darstellungsregel |

Die geplanten Ressourcen `visual_baseline_v0.tres`, `world_dungeon.tres` und
`small_interior.tres` werden bewusst erst in Aufgabe 20 angelegt. Das
Testlabor behält bis dahin den manuellen Wechsel zwischen seinen Testwerten.
Die lokale Datei `user://visual_lab_settings.cfg` stellt nur die zuletzt
gewählten persönlichen Testschalter wieder her und ist keine verbindliche
Quelle für Spielregeln. Die endgültige technische Entscheidung folgt erst
nach den Aufgaben 17 bis 20; vorher wird kein Darstellungsprofil-ADR angelegt.

## Inhalt des Testlabors

### 1. Helden-Testfläche

Die Helden-Testfläche ermöglicht:

```text
- Spielfigur anzeigen
- Bewegung in vier Richtungen
- Idle- und Laufanimation testen
- Figurengröße vergleichen
- Schatten und Kollisionskörper anzeigen
```

### 2. Größenvergleich

Gemeinsam darzustellen sind:

```text
- Held
- normale Tür
- Hauswand
- Baum
- kleiner Gegner
- großer Gegner-Platzhalter
```

Damit wird geprüft, ob alle Größen zueinander passen. Die Vergleichsobjekte
sind originale EtherFood-Prototypassets und noch keine fertigen
Produktionsgrafiken. Sie werden durch ein lokales, deterministisches
Hilfsskript ohne Netzwerkzugriff erzeugt.

Alle Größenreferenzen verwenden dieselbe schräge Top-down-Spielperspektive.
Bei Figuren bleiben Kopfoberseite, Schultern und der mittige Bodenanker
lesbar; Gebäude zeigen Dachfläche, Dachkante und eine schmale südliche Wand.
Frontale Fassaden, Porträts und seitliche Plattformdarstellungen sind für
Weltobjekte im Vergleich nicht zulässig. Der bewegliche Held und die
nicht kollidierbaren Referenzobjekte werden anhand ihrer Bodenanker nach Y
sortiert, während die Maßstabsbeschriftungen stets darüber liegen.

Der derzeitige klassische 16-Bit-RPG-Stil ist eine Arbeitsrichtung für den
Prototyp und keine endgültige Art-Bible. Auch die sichtbaren Zielhöhen und
alle umschaltbaren Größenwerte bleiben vorläufige Testwerte.

### 3. Grafikvarianten

Umschaltbar sein sollen:

```text
- verschiedene Tilegrößen
- verschiedene Heldenhöhen
- naher Kamerazoom
- mittlerer Kamerazoom
- weiter Kamerazoom
- Pixel-Snap ein und aus
- Texturfilterung zum Vergleich
```

Die zu vergleichenden Tilegrößen, Heldenhöhen und Kameraansichten stammen aus
der visuellen Richtung V0. Die endgültige Auswahl erfolgt erst nach dem
sichtbaren Vergleich.

#### Pixel-Snap-Vergleich

Im mit `F5` geöffneten Testlabor-Menü schaltet ein fokussier- und anklickbarer
Knopf zwischen `Pixel-Snap: AN` und `Pixel-Snap: AUS`. `X` bietet denselben
Wechsel direkt während der Bewegung. Der boolesche Zustand wird gemeinsam mit
den vorhandenen Testwert-Presets gespeichert und beim nächsten Öffnen geladen.
Ältere Version-1-Dateien ohne den Schlüssel bleiben gültig und verwenden AUS.

Der Schalter setzt ausschließlich den Transform-Snap des aktiven Viewports.
Logische Positionen, Bewegung, Kollisionsformen und Kameragrenzen werden nicht
gerundet. Beim Verlassen des Testlabors wird die vorherige Viewport-Einstellung
wiederhergestellt. In der Diagnose bleiben Heldenposition, tatsächliches
Kamerazentrum und Weltanker mit zwei Nachkommastellen getrennt sichtbar.

Der erste Vergleich nur bei `1280 × 720` reichte für die Abnahme nicht aus,
weil die Fensterskalierung dort den Kamerazoom `1,50 ×` zu einer ganzzahligen
Ausgabeskalierung machte. Der korrigierte Vergleich prüft deshalb zusätzlich
`1920 × 1080` und echte Bewegung in drei Richtungen. Details und der
chronologische Ausgangsbefund stehen unter
[Laufende Testergebnisse](#laufende-testergebnisse). Für den derzeitigen
Prototyp gilt folgende Versuchsempfehlung:

| Bereich | Empfehlung | Begründung |
|---|---|---|
| Held | AN | Der visuelle Anker bleibt stabil; die physische Position wird nicht gerundet. |
| Kamera | AN mit gemeinsamem Darstellungsraster | Kein Phasenwechsel; die diskrete Kadenz bei 1,50× bleibt sichtbar. |
| Welt | AN | Tiles und feste Weltobjekte behalten beim Kameraschwenk ihre Rasterphase. |

Das legt weder Kamerazoom noch Maßstab verbindlich fest. Die globale
Pixel-Snap-Regel wird erst mit der Darstellungsgrundlage V0 in das Projekt
übernommen.

#### Texturfilter-Vergleich

Neben Pixel-Snap steht im `F5`-Menü ein zweiter fokussier- und anklickbarer
Knopf. Er wechselt zwischen `Texturfilter: Nearest-Neighbor` und
`Texturfilter: Weich`; `N` ermöglicht denselben Wechsel während des laufenden
Tests. Die ID `nearest` oder `soft` wird zusammen mit den vorhandenen
Testwerten gespeichert. Version-1-Presets ohne gültige Filter-ID verwenden
Nearest-Neighbor.

Die Umschaltung erfasst ausschließlich die 25 texturierten `Sprite2D`-
Instanzen unter `TestWorld`: den Held, den texturierten Vergleichsboden, die
Größenreferenzen und die Sprites beider Weltzustände. Sie ändert weder die
globale Projekteinstellung noch Szenenressourcen. Beim Verlassen werden alle
vorherigen Instanzwerte wiederhergestellt. Vektorgezeichnete Tile-Raster und
Kollisionsformen besitzen keine Texturabtastung und bleiben deshalb in beiden
Varianten identisch.

Der vorläufige Vergleich wurde bei 1280 × 720 mit aktivem Pixel-Snap, kontrollierten
Schritten von 2,2 Weltpixeln und 124 echten OpenGL-Aufnahmen durchgeführt.
Getestet wurden alle drei Zoomstufen, Stillstand und Bewegung des Helden,
Kameraverfolgung, texturierter Boden, Referenzobjekte sowie beschädigter und
wiederhergestellter Weltzustand.

| Testbereich | Nearest-Neighbor | Weich |
|---|---|---|
| Held im Stillstand | harte Silhouette und klare Innenpixel | bei nicht ganzzahliger Ausgabe sichtbar geglättet |
| Held in Bewegung | klare Pixel, Rasterkadenz bleibt sichtbar | weichere Kanten, aber dieselbe Rasterkadenz |
| Kameraverfolgung | unveränderte logische Folgebewegung | unveränderte logische Folgebewegung |
| Zoom Nah, 1,50× | bei der getesteten Ausgabe pixelgleich zu Weich | bei exakter Ausrichtung kein sichtbarer Gewinn |
| Zoom Mittel, 1,00× | schärfer, vereinzelt ungleich breite Ausgabepixel | deutlich mehr Mischfarben und Unschärfe |
| Zoom Weit, 0,75× | härter, sehr feine Details können ausdünnen | etwas ruhiger, aber feine Details verschmelzen |
| Tiles und Kanten | texturierter Boden bleibt klar; Vektorraster unverändert | Boden wird weich; Vektorraster unverändert |
| Weltobjekte | Materialpixel und Konturen bleiben lesbar | Konturen und kleine Materialwechsel verwischen |
| beschädigter Weltzustand | Schäden und kahle Vegetation bleiben klar | feine Schadenskanten werden weicher |
| wiederhergestellter Weltzustand | Pflanzen und Gebäudedetails bleiben klar | kleine Blatt- und Mauerpixel verschmelzen |

Die ganzzahlige Ausgabe des nahen Zooms ergab zwischen beiden Filtern keine
abweichenden Pixel. Beim mittleren Zoom änderten sich je nach Bildbereich rund
13.000 Ausgabepixel; die weiche Variante erzeugte dort wesentlich mehr
interpolierte Farben. Im weiten Zoom war der Unterschied kleiner, weil beide
Varianten bereits auf die halbe Ausgabegröße verkleinerten.

Die Kamerafahrten zeigten für beide Filter dieselbe Folge gerasterter Schritte:
nah überwiegend 2 bis 3 Pixel, mittel 1 bis 2 Pixel und weit vereinzelt ein
Haltebild vor einem 2-Pixel-Schritt. Weiche Filterung ändert diese Bewegung
nicht, sondern kaschiert Kanten lediglich durch Farbmischung. Bewegung,
Kollision, Kameragrenzen und Pixel-Snap-Zustand blieben unverändert.

Nearest-Neighbor bleibt damit der **bevorzugte Kandidat**, ist aber noch kein
verbindlicher Projektstandard. Die Beobachtungen bei `1,50 ×` entstanden vor
der korrigierten Pixel-Snap-Abnahme und werden in Aufgabe 18 mit allen drei
Zoomstufen wiederholt. Erst danach werden Standard, mögliche lokale Ausnahmen
für nicht als Pixelart angelegte Atmosphäreneffekte und bekannte Probleme
verbindlich dokumentiert.

### 4. Weltzustände

Mindestens ein Testbereich besitzt zwei umschaltbare Zustände:

```text
Beschädigte Welt
↔
Wiederhergestellte Welt
```

Verglichen werden:

```text
- Farben
- Nebel
- Pflanzen
- Licht
- Boden
- Gebäudeschäden
```

Der Zustandswechsel dient ausschließlich dem direkten visuellen Vergleich.
Er benötigt weder Handlung noch Speichersystem.

Die Testgrafiken sind originale, lokal reproduzierbare Prototypassets. Der
Größenvergleich und der Weltzustandsvergleich teilen eine dunkle
Top-down-Pixelsprache; feinere Materialpixel ersetzen reine Diagrammformen,
ohne daraus bereits eine finale Art-Bible abzuleiten.

### 5. Diagnoseanzeigen

Entwickler sollen folgende Anzeigen unabhängig voneinander umschalten können:

```text
- Kollisionsformen
- aktuelle FPS
- rohe und gerundete Spielerkoordinaten
- rohe und gerasterte Kameraposition, tatsächliches Kamerazentrum und Weltanker
- Kameraprofil und Fensterskalierung
- aktueller Kamerazoom
- gewählte Tilegröße
- gewählte Figurengröße
- aktiver Weltzustand
- aktiver Pixel-Snap-Zustand
- aktiver Texturfilter
```

Die Anzeigen machen die jeweils aktive Testkonfiguration unmittelbar
erkennbar und sind nicht für normale Spielbuilds bestimmt.

`F3` beziehungsweise Controller-Select/Back schaltet das Diagnosepanel mit
FPS, rohen und gerundeten Heldenpositionen, rohem und gerastertem Kameraziel,
tatsächlichem Kamerazentrum, Weltanker, Kameraprofil, Figuren-, Tile-,
Weltzustands-, Pixel-Snap-, Vertex-Snap-, Darstellungsraster-, Texturfilter-,
Fenster- und Fensterskalierungswerten.
`F4` schaltet davon unabhängig eine eigene Zeichnung der vorhandenen
Helden-, Hindernis- und Weltgrenzen-Kollisionen. Beide Anzeigen beginnen bei
jedem Öffnen ausgeschaltet und werden nicht in den Testlabor-Einstellungen
gespeichert. Das Diagnosepanel aktualisiert seine Werte ungefähr alle
0,2 Sekunden. Die Kollisionszeichnung liest die bestehenden Physikformen nur
aus und verändert weder sie noch Godots globale Debug-Hinweise.

## Nicht enthalten

```text
- richtige Handlung
- Dialoge
- Speicherstände
- vollständiges Kampfsystem
- endgültiger Held
- endgültige Gegner
- produktionsfertige Weltkarte
- fertige Spielgrafiken
```

## Prüfung

Das visuelle Testlabor ist ausreichend festgelegt, wenn:

- sein Zweck als unabhängige interne Entwicklungsszene eindeutig beschrieben
  ist,
- alle fünf Testbereiche dokumentiert sind,
- beschädigte und wiederhergestellte Welt direkt verglichen werden können,
- die umschaltbaren Diagnoseanzeigen festgelegt sind,
- `visual_lab` ausdrücklich nur in Entwicklungsbuilds erreichbar ist und
- noch offene Grafikentscheidungen nicht ohne ihren vorgesehenen Vergleich
  vorweggenommen werden.
