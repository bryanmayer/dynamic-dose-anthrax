# Turn the confusing wide format into a wide tidy format

library(tidyverse)

brachman_data_raw = read.delim("Brachman_anthrax_data_raw.txt",sep='\t',header=T)
brachman_data_raw$days = 1:nrow(brachman_data_raw)

brachman_data = plyr::ldply(1:3, function(run){
  out = brachman_data_raw %>% select(days, ends_with(as.character(run))) %>%
    mutate(run = paste("Run", run +2))
  names(out) <- gsub(run, "", names(out))
  out %>%
    rename(exposure=Exp, death_all = DeathOutcome, death_anthrax = AnthraxDeath, total_monkeys = Total)
})

write_csv(brachman_data, "Brachman_anthrax_data.csv")
