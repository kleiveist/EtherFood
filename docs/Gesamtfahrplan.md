<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# EtherFood – Übersichtlicher Gesamtfahrplan bis zum fertigen Spiel 🎮

**Projektstand:** 3. September 2026, Maßstab V0 verbindlich festgelegt;
Pixel-Snap-, Texturfilter-, Nebel- und Lichttest abgeschlossen;
Bewegungssteuerung V0 teilweise umgesetzt

Dieser Fahrplan ist das Orientierungshandbuch für neue Chats. Er zeigt die vollständige Entwicklungsreihenfolge vom aktuellen Stand bis zur stabilen Veröffentlichung.

Spätere Aufgaben sind zunächst **Arbeitspakete auf Projektebene**. Sie werden erst dann genauer unterteilt, wenn sie tatsächlich an der Reihe sind. Dadurch bleibt die Regel bestehen: **immer nur eine Aufgabe gleichzeitig**.

## Verbindliche Arbeitsweise

| Schritt | Regel                                                                        |
| ------: | ---------------------------------------------------------------------------- |
|       1 | Es wird immer nur **eine Aufgabe** ausgewählt.                               |
|       2 | Zuerst werden bestehender Projektstand und Dokumentation geprüft.            |
|       3 | Danach wird nur das umgesetzt, was für diese Aufgabe notwendig ist.          |
|       4 | Anschließend wird die Änderung getestet.                                     |
|       5 | Danach folgt eine kurze Zusammenfassung mit englischem Git-Commit und Emoji. |
|       6 | Erst nach **„Erledigt ✅“** beginnt die nächste Aufgabe.                      |
|       7 | Spätere Systeme und Regionen werden nicht vorgezogen.                        |
|       8 | Bestehende Systeme werden erweitert und nicht unnötig neu entwickelt.        |

## Statuszeichen

| Zeichen | Bedeutung                                         |
| :-----: | ------------------------------------------------- |
|    ✅    | abgeschlossen                                     |
|    🔵   | aktuell aktiv                                     |
|    🟡    | teilweise umgesetzt; Abschlusskriterien noch offen |
|    ⚪    | geplant, noch nicht begonnen                      |
|    🔁   | wird für mehrere Regionen oder Kapitel wiederholt |
|    🔒   | Meilenstein muss geprüft und abgeschlossen werden |

# 1. Bereits abgeschlossener Projektstand

| Bereich         | Umgesetzter Stand                                         | Status |
| --------------- | --------------------------------------------------------- | :----: |
| Dokumentation   | Grundlegende Projektdokumentation angelegt                |    ✅   |
| Spielstruktur   | Erster spielbarer Abschnitt grob geplant                  |    ✅   |
| Einstieg        | Titelbildschirm umgesetzt                                 |    ✅   |
| Menü            | Hauptmenü umgesetzt                                       |    ✅   |
| Testumgebung    | Visuelles Testlabor eingerichtet                          |    ✅   |
| Spieler         | Grundlegende Spielerbewegung                              |    ✅   |
| Kollision       | Spieler und Testobjekte kollidieren                       |    ✅   |
| Blickrichtung   | Blickrichtung des Helden funktioniert                     |    ✅   |
| Kamera          | Kamera verfolgt den Spieler                               |    ✅   |
| Welt            | Weltgrenzen eingerichtet                                  |    ✅   |
| Zoom            | Drei Kamera-Zoomstufen vorhanden                          |    ✅   |
| Figurenmaßstab  | Verschiedene Heldenhöhen vergleichbar                     |    ✅   |
| Größenvergleich | Referenzobjekte für den Maßstab vorhanden                 |    ✅   |
| Tiles           | Mehrere Tilegrößen testbar                                |    ✅   |
| Testlabor       | Presets können gespeichert werden                         |    ✅   |
| Testlabor-Grafik | Originale Top-down-Pixelart-Prototypen integriert         |    ✅   |
| Diagnose        | FPS, Werte und eigene Kollisionsüberlagerung schaltbar     |    ✅   |
| Pixel-Snap      | Vergleich und Prüfung abgeschlossen                        |    ✅   |
| Texturfilter    | Vergleich und Prüfung abgeschlossen                        |    ✅   |
| Atmosphäre      | Nebel und Licht auf großer Haus-, Wald- und Sägewerkfläche geprüft |    ✅   |
| Maßstab V0      | 80-px-Held, 32er Raster und normale 1,00×-Spielansicht festgelegt |    ✅   |
| Steuerungshilfe | Testlabor-Steuerung über F5 ein- und ausblendbar           |    ✅   |
| Weltzustände    | Beschädigt/Wiederhergestellt als Debug-Vergleich vorhanden |    ✅   |
| Rekonstruktion  | Getrennte Fortschritte für Natur, Gebäude, Seelen und Personen dokumentiert | ✅ |
| Spielzeit       | Ingame-Simulation auf 15 Minuten pro Um dokumentiert       |    ✅   |
| Heldenraum      | Begehbarer Raum mit Kamera, Grenzen und Hindernissen       |    ✅   |
| Ratgeber        | Sichtbarer originaler Prototyp mit Hut, Augen und Besen    |    ✅   |
| Erste Interaktion | Reichweitenhinweis und einzelne Ratgeber-Nachricht        |    ✅   |

