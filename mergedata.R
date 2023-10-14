dat_merge = read.csv("DonneesOuverte2022.csv")
library(tidyverse)
dat_merge = dat_merge %>% select(c("STARTSTATIONNAME","STARTSTATIONARRONDISSEMENT"))
dat = read.csv("bixi1.csv")
dat_mid = read.csv("2021_stations.csv")
dat_join = inner_join(dat_merge, dat_mid, by=c("STARTSTATIONNAME"="name"))
dat_join = dat_join %>% distinct(STARTSTATIONNAME, .keep_all = TRUE)
dat_join = dat_join %>% select(c("STARTSTATIONNAME","STARTSTATIONARRONDISSEMENT", "pk"))
dat_join = right_join(dat_join,dat, by=c("pk"="station"))
dat_full= dat_join %>% 
  rename(
    name = STARTSTATIONNAME,
    station = pk,
    arrond = STARTSTATIONARRONDISSEMENT
  )
dat_full <- dat_full %>%
  mutate(arrond = ifelse(is.na(arrond), "autres", arrond))
write.csv(dat_full, "bixifull.csv")
