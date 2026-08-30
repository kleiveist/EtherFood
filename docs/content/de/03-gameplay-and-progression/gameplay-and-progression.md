---
title: "Gameplay und Fortschritt"
language: de
status: draft
version: "0.2"
source_of_truth: true
translation_status: blocked-until-concept-complete
---
<!-- AUTO-GENERATED:backlink START -->
[← Back](03-gameplay-and-progression.md)
<!-- AUTO-GENERATED:backlink END -->
[← Gameplay und Fortschritt](index.md)

# Gameplay und Fortschritt

## Zweck des Dokuments

Dieses Dokument beschreibt den bestätigten Makrofortschritt und strukturiert
die noch offenen Regeln, die daraus ein spielbares Fortschrittssystem machen.

## Bestätigte Entscheidungen

Der Fortschrittsrahmen lautet:

1. Natur und Landschaft werden wiederhergestellt.
2. Danach kehren Bewohner zurück.
3. Siedlungen und Städte werden wiederhergestellt oder neu belebt.
4. Erinnerungen und Geschichte der Welt werden aufgedeckt.
5. Fähigkeiten des Helden verbessern oder erweitern sich durch die Interaktion
   mit wiederhergestellten Erinnerungen und Geschichte.

Die achtteilige Makrostruktur und der konkrete Graslandablauf sind inzwischen
festgelegt. Die genaue Ausgestaltung der späteren Regionen und ihre
Balancingwerte bleiben offen.

## Aktueller Arbeitsentwurf

Fortschritt verbindet Weltzustand, Erkenntnis und Handlungsmöglichkeiten. Die
ersten vier Makroabschnitte sind Grasland, Wald, Hochland und Hauptstadt. Danach
folgen drei anwendungsorientierte Passagen in Tatok und ein Schlussabschnitt in
Semms Bereich. Innerhalb einer Wiederherstellungsregion dürfen Erkundungswege
verzweigen; die übergeordnete Reihenfolge bleibt erhalten. Ressourcen und
Balancingwerte sind nicht freigegeben.

## Spielerperspektive und Spielerfantasie

Der Spieler soll Fortschritt als konkrete Verbesserung der Welt und nicht nur
als wachsende Zahl wahrnehmen. Wie viel Freiheit er bei Reihenfolge, Auswahl und
Rückkehr in frühere Gebiete besitzt, ist eine offene Designfrage.

## Regeln und Ablauf

Für jede Stufe sind Auslöser, sichtbarer Zustandswechsel, Folgefreischaltung,
Persistenz und mögliche Rückschritte zu definieren. Der Graslandabschnitt
ordnet diese Funktionen erstmals konkreten Orten zu: Turm, Sägewerk,
Wasserwerk, Lichterhaus und Dorf. Die [Abschnittsstruktur](game-flow-and-section-structure.md)
ist verbindlich; ihre offenen Mengen und Inhalte benötigen weitere Entscheidung
oder Prototyp.

## Eingaben

Mögliche Eingaben sind Erkundung, Kampf, Weltinteraktion,
Wiederherstellungsaufgaben und Erinnerungsinteraktion. Welche davon erforderlich,
optional, wiederholbar oder verbrauchbar sind, ist noch nicht entschieden.

## Ausgaben

Bestätigte Ausgabekategorien sind wiederhergestellte Landschaft, zurückkehrende
Bewohner, belebte Siedlungen und Städte, aufgedeckte Erinnerungen und Geschichte
sowie erweiterte Heldenfähigkeiten. Konkrete Gegenstände, Punkte oder
Ressourcen sind nicht beschlossen.

## Systemabhängigkeiten

Das System hängt von Core Loop, Landschaft, Welt/Story, Kampf, Bewohner- und
Siedlungszuständen sowie Fähigkeitsdesign ab. Maschinen, Zuro und
Gegnerentwicklung dürfen nur nach geklärter eigener Regelstruktur angebunden
werden.

## Veränderbare und später zu balancierende Werte

Noch offen sind Schwellen, Dauer, Aufgabenanzahl, Wiederholungsrate,
Freischaltreihenfolge, Fähigkeitsstärke und Kosten. Dieses Dokument enthält
keine konkreten Zahlen.

## Visuelles, akustisches und UI-Feedback

Jede Fortschrittsstufe benötigt unterscheidbare Welt-, Audio- und UI-Rückmeldung.
Der Spieler muss verstehen können, was sich geändert hat, wodurch es geschah
und welche neue Möglichkeit entstand. Die genaue Darstellung ist noch offen.

## Sonderfälle und Risiken

- Ein globaler Fortschritt könnte lokale Ursache und Wirkung unverständlich
  machen.
- Dauerhafte Rückschritte könnten Wiederherstellung entwerten; vollständige
  Irreversibilität könnte Entscheidungen bedeutungslos machen.
- Fähigkeitserweiterungen dürfen Storyfunde nicht zu bloßen Zahlenbehältern
  reduzieren.
- Abhängigkeiten können Sackgassen erzeugen, wenn Zugangsregeln unklar sind.

## Offene Fragen

- Wie werden die festgelegten Wiederherstellungseinheiten technisch und im UI
  abgebildet?
- Welche konkreten Auslöser verwenden Wald, Hochland und Hauptstadt?
- Wie werden Fähigkeiten aus Erinnerungen ausgewählt oder angewendet?
- Sind Zustandsänderungen dauerhaft, reversibel oder teilweise variabel?
- Wie werden Spielerziel und nächster Schritt kommuniziert?

## Abnahmekriterien

- Jede Stufe besitzt Auslöser, Ergebnis, Feedback, Persistenz und Testkriterium.
- Ein Konzeptprototyp zeigt mindestens einen nachvollziehbaren Durchlauf der
  bestätigten Folge.
- Es existiert keine unlösbare Abhängigkeit zwischen Weltzustand und Zugang.
- Testpersonen können Fortschrittsursache und neue Möglichkeit erklären.

## Verwandte Konzeptseiten

- [Core Loop](../00-overview/core-loop.md)
- [Spielablauf und Abschnittsstruktur](game-flow-and-section-structure.md)
- [Handlung und Welt](../02-story-and-world/story-and-world.md)
- [Landschaftssystem](../07-landscape-and-environment/landscape-system.md)
- [Vertical Slice](../09-prototypes-and-tests/vertical-slice.md)