# 2. Gesamtübersicht der Entwicklungsphasen

| Phase |   Aufgaben | Hauptziel                                               | Abschluss                                         |
| ----: | ---------: | ------------------------------------------------------- | ------------------------------------------------- |
|     1 |      16–22 | Visuelle und technische Darstellungsgrundlage festlegen | Maßstab und Pixelart-Grundlage V0                 |
|     2 |      23–39 | Vertical Slice als spielbaren Rohbau umsetzen           | Kompletter Ablauf grundsätzlich spielbar          |
|     3 |      40–55 | Vertical Slice vervollständigen und stabilisieren       | Vertical Slice V1 abgeschlossen                   |
|     4 |      56–66 | Gesamtes Spiel konzeptionell festlegen                  | Umfang und vollständige Spielstruktur freigegeben |
|     5 |      67–89 | Benötigte Kernsysteme produktionsreif machen            | Technisches Fundament für das gesamte Spiel       |
|     6 |      90–98 | Grafik-, Audio- und Inhaltspipelines festlegen          | Produktionsabläufe verbindlich                    |
|     7 | 99.1–99.12 | Regionen und Kapitel einzeln produzieren                | Alle geplanten Inhalte abgeschlossen              |
|     8 |    100–112 | Gesamtes Spiel zusammensetzen                           | Content-Complete-Alpha                            |
|     9 |    113–124 | Alpha testen und stabilisieren                          | Alpha-Freigabe                                    |
|    10 |    125–134 | Beta, Lokalisierung und Veröffentlichung vorbereiten    | Content Lock                                      |
|    11 |    135–142 | Release Candidate, Veröffentlichung und Stabilisierung  | Fertiges stabiles Spiel                           |

---

# Phase 1 – Visuelle und technische Grundlage

In dieser Phase wird noch kein vollständiger Grasland-Abschnitt gebaut. Zuerst werden Maßstab, Darstellung und Kamera verbindlich festgelegt.

|    Nr. | Aufgabe                        | Ziel und Abschlusskriterium                                                                                                                | Status |
| -----: | ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------ | :----: |
| **16** | **🔍 Diagnoseanzeige**         | FPS, Spielerposition, Kameraposition, Tilegröße, Figurengröße, Zoom, Kollisionsflächen und aktive Testeinstellungen werden live angezeigt. |   ✅   |
|   17.1 | 🎮 Bewegungssteuerung V0       | Lauf-, Boost-, Schleich- und Sprungzustände für die Tastatur technisch absichern.                                                          |    🟡   |
|   17.2 | 📐 Pixel-Snap vollständig testen | Darstellung und Bewegung mit allen V0-Bewegungszuständen bei 1,00× und 1,50× vergleichen.                                                |    ✅   |
|     18 | 🖼️ Texturfilter testen        | Nearest-Neighbor und weiche Filterung vergleichen; geeignete Variante bestimmen.                                                           |    ✅   |
|     19 | 🌫️ Nebel und Licht testen     | Varianten für beschädigten und wiederhergestellten Weltzustand auf großer Haus-, Wald- und Sägewerkfläche vergleichen.                      |    ✅   |
|     20 | 📏 Maßstab V0 festlegen        | Heldenhöhe, Tilegröße, Kamera-Zoom und Referenzauflösung verbindlich auswählen.                                                            |    ✅   |
|     21 | 📝 Dokumentation aktualisieren | Alle Ergebnisse aus dem visuellen Testlabor dokumentieren.                                                                                 |    🟡   |
|     22 | 🎨 Pixelart-Grafikpaket V0     | Erstes echtes Grafikpaket nach den festgelegten Maßstabs- und Filterregeln erstellen.                                                      |    🟡   |
|      — | 🔒 Meilenstein                 | Darstellungsgrundlage V0 ist geprüft. Erst danach beginnt der Heldenraum.                                                                  |    ⚪   |

---

# Phase 2 – Vertical Slice als spielbarer Rohbau

Der Vertical Slice erhält den vollständigen grundlegenden Ablauf:

**Titelbildschirm → Hauptmenü → Heldenraum → Einführung → Nebelweg → Turm → Kampf → Turmwächter → Wiederherstellung → zurückkehrende Seele → Erinnerung → gespeicherter Fortschritt**

