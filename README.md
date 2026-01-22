# Typst template für DHBW (in Anlehnung an die LaTeX-Vorlage)

Diese Vorlage ist eine Typst-Implementierung, die sich am Aufbau/Look der gängigen DHBW-LaTeX-Vorlage orientiert (Deckblatt, Verzeichnisse, Nummerierungen, typische Struktur).

## Warum Typst und nicht LaTeX?

- **Schneller Workflow:** kurze Compile-Zeiten, schnelle Feedback-Schleifen
- **Lesbare Syntax:** weniger Boilerplate, mehr Fokus auf Inhalt
- **Bessere Fehlermeldungen:** Probleme sind i.d.R. leichter zu finden
- **Modernes Layouting:** Tabellen/Figuren/Grids sind konsistent integriert
- **Weniger Paket-Wildwuchs:** vieles geht ohne „welches Paket war das nochmal?“

## Benutzung

Die meiste Nutzung steht in der `main.pdf`. Kurzfassung: In `main.typ` importierst du `bericht` und konfigurierst alles über `#show: bericht.with(...)`. Der eigentliche Inhalt kommt als Body-Block hinten dran.

## Typst Doku

- https://typst.app/docs/  
  (Die Doku ist wirklich brauchbar.)
