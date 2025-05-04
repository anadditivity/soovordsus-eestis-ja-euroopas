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
  labs(y = 'Juhatuste liikmete osakaal (%)', x = 'Riik ja EL keskmine', fill = 'Sugu') +
  theme_bw()


andmed_pikk <- andmed_koik %>%
  pivot_longer(
    cols = 2:ncol(andmed_koik),
    names_to = 'Indeks',
    values_to = 'Skoor'
  )

colnames(andmed_pikk)[1] <- 'Riik'

andmed_pikk <- andmed_pikk %>%
  mutate(lyhend = case_when(
    Indeks == 'Overall.Gender.Equality.Index' ~ 'Soolise võrdõiguslikkuse indeks',
    Indeks == 'Work..Domain.score.' ~ 'Töö',
    Indeks == 'Participation.in.work..Subdomain.score.' ~ 'Tööhõive',
    Indeks == 'Segregation.and.quality.of.work..Subdomain.score.' ~ 'Töösegregatsioon ja kvaliteet',
    Indeks == 'Money..Domain.score.' ~ 'Raha',
    Indeks == 'Financial.resources..Subdomain.score.' ~ 'Majanduslikud varad',
    Indeks == 'Economic.situation..Subdomain.score.' ~ 'Majanduslik olukord',
    Indeks == 'Knowledge..Domain.score.' ~ 'Teadmised',
    Indeks == 'Attainment.and.participation..Subdomain.score.' ~ 'Hariduses osalemine ja saavutused',
    Indeks == 'Segregation..Subdomain.score.' ~ 'Hariduse segregatsioon',
    Indeks == 'Time..Domain.score.' ~ 'Aeg',
    Indeks == 'Care.activities..Subdomain.score.' ~ 'Hoolekanne',
    Indeks == 'Social.activities..Subdomain.score.' ~ 'Sotsiaalne tegevus',
    Indeks == 'Power..Domain.score.' ~ 'Võim',
    Indeks == 'Political.power..Subdomain.score.' ~ 'Poliitiline võim',
    Indeks == 'Economic.power..Subdomain.score.' ~ 'Majanduslik võim',
    Indeks == 'Social.power..Subdomain.score.' ~ 'Sotsiaalne võim',
    Indeks == 'Health..Domain.score.' ~ 'Tervis',
    Indeks == 'Health.status..Subdomain.score.' ~ 'Tervise seisund',
    Indeks == 'Healthy.behaviour..Subdomain.score.' ~ 'Tervislik eluviis',
    Indeks == 'Access.to.health.structures..Subdomain.score.' ~ 'Tervishoiu kättesaadavus',
    TRUE ~ 'Muu'
  )) %>%
  mutate(lyhend = factor(lyhend, levels = c(
    'Soolise võrdõiguslikkuse indeks',
    'Töö',
    'Tööhõive',
    'Töösegregatsioon ja kvaliteet',
    'Raha',
    'Majanduslikud varad',
    'Majanduslik olukord',
    'Teadmised',
    'Hariduses osalemine ja saavutused',
    'Hariduse segregatsioon',
    'Aeg',
    'Hoolekanne',
    'Sotsiaalne tegevus',
    'Võim',
    'Poliitiline võim',
    'Majanduslik võim',
    'Sotsiaalne võim',
    'Tervis',
    'Tervise seisund',
    'Tervislik eluviis',
    'Tervishoiu kättesaadavus',
    'Muu'
  )))

andmed_pikk_ilma_suurteta <- andmed_pikk[!(andmed_pikk$lyhend %in% c('Töö', 'Võim', 'Tervis', 'Muu', 'Aeg','Raha', 'Teadmised','Soolise võrdõiguslikkuse indeks')),]

ggplot(andmed_pikk_ilma_suurteta, aes(x = lyhend, y = Skoor)) +
  geom_boxplot() +
  geom_point(data = filter(andmed_pikk_ilma_suurteta, andmed_pikk_ilma_suurteta$Riik == "Estonia"), 
             aes(x = lyhend, y = Skoor), 
             size = 3, color = '#0072CE') +
  labs(y = 'Soolise võrdõiguslikkuse indeks (SVI)', x = 'Valdkonnad', title = 'Eesti võrrelduna teiste riikidega') +
  theme_minimal() + coord_flip()


soome_ja_eesti <- andmed_pikk_ilma_suurteta[andmed_pikk_ilma_suurteta$Riik %in% c('Estonia', 'Finland'),]


# ggplot(soome_ja_eesti, aes(x = lyhend, y = Skoor)) +
#   geom_boxplot() +
#   geom_point(data = filter(soome_ja_eesti, soome_ja_eesti$Riik == "Estonia"), 
#              aes(x = lyhend, y = Skoor), 
#              size = 3, color = '#0072CE') +
#   geom_point(data = filter(soome_ja_eesti, soome_ja_eesti$Riik == "Finland"), 
#              aes(x = lyhend, y = Skoor), 
#              size = 3, color = '#FFD700') +
#   labs(y = 'Soolise võrdõiguslikkuse indeks (SVI)', x = 'Valdkonnad', title = 'Eesti ja Soome võrdlus') +
#   theme_minimal() + coord_flip()


soome_ja_eesti$Riik <- recode(soome_ja_eesti$Riik,
                              "Estonia" = "Eesti",
                              "Finland" = "Soome")