| Nr. | Aufgabe                       | Ziel und Abschlusskriterium                                                           | Status |
| --: | ----------------------------- | ------------------------------------------------------------------------------------- | :----: |
|  23 | 🏠 Heldenraum-Blockout        | Raumform, Wege, Türen, Größe und Kamerabereich als einfacher spielbarer Rohbau.       |    🟡   |
|  24 | 📐 Heldenraum-Maßstab         | Kollision, Kamera, Tiles und Objektgrößen mit Maßstab V0 abstimmen.                   |    🟡   |
|  25 | 🧍 Heldengrafik V0            | Erste verwendbare Lauf-, Stand- und Blickrichtungsanimationen integrieren.            |    🟡   |
|  26 | ✋ Interaktionssystem V0       | Gegenstände, Türen und markierte Interaktionspunkte können benutzt werden.            |    🟡   |
|  27 | 💬 Text- und Dialoganzeige V0 | Kurze Einführungstexte und Dialoge können kontrolliert angezeigt werden.              |    🟡   |
|  28 | 📖 Einführung umsetzen        | Einstieg im Heldenraum mit den notwendigen Ereignissen und Hinweisen.                 |    🟡   |
|  29 | 🚪 Szenenübergänge            | Wechsel zwischen Heldenraum, Nebelweg und späteren Bereichen funktioniert.            |    ⚪   |
|  30 | 🌫️ Nebelweg-Blockout         | Wegführung, Grenzen, Kamera und wichtige Punkte als Rohbau erstellen.                 |    ⚪   |
|  31 | 🧭 Nebelweg-Spielablauf       | Auslöser, Orientierung und Übergang zum Turm funktionieren.                           |    ⚪   |
|  32 | 🌍 Weltzustand V0             | Beschädigter und wiederhergestellter Zustand werden als echtes Spielsystem schaltbar. |    ⚪   |
|  33 | 🗼 Turm-Außenbereich          | Turmeingang und unmittelbare Umgebung als Blockout umsetzen.                          |    ⚪   |
|  34 | 🏰 Turm-Innenbereich          | Räume, Wege, Hindernisse und Kampfflächen des Vertical Slice erstellen.               |    ⚪   |
|  35 | ⚔️ Kampfgrundlage             | Kampfzustand, Angriffsablauf und grundlegende Kampflogik einrichten.                  |    ⚪   |
|  36 | 💥 Treffer und Schaden        | Hitboxen, Treffererkennung, Schaden und Rückmeldung funktionieren.                    |    ⚪   |
|  37 | ❤️ Lebens- und Neustartsystem | Spieler kann Schaden erhalten, scheitern und kontrolliert neu starten.                |    ⚪   |
|  38 | 👾 Gegnerverhalten V0         | Erster Gegner kann erkennen, verfolgen, angreifen und besiegt werden.                 |    ⚪   |
|  39 | 🛡️ Turmwächter-Prototyp      | Grundlegendes Verhalten und Kampfphasen des Turmwächters sind spielbar.               |    ⚪   |
|   — | 🔒 Meilenstein                | Der komplette Vertical-Slice-Ablauf existiert als einfacher Rohbau.                   |    ⚪   |

---

# Phase 3 – Vertical Slice vervollständigen und stabilisieren

| Nr. | Aufgabe                          | Ziel und Abschlusskriterium                                                               | Status |
| --: | -------------------------------- | ----------------------------------------------------------------------------------------- | :----: |
|  40 | 🏟️ Wächterarena                 | Arena, Eintritt, Kampfgrenzen und Neustartpunkt funktionieren.                            |    ⚪   |
|  41 | 🛡️ Turmwächter V1               | Angriffsmuster, Lebensphasen, Niederlage und Rückmeldung fertigstellen.                   |    ⚪   |
|  42 | ✨ Wiederherstellungssequenz      | Nach dem Kampf wechselt der Weltzustand sichtbar und technisch korrekt.                   |    ⚪   |
|  43 | 👻 Zurückkehrende Seele          | Rückkehr der Seele als kontrollierte Ereignisfolge umsetzen.                              |    ⚪   |
|  44 | 🧠 Erinnerungssequenz            | Erinnerung darstellen und anschließend korrekt in den Spielablauf zurückkehren.           |    ⚪   |
|  45 | 💾 Speichern und Laden V0        | Fortschritt des Vertical Slice kann gespeichert und wieder geladen werden.                |    ⚪   |
|  46 | 🔗 Gesamtablauf verbinden        | Titelbildschirm bis gespeicherter Fortschritt ohne manuelle Entwicklereingriffe spielbar. |    ⚪   |
|  47 | 🧪 End-to-End-Prüfung            | Gesamter Ablauf mehrfach ohne Blockierung oder falsche Übergänge spielbar.                |    ⚪   |
|  48 | 🎨 Grafikpass V0                 | Heldenraum, Nebelweg, Turm, Gegner und Wächter erhalten zusammenpassende Grafiken.        |    ⚪   |
|  49 | ✨ Effekte-, Licht- und Nebelpass | Zustandswechsel, Treffer und Atmosphäre erhalten lesbare Effekte.                         |    ⚪   |
|  50 | 🖥️ Benutzeroberfläche V0        | HUD, Hinweise, Dialoge und Menüs sind verständlich und einheitlich.                       |    ⚪   |
|  51 | ♿ Bedienbarkeitsprüfung V0       | Textlesbarkeit, Eingaben, Kamerabewegung und wichtige Optionen prüfen.                    |    ⚪   |
|  52 | 🔊 Audio- und Musikpass V0       | Schritte, Treffer, Umgebung, Menü und wichtige Szenen erhalten Audio.                     |    ⚪   |
|  53 | ⚙️ Leistungsprüfung              | FPS, Ladezeiten, Speicherbedarf und problematische Szenen untersuchen.                    |    ⚪   |
|  54 | 🐞 Vertical-Slice-Test           | Fehler, Softlocks, Kollisionsprobleme und unklare Spielstellen beheben.                   |    ⚪   |
|  55 | 📚 Vertical Slice V1 abschließen | Dokumentation aktualisieren, Entscheidungen festhalten und Meilenstein sperren.           |    ⚪   |
|   — | 🔒 Meilenstein                   | Der erste vollständige Abschnitt ist spielbar, speicherbar und stabil.                    |    ⚪   |

