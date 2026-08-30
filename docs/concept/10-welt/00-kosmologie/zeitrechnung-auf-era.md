---
title: Zeitrechnung auf Era
status: accepted
updated: 2026-08-30
---
<!-- AUTO-GENERATED:backlink START -->
[← Zurück](00-kosmologie.md)
<!-- AUTO-GENERATED:backlink END -->
# Zeitrechnung auf Era

## 1. Grundprinzip der Zeitmessung

Eras feste Zeitrechnung verwendet die Einheiten Um, Tan, Dir und Mohn. Sie
bleibt rechnerisch stabil, obwohl Sol und Yol unregelmäßig laufen und sichtbare
Licht- oder Dunkelphasen deshalb keine gleichmäßige Uhr bilden.

Sol definiert grundsätzlich den erlebten Tag, Yol grundsätzlich die erlebte
Nacht. Für die vollständige Rotation Eras dient zusätzlich ZEHS als annähernd
fester Himmelsbezug. Kalenderdauer, lokale Sonnenphase und sichtbare
Strahlungsintensität sind daher getrennte Angaben.

## 2. Zeiteinheiten

| Größe | Umrechnung |
|---|---:|
| 1 Tan | 20 Um |
| 1 Dir | 10 Tan = 200 Um |
| 1 Mohn | 35 Dir = 350 Tan = 7000 Um |
| 1 Konvektionszyklus | 10 Mohn = 350 Dir = 3500 Tan = 70000 Um |

Die ältere Quellenzeile `1 Mohn = Konvektion` ist rechnerisch unvereinbar mit
dieser Zeitrechnung und gilt als verworfene Arbeitszeile, nicht als Kanon.

## 3. Umrechnung in irdische Maßstäbe

Für den irdischen Vergleich gilt:

| Era-Einheit | Irdischer Vergleich |
|---|---:|
| 1 Um | 1 Stunde |
| 1 Tan | 20 Stunden |
| 1 Dir | 200 Stunden = 8 Tage und 8 Stunden |
| 1 Mohn | 7000 Stunden = 291 Tage und 16 Stunden, ungefähr 0,8 Jahre |
| 1 Konvektionszyklus | 70000 Stunden = 2916 Tage und 16 Stunden, ungefähr 8 Jahre |

`1 Dir = 8 Tage` ist als gerundete Kurzform zulässig. Der exakte Vergleich
bleibt 8 Tage und 8 Stunden.

## 4. Theoretische In-Game-Umrechnung

Bei der theoretischen Skalierung `1 Um = 1 reale Spielminute` ergibt sich:

| Era-Einheit | Reale Spielzeit |
|---|---:|
| 1 Um | 1 Minute |
| 1 Tan | 20 Minuten |
| 1 Dir | 200 Minuten = 3 Stunden und 20 Minuten |
| 1 Mohn | 7000 Minuten = 116 Stunden und 40 Minuten |
| 1 Konvektionszyklus | 70000 Minuten = 1166 Stunden und 40 Minuten = 48 Tage, 14 Stunden und 40 Minuten |

Diese Tabelle ist eine theoretische Umrechnung. Sie verpflichtet das Spiel
weder zu einer vollständig in Echtzeit simulierten Welt noch zu diesem
Balancing.

## 5. Datums- und Uhrzeitnotation

In der Dokumentation steht eine Zeitmenge als Zahl mit Einheit, zum Beispiel
`20 Tan`, `2 Dir` oder `400 Um`. Zusammengesetzte Mengen werden von der größten
zur kleinsten Einheit notiert.

Für Kalender- oder Simulationsbeispiele gilt die lesbare Struktur:

`Mohn <M> · Dir <D> · Tan <T> · Um <U> · Sonnenphase: <Laufart> · S-Int <Wert>`

Die Platzhalter zeigen nur das Format und legen kein historisches Datum fest.
Eine überall verbindliche In-World-Epoche und die Frage, ob einzelne Kulturen
null- oder einsbasiert zählen, sind nicht freigegeben. Quellen müssen ihre
Zählweise deshalb kenntlich machen. Gelehrte können Datierungen
unterschiedlicher Herkunft nur vergleichen, wenn diese Angabe erhalten ist.

## 6. ZEHS als Referenzpunkt

ZEHS ist ein weit entfernter, sehr heller und annähernd fester Referenzstern.
Er befindet sich ungefähr 40 AU vom zentralen System entfernt. Sein Untergang
und erneuter Aufgang dienen als Bezug für eine vollständige Rotation Eras. Der
Name steht in Verbindung mit Zehsen.

ZEHS ist Weltenlogik. Entfernung und Bewegung sind keine Verpflichtung zu
einer naturwissenschaftlich exakten astronomischen Simulation.

## 7. Verhältnis zur Konvektion

Der verlässliche große Konvektionszyklus umfasst 10 Mohn, 350 Dir, 3500 Tan
oder 70000 Um und entspricht ungefähr acht irdischen Jahren.

Die Konvektion selbst dauert:

- 20 Tan;
- 2 Dir;
- 400 Um;
- im irdischen Vergleich 400 Stunden beziehungsweise 16 Tage und 16 Stunden;
- bei der theoretischen In-Game-Skalierung 400 Minuten beziehungsweise
  6 Stunden und 40 Minuten.

Die kosmischen Bedingungen des Ereignisses beschreibt
[Zeitzyklen und Konvektion](zeitzyklen-und-konvektion.md).

## 8. Abgrenzung zwischen Lore-Zeit und tatsächlicher Spielzeit

Die Zeitrechnung definiert Weltenlogik und belastbare Umrechnungen. Gameplay
kann lange Zeiträume durch Weltzustände, Zeitsprünge, Storyereignisse oder
regionale Regeln darstellen. Weder ein Mohn noch ein Konvektionszyklus muss in
voller Echtzeit ablaufen. Auch kurze spielbare Zustände dürfen einen längeren
Lore-Zeitraum repräsentieren, solange die Dokumentation beide Ebenen klar
trennt.
