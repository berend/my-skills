---
name: projekt-arbeit-übersicht
description: Erstellt aus einer PDF-Projektdokumentation für Fachinformatiker eine neutrale Übersicht entlang der sieben Bewertungsbereiche. Verwenden, wenn der Nutzer den Skill mit einem PDF-Dateinamen aufruft und pro Bereich einen Absatz ohne Bewertung, Benotung oder Verbesserungsvorschläge benötigt.
---

# Projektarbeit-Übersicht

## Aufruf

Der Skill wird mit dem Pfad zu genau einer PDF-Datei aufgerufen:

```text
$projekt-arbeit-übersicht Projektdoku1.pdf
```

Behandle das erste Argument als Eingabedatei. Falls kein Dateiname angegeben wurde
oder die Datei nicht gelesen werden kann, fordere eine lesbare PDF-Datei an.

## Vorgehen

1. Lies die vollständige PDF einschließlich Inhaltsverzeichnis, Fließtext,
   Tabellen, Grafiken, Anlagenverweisen und Anhängen.
2. Prüfe die sichtbare Darstellung der PDF-Seiten, damit Aussagen zu Layout,
   Seitenaufbau, Tabellen und Grafiken auf der tatsächlichen Darstellung beruhen.
3. Ordne die belegbaren Inhalte den Leitfragen aus
   [KRITERIEN.md](KRITERIEN.md) zu.
4. Erstelle genau einen zusammenhängenden Absatz für jeden der sieben Bereiche.

## Ausgabe

Verwende genau diese sieben Überschriften in dieser Reihenfolge:

1. `Inhalt und Gliederung`
2. `Form`
3. `Auftragsbeschreibung`
4. `Fachsprache`
5. `Durchführung`
6. `Projektlösung und Ergebnisse`
7. `Projektrelevante Unterlagen`

Beschreibe unter jeder Überschrift sachlich, welche in den Leitfragen genannten
Aspekte die Dokumentation behandelt und wie sie dargestellt werden. Fasse
zusammengehörige Aspekte zu gut lesbarer Prosa zusammen; beantworte die
Leitfragen nicht als Liste.

## Grenzen

- Erstelle keine Bewertung, Benotung, Punktevergabe oder Rangfolge.
- Verwende keine wertenden Urteile wie „gut“, „schlecht“, „angemessen“,
  „sinnvoll“, „korrekt“ oder „überzeugend“.
- Gib keine Verbesserungsvorschläge oder Prüfungsempfehlungen.
- Erfinde keine Inhalte. Benenne fehlende oder nicht erkennbare Aspekte neutral,
  wenn sie für die Übersicht relevant sind.
- Behaupte die Einhaltung externer Vorgaben nur, wenn das zugehörige Merkblatt
  oder die konkreten Vorgaben vorliegen. Nenne andernfalls nur beobachtbare
  Merkmale wie Seitenzahl, Schriftbild und Seitenaufbau.
- Halte jeden Absatz kompakt, aber decke alle für die Dokumentation relevanten
  Leitfragen des Bereichs ab.
