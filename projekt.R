andmed_mehed <- read.csv('andmestik/2024-EIGE-calcs-M-data.csv', encoding = 'UTF-8', sep =';')
andmed_naised <- read.csv('andmestik/2024-EIGE-calcs-W-data.csv', encoding = 'UTF-8', sep =';')
andmed_koik <- read.csv('andmestik/2024-EIGE-data.csv', encoding = 'UTF-8', sep =';')
library(ggplot2)
library(dplyr)
library(tidyr)
ggplot(andmed_koik, aes(x = reorder(Geographic.region..Sub...Domain.Scores, Power..Domain.score.), 
                        y = Power..Domain.score.)) + geom_col() + coord_flip() + labs(y = 'Soolise võrdõiguslikkuse indeks võimus', x = 'Riik ja EL keskmine')


andmed_mehed$Gender <- "Mehed"
andmed_naised$Gender <- "Naised"
andmed_kokku <- bind_rows(andmed_mehed, andmed_naised)

ggplot(andmed_kokku, aes(x = reorder(Geographic.region.Individual.indicators.used.to.compute.the.Gender.Equality.Index,
                                     Share.of.members.of.boards.in.largest.quoted.companies..supervisory.board.or.board.of.directors....),
                         y = Share.of.members.of.boards.in.largest.quoted.companies..supervisory.board.or.board.of.directors....,
                         fill = Gender)) +
  geom_col(position = "dodge") +
  coord_flip() +
  scale_fill_grey(start = 0.3, end = 0.7) +
  labs(y = 'Juhatuste liikmete osakaal (%)', x = 'Riik ja EL keskmine', fill = "Sugu") +
  theme_bw()


andmed_pikk <- andmed_koik %>%
  pivot_longer(
    cols = 2:ncol(andmed_koik),
    names_to = "Indeks",
    values_to = "Skoor"
  )

colnames(andmed_pikk)[1] <- 'Riik'

andmed_pikk <- andmed_pikk %>%
  mutate(lyhend = case_when(
    Indeks == 'Overall.Gender.Equality.Index' ~ 'Soolise võrdõiguslikkuse indeks',
    Indeks == 'Work..Domain.score.' ~ 'Töö valdkond',
    Indeks == 'Participation.in.work..Subdomain.score.' ~ 'Tööhõive',
    Indeks == 'Segregation.and.quality.of.work..Subdomain.score.' ~ 'Töösegregatsioon ja kvaliteet',
    Indeks == 'Money..Domain.score.' ~ 'Raha valdkond',
    Indeks == 'Financial.resources..Subdomain.score.' ~ 'Majanduslikud varad',
    Indeks == 'Economic.situation..Subdomain.score.' ~ 'Majanduslik olukord',
    Indeks == 'Knowledge..Domain.score.' ~ 'Teadmiste valdkond',
    Indeks == 'Attainment.and.participation..Subdomain.score.' ~ 'Hariduses osalemine ja saavutused',
    Indeks == 'Segregation..Subdomain.score.' ~ 'Hariduse segregatsioon',
    Indeks == 'Time..Domain.score.' ~ 'Aja kasutus',
    Indeks == 'Care.activities..Subdomain.score.' ~ 'Hooldustegevused',
    Indeks == 'Social.activities..Subdomain.score.' ~ 'Sotsiaalne tegevus',
    Indeks == 'Power..Domain.score.' ~ 'Võimu valdkond',
    Indeks == 'Political.power..Subdomain.score.' ~ 'Poliitiline võim',
    Indeks == 'Economic.power..Subdomain.score.' ~ 'Majanduslik võim',
    Indeks == 'Social.power..Subdomain.score.' ~ 'Sotsiaalne võim',
    Indeks == 'Health..Domain.score.' ~ 'Tervise valdkond',
    Indeks == 'Health.status..Subdomain.score.' ~ 'Tervise seisund',
    Indeks == 'Healthy.behaviour..Subdomain.score.' ~ 'Tervislik käitumine',
    Indeks == 'Access.to.health.structures..Subdomain.score.' ~ 'Juurdepääs terviseteenustele',
    TRUE ~ 'Muu'
  )) %>%
  mutate(lyhend = factor(lyhend, levels = c(
    'Soolise võrdõiguslikkuse indeks',
    'Töö valdkond',
    'Tööhõive',
    'Töösegregatsioon ja kvaliteet',
    'Raha valdkond',
    'Majanduslikud varad',
    'Majanduslik olukord',
    'Teadmiste valdkond',
    'Hariduses osalemine ja saavutused',
    'Hariduse segregatsioon',
    'Aja kasutus',
    'Hooldustegevused',
    'Sotsiaalne tegevus',
    'Võimu valdkond',
    'Poliitiline võim',
    'Majanduslik võim',
    'Sotsiaalne võim',
    'Tervise valdkond',
    'Tervise seisund',
    'Tervislik käitumine',
    'Juurdepääs terviseteenustele',
    'Muu'
  )))


ggplot(andmed_pikk, aes(x = lyhend, y = Skoor)) +
  geom_boxplot() +
  geom_point(data = filter(andmed_pikk, andmed_pikk$Riik == "Estonia"), 
             aes(x = lyhend, y = Skoor), 
             size = 3, color = '#0072CE') +
  labs(y = "Soolise võrdõiguslikkuse indeks", x = "Valdkond", title = "Eesti võrrelduna teiste riikidega") +
  theme_minimal() + coord_flip()