---

# Phase 4 – Gesamtes Spiel verbindlich planen

Erst nach dem stabilen Vertical Slice wird der genaue Umfang des vollständigen Spiels festgelegt. Die späteren Kapitel werden vorher nicht vollständig produziert.

| Nr. | Aufgabe                                | Ziel und Abschlusskriterium                                                      | Status |
| --: | -------------------------------------- | -------------------------------------------------------------------------------- | :----: |
|  56 | 🔎 Vertical-Slice-Auswertung           | Technische, spielerische und gestalterische Erkenntnisse dokumentieren.          |    ⚪   |
|  57 | 📖 Gesamthandlung strukturieren        | Anfang, Hauptkonflikt, Wendepunkte und Ende des vollständigen Spiels festlegen.  |    ⚪   |
|  58 | 🗺️ Kapitel und Regionen ordnen        | Reihenfolge aller notwendigen Regionen, Dungeons und Handlungskapitel bestimmen. |    ⚪   |
|  59 | 🎯 Kritischen Spielpfad festlegen      | Definieren, welche Inhalte zwingend für das Durchspielen erforderlich sind.      |    ⚪   |
|  60 | 🌍 Weltkarte und Verbindungen          | Reisewege, Übergänge und räumliche Beziehungen der Regionen festlegen.           |    ⚪   |
|  61 | 🎮 Systemumfang freigeben              | Entscheiden, welche Systeme tatsächlich in das fertige Spiel gehören.            |    ⚪   |
|  62 | 📈 Fortschritt und Spielbalance planen | Fähigkeiten, Ausrüstung, Gegnerstärke und Belohnungskurve planen.                |    ⚪   |
|  63 | 🧑 NPC-, Dialog- und Aufgabenplan      | Wichtige Figuren, Gespräche, Aufgaben und Erinnerungen strukturieren.            |    ⚪   |
|  64 | 👾 Gegner- und Bossplan                | Benötigte Gegnertypen, Varianten und Bosse festlegen.                            |    ⚪   |
|  65 | 🎨 Gestaltungsbibeln erstellen         | Verbindliche Regeln für Grafik, Animation, UI, Effekte, Musik und Geräusche.     |    ⚪   |
|  66 | 🔐 Gesamtumfang sperren                | Spielumfang, Kapitelzahl und Produktionsreihenfolge verbindlich freigeben.       |    ⚪   |
|   — | 🔒 Meilenstein                         | Es ist klar definiert, was zum fertigen Spiel gehört und was nicht.              |    ⚪   |

---

# Phase 5 – Kernsysteme für das vollständige Spiel

Nur Systeme, die in Aufgabe 61 freigegeben wurden, werden umgesetzt. Nicht benötigte Systeme werden als **nicht erforderlich** markiert und nicht vorsorglich entwickelt.

