---
title: Erster spielbarer Abschnitt
status: accepted
updated: 2026-08-30
---
<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# Erster spielbarer Abschnitt

## Zweck und Abgrenzung

Dieses Dokument legt den Umfang des ersten spielbaren Prototyps verbindlich
fest. Er ist ein kurzer, linear abschließbarer Nachweis für den grundlegenden
Spielfluss und noch nicht der vollständige erste Graslandabschnitt. Ebenso ist
er enger begrenzt als ein späterer Vertical Slice mit ausgebautem Kampf,
mehreren Gegnertypen und vollständiger Erinnerungsverbesserung.

Der Prototyp verändert weder den
[Handlungsverlauf](../20-handlung/handlungsverlauf.md) noch die
[achtteilige Abschnittsstruktur](../20-handlung/spielablauf-und-abschnittsstruktur.md).
Er bildet nur deren frühesten Ausschnitt in verkürzter Form ab.

## Verbindlicher Ablauf

```text
Spielstart
→ Titelbildschirm
→ Hauptmenü
→ Neues Spiel
→ Erwachen im Heldenraum
→ erste Bewegung und Interaktion
→ kurzer Weg durch den Nebel
→ kleiner Turm-Testabschnitt
→ einfacher Kampf
→ ein Teil der Welt wird wiederhergestellt
→ eine Seele oder Erinnerung kehrt zurück
→ Ende des Prototyps
```

Diese Reihenfolge ist für den Prototyp verbindlich. Es gibt darin keine freie
Erkundung des vollständigen Graslands und keinen Übergang in einen späteren
Produktionsabschnitt.

## Was der Spieler erlebt

Der Spieler sieht zuerst den Titelbildschirm, wechselt in das Hauptmenü und
beginnt über **Neues Spiel**. Danach erwacht der Held ohne Erinnerung im
Heldenraum. Der kleine fliegende Ratgeber ist dort als erste erkennbare
Begleitung vorhanden. In diesem geschützten Raum lernt der Spieler die erste
Bewegung und führt eine einfache Interaktion aus.

Anschließend verlässt der Held den Heldenraum und folgt einem kurzen,
überschaubaren Weg durch den Nebel. Der bereits kanonische Übergang über das
verlassene Haus darf darin knapp angedeutet werden, bildet für diesen Prototyp
aber weder eine eigene Erkundungszone noch einen eigenen Dungeon. Leuchtpunkte
weisen den Weg zum Turm.

Im kleinen Turm-Testabschnitt kommt es zu einem einfachen, abschließbaren
Kampf. Nach dem Erfolg wird ein begrenzter Teil der Welt sichtbar
wiederhergestellt. Danach kehrt mindestens eine Seele oder eine Erinnerung
zurück. Welche dieser beiden Formen für den ersten Prototyp verwendet wird,
bleibt bis zur konkreten Szenenplanung offen; beides gleichzeitig ist für
diesen Meilenstein nicht erforderlich. Unmittelbar danach endet der Prototyp
mit einem eindeutigen Abschlusshinweis.

## Beginn und Ende

Der Abschnitt **beginnt** mit dem ersten sichtbaren Titelbildschirm. Die
eigentliche Steuerung des Helden beginnt nach **Neues Spiel** mit seinem
Erwachen im Heldenraum.

Der Abschnitt **endet**, sobald die Wiederherstellung sichtbar abgeschlossen
ist, eine Seele oder Erinnerung zurückgekehrt ist und der Spieler einen klaren
Hinweis auf das Ende des Prototyps erhalten hat. Der Spieler betritt danach
weder das vollständige Grasland noch einen weiteren Dungeon.

## Benötigte Szenen

Die folgenden Einträge sind logische Spielszenen. Ob mehrere davon später in
einer gemeinsamen technischen Godot-Szene umgesetzt werden, wird hier noch
nicht festgelegt.

