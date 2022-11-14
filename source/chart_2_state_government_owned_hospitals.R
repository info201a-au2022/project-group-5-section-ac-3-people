library(ggplot2)
library(tidyverse)
# Making state/owned by state gov't data frame
view(hospital_owners_by_state)
state_gov_hospitals <- data.frame(hospital_owners_by_state$STATE, hospital_owners_by_state$owner_state_govt)
view(state_gov_hospitals)
state_gov_hospitals <- state_gov_hospitals %>% 
  rename(region = state)
state_gov_hospitals <- state_gov_hospitals %>% 
  rename(owned_by_state_govt = hospital_owners_by_state.owner_state_govt)
view(state_gov_hospitals)