| Nr. | Aufgabe                                       | Ziel und Abschlusskriterium                                                            | Status |
| --: | --------------------------------------------- | -------------------------------------------------------------------------------------- | :----: |
|  67 | 🏗️ Architekturprüfung                        | Vertical-Slice-Code prüfen und nur notwendige technische Schulden beheben.             |    ⚪   |
|  68 | 📦 Datenbasierte Inhalte                      | Gegner, Gegenstände, Dialoge und Regionen über einheitliche Datenstrukturen verwalten. |    ⚪   |
|  69 | 💾 Speichersystem V1                          | Mehrere Speicherstände, Versionsdaten und sichere Ladefehlerbehandlung.                |    ⚪   |
|  70 | 📊 Spielerwerte und Fortschritt               | Lebenswerte, Ressourcen und freigegebene Fortschrittswerte zentral verwalten.          |    ⚪   |
|  71 | 🎒 Gegenstände und Inventar                   | Benötigte Gegenstände aufnehmen, anzeigen und verwenden.                               |    ⚪   |
|  72 | 🛡️ Ausrüstung und Verbesserungen             | Freigegebene Ausrüstung und Verbesserungen technisch umsetzen.                         |    ⚪   |
|  73 | ⚔️ Kampfsystem V1                             | Kampfreaktionen, Angriffstypen, Trefferregeln und Gegnergruppen erweitern.             |    ⚪   |
|  74 | 👾 Gegner- und Bossrahmen                     | Wiederverwendbare Grundlage für Gegnerverhalten und Bossphasen.                        |    ⚪   |
|  75 | ☣️ Zustände und Gefahren                      | Freigegebene Statuseffekte, Umweltgefahren und Gegenwirkungen umsetzen.                |    ⚪   |
|  76 | 🎬 Dialog- und Ereignissystem                 | Dialoge, Erinnerungen und kontrollierte Ereignisabläufe produktionsreif machen.        |    ⚪   |
|  77 | 📜 Aufgaben- und Zielsystem                   | Hauptziele und freigegebene Nebenaufgaben nachvollziehbar verwalten.                   |    ⚪   |
|  78 | 🌗 Weltzustands- und Wiederherstellungssystem | Beschädigte und wiederhergestellte Zustände für alle Regionen skalierbar machen.       |    ⚪   |
|  79 | 🕛 Zeit- und Himmelszyklen                    | Kanonische Zeitrechnung, Weltzyklen und dokumentierte Himmelskörper integrieren.       |    ⚪   |
|  80 | 🗺️ Reisen, Schlafen und Warten               | Zeitverhalten bei Räumen, Dungeons, Reisen und Ruhe nach Dokumentation umsetzen.       |    ⚪   |
|  81 | 💰 Handel und Wirtschaft                      | Nur den freigegebenen Umfang für Händler, Preise und Tausch umsetzen.                  |    ⚪   |
|  82 | 🖥️ HUD und Menüs V1                          | Vollständige Produktionsoberfläche für Spielwerte, Karten und Einstellungen.           |    ⚪   |
|  83 | 🎮 Eingaben und Controller                    | Tastatur, Controller, Tastenbelegung und Eingabekonflikte zuverlässig verwalten.       |    ⚪   |
|  84 | ♿ Barrierefreiheitsoptionen                   | Lesbarkeit, Bewegung, Effekte, Lautstärke und relevante Hilfsoptionen anbieten.        |    ⚪   |
|  85 | 🔊 Audiosystem V1                             | Musikwechsel, Umgebungsgeräusche, Lautstärkegruppen und Übergänge verwalten.           |    ⚪   |
|  86 | 🌐 Lokalisierungsgrundlage                    | Texte von Code trennen und Übersetzungen technisch ermöglichen.                        |    ⚪   |
|  87 | ⚙️ Leistung und Ladeverhalten                 | Leistungsbudgets, Ladeübergänge und Speichergrenzen definieren.                        |    ⚪   |
|  88 | 🧪 Builds und automatische Prüfungen          | Reproduzierbare Test-Builds und grundlegende Startprüfungen einrichten.                |    ⚪   |
|  89 | 🔐 Kernsysteme integrieren                    | Alle freigegebenen Grundsysteme gemeinsam testen und sperren.                          |    ⚪   |
|   — | 🔒 Meilenstein                                | Das technische Fundament trägt die Produktion des gesamten Spiels.                     |    ⚪   |

---

# Phase 6 – Produktionspipeline für Grafik, Audio und Inhalte

| Nr. | Aufgabe                            | Ziel und Abschlusskriterium                                                       | Status |
| --: | ---------------------------------- | --------------------------------------------------------------------------------- | :----: |
|  90 | 🎨 Pixelart-Regelwerk finalisieren | Auflösung, Raster, Palette, Schattierung und Exportregeln verbindlich festlegen.  |    ⚪   |
|  91 | 🌿 Umgebungs- und Tileset-Pipeline | Tiles, Objekte, Übergänge und Zustandsvarianten einheitlich produzieren.          |    ⚪   |
|  92 | 🧍 Figuren- und Animationspipeline | Benennung, Bildgrößen, Richtungen und Animationsphasen standardisieren.           |    ⚪   |
|  93 | ✨ Effekt- und Lichtpipeline        | Treffer, Magie, Nebel, Licht und Wiederherstellung einheitlich erstellen.         |    ⚪   |
|  94 | 🖥️ UI-Grafikpipeline              | Fenster, Symbole, Schriften und Zustände nach festen Regeln produzieren.          |    ⚪   |
|  95 | 🎵 Audio- und Musikpipeline        | Dateiformate, Lautstärken, Schleifen und Einbindung standardisieren.              |    ⚪   |
|  96 | 🧩 Inhaltsvorlagen                 | Vorlagen für Regionen, Räume, Dungeons, Begegnungen und Bosse erstellen.          |    ⚪   |
|  97 | ✅ Produktions-Checklisten          | Technische und gestalterische Abnahmekriterien pro Inhaltstyp definieren.         |    ⚪   |
|  98 | 🔐 Pipeline-Probe abschließen      | Einen kleinen Beispielinhalt vollständig durch alle Pipelines führen und prüfen.  |    ⚪   |
|   — | 🔒 Meilenstein                     | Neue Inhalte können ohne wechselnde Formate und Sonderlösungen produziert werden. |    ⚪   |