| Szene | Aufgabe im Ablauf | Abschluss der Szene |
|---|---|---|
| Titelbildschirm | Spiel und Projekt sichtbar eröffnen | Wechsel zum Hauptmenü |
| Hauptmenü | **Neues Spiel** als erforderlichen Einstieg anbieten | Start des Prototyps |
| Heldenraum | Erwachen, Ratgeber, erste Bewegung und erste Interaktion vermitteln | Ausgang in Richtung Nebel erreichen |
| Kurzer Nebelweg | Orientierung über Leuchtpunkte und den knappen Übergang am verlassenen Haus vermitteln | Eingang des Turm-Testabschnitts erreichen |
| Turm-Testabschnitt | Einen begrenzten Weg und einen einfachen Kampf enthalten | Kampf erfolgreich abschließen |
| Wiederherstellungs- und Abschlussszene | Vorher-nachher-Veränderung sowie Rückkehr einer Seele oder Erinnerung zeigen | Eindeutigen Hinweis **Ende des Prototyps** anzeigen |

## Enthaltene Mechaniken

- Wechsel von Titelbildschirm zu Hauptmenü und Start über **Neues Spiel**;
- grundlegende Bewegung des Helden;
- mindestens eine einfache Interaktion;
- gerichtete Orientierung im Nebel durch Leuchtpunkte;
- Übergänge zwischen den benötigten Spielszenen;
- ein einfacher Kampf mit einer grundlegenden Angriffsaktion;
- ein sichtbarer Wechsel von einem unvollständigen zu einem teilweise
  wiederhergestellten Weltzustand;
- Rückkehr einer Seele oder einer Erinnerung als erzählerische Rückmeldung;
- ein klar erkennbarer Endzustand des Prototyps.

Die konkreten Eingaben, Zahlenwerte, Gegnerwerte und technischen
Szenenwechsel werden erst in späteren Aufgaben festgelegt.

## Noch nicht enthalten

- vollständiges Grasland;
- Sägewerk;
- Wasserwerk;
- Lichterhaus;
- vollständiges Dorf;
- Abschnitte 2 bis 8;
- vollständiger Turm und endgültiger Turmboss beziehungsweise Miniboss;
- endgültiges Kampfsystem;
- das vollständige Aktionsset aus Angriff, Ausweichen, Blocken und Magie;
- finales Game-Cover;
- endgültige Grafiken;
- mehrere Speicherstände.

Diese Punkte sind keine stillen Anforderungen an den ersten Prototyp. Sie
werden durch seinen Abschluss weder umgesetzt noch verworfen.

## Verhältnis zum bestehenden Kanon

Die sichtbare Wiederherstellung folgt weiterhin auf den Turmabschnitt und
liegt vor der späteren Rückkehr von Bewohnern und Erinnerungen. Für den kurzen
Prototyp darf der einfache Testkampf den Wiederherstellungsmoment technisch
auslösen. Das legt nicht fest, dass in der endgültigen Handlung der
kanonische Turmboss entfällt oder durch genau diesen Kampf ersetzt wird.

Der in
[ADR-0002](../entscheidungen/ADR-0002-wiederherstellungsreihenfolge.md)
beschriebene spätere Vertical Slice soll Landschaftsrekonstruktion, eine
zurückkehrende Seele und eine erinnerungsbasierte Verbesserung gemeinsam
zeigen. Der hier festgelegte frühere Prototyp muss dagegen zunächst nur eine
Seele **oder** eine Erinnerung zurückbringen und erfüllt deshalb bewusst noch
nicht den vollständigen Vertical-Slice-Umfang.

## Erfolgskriterien

Der erste spielbare Abschnitt gilt als erfolgreich, wenn:

1. der Ablauf vom Titelbildschirm bis zum Abschlusshinweis ohne fehlenden
   Zwischenschritt durchlaufen werden kann;
2. **Neues Spiel** zuverlässig in den Heldenraum führt;
3. Bewegung und mindestens eine Interaktion verständlich erprobt werden;
4. der Nebelweg eindeutig zum Turm-Testabschnitt führt;
5. der einfache Kampf abgeschlossen werden kann;
6. danach ein begrenzter Teil der Welt sichtbar wiederhergestellt wird;
7. mindestens eine Seele oder eine Erinnerung erkennbar zurückkehrt;
8. der Prototyp unmittelbar danach eindeutig endet;
9. für diesen Nachweis keiner der ausdrücklich ausgeschlossenen Inhalte
   vorausgesetzt wird.

Diese Kriterien beschreiben die spätere Abnahme des spielbaren Prototyps. In
dieser Dokumentationsaufgabe wird noch keine der genannten Szenen oder
Mechaniken programmiert.
