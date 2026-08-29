---
title: "Entscheidungsprotokoll"
language: de
status: approved
version: "0.1"
source_of_truth: true
translation_status: blocked-until-concept-complete
---

[← Entscheidungen und Archiv](index.md)

# Entscheidungsprotokoll

## Zweck

Dieses Protokoll macht bestätigte Konzeptentscheidungen und spätere Änderungen
auffindbar. Ausführliche neue Entscheidungen verwenden die
[Entscheidungsvorlage](../templates/decision-template.md) und werden hier
verlinkt.

## Initiale bestätigte Entscheidungen

| ID | Datum | Status | Entscheidung | Betroffene Dokumente | Ersetzt |
| --- | --- | --- | --- | --- | --- |
| EF-DEC-001 | 2026-08-29 | `approved` | Projekt- und Spielname ist exakt `ether-food`. | [Projektsteckbrief](../00-overview/project-brief.md) | — |
| EF-DEC-002 | 2026-08-29 | `approved` | Deutsch ist Konzeptquelle; Englisch ist technische Sprache; Detailübersetzungen folgen erst nach Gesamtabschluss und Quellfreigabe. | [Sprachrichtlinie](../01-baseline/language-policy.md) | — |
| EF-DEC-003 | 2026-08-29 | `approved` | Top-down-Action-RPG über Wiederherstellung einer verlorenen Welt, Rückkehr von Zivilisationen und vergessene Erinnerungen. | [Projektsteckbrief](../00-overview/project-brief.md) | — |
| EF-DEC-004 | 2026-08-29 | `approved` | Wiederherstellungsfolge: Landschaft → Bewohner → Siedlungen/Städte → Erinnerungen/Geschichte → Fähigkeitserweiterung. | [Gameplay und Fortschritt](../03-gameplay-and-progression/gameplay-and-progression.md) | — |
| EF-DEC-005 | 2026-08-29 | `approved` | Kampfumfang des ersten Vertical Slice: Angriff, Ausweichen, Blocken und Fernkampfmagie. | [Kampfsystem](../04-combat/combat-system.md) | — |
| EF-DEC-006 | 2026-08-29 | `approved` | Maschinen und Zuro bleiben geplante, aber undefinierte Systeme; offene Regeln werden nicht erfunden. | [Maschinensystem](../05-machines/machine-system.md), [Zuro-System](../06-zuro-and-enemies/zuro-system.md) | — |

## Änderungsregel

Eine Änderung an einem bereits freigegebenen Dokument benötigt Kontext,
betrachtete Optionen, Entscheidung, Begründung, Folgen, betroffene Dokumente,
neue Dokumentversion und gegebenenfalls eine ersetzte Entscheidung. Spätere
Übersetzungen werden bei Quelländerung als veraltet gekennzeichnet.

## Offene Prozessfragen

Freigaberollen, Nummerierungsverfahren für ausführliche Einzelentscheidungen und
Versionierung rein redaktioneller Änderungen sind noch nicht entschieden.

## Abnahmekriterien

- Jede inhaltliche Änderung an `approved` ist über eine Protokoll-ID auffindbar.
- Ersetzte Entscheidungen bleiben erhalten und verweisen auf den Nachfolger.
- Konzeptstatus und betroffene Quelldokumente werden im selben Änderungssatz
  aktualisiert.

## Verwandte Dokumente

- [Dokumentationsgovernance](../01-baseline/documentation-governance.md)
- [Konzeptstatus](../01-baseline/concept-status.md)
- [Archivrichtlinie](archive-policy.md)