---

# Phase 7 – Alle Regionen und Kapitel produzieren

Die genaue Zahl und Benennung der Regionen wird erst in den Aufgaben 57 bis 66 festgelegt.

Der folgende Ablauf wird **für jede Region beziehungsweise jedes Kapitel einzeln wiederholt**. Der erste vollständige Grasland-Abschnitt beginnt erst hier.

|   Nr. | Aufgabe pro Region oder Kapitel | Ziel und Abschlusskriterium                                                       | Status |
| ----: | ------------------------------- | --------------------------------------------------------------------------------- | :----: |
|  99.1 | 📄 Detailkonzept                | Handlung, Spielziel, Orte, Gegner und besondere Mechaniken der Region festlegen.  |   🔁   |
|  99.2 | 🧱 Blockout                     | Karte, Wege, Räume, Grenzen und Übergänge vollständig als Rohbau erstellen.       |   🔁   |
|  99.3 | 🧩 Spielmechaniken              | Interaktionen, Hindernisse, Rätsel und besondere Regionalmechaniken umsetzen.     |   🔁   |
|  99.4 | 🧑 Figuren und Handlung         | NPCs, Dialoge, Erinnerungen und Ereignisse integrieren.                           |   🔁   |
|  99.5 | ⚔️ Begegnungen                  | Gegnergruppen, Platzierung und Kampfsituationen einrichten.                       |   🔁   |
|  99.6 | 👑 Dungeon und Boss             | Vorgesehene Dungeons, Wächter oder Bosse fertigstellen.                           |   🔁   |
|  99.7 | 🌗 Weltzustände                 | Beschädigte und wiederhergestellte Fassung der Region umsetzen.                   |   🔁   |
|  99.8 | 🎨 Finale Grafik                | Tiles, Objekte, Figuren, Animationen, Licht und Effekte fertigstellen.            |   🔁   |
|  99.9 | 🔊 Audio und Musik              | Umgebung, Ereignisse, Kämpfe und regionale Musik integrieren.                     |   🔁   |
| 99.10 | 📈 Fortschritt und Speichern    | Belohnungen, Fähigkeiten, Gegenstände und Speicherpunkte korrekt anbinden.        |   🔁   |
| 99.11 | 🧪 Regionsprüfung               | Fehler, Leistung, Wegführung, Lesbarkeit und Barrierefreiheit prüfen.             |   🔁   |
| 99.12 | 🔐 Region sperren               | Region vollständig testen, dokumentieren und für die Gesamtintegration freigeben. |   🔁   |

## Reihenfolge innerhalb der Inhaltsproduktion

| Regel | Bedeutung                                                                      |
| ----: | ------------------------------------------------------------------------------ |
|     1 | Es wird immer nur **eine Region oder ein Kapitel gleichzeitig** produziert.    |
|     2 | Die nächste Region beginnt erst nach Abschluss von Aufgabe 99.12.              |
|     3 | Systeme werden nicht während jeder Region neu erfunden.                        |
|     4 | Neue technische Anforderungen werden zuerst als eigene Aufgabe geprüft.        |
|     5 | Aufgabe 100 beginnt erst, wenn alle freigegebenen Regionen abgeschlossen sind. |

---

# Phase 8 – Vollständiges Spiel zusammensetzen

