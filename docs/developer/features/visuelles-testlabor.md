<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Funktion: Visuelles Testlabor

## Zweck

Das visuelle Testlabor ist eine interne Entwicklungsszene. Dort werden
Grafik, Maßstab, Kamera und Weltzustände getestet, ohne den eigentlichen
Spielabschnitt ständig verändern zu müssen.

Die Versuche folgen der
[visuellen Richtung V0](../../concept/60-produktion/visuelle-richtung-v0.md).
Sie dienen dem sichtbaren Vergleich. Abgeschlossene Einzeltests halten ihre
bestätigten Entscheidungen hier fest, ohne offene Folgefragen vorwegzunehmen.

## Umsetzungsstand

Stand: 8. September 2026.

Die vorhandenen Testflächen und Testergebnisse bleiben bestehen. Die auf
dieser Seite festgelegte Neufassung der `F5`-Steuerung ist umgesetzt. Das
Testlabor verwendet ein Themenmenü, trennt lokale Testwerte von versionierten
Spielstandards und kennzeichnet letztere mit goldenem Rahmen und Stern. Die
früheren Direktkürzel der einzelnen Testparameter sind entfernt.

Die Neufassung ändert für sich genommen keinen bereits angenommenen Wert.
Insbesondere bleibt [Maßstab V0](#maßstab-v0) bestehen, bis im Labor ein
anderer Wert ausdrücklich übernommen und die zugehörige Entscheidung
nachvollziehbar aktualisiert wurde.

## Route und Zugang

```text
visual_lab
```

Die Route `visual_lab` darf nur in Entwicklungsbuilds erreichbar sein. In der
normalen Spielversion sind weder der Menüpunkt noch ein direkter Aufruf dieser
Route verfügbar. Das Testlabor ist eine reine Entwicklungsfunktion und kein
Bestandteil der Spielhandlung.

Das Testlabor startet mit geschlossenem Steuerungsmenü. `F5` öffnet und
schließt das gesamte Menü; ein kleiner Hinweis auf `F5` bleibt bei
geschlossenem Menü sichtbar. Das geöffnete Menü bleibt als schmales
Werkzeugfenster links oben und bedeckt nur einen kleinen Teil der Testwelt.
Der offene oder geschlossene Zustand wird nicht gespeichert. Die Testfigur
bleibt auch bei geöffnetem Menü beweglich.

`F3` schaltet die Diagnoseanzeige weiterhin direkt ein oder aus. `F4` schaltet
weiterhin unabhängig davon die Kollisionsflächen ein oder aus. Beide Funktionen
sind zusätzlich im Menü erreichbar, beginnen bei jedem Start ausgeschaltet und
werden nicht als Test- oder Spielwert gespeichert.

Alle veränderlichen Testparameter werden ausschließlich im Menü bedient.
Eigene Direktkürzel für Zoom, Figurengröße, Tilegröße,
Weltzustand, Nebel, Licht, Pixel-Snap und Texturfilter entfallen. Die normale
Spielsteuerung, `Esc` zum Verlassen, `F3`, `F4` und `F5` sind davon nicht
betroffen. `Strg + Alt + E` bleibt als einziges Kürzel zum ausdrücklichen
Übernehmen einer fokussierten Einstellung bestehen; dieselbe Aktion muss auch
über einen sichtbaren Menüknopf erreichbar sein.

## Aufbau des F5-Menüs

Eine dauerhaft sichtbare Themenleiste am oberen Rand des geöffneten Menüs
ordnet die vorhandenen und späteren Laborwerkzeuge. Neue Testwerkzeuge werden
einem Thema zugewiesen und erhalten kein neues globales Direktkürzel.

| Thema | Inhalt |
|---|---|
| Kamera | Zielbereich und dessen Zoomstufe |
| Maßstab | Heldenhöhe und Tilegröße als unabhängige Einzelwerte |
| Darstellung | Pixel-Snap, Texturfilter und spätere Grafikoptionen |
| Welt und Atmosphäre | Vorschau des Weltzustands sowie zustandsbezogener Nebel und zustandsbezogenes Licht |
| Diagnose und Hilfe | Diagnoseanzeige, Kollisionsflächen, Bewegung, Zurück und Bedienhinweise |
| Gameplay | Geschwindigkeiten sowie Sprunghöhen und -weiten |

Das grundsätzliche Layout lautet:

```text
┌ TESTLABOR ───────────────────────────┐   sichtbare Testwelt
│ [Kamera] [Maßstab] [Darstellung]    │
│ [Welt]   [Diagnose] [Gameplay]       │
├──────────────────────────────────────┤
│ scrollbarer Themeninhalt             │
│ [Wert A] [★ Standard] [Wert C]       │
│ Status und Übernahme                 │
└──────────────────────────────────────┘
```

Das Menü verwendet ein mehrzeiliges Themenraster, Container und einen
scrollbaren Inhaltsbereich. Bei der logischen Referenzansicht misst es
`600 × 684` Pixel und beansprucht damit weniger als ein Viertel der
Bildfläche. Es bleibt mindestens bei `1280 × 720` und `1920 × 1080`
vollständig bedienbar. Maus, normale UI-Tastaturnavigation und
Controller-Navigation erreichen dieselben Einstellungen. Die Welt wird durch
das Menü nicht pausiert; insbesondere kann die Figur weiterhin bewegt werden,
während Änderungen sofort in der sichtbaren Testfläche erscheinen.

## Testwert und übernommener Spielwert

Jede übernehmbare Einstellung unterscheidet zwei voneinander unabhängige
Zustände:

- Der **aktuelle Testwert** ist die momentan sichtbare Auswahl im Labor. Er
  darf beliebig gewechselt und als lokaler Arbeitsstand gemerkt werden.
- Der **übernommene Spielwert** ist der versionierte Standard, den passende
  Spielszenen tatsächlich verwenden. Er bleibt beim weiteren Vergleichen
  unverändert, bis er erneut ausdrücklich übernommen wird.

Bei wenigen festen Varianten werden alle Werte nebeneinander als
Auswahlknöpfe gezeigt. Der aktuelle Testwert erhält die normale
Auswahlmarkierung. Der übernommene Wert erhält unabhängig davon einen goldenen
Rahmen, einen Stern und die zugängliche Bezeichnung `Spielstandard`. Wenn
beide Zustände auf demselben Wert liegen, sind beide Kennzeichnungen sichtbar.
Die Goldmarkierung darf nicht nur durch Farbe vermittelt werden und darf beim
bloßen Durchschalten der Testwerte nicht mitwandern.

Ein Status am jeweiligen Eintrag zeigt eindeutig entweder `Entspricht dem
Spielstandard` oder `Nicht übernommener Testwert`. Fokus, Hover und gedrückter
Zustand verwenden eine andere Darstellung als die goldene
Spielstandard-Markierung.

### Werte übernehmen

Der Knopf `Als Spielstandard übernehmen` und `Strg + Alt + E` arbeiten immer
auf dem aktuell fokussierten Eintrag und seinem sichtbaren Kontext. Eine
Einzeleinstellung übernimmt nur diesen Wert. Verdeckte Sammeländerungen sind
nicht zulässig.

Das Übernahmekürzel reagiert nur bei geöffnetem `F5`-Menü und einem
übernehmbaren fokussierten Eintrag. Außerhalb dieses Zustands verändert es
nichts. Damit kann kein zuletzt fokussierter oder aktuell unsichtbarer Wert
versehentlich zum Spielstandard werden.

Erst nach erfolgreichem Schreiben des Spielwerts wandert dessen
Goldmarkierung. Bei einem Fehler bleibt der bisherige Spielstandard sichtbar
und das Menü meldet den Grund. Die Übernahme ist ausschließlich in einer
beschreibbaren Entwicklungsumgebung verfügbar und führt niemals selbstständig
einen Git-Commit aus.

Nicht jede Laborfunktion stellt einen Spielstandard dar:

| Einstellung | Übernehmbar | Bedeutung |
|---|---|---|
| Zoom | ja, je Zielbereich | festes Basiskameraprofil des Bereichs |
| Heldenhöhe und Tilegröße | ja | Produktionsmaßstab |
| Pixel-Snap und Texturfilter | ja | Darstellungsstandard beziehungsweise spätere Voreinstellung |
| Nebel und Licht | ja, je Weltzustand | atmosphärischer Standard des jeweiligen Zustands |
| Bewegungsgeschwindigkeiten und Sprungwerte | ja, je fokussiertem Regler | versionierte Bewegungsressource |
| angezeigter Weltzustand | nein | gleichberechtigte Vorschau bestehender Spielzustände |
| Diagnose, Kollision und Fensterwerte | nein | reine Entwicklungswerkzeuge und Messwerte |

Wird eine Einstellung später als Spieleroption angeboten, ist der goldene
Wert nur ihre ausgelieferte Voreinstellung. Eine im Spiel gespeicherte
Benutzerauswahl darf diese Voreinstellung überschreiben.

### Speicherquellen

Der lokale Arbeitsstand und der Spielstandard bleiben technisch getrennt:

- `user://visual_lab_settings.cfg` darf aktuelle Testwerte für das erneute
  Öffnen des Labors merken. Sie ist niemals Produktionsquelle.
- Angenommene Spielwerte liegen in versionierten Ressourcen unter
  `game/shared/resources/`. Das Labor liest die Goldmarkierung direkt aus
  diesen Ressourcen; eine zweite Datei mit denselben Standardwerten ist nicht
  zulässig.
- Spielszenen lesen ihre Ausgangswerte aus denselben versionierten Ressourcen
  und niemals aus der lokalen Testlabor-Konfiguration.

Die zentrale Zuordnung liegt in
`game/shared/resources/visual_lab_standards_v0.tres`. Sie verweist auf
`visual_baseline_v0.tres` sowie die Kameraprofile für Außenwelt, Dorf, Dungeon
und kleinen Innenraum und enthält die Nebel- und Licht-IDs beider
Weltzustände. Das Dorfprofil bleibt zunächst als eigene Ressource vorbereitet,
erbt aber über die Zuordnung den Außenweltwert. Erst die ausdrückliche
Übernahme eines Dorfzooms löst diese Vererbung.

Der lokale Arbeitsstand verwendet Speicherschema 3. Neben
`camera_context` werden `camera_zoom_world`, `camera_zoom_village`,
`camera_zoom_dungeon` und `camera_zoom_small_interior` getrennt gespeichert.
Die Gameplay-Regler werden als begrenzte Zahlenwerte gespeichert. Gültige
Version-1- und Version-2-Werte werden beim Laden übernommen und unmittelbar
in das neue Schema geschrieben; fehlende oder ungültige Werte fallen auf den
jeweiligen Spielstandard zurück.

Der Gameplay-Held erhält beim Öffnen eine tiefe Kopie von
`hero_movement_v0.tres`. Änderungen an der lokalen Vorschau können die
geladene Standardressource deshalb nicht versehentlich verändern.

Eine Übernahme macht die gewählten Werte ohne erneute Mitteilung im
Arbeitsbaum prüfbar. Sie ersetzt jedoch nicht die Repository-Regeln: Wenn ein
bereits angenommener Kanonwert geändert wird, müssen die passende Entscheidung
und die beschreibende Dokumentation vor dem Commit nachvollziehbar
aktualisiert werden.

## Zoomprofile nach Zielbereich

Der Kamerabereich wird vor der Zoomstufe ausgewählt. Jeder Bereich merkt
seinen aktuellen Testwert und besitzt einen unabhängig markierten
Spielstandard:

| Stabile ID | Anzeige | Bestehender Ausgangspunkt |
|---|---|---|
| `world` | Außenwelt | `1,00×` aus Maßstab V0 |
| `village` | Dorf | erbt zunächst den Außenweltwert, bis ein eigener Wert angenommen wird |
| `dungeon` | Dungeon | `1,00×` aus Maßstab V0 |
| `small_interior` | Kleiner Innenraum | `1,50×` aus dem bestehenden Szenenprofil |

Alle vier Bereiche lassen sich unabhängig vergleichen. Ein Wechsel des
Bereichs übernimmt keinen Wert. Die Bezeichnung `Kleiner Innenraum` bleibt
bewusst enger als `Innenraum`, weil Maßstab V0 bisher nur kleine Räume mit
`1,50×` festlegt. Weitere Bereiche können später mit stabiler ID ergänzt
werden.

Der angenommene Zoom ist der Basiszoom der passenden Spielszene. Temporäre
Überlagerungen wie der vorhandene Schleichzoom bleiben davon getrennt und
dürfen den gespeicherten Bereichsstandard nicht verändern.

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
| Kleine Innenräume | 1,50× | später als Szenenprofil freigegeben |

Pixel-Snap war damit noch nicht abschließend abgenommen. Der Fehler trat bei
`1920 × 1080` reproduzierbar auf, während `1,50 ×` im Fenster mit
`1280 × 720` durch dessen Skalierung von zwei Dritteln effektiv auf
`1,00 ×` Ausgabeskalierung kam und ruhig wirkte.

Die erste Korrektur rundete nicht die physische Position des
`CharacterBody2D`, sondern koppelte Heldenbild und Kamera auf einem groben
Weltpixelraster. Zusätzlich blieb Godots globales Transform-Snap aktiv. Der
anschließende praktische Nachtest hat diese Lösung am selben Tag verworfen:

| Einstellung | Praktischer Gegenbefund | Status |
|---|---|---|
| `1,00×`, Pixel-Snap AN | Welt schimmert und flackert bei Bewegung stark | nicht bestanden |
| `1,50×`, Pixel-Snap AN | Welt schimmert und flackert bei Bewegung stark | nicht bestanden |
| Pixel-Snap AUS | Kanten flackern wie vor der Korrektur | nicht bestanden |
| Heldenanzeige | bleibt gegenüber der Kamera fixiert | Teilproblem gelöst |

Die Bildanalyse hatte zwar gleich ausgerichtete Einzelmuster verglichen, aber
die ungleichmäßige zeitliche Bewegung nicht ausreichend bewertet. Das grobe
Raster erzeugte bei `1,50 ×` beispielsweise eine `6/6/3`-Pixel-Kadenz. Das
globale Transform-Snap rundete zudem verschachtelte Weltobjekte unabhängig
voneinander. Beides erklärt, warum AN im direkten Spieltest unruhiger wirkte.

Die zweite Korrektur verwendet deshalb ein gemeinsames, rein visuelles Raster
von genau einem Ausgabepixel. Seine Weltweite wird aus Kamerazoom und
Fensterskalierung berechnet. Kamera und Heldenbild bleiben in ihrer
vorhandenen Hierarchie; Viewport-Transform-Snap, Vertex-Snap und
Kamera-Smoothing bleiben AUS. Eine feste Viertelpixelphase hält Kanten von der
numerisch instabilen Rundungsgrenze fern; bei Nearest-Neighbor bleibt sie ohne
weiche Zwischenpixel. Bewegung, `move_and_slide()` und Kollision bleiben
unverändert.

Die automatisierte Wiederholung umfasst horizontale, vertikale und diagonale
Bewegung sowie getrennt verfolgte Ausschnitte für Held, Tilefläche und
Weltobjekte:

| Einstellung | Technisches Ergebnis der zweiten Korrektur | Status |
|---|---|---|
| `1,00×`, Pixel-Snap AN, Nearest | ganze Ausgabepixelschritte; Muster stabil | bestanden |
| `1,50×`, Pixel-Snap AN, Nearest | kleinste 5-/6-Pixel-Kadenz; Muster stabil | bestanden |
| Pixel-Snap AUS, Nearest | unveränderte freie Vergleichsbewegung | bekannte Kantenunruhe |
| Fenster 1920 × 1080 | keine grobe 3-/6-Pixel-Kadenz mehr | bestanden |
| Fenster 1280 × 720 | Fensterskalierung im Ausgaberaster berücksichtigt | bestanden |

Der anschließende direkte Bewegungstest wurde am 3. September 2026 abgenommen;
Pixel-Snap gilt damit als getestet. Aufgabe 20 hat `1,50×` anschließend als
zulässiges Szenenprofil für kleine Innenräume bestätigt; die normale
Spielansicht bleibt `1,00×`.

Der angezeigte Weltzustand `Beschädigt` bezeichnet ausschließlich den Zustand
des jeweiligen Tests. Beschädigte und wiederhergestellte Welt bleiben
gleichberechtigte Spiel- und Testzustände; keiner von beiden ist eine globale
Darstellungsregel.

## Maßstab V0

Der Benutzer hat am 3. September 2026 Kandidat B als verbindlichen
`Maßstab V0` ausgewählt:

| Eigenschaft | Verbindlicher Wert |
|---|---|
| Heldenhöhe | 80 px |
| Tilegröße | 32 × 32 px |
| Standard-Zoom | 1,00× |
| Referenzauflösung | 1920 × 1080 |
| Seitenverhältnis | 16:9 |
| Pixel-Snap | AN |
| Texturfilter | Nearest-Neighbor |

`1,00×` bezeichnet die normale Spielansicht. Kleine Räume dürfen wie der
Heldenraum über ein Szenenprofil `1,50×` verwenden; weitere
Setting-spezifische Profile bleiben möglich. Der Held kennt diese
Szenenentscheidung nicht selbst. Die verbindliche Begründung steht in
[ADR-0011](../../concept/entscheidungen/ADR-0011-massstab-v0.md).

Die frühere Bündelauswahl `A → Maßstab V0 → C` ist entfernt. Heldenhöhe,
Tilegröße, Kamerazoom, Pixel-Snap und Texturfilter bleiben als unabhängige
Einzelwerte testbar. So verändert eine manuelle Auswahl keine weiteren Werte
im Hintergrund. Diese Folgeentscheidung steht in
[ADR-0013](../../concept/entscheidungen/ADR-0013-massstabsbuendel-entfernen.md).

Eine frische oder unvollständige Testlabor-Konfiguration lädt die einzelnen
Werte aus Maßstab V0. Die verbindliche Ressourcenquelle ist
`game/shared/resources/visual_baseline_v0.tres`, nicht die lokale
Einstellungsdatei. Bestehende Karten wurden nicht großflächig umgebaut. Der
Heldenraum liest die Heldenhöhe aus dem Maßstab und verwendet dasselbe 32er
Raster, behält aber sein passendes kleines Innenraumprofil mit `1,50×`.

Die verbindlichen Ergebnisse des gesamten Testlabors sind in der
[visuellen Darstellungsgrundlage V0](../architecture/visuelle-darstellungsgrundlage-v0.md)
zusammengeführt. Diese Funktionsseite behält die ausführlichen historischen
Vergleiche und die Bedienung des Labors bei.

## Gameplay-Tab

Der sechste Tab ist scrollbar und stellt alle derzeit aktiven
Bewegungsparameter als numerische Regler dar:

| Gruppe | Werte | Grenze |
|---|---|---|
| Geschwindigkeit | Schleichen, Gehen, Laufen, Rennen, Sprinten | 40–500 px/s in 5er-Schritten |
| Sprunghöhe | Steh-, Geh-, Lauf-, Renn- und Sprintsprung | 8–64 px in 1er-Schritten |
| Sprungweite | Geh-, Lauf-, Renn- und Sprintsprung | 16–160 px in 1er-Schritten |

Die Stehsprungweite wird als fester Wert `0 px` angezeigt. Der Regler zeigt
aktuellen Testwert und Spielstandard zugleich. Eine Änderung wirkt sofort auf
den Laborhelden, bleibt lokal und wird erst nach ausdrücklicher Übernahme des
fokussierten Reglers in `hero_movement_v0.tres` geschrieben.

Stehsprungangriff, Gehsprungangriff, Laufsprungangriff, Rennsprungangriff,
Sprintsprungangriff, Ausweichen, Schleichrolle und Ausweich-Backflip sind als
ausgegraute, nicht fokussierbare Platzhalter sichtbar. Sie besitzen noch keine
Laufzeitlogik.

## Inhalt des Testlabors

### 1. Helden-Testfläche

Die Helden-Testfläche ermöglicht:

```text
- Spielfigur anzeigen
- Schleichen, Gehen, Laufen, Rennen und Sprinten in vier Richtungen
- Steh-, Geh-, Lauf-, Renn- und Sprintsprung
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
Prototyp und keine endgültige Art-Bible. Die abweichenden umschaltbaren
Größenwerte bleiben Testwerte; Maßstab V0 ist davon eindeutig getrennt.

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
- Nebelstärken je Weltzustand
- Lichtprofile je Weltzustand
```

Die umschaltbaren Tilegrößen, Heldenhöhen und Kameraansichten stammen aus der
visuellen Richtung V0. Der sichtbare Vergleich ist abgeschlossen; die
Varianten bleiben für spätere Regressionen verfügbar.

#### Pixel-Snap-Vergleich

Im Thema `Darstellung` wählt ein fokussier- und anklickbarer Eintrag zwischen
`Pixel-Snap: AN` und `Pixel-Snap: AUS`. Es gibt dafür kein eigenes
Direktkürzel. Der aktuelle Testwert kann als lokaler Arbeitsstand gemerkt
werden; der gold markierte Spielstandard wird davon getrennt aus der
versionierten Darstellungsgrundlage gelesen. Alte lokale Einstellungsdateien
ohne den Schlüssel fallen bei der Migration auf diesen Spielstandard zurück.

Der Schalter rastert ausschließlich die visuellen Positionen von Kamera und
Heldenbild auf ganze Ausgabepixelschritte. Das globale Viewport-Transform-Snap
bleibt AUS, damit verschachtelte Weltobjekte nicht unabhängig voneinander
gerundet werden. Logische Positionen, Bewegung, Kollisionsformen und
Kameragrenzen werden nicht verändert. Beim Verlassen des Testlabors werden die
vorherigen Viewport-Einstellungen wiederhergestellt. In der Diagnose bleiben
rohe und gerasterte Positionen getrennt sichtbar.

Der erste Vergleich nur bei `1280 × 720` reichte für die Abnahme nicht aus,
weil die Fensterskalierung dort den Kamerazoom `1,50 ×` zu einer ganzzahligen
Ausgabeskalierung machte. Der korrigierte Vergleich prüft deshalb zusätzlich
`1920 × 1080` und echte Bewegung in drei Richtungen. Details und der
chronologische Ausgangsbefund stehen unter
[Laufende Testergebnisse](#laufende-testergebnisse). Der anschließende
Sichttest hat Held, Kamera und Welt bei `1,00×` und `1,50×` bestätigt.
Aufgabe 20 ordnet diese Ausgabepixel-Ausrichtung dem verbindlichen Maßstab V0
zu.

#### Texturfilter-Vergleich

Neben Pixel-Snap steht im Thema `Darstellung` ein zweiter fokussier- und
anklickbarer Eintrag. Er wählt zwischen `Texturfilter: Nearest-Neighbor` und
`Texturfilter: Weich`; ein eigenes Direktkürzel gibt es nicht. Die ID
`nearest` oder `soft` kann als lokaler Testwert gemerkt werden. Lokale
Altstände ohne gültige Filter-ID fallen bei der Migration auf den
versionierten Spielstandard zurück.

Die Umschaltung erfasst ausschließlich die 51 texturierten `CanvasItem`-
Instanzen unter `TestWorld`: den animierten Helden als `AnimatedSprite2D`, den
texturierten Vergleichsboden, die Größenreferenzen und die `Sprite2D`-Objekte
beider Weltzustände. Sie ändert weder die globale Projekteinstellung noch
Szenenressourcen. Beim Verlassen werden alle vorherigen Instanzwerte
wiederhergestellt. Vektorgezeichnete Tile-Raster und Kollisionsformen besitzen
keine Texturabtastung und bleiben deshalb in beiden Varianten identisch.

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

Nearest-Neighbor wurde damit zum bevorzugten Kandidaten. Der anschließende
Vergleich mit allen drei Zoomstufen wurde am 3. September 2026 abgenommen;
Aufgabe 18 gilt damit als abgeschlossen. Aufgabe 20 hat den Filter als
Standard für Pixelart in Maßstab V0 übernommen. Bewusst weich angelegte
Atmosphäreneffekte bleiben davon ausgenommen.

#### Nebel und Licht

Stand: 3. September 2026.

Das Thema `Welt und Atmosphäre` wechselt zwischen beschädigter und
wiederhergestellter Welt. Die Nebelauswahl durchläuft die drei Nebelstärken
des aktiven Zustands; die Lichtauswahl durchläuft dessen zwei Lichtprofile.
Eigene Direktkürzel für diese drei Einträge gibt es nicht. Der lokale
Arbeitsstand wird für beide Weltzustände getrennt gemerkt; ein
Zustandswechsel stellt die zuletzt getestete Kombination dieses Zustands
wieder her. Alte lokale Einstellungsdateien ohne diese Werte und unbekannte
IDs verwenden die jeweiligen versionierten Spielstandards.

Die deckungsgleiche Vergleichsfläche misst jetzt `1440 × 810` Pixel. Sie
verbindet das vorhandene Haus mit einem offenen Laufweg, zwölf Bäumen und
einer Sägewerk-Teststation. Haus, Wald und Sägewerk besitzen paarige
beschädigte und wiederhergestellte Prototypgrafiken. Diese Zusammenstellung
ist ausschließlich eine nicht-kanonische Entwicklungskulisse; sie legt weder
einen Ort noch eine Spielmechanik fest.

Die bisherigen geraden Nebelbänder wurden durch zwei wolkige RGBA-Texturen
ersetzt. Sie besitzen unregelmäßige Bänke, Lücken und 16 abgestufte
Transparenzwerte. Das Bildgenerator-Ergebnis wurde auf ein logisches
`720 × 405`-Raster reduziert, mit Nearest-Neighbor auf `1440 × 810`
verdoppelt, zustandsabhängig eingefärbt und ohne Metadaten komprimiert. Der
beschädigte Nebel bleibt höchstens 68 Prozent, der wiederhergestellte
höchstens 38 Prozent deckend. Die Variantensteuerung verändert weiterhin nur
Sprite-Deckkraft und flächige Farbmodulation; Shader, Physik und Spielmechanik
bleiben unberührt.

##### Beschädigter Weltzustand

- Gewählte Nebelstärke: Mittel
- Gewähltes Lichtprofil: Kühl und dunkel
- Helligkeit: Sehr dunkel
- Kontrast: Mittel
- Farbstimmung: Kühl und entsättigt
- Sichtbarkeit des Helden: Im Stillstand und bei Bewegung in allen drei
  Zoomstufen erhalten; selbst die hohe Nebelvariante verdeckt ihn nicht.
  Hauskontur, beschädigtes Sägewerk, Weg und kahle Waldsilhouetten bleiben
  unterscheidbar.
- Bekannte Probleme: Die Varianten sind bewusst auf die vorhandene
  Testlabor-Vorschau begrenzte Prototypwerte. Die hohe Nebelstufe ist nur ein
  Vergleichsextrem und keine Produktionsvorgabe.

##### Wiederhergestellter Weltzustand

- Gewählte Nebelstärke: Gering
- Gewähltes Lichtprofil: Warm und klar
- Helligkeit: Hell
- Kontrast: Hoch
- Farbstimmung: Leicht warm
- Sichtbarkeit des Helden: Im Stillstand und bei Bewegung in allen drei
  Zoomstufen erhalten; Figur, Weg, arbeitendes Sägewerk und dichter Wald
  bleiben klar getrennt.
- Bekannte Probleme: Die warme Farblage und die geringe Nebelstärke sind
  vorläufige Vergleichswerte. Eine endgültige Palette oder ein finales
  Atmosphärenasset wird daraus noch nicht abgeleitet.

##### Technische Prüfung

- Getestete Zoomstufen: Weit `0,75×`, Mittel `1,00×` und Nah `1,50×`.
- Verhalten bei Kamerabewegung: 72 OpenGL-Bewegungsaufnahmen mit je zwölf
  Bildern pro Zustand und Zoom wurden auf der vergrößerten Fläche verglichen.
  Nebel, Licht, Haus, Wald und Sägewerk blieben gemeinsam an der Welt
  verankert; es trat kein separates Springen oder Flackern einer
  Atmosphärenlage auf.
- Verhalten beim Weltzustandswechsel: Alle 36 Kombinationen aus zwei
  Zuständen, drei Nebelstärken, zwei Lichtprofilen und drei Zoomstufen wurden
  gerendert. Der Wechsel hinterließ keine Ebene und keinen Farbwert des
  vorherigen Zustands.
- Auswirkungen auf die Leistung: In einem isolierten
  Software-OpenGL-Lauf mit je 360 Frames erreichten die bevorzugten Profile
  auf der vergrößerten Fläche 64,20 Frames/s (beschädigt) und 61,66 Frames/s
  (wiederhergestellt). Beide Läufe blieben auch im softwaregerenderten
  llvmpipe-Vergleich oberhalb von 60 Frames/s; die statischen Wolkenbilder
  benötigen keine laufende Atmosphärenberechnung.
- Preset-Speicherung geprüft: Ja; aktive und inaktive Zustandsauswahl werden
  gespeichert, geladen und bei ungültigen IDs kontrolliert zurückgesetzt.
- Lesbarkeit und Kollision: Die Render- und Laufzeittests bestätigten
  sichtbare Helden-, Hindernis- und Grenzkonturen in beiden Zuständen. Die
  vergrößerte Kulisse fügt keine Kollisionsform hinzu; Bewegung,
  `move_and_slide()` und die vorhandenen Testhindernisse blieben unverändert.

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
- rohe Spielerkoordinaten und gerasterte Heldenanzeige
- rohe und gerasterte Kameraposition, tatsächliches Kamerazentrum und Weltanker
- Kamerabereich, Darstellungsraster, Rasterphase und Fensterskalierung
- Basis- und aktiver Kamerazoom
- aktueller Bewegungs- und Sprungzustand
- gewählte Tilegröße
- gewählte Figurengröße
- manuelle Maßstabseinstellung
- aktuelle Geschwindigkeit und Feststelltasten-Gehmodus
- Referenzauflösung und Seitenverhältnis
- aktiver Weltzustand
- aktive Nebelstärke
- aktives Lichtprofil
- aktiver Pixel-Snap-Zustand
- aktiver Texturfilter
```

Die Anzeigen machen die jeweils aktive Testkonfiguration unmittelbar
erkennbar und sind nicht für normale Spielbuilds bestimmt.

`F3` schaltet ein kompaktes, halbtransparentes Diagnosepanel um. Es zeigt FPS,
rohe Heldenposition, gerasterte Heldenanzeige, rohes und gerastertes
Kameraziel, tatsächliches Kamerazentrum,
Weltanker, manuelle Maßstabseinstellung, Referenzauflösung, Seitenverhältnis,
Kamerabereich, Basis- und Aktivzoom, Bewegungszustand, Geschwindigkeit,
Feststelltasten-Gehmodus, Sprungzustand, Figuren-, Tile-,
Weltzustands-, Nebel-, Lichtprofil-, Pixel-Snap-, Viewport-Transform-Snap-,
Vertex-Snap-, Darstellungsraster-, Rasterphasen- und Texturfilterwerte sowie
Fenstergröße und Skalierungsfaktor. In der Referenzansicht ist das Panel auf
`450 × 620` Pixel begrenzt; sein Hintergrund besitzt `58 %` Deckkraft.
Derselbe Schalter ist unter `Diagnose und Hilfe` erreichbar.

`F4` schaltet davon unabhängig eine eigene Zeichnung der vorhandenen Helden-,
Hindernis- und Weltgrenzen-Kollisionen; auch dafür gibt es einen Menüeintrag.
Beide direkten Funktionstasten bleiben bewusst erhalten. Beide Anzeigen
beginnen bei jedem Öffnen ausgeschaltet und werden nicht in den
Testlabor-Einstellungen gespeichert. Das Diagnosepanel aktualisiert seine
Werte ungefähr alle 0,2 Sekunden. Die Kollisionszeichnung liest die
bestehenden Physikformen nur aus und verändert weder sie noch Godots globale
Debug-Hinweise.

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
- alle sechs Testbereiche dokumentiert sind,
- `F5` ein nach Themen gegliedertes und bei `1280 × 720` bedienbares Menü
  öffnet, das nur einen kleinen Teil der Testwelt bedeckt,
- die Testfigur bei geöffnetem `F5`-Menü beweglich bleibt,
- veränderliche Testparameter ohne eigene Direktkürzel vollständig über das
  Menü bedienbar sind,
- `F3` für Diagnose und `F4` für Kollisionsflächen erhalten bleiben,
- aktueller Testwert und übernommener Spielwert technisch und visuell getrennt
  bleiben,
- die Goldmarkierung auch beim weiteren Vergleichen eindeutig beim
  übernommenen Wert bleibt,
- `Strg + Alt + E` und der sichtbare Übernahmeknopf nur den fokussierten Wert
  übernehmen,
- Gameplay-Regler die dokumentierten Grenzen erzwingen und nur eine tiefe
  Laufzeitkopie verändern,
- Außenwelt, Dorf, Dungeon und kleiner Innenraum unabhängige Zoomtests und
  Spielstandards besitzen,
- Spielszenen ausschließlich versionierte Spielwerte und niemals lokale
  Testwerte als Ausgangspunkt verwenden,
- beschädigte und wiederhergestellte Welt direkt verglichen werden können,
- die umschaltbaren Diagnoseanzeigen kompakt und halbtransparent bleiben,
- `visual_lab` ausdrücklich nur in Entwicklungsbuilds erreichbar ist und
- noch offene Grafikentscheidungen nicht ohne ihren vorgesehenen Vergleich
  vorweggenommen werden.
