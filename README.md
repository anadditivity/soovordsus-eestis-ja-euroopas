# Saagem ometi eurooplasteks! Statistiline vaade Eesti soolise võrdsuse indeksile

## Anet Ilustrumm, Marin-Brith Põldma, Adeline Talvik

## 4. mai 2025

Tartu Ülikooli aine "Statistiline andmeteadus ja visualiseerimine" (MTMS.01.100) projekti "Saagem ometi eurooplasteks! Statistiline vaade Eesti soolise võrdsuse indeksile" repositoorium.

Artiklis vaadeldakse sugu binaarsena, kuna vaadeldavad andmed on kogutud binaarse soo eeldusega. Artikli autorite arvates pole sugu rangelt binaarne.

### Failide kirjeldus

Koodihoidla koosneb järgnevatest failidest:
* `andmestik/2011-2024-statamet-brutotunnipalgad.csv` - Statistikaameti 2011-2024 brutotunnipalgad valdkondade peale kokku, jaotatud soo kaupa. [Saadud Statistikaameti tabelist PA5335](https://andmed.stat.ee/et/stat/majandus__palk-ja-toojeukulu__palk__aastastatistika/PA5335).
* `andmestik/2024-EIGE-data.csv` - Euroopa soolise võrdõiguslikkuse instituudi (EIGE) 2024. aasta soolise võrdsuse indeksi raporti andmefail. [Saadud EIGE 2024. aasta andmestiku lehelt](https://eige.europa.eu/gender-statistics/dgs/indicator/index__index_scores/datatable).
* `andmestik/EE-valdkonniti.csv` - EIGE 2024. aasta soolise võrdsuse indeksi Eesti tulemuste andmefail. [Saadud EIGE 2024. aasta Eesti tulemuste lehel](https://eige.europa.eu/gender-equality-index/2024/country/EE) alla kerides nupu "Estonia trends in more detail" kaudu.
* `andmestik/EIGE-metadata.xslx` - EIGE 2024. aasta soolise võrdsuse indeksi raporti metafail; sisaldab näitajate kirjeldusi. [Saadud EIGE 2024. aasta andmete lehel metaandmete vaheaknast](https://eige.europa.eu/gender-statistics/dgs/indicator/index__index_scores/metadata).
* `andmestik/palgalohe-tabel.csv` - Statistikaameti ja Eurostati andmetel loodud kombineeritud palgalõhe fail. Andmed [Statistikaameti tabelist PA5335](https://andmed.stat.ee/et/stat/majandus__palk-ja-toojeukulu__palk__aastastatistika/PA5335) ja [Eurostat andmetabelist sdg_05_20](https://ec.europa.eu/eurostat/databrowser/view/sdg_05_20/default/table?lang=en).
* `artikkel.html` - faili `artikkel.Rmd` väljund; loetav artikkel.
* `artikkel.Rmd` - R Markdown formaadis artiklifail. Sisaldab teksti ning graafikute koodi.
* `LICENCE` - MIT litsents.
* `README.md` - fail, mida praegu loed.