| Nr. | Aufgabe                                     | Ziel und Abschlusskriterium                                                           | Status |
| --: | ------------------------------------------- | ------------------------------------------------------------------------------------- | :----: |
| 100 | 🔗 Regionen verbinden                       | Alle Übergänge, Reisewege und Rückkehrmöglichkeiten funktionieren.                    |    ⚪   |
| 101 | 🎯 Kritischen Pfad durchspielen             | Hauptspiel vom Start bis zum Ende ohne Entwicklungsabkürzungen spielbar.              |    ⚪   |
| 102 | 🧭 Nebeninhalte integrieren                 | Freigegebene optionale Inhalte korrekt in Welt und Fortschritt einfügen.              |    ⚪   |
| 103 | 📈 Globale Fortschrittsbalance              | Fähigkeiten, Ausrüstung, Belohnungen und Gegnerstärke über das ganze Spiel abstimmen. |    ⚪   |
| 104 | ⚔️ Globale Kampf- und Schwierigkeitsbalance | Schwierigkeit steigt nachvollziehbar und vermeidet unfaire Spitzen.                   |    ⚪   |
| 105 | 📖 Handlungs- und Dialogkontinuität         | Ereignisse, Figurenwissen und Dialogzustände widersprechen sich nicht.                |    ⚪   |
| 106 | 🌍 Weltzustandskontinuität                  | Wiederherstellungen und Veränderungen bleiben über Regionen hinweg korrekt.           |    ⚪   |
| 107 | 🕛 Zeit- und Zykluskontinuität              | Zeit, Reisen, Himmelszyklen und gespeicherte Weltzeit bleiben konsistent.             |    ⚪   |
| 108 | 💾 Vollständige Speicherprüfung             | Speichern und Laden funktioniert an allen vorgesehenen Stellen.                       |    ⚪   |
| 109 | 🎨 Globale Grafikprüfung                    | Figuren, Regionen, UI, Effekte und Zustände wirken wie ein zusammengehöriges Spiel.   |    ⚪   |
| 110 | 🔊 Finaler Audio-Mix                        | Musik, Umgebung, Dialogsignale und Effekte besitzen ausgeglichene Lautstärken.        |    ⚪   |
| 111 | 🌐 Ausgangstexte sperren                    | Alle Texte für Übersetzung und Endkorrektur fertigstellen.                            |    ⚪   |
| 112 | 🅰️ Content-Complete-Alpha                  | Alle geplanten Inhalte sind eingebaut und grundsätzlich durchspielbar.                |    ⚪   |
|   — | 🔒 Meilenstein                              | Das vollständige Spiel existiert. Danach werden keine großen Inhalte mehr ergänzt.    |    ⚪   |

---

# Phase 9 – Alpha-Test und Stabilisierung

| Nr. | Aufgabe                              | Ziel und Abschlusskriterium                                                      | Status |
| --: | ------------------------------------ | -------------------------------------------------------------------------------- | :----: |
| 113 | 🎮 Interne Komplettdurchläufe        | Mehrere vollständige Durchläufe mit unterschiedlichen Spielweisen durchführen.   |    ⚪   |
| 114 | 🚨 Abstürze und Softlocks            | Alle reproduzierbaren Abstürze und blockierenden Situationen beheben.            |    ⚪   |
| 115 | 💾 Speicherfehler und Migration      | Beschädigte Spielstände verhindern und ältere Teststände kontrolliert behandeln. |    ⚪   |
| 116 | ⚙️ Leistung und Ladezeiten           | Problematische Regionen, Effekte und Übergänge optimieren.                       |    ⚪   |
| 117 | ⚔️ Kampfbalance                      | Gegner, Bosse, Schaden und Heilung anhand vollständiger Durchläufe abstimmen.    |    ⚪   |
| 118 | 📈 Fortschritt und Wirtschaft        | Belohnungen, Preise und Verbesserungen auf Sackgassen oder Überschuss prüfen.    |    ⚪   |
| 119 | 📖 Tempo und Einführung              | Verständlichkeit, Einführung und Handlungsfluss über das gesamte Spiel prüfen.   |    ⚪   |
| 120 | ♿ Bedienbarkeit und Barrierefreiheit | Optionen und kritische Spielsituationen mit verschiedenen Einstellungen testen.  |    ⚪   |
| 121 | 🎮 Eingabe- und Geräteprüfung        | Unterstützte Controller, Auflösungen und Eingabewechsel prüfen.                  |    ⚪   |
| 122 | ✅ Vollständigkeitsprüfung            | Alle freigegebenen Inhalte, Texte, Grafiken und Audiodateien kontrollieren.      |    ⚪   |
| 123 | 🔄 Alpha-Regressionstest             | Nach Korrekturen erneut alle wichtigen Systeme und Kapitel prüfen.               |    ⚪   |
| 124 | 🔐 Alpha-Freigabe                    | Keine bekannten Blocker; vollständiges Spiel für Beta-Test freigeben.            |    ⚪   |

---

# Phase 10 – Beta und Veröffentlichungsvorbereitung

| Nr. | Aufgabe                          | Ziel und Abschlusskriterium                                                        | Status |
| --: | -------------------------------- | ---------------------------------------------------------------------------------- | :----: |
| 125 | 🧪 Geschlossener Beta-Test       | Externe Testpersonen spielen ohne Entwickleranleitung.                             |    ⚪   |
| 126 | 📋 Rückmeldungen auswerten       | Fehler, Verständnisprobleme und Balancehinweise nach Wichtigkeit ordnen.           |    ⚪   |
| 127 | 🐞 Beta-Fehler beheben           | Relevante Fehler korrigieren, ohne neue große Systeme einzubauen.                  |    ⚪   |
| 128 | ⚖️ Letzte Balancekorrektur       | Nur noch klar begründete Zahlen- und Schwierigkeitsanpassungen.                    |    ⚪   |
| 129 | 🌐 Übersetzung und Sprachprüfung | Freigegebene Sprachen übersetzen, kontrollieren und im Spiel testen.               |    ⚪   |
| 130 | 📜 Rechtliches und Lizenzen      | Fremdmaterial, Bibliotheken, Schriften, Audio und Namensnennungen prüfen.          |    ⚪   |
| 131 | 🏆 Plattformfunktionen           | Nur freigegebene Erfolge, Cloud-Speicherung oder Plattformanbindungen integrieren. |    ⚪   |
| 132 | 🖼️ Veröffentlichungsmaterial    | Spielbeschreibung, Screenshots, Cover, Symbole und Trailer fertigstellen.          |    ⚪   |
| 133 | 📘 Hilfen und Supporttexte       | Steuerung, bekannte Hinweise, Fehlerberichte und Supportablauf dokumentieren.      |    ⚪   |
| 134 | 🔒 Content Lock                  | Keine neuen Inhalte oder Funktionen mehr; nur noch Fehlerkorrekturen.              |    ⚪   |

