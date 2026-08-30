---
title: "Core Loop"
language: de
status: draft
version: "0.2"
source_of_truth: true
translation_status: blocked-until-concept-complete
---
<!-- AUTO-GENERATED:backlink START -->
[← Back](00-overview.md)
<!-- AUTO-GENERATED:backlink END -->
[← Überblick](index.md)

# Core Loop

## Zweck des Dokuments

Dieses Dokument visualisiert die bestätigte Grundstruktur des wiederkehrenden
Spielablaufs. Das Diagramm ist ein Arbeitsentwurf und noch keine freigegebene
Missions-, Ressourcen- oder Zustandsmaschine.

## Bestätigte Entscheidungen

Bestätigt sind Erkundung einer beschädigten Welt, das Überwinden von Gefahren
und Gegnern sowie die Reihenfolge von Landschaftswiederherstellung über die
Rückkehr von Bewohnern und Siedlungen bis zu Erinnerungen und erweiterten
Heldenfähigkeiten.

## Wiederkehrender Gebietsloop

```mermaid
flowchart TD
    A["Unlesbares oder versperrtes Gebiet erkunden"] --> B["Regionalen Zugangsdungeon bewältigen"]
    B --> C["Landschaft und Wege sichtbar machen"]
    C --> D["Weitere Quellen und Monsternester finden"]
    D --> E["Gebäude und Bewohner zurückbringen"]
    E --> F["Erinnerungen durch Kampf und Rätsel befreien"]
    F --> G["Von der Gemeinschaft Wissen und Fähigkeiten erwerben"]
    G --> H["Nächsten Abschnitt erreichen"]
```

Der Loop gilt als Rhythmus der ersten vier Abschnitte und darf regional anders
inszeniert werden. Maschinen und Zuro sind nicht als allgemeine Schritte
eingetragen, weil ihre übergreifende Bedeutung weiterhin nicht entschieden ist.

## Spielerperspektive und Spielerfantasie

Der Spieler soll einen verständlichen Wechsel aus Erkunden, Bewältigen,
Wiederherstellen, Entdecken und Wachsen erleben. Noch nicht entschieden ist,
welcher Anteil der Spielzeit auf jeden Teil entfällt.

## Regeln und Ablauf

Das Diagramm beschreibt die freigegebene Makrofolge. Der Graslandabschnitt
setzt sie mit Turm, Sägewerk, Wasserwerk, Lichterhaus und Dorf erstmals konkret
um. Rücksprünge, optionale Aufgaben und parallele Ziele innerhalb eines
Abschnitts bleiben durch Prototypen zu prüfen.

## Eingaben und Ausgaben

- Eingaben: erreichbare Gebiete, Gefahren, Gegner und noch zu definierende
  Wiederherstellungsbedingungen.
- Ausgaben: veränderte Landschaft, zurückkehrende Weltbestandteile,
  erschlossene Erinnerungen, Fähigkeiten und neue Aufgaben.
- Noch nicht entschieden: konkrete Ressourcen, Questdaten und Zustandswerte.

## Systemabhängigkeiten

Der Loop hängt von Landschaft, Kampf, Weltzustand, Bewohnern, Siedlungen,
Erinnerungen und Fortschritt ab. Maschinen, Zuro und Gegnerentwicklung sind
mögliche Einflussfaktoren, deren Anschlussstellen erst nach ihrer Definition
festgelegt werden dürfen.

## Veränderbare und später zu balancierende Werte

Zu prüfen sind Dauer, Häufigkeit, Abwechslung, Schwellen und Verhältnis der
Loop-Phasen. Es werden noch keine Zielzeiten oder Mengen festgelegt.

## Visuelles, akustisches und UI-Feedback

Der Übergang zwischen beschädigtem und wiederhergestelltem Zustand muss sichtbar
und verständlich sein. Audio- und UI-Signale sind noch nicht entschieden und
müssen die Weltveränderung ergänzen, nicht ersetzen.

## Sonderfälle und Risiken

- Erzwungene Linearität könnte Erkundung entwerten.
- Unklare Wiederherstellungsbedingungen könnten Fortschritt willkürlich wirken
  lassen.
- Zu spätes Feedback könnte Ursache und Wirkung trennen.
- Der Loop darf Maschinen oder Zuro nicht vor deren Freigabe voraussetzen.

## Offene Fragen

- Was gilt spielerisch als abgeschlossene Wiederherstellung eines Gebiets?
- Wie werden neue Aufgaben entdeckt oder freigeschaltet?
- Welche Nebenwege und Aufgaben sind optional oder unumkehrbar?
- Wie verbindet sich der Moment-zu-Moment-Kampf mit dem Makrofortschritt?

## Abnahmekriterien

- Ein Prototyp kann alle dargestellten Schritte in nachvollziehbarer Reihenfolge
  zeigen.
- Testpersonen können Ursache und Wirkung jeder Zustandsänderung beschreiben.
- Der Ablauf widerspricht keiner bestätigten Wiederherstellungsentscheidung.
- Maschinen und Zuro erscheinen erst nach eigener Freigabe als feste Faktoren.

## Verwandte Konzeptseiten

- [Gameplay und Fortschritt](../03-gameplay-and-progression/gameplay-and-progression.md)
- [Spielablauf und Abschnittsstruktur](../03-gameplay-and-progression/game-flow-and-section-structure.md)
- [Landschaftssystem](../07-landscape-and-environment/landscape-system.md)
- [Vertical Slice](../09-prototypes-and-tests/vertical-slice.md)
- [Designprinzipien](design-pillars.md)