ggplot(soome_ja_eesti, aes(x = lyhend, y = Skoor, fill = Riik)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(y = 'Soolise võrdõiguslikkuse indeks (SVI)', x = 'Valdkonnad', fill = 'Riik') +
  scale_fill_manual(
    values = c("Eesti" = "#0072CE", "Soome" = "#F2B800"),
    labels = c("Eesti", "Soome")
  )

####sama asi rootsiga

rootsi_ja_eesti <- andmed_pikk_ilma_suurteta[andmed_pikk_ilma_suurteta$Riik %in% c('Estonia', 'Sweden'),]
rootsi_ja_eesti$Riik <- recode(rootsi_ja_eesti$Riik,
                              "Estonia" = "Eesti",
                              "Sweden" = "Rootsi")

ggplot(rootsi_ja_eesti, aes(x = lyhend, y = Skoor, fill = Riik)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(y = 'Soolise võrdõiguslikkuse indeks (SVI)', x = 'Valdkonnad', fill = 'Riik') +
  scale_fill_manual(
    values = c("Eesti" = "#0072CE", "Rootsi" = "#F2B800"),
    labels = c("Eesti", "Rootsi")
  )

### Eesti

#väiksed valdkonnad
eesti_vaiksed <- andmed_pikk_ilma_suurteta[andmed_pikk_ilma_suurteta$Riik %in% c('Estonia'),]
eesti_vaiksed$Riik <- recode(eesti_vaiksed$Riik,
                               "Estonia" = "Eesti")

ggplot(eesti_vaiksed, aes(x=lyhend,y=Skoor, fill = Riik)) + geom_col() + coord_flip() + 
  scale_fill_manual(values = c('Eesti' = '#0072CE')) +
  labs(y = 'Soolise võrdõiguslikkuse indeks (SVI)', x = 'Valdkonnad', fill = 'Riik',
       title = 'Eesti SVI trendid') + theme(legend.position = 'none')


#suured valdkonnad
andmed_pikk_suured <- andmed_pikk[(andmed_pikk$lyhend %in% c('Töö', 'Võim', 'Tervis', 'Muu', 'Aeg','Raha', 'Teadmised','Soolise võrdõiguslikkuse indeks')),]
eesti_suured <- andmed_pikk_suured[andmed_pikk_suured$Riik %in% c('Estonia'),]

eesti_suured$Riik <- recode(eesti_suured$Riik,
                             "Estonia" = "Eesti")

ggplot(eesti_suured, aes(x=lyhend,y=Skoor, fill = Riik)) + geom_col() + coord_flip() + 
  scale_fill_manual(values = c('Eesti' = '#0072CE')) +
  labs(y = 'Soolise võrdõiguslikkuse indeks (SVI)', x = 'Valdkonnad', fill = 'Riik',
       title = 'Eesti SVI trendid') + theme(legend.position = 'none')


#modeme tabelit
eesti_valdkonniti <- read.csv('andmestik/EE-valdkonniti.csv', encoding = 'UTF-8', sep =';')
eesti_valdkonniti_suured <- eesti_valdkonniti[eesti_valdkonniti$Sub.domain=='',]
colnames(eesti_valdkonniti_suured) <- gsub("^X", "", colnames(eesti_valdkonniti_suured))
colnames(eesti_valdkonniti_suured)[1] <- 'Valdkond'
eesti_valdkonniti_suured<-  eesti_valdkonniti_suured[,-2]

eesti_valdkonniti_suured <- eesti_valdkonniti_suured %>%
  mutate(Valdkond = case_when(
    Valdkond == 'Work' ~ 'Töö',
    Valdkond == 'Money' ~ 'Raha',
    Valdkond == 'Knowledge' ~ 'Teadmised',
    Valdkond == 'Time' ~ 'Aeg',
    Valdkond == 'Power' ~ 'Võim',
    Valdkond == 'Health' ~ 'Tervis',
    Valdkond == 'Index' ~ 'SVI'
  )) %>%
  mutate(Valdkond = factor(Valdkond, levels = c(
    'Töö',
    'Raha',
    'Teadmised',
    'Aeg',
    'Võim',
    'Tervis',
    'SVI'
  )))


eesti_valdkonniti_pikk <- eesti_valdkonniti_suured %>%
  pivot_longer(
    cols = -Valdkond,           
    names_to = "Aasta",
    values_to = "Indeks"
  ) %>% mutate(Aasta = as.integer(Aasta))


###trendid


ggplot(eesti_valdkonniti_pikk, aes(x = Aasta, y = Indeks, color = Valdkond, group = Valdkond)) +
  geom_line(size = 0.5) +
  geom_point(size = 2) +
  scale_x_continuous(breaks = c(2013, 2015, 2017, 2019, 2020, 2021, 2022, 2023, 2024)) +
  labs(title = "SVI läbi aastate (valdkonniti)",
       x = "Aasta", y = "Indeks", color = "Valdkond") +
  theme_minimal()


###palgalõhed
palgalõhe_eurostat <- read.csv('andmestik/eurostat-palgalohe.csv', encoding = 'UTF-8', sep =',')
palgalõhe_statamet <- read.csv('andmestik/statamet-palgalohe.csv', encoding = 'UTF-8', sep =',')