---

# Phase 11 – Release und fertiges Spiel

| Nr. | Aufgabe                                | Ziel und Abschlusskriterium                                                      | Status |
| --: | -------------------------------------- | -------------------------------------------------------------------------------- | :----: |
| 135 | 📦 Release-Build erstellen             | Finalen Build reproduzierbar und mit korrekter Versionsnummer erstellen.         |    ⚪   |
| 136 | 🧪 Vollständiger Regressionstest       | Kritischen Pfad, Speicherstände, Menüs, Eingaben und alle Kapitel erneut prüfen. |    ⚪   |
| 137 | ⚙️ Finale Leistungs- und Geräteprüfung | Unterstützte Systeme, Auflösungen und Controller abschließend testen.            |    ⚪   |
| 138 | 💾 Finale Speicher- und Buildprüfung   | Neuinstallation, Aktualisierung, Speichern, Laden und Spielabschluss testen.     |    ⚪   |
| 139 | 🟡 Gold-Master-Freigabe                | Exakt freizugebender Build wird dokumentiert und gesperrt.                       |    ⚪   |
| 140 | 🚀 Veröffentlichung                    | Freigegebenen Build und Veröffentlichungsmaterial bereitstellen.                 |    ⚪   |
| 141 | 🩹 Kritische Startkorrekturen          | Nur schwere, reproduzierbare Veröffentlichungsprobleme beheben.                  |    ⚪   |
| 142 | 🏁 Stabile Vollversion                 | Veröffentlichung ist stabil, dokumentiert und vollständig spielbar.              |    ⚪   |

# Endzustand des Projekts

| Bereich             | Bedingung für „fertiges Spiel“                                     |
| ------------------- | ------------------------------------------------------------------ |
| Handlung            | Vollständiger Hauptpfad vom Titelbildschirm bis zum Ende           |
| Regionen            | Alle freigegebenen Regionen und Dungeons abgeschlossen             |
| Spielsysteme        | Nur die tatsächlich benötigten Systeme sind stabil umgesetzt       |
| Grafik              | Einheitlicher Pixelart-Stil und vollständige Zustandsvarianten     |
| Audio               | Musik, Effekte und Umgebung vollständig integriert                 |
| Weltzustände        | Beschädigung und Wiederherstellung funktionieren dauerhaft         |
| Zeit und Weltzyklen | Kanonische Zeit- und Himmelsregeln sind korrekt integriert         |
| Fortschritt         | Balance, Fähigkeiten, Gegenstände und Belohnungen funktionieren    |
| Speicherung         | Fortschritt kann zuverlässig gespeichert und geladen werden        |
| Bedienung           | Menüs, Controller, Einstellungen und Barrierefreiheit geprüft      |
| Technik             | Keine bekannten Abstürze, Softlocks oder kritischen Speicherfehler |
| Veröffentlichung    | Gold-Master-Build veröffentlicht und stabilisiert                  |

# Aktueller direkter Einstieg

| Letzter abgeschlossener Schritt | Nachweis | Nächster Schritt |
| ------------------------------- | -------- | ---------------- |
| **Aufgabe 20 – Maßstab V0 festlegen** | Kandidat B ist als 80-px-Held, 32er Raster und normale 1,00×-Spielansicht festgelegt; kleine Räume dürfen 1,50×-Profile verwenden. | **Aufgabe 21 – Dokumentation aktualisieren**: Ergebnisse des visuellen Testlabors systematisch zusammenführen. |

Die letzten abgeschlossenen Implementierungsschritte sind die Diagnoseanzeige,
die F5-Steuerungshilfe, der begehbare Heldenraum und die erste
Ratgeber-Interaktion sowie die Pixel-Snap-, Texturfilter-, Nebel- und
Lichttests sowie Maßstab V0. Diese Vorarbeiten schließen die größeren gelben
Arbeitspakete noch nicht vollständig ab. Insbesondere fehlen weiterhin die
Freigabe der Bewegungssteuerung V0, Türen und Ausgang, Animationen sowie ein
allgemeines Text- und Dialogsystem.

**Aufgabe 20 ist abgeschlossen. Als Nächstes folgt Aufgabe 21; die
Bewegungssteuerung V0 bleibt 🟡.**
