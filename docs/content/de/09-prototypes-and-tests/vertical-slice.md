---
title: "Konzept-Vertical-Slice"
language: de
status: draft
version: "0.1"
source_of_truth: true
translation_status: blocked-until-concept-complete
---
<!-- AUTO-GENERATED:backlink START -->
[← Back](09-prototypes-and-tests.md)
<!-- AUTO-GENERATED:backlink END -->
[← Prototypen und Tests](index.md)

# Konzept-Vertical-Slice

## Zweck des Dokuments

Der Konzept-Vertical-Slice prüft, ob die bestätigte Spielidee in einem kleinen,
zusammenhängenden Ablauf verständlich und technisch untersuchbar ist. Er ist
kein zugesagter Produktionsumfang und kein Beleg für Produktionsreife.

## Bestätigte Entscheidungen

Der Slice enthält:

- ein kleines beschädigtes Gebiet,
- eine sichtbare Landschaftswiederherstellung,
- mindestens eine Rückkehr oder Veränderung in der Welt,
- einen einfachen Gegner,
- Angriff,
- Ausweichen,
- Blocken,
- Fernkampfmagie,
- ein erstes Erinnerungs- oder Geschichtselement,
- eine sichtbare Auswirkung auf den Fortschritt.

Maschinen und Zuro werden nur aufgenommen, wenn ihre Kernannahmen vorher
ausreichend definiert und als eigene Testziele begrenzt wurden.

## Aktueller Arbeitsentwurf

Ein kurzer, in sich geschlossener Ablauf soll Erkundung, einfache Gefahr,
Kampf, Landschaftstransformation, Weltreaktion, Erinnerung und Fortschrittsfolge
verbinden. Konkretes Gebiet, Gegnerdesign, Storyinhalt und Werte sind noch nicht
entschieden.

## Spielerperspektive und Spielerfantasie

Der Spieler soll erkennen: „Ich habe eine Gefahr bewältigt, einen Teil der Welt
wiederhergestellt, dadurch eine Rückkehr und Erinnerung ermöglicht und eine neue
Fortschrittswirkung ausgelöst.“ Ob dieses Erlebnis tatsächlich entsteht, muss
beobachtet und darf nicht vorausgesetzt werden.

## Regeln und Ablauf

1. Ein beschädigtes Gebiet wird aus Top-down-Perspektive erkundet.
2. Mindestens ein einfacher Gegner stellt eine lesbare Gefahr dar.
3. Die vier bestätigten Kampfhandlungen sind verfügbar und unterscheidbar.
4. Eine noch zu definierende Handlung führt zur sichtbaren
   Landschaftswiederherstellung.
5. Mindestens eine Weltkomponente kehrt zurück oder verändert sich.
6. Ein Erinnerungs- oder Geschichtselement wird zugänglich.
7. Eine sichtbare Fortschrittsfolge wird ausgelöst.

Die genaue Ursache zwischen den Schritten ist noch nicht entschieden und muss
vor der Umsetzung beschrieben werden.

## Eingaben

Benötigt werden semantische Bewegungs- und Kampfaktionen sowie eine noch zu
entscheidende Welt-/Erinnerungsinteraktion. Controller- und Tastaturablauf,
Eingabehinweise und Remappinganforderungen sind Teil des Tests.

## Ausgaben

Beobachtbare Ausgaben sind Gegner- und Kampfreaktionen, Landschaftswechsel,
Weltreaktion, Erinnerung/Geschichte und Fortschrittsänderung. Keine konkrete
Belohnung oder Zahl ist freigegeben.

## Systemabhängigkeiten

Der Slice verbindet Core Loop, Landschaft, Kampf, Gegner, Welt/Story,
Fortschritt und Präsentation. Maschinen und Zuro bleiben außerhalb, sofern ihre
Aufnahme nicht durch dokumentierte Annahme, Schnittstelle und Testfrage
begründet ist.

## Veränderbare und später zu balancierende Werte

Gebietsgröße, Gegnerwerte, Aktionszeiten, Reichweiten, Ressourcen,
Transformationsdauer und Fortschrittsschwellen bleiben Prototypvariablen. Es
werden keine Erfolgszahlen oder Produktionswerte erfunden.

## Visuelles, akustisches und UI-Feedback

Der Test benötigt unterscheidbare Rückmeldung für Gefahr, vier Kampfhandlungen,
Wiederherstellung, Weltreaktion, Erinnerung und Fortschritt. Die konkrete
Gestaltung bleibt offen; Informationsverständlichkeit wird beobachtet.

## Testfragen

- Versteht der Spieler den Zustand des beschädigten Gebiets?
- Sind Gegnerabsicht und die vier Kampfoptionen unterscheidbar?
- Erkennt der Spieler, welche Handlung die Landschaft verändert hat?
- Wird die Rückkehr beziehungsweise Weltveränderung wahrgenommen und der
  Wiederherstellung zugeordnet?
- Ist das Erinnerungs- oder Geschichtselement als Teil des Fortschritts
  verständlich?
- Erkennt der Spieler die sichtbare Fortschrittsauswirkung und den nächsten
  möglichen Schritt?
- Wirkt der Ablauf zusammenhängend oder wie eine Folge unverbundener Demos?
- Welche Barrieren entstehen bei Controller, Tastatur, visueller oder
  akustischer Wahrnehmung?

## Sonderfälle und Risiken

- Ein hart codierter Vorführeffekt kann falsche Systemreife vortäuschen.
- Ein einfacher Gegner darf keine unentschiedene Gegnerprogression voraussetzen.
- Unklare Interaktionsbedingungen können die Kernfrage verfälschen.
- Zu hohe Präsentationsqualität kann strukturelle Verständnisprobleme verdecken.

## Offene Fragen

- Welche konkrete Annahme verbindet Kampf mit Wiederherstellung?
- Welche minimale Weltreaktion ist aussagekräftig?
- Welches Erinnerungsformat prüft die Verbindung zu Fortschritt ohne Story
  vorwegzunehmen?
- Welche Beobachtungsmethode und Testgruppe sind geeignet?

## Abnahmekriterien

- Alle bestätigten Slice-Bestandteile sind in einem überprüfbaren Ablauf
  enthalten.
- Vor dem Test sind Annahme, Nicht-Ziele und Beobachtungsfragen dokumentiert.
- Ergebnisse werden ohne erfundene Zielwerte im Testprotokoll festgehalten.
- Eine dokumentierte Entscheidung bestimmt, was verworfen, erneut getestet oder
  zur Systemausarbeitung zugelassen wird.
- Prototypcode wird nur nach separatem technischem Review als Produktionscode
  betrachtet.

## Verwandte Konzeptseiten

- [Core Loop](../00-overview/core-loop.md)
- [Kampfsystem](../04-combat/combat-system.md)
- [Landschaftssystem](../07-landscape-and-environment/landscape-system.md)
- [Testprotokoll](test-log.md)
