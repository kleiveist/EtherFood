---
title: "Präsentationsrichtung"
language: de
status: draft
version: "0.1"
source_of_truth: true
translation_status: blocked-until-concept-complete
---
<!-- AUTO-GENERATED:backlink START -->
[← Back](08-art-audio-and-ui.md)
<!-- AUTO-GENERATED:backlink END -->
[← Grafik, Audio und Benutzeroberfläche](index.md)

# Präsentationsrichtung

## Zweck des Dokuments

Dieses Dokument verbindet Grafik, Audio und Benutzeroberfläche mit den
bestätigten Spielerinformationen. Es legt noch keinen finalen Stil, keine
Assetliste und keine technische Produktionspipeline fest.

## Bestätigte Entscheidungen

- Die Perspektive ist Top-down.
- Landschaftswiederherstellung, Rückkehr von Bewohnern und Siedlungen,
  Erinnerungen, Fortschritt und die vier Vertical-Slice-Kampfhandlungen müssen
  für den Spieler verständlich werden.
- Das Spiel entwickelt eine eigenständige Identität und kopiert keine konkreten
  geschützten Inhalte seiner internen Referenz.

## Aktueller Arbeitsentwurf

Präsentation soll Zustände, Handlungsfolgen und Gefahren mehrkanalig lesbar
machen. Grafikstil, Farbwelt, Formensprache, Instrumentierung, Klangästhetik,
UI-Layout und Typografie sind noch nicht entschieden.

## Spielerperspektive und Spielerfantasie

Der Spieler soll aus der Top-down-Sicht eine beschädigte Welt erkennen, ihre
Transformation erleben und in Kampf sowie Erkundung klare Rückmeldung erhalten.
Die emotionale Tonalität benötigt eine verbindliche Story- und
Designentscheidung.

## Regeln und Ablauf

Für jeden relevanten Zustand sind Informationspriorität, Zeitpunkt, Dauer,
Wiederholung und alternative Wahrnehmungskanäle zu definieren. Kosmetische
Elemente dürfen spielentscheidende Telegraphie nicht überdecken.

## Eingaben

Präsentation reagiert auf Weltzustände, Spielerhandlungen, Gegnerabsichten,
Treffer, Block, Ausweichen, Magie, Erinnerungsinteraktionen und Fortschritt.
Welche Ereignisse technisch existieren, folgt den freigegebenen Systemen.

## Ausgaben

Mögliche Ausgaben sind Animation, Form, Farbe, Licht, Partikel, Klang, Musik,
Text, Symbol, Anzeige und Controllerfeedback. Die Auswahl und Kombination sind
noch nicht entschieden.

## Systemabhängigkeiten

Die Präsentation hängt von allen fachlichen Systemen, Eingabegeräten,
Barrierefreiheit, Lokalisierung, Kamera, Rendering, Audio und UI-Technik ab.
Medien werden nach der [Medienrichtlinie](../../../assets/README.md) verwaltet.

## Veränderbare und später zu balancierende Werte

Effektdauer, Intensität, Lautstärke, Kontrast, Kamerabewegung,
Informationsdichte, Textgröße und UI-Skalierung bleiben veränderbar. Es werden
keine konkreten Zielwerte freigegeben.

## Visuelles, akustisches und UI-Feedback

Zu entwerfen und zu testen sind mindestens:

- beschädigter gegenüber wiederhergestelltem Landschaftszustand,
- Rückkehr oder Veränderung in der Welt,
- Angriffs-, Ausweich-, Block- und Magiezustand,
- Gegnertelegraphie, Treffer und Niederlage,
- Erinnerungsfund und daraus entstehender Fortschritt,
- Ziel, nächster Schritt und relevante Systemgrenzen.

## Sonderfälle und Risiken

- Alleinige Farbcodierung oder alleiniger Ton schließt Spieler aus.
- Partikel, Kameraeffekte oder UI können die Top-down-Lesbarkeit mindern.
- Uneinheitliche Zustandszeichen können Ursache und Wirkung verschleiern.
- Zu frühe Assetproduktion könnte ungeklärte Welt- und Mechanikentscheidungen
  verfestigen.

## Offene Fragen

- Welche eigenständige visuelle und akustische Identität unterstützt die
  Spielvision?
- Welche Informationen gehören in die Welt, welche in UI und welche in Audio?
- Welche Barrierefreiheitsoptionen sind für den Vertical Slice prüfbar?
- Wie werden Erinnerung und Wiederherstellung unterschieden und verbunden?

## Abnahmekriterien

- Jeder kritische Zustand besitzt mindestens zwei geeignete, nicht
  widersprüchliche Rückmeldungskanäle oder eine dokumentierte Alternative.
- Kampftelegraphie und Weltzustände bleiben in der Top-down-Ansicht lesbar.
- Medien besitzen Quelle, Lizenzstatus und Konzept-/Buildbezug.
- Ein Review bestätigt die eigenständige Identität ohne kopierte Inhalte.

## Verwandte Konzeptseiten

- [Designprinzipien](../00-overview/design-pillars.md)
- [Kampfsystem](../04-combat/combat-system.md)
- [Landschaftssystem](../07-landscape-and-environment/landscape-system.md)
- [Vertical Slice](../09-prototypes-and-tests/vertical-slice.md)
