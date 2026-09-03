---
title: Rekonstruktionssystem
status: draft-design
updated: 2026-09-02
---

<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Rekonstruktionssystem

## Zweck

Das Rekonstruktionssystem übersetzt das Befreien von Monsterhöhlen in sichtbare, spielbare Weltveränderung. Es ist die wichtigste Verbindung zwischen Kampf und Weltaufbau.

## Grundregel: kein globaler binärer Weltzustand

Eine Region besitzt keinen einzelnen Schalter für „beschädigt“ oder
„wiederhergestellt“. Landschaft, Gebäude, Seelen und Personen entwickeln sich
als getrennte Rekonstruktionseinheiten. Sie können gleichzeitig
unterschiedlich weit fortgeschritten sein. Die Wiederherstellung geschieht
lokal und schrittweise; der Abschluss eines Dungeons macht nicht automatisch
jedes Element einer Region fertig.

Der regionale Fortschritt ist eine abgeleitete Übersicht über diese
Einzelzustände. Er ist kein eigener An/Aus-Zustand und darf die zugrunde
liegenden Phasen nicht ersetzen.

## Rekonstruktionseinheiten

Jede Region kann in wiederherstellbare Einheiten gegliedert werden:

- Geländeabschnitt;
- Naturknoten;
- Bewohner- oder Seelengruppe;
- Gebäude oder Stadtfunktion;
- Erinnerungsknoten;
- Fähigkeit oder Fähigkeitsverbesserung.

Die Einheiten bleiben unabhängig. Eine bereits wiederbelebte Landschaft kann
beispielsweise ein Wohnhaus im Rohbau, eine noch gebundene Seele und erst zwei
zurückgekehrte Bewohner enthalten.

## Zustände der Einheiten

### Landschaft und Natur

Natur wird abschnittsweise geheilt. Nebelquellen, Boden, Gewässer,
Vegetationsgruppen und andere Naturknoten können getrennt fortschreiten:

```text
0 – verdorben
1 – stabilisiert
2 – erste Vegetation
3 – wiederbelebt
```

Eine Phase kann mehrere sichtbare Änderungen verbinden, etwa weniger Nebel,
klareren Boden und zurückkehrende Pflanzen. Benachbarte Naturknoten müssen
dabei nicht dieselbe Phase besitzen.

### Gebäude und Ruinen

Gebäude werden einzeln gebaut oder repariert. Ein Neubau verwendet:

```text
0 – nicht vorhanden / Bauplatz
1 – Fundament
2 – Rohbau
3 – funktionsfähig
4 – vollständig ausgebaut
```

Wenn am Ort tatsächlich ein altes zerstörtes Gebäude steht, verwendet es
stattdessen passende Reparaturphasen:

```text
0 – Ruine
1 – gesichert
2 – repariert
3 – wieder in Betrieb
```

Ein fertiges Gebäude schließt weder andere Bauvorhaben noch die gesamte Region
ab. Bewohner beziehen einen Ort erst, wenn dessen eigener Zustand dies
zulässt.

### Seelen

Jede relevante Seele wird einzeln gefunden, befreit und nach Era
zurückgeführt:

```text
0 – verloren oder gebunden
1 – befreit
2 – zurückgeführt
```

### Personen

Rückkehr und Ansiedlung einer Person sind getrennte Schritte:

```text
0 – abwesend
1 – zurückgekehrt
2 – angesiedelt
3 – übernimmt eine Aufgabe
```

Die Personenphase darf sich nur erhöhen, wenn die erzählerischen und
räumlichen Voraussetzungen dieser einzelnen Person erfüllt sind.

## Regionaler Fortschritt

Eine Region fasst die Zustände ihrer Einheiten für Karte, Aufgaben und
Spielerfeedback zusammen. Eine solche Übersicht kann beispielsweise lauten:

```text
Landschaft:        60 % wiederhergestellt
Sägewerk:          fertig aufgebaut
Wohnhaus:          Rohbau
Wasserwerk:        noch nicht begonnen
Seele des Müllers: zurückgeführt
Dorfbewohner:      2 von 8 zurückgekehrt
Nebelquelle:       beseitigt
```

Der Prozentwert wird aus den tatsächlich vorhandenen Einzelzuständen
berechnet. Gewichtung und genaue Formel bleiben datengetriebene
Balancingfragen; sie dürfen keinen versteckten globalen Binärzustand
einführen. Eine Region kann deshalb deutlich lebendiger wirken und dennoch
unfertige Gebäude, fehlende Personen oder verdorbene Naturknoten enthalten.

## Auslöser

Eine Rekonstruktion kann ausgelöst werden durch:

- das Besiegen eines Höhlenkerns;
- das Schließen eines Siegels;
- das Reinigen mehrerer miteinander verbundener Monsterquellen;
- das Lösen einer Erinnerungsaufgabe;
- den Schutz einer zurückgekehrten Seele;
- einen regionalen Bosskampf.

## Darstellung

Die Veränderung soll nach Möglichkeit direkt im Spielraum sichtbar werden. Geeignete Formen sind:

- Landschaft baut sich vor den Augen des Spielers auf;
- Farbe, Licht und Geräusche kehren zurück;
- neue Wege wachsen oder werden freigelegt;
- Bewohner erscheinen nicht abstrakt im Menü, sondern beziehen konkrete Orte;
- eine Stadt entwickelt sich in mehreren erkennbaren Stufen.

## Grasland als Referenz

Im Grasland zeigt das System mehrere Granularitäten: Der Turmboss lässt ein
großes zusammenhängendes Bündel von Naturknoten auf Karte und in der Welt
aufblühen, schließt aber nicht alle anderen Rekonstruktionseinheiten des
Gebiets ab. Im riesigen Sägewerk löst dagegen jedes besiegte Monsternest einen
einzelnen Gebäudefortschritt aus. Später befreit der Wasserwerkdungeon
Menschenseelen, während das Lichterhaus Erinnerungen in kurzen
Lampenabschnitten zurückgibt. Diese Folge ist der Referenzablauf, aber keine
Verpflichtung, alle späteren Regionen identisch zu bauen.

## Visueller Debug-Vergleich

„Beschädigt ↔ wiederhergestellt“ bleibt als technischer A/B-Vergleich im
visuellen Testlabor zulässig. Er zeigt einen Vorher-/Nachher-Kontrast für
Grafik, Lesbarkeit und Atmosphäre, bildet aber ausdrücklich nicht das
eigentliche Weltmodell ab. Eine spätere Rekonstruktionsvorschau soll Natur-,
Gebäude- und Seelenphasen unabhängig darstellen können.

## Technische Konsequenz

Die Welt benötigt persistente Zustände pro Rekonstruktionseinheit. Quests,
Kollisionen, Gegner, Navigation, Dialoge und Musik müssen auf die jeweils
relevanten Einzelzustände reagieren können. Ein regionaler Wert wird daraus
berechnet und nicht separat als Wahrheit gespeichert. Das System sollte
datengetrieben sein, damit Regionen nicht ausschließlich über individuelle
Skripte gebaut werden müssen.
