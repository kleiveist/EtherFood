<!-- AUTO-GENERATED:backlink START -->
[← Zurück](developer.md)
<!-- AUTO-GENERATED:backlink END -->
# Dokumentationsstruktur

Die Dokumentation ist bewusst einfach gegliedert. Jeder Bereich hat genau eine
Aufgabe.

| Bereich | Pfad | Aufgabe |
|---|---|---|
| Spielkonzept | [`docs/concept/`](../concept/index.md) | Einzige Quelle für Kanon, Handlung, Welt und Spielmechanik |
| Entwicklung | [`docs/developer/`](index.md) | Architektur, Umsetzung, technische Entscheidungen und Arbeitspläne |
| Spielerhandbuch | [`docs/player-guide/`](../player-guide/index.md) | Spätere öffentliche Spielhilfe |
| Medien | [`docs/assets/`](../assets/README.md) | Bilder, Karten, Diagramme, Videos und bearbeitbare Quellen |
| Forge2D-Referenz | [`docs/.forge2d-template/`](../.forge2d-template/index.md) | Unveränderte englische Grundlage der Vorlage |

## Sprache

Alle aktive Projektdokumentation wird auf Deutsch geschrieben. Code, Befehle,
Pfade und technische Bezeichner dürfen Englisch bleiben. Nur die geerbte
Forge2D-Referenz bleibt unverändert auf Englisch. Es gibt keinen englischen
Konzeptspiegel.

## Arbeitsweise

- Neue Aussagen zu Kanon oder Spielablauf gehören direkt auf die passende
  Konzeptseite.
- Bereits angenommene Festlegungen werden über eine Entscheidung unter
  `docs/concept/entscheidungen/` geändert.
- Technische Seiten beschreiben die Umsetzung und verweisen auf das Konzept,
  statt eine zweite Fassung zu führen.
- Komplexe Arbeiten erhalten einen fortlaufenden Plan unter
  `docs/developer/plans/`.
- Relative Markdown-Links halten die Dokumentation auf GitHub und lokal
  navigierbar.
- Die mit `AUTO-GENERATED` markierten Navigationsteile werden vom vorhandenen
  Dokumentationsgenerator erneuert und nicht von Hand gepflegt.

## Medien

Bearbeitbare Quellen liegen unter `docs/assets/source/`, Exporte unter
`docs/assets/images/`, Diagramme unter `docs/assets/diagrams/` und
Videohinweise unter `docs/assets/videos/`. Für einfache Abläufe ist Mermaid
bevorzugt, wenn das Diagramm auch im Markdown verständlich bleibt.
