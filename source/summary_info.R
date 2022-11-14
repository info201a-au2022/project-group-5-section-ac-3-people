maternal_mortality_race <- read.csv("../data/maternal_mortality_race.csv")
maternal_mortality_location <- read.csv("../data/maternal_mortality_urban_rural.csv")
us_hospital_locations <- read.csv("../data/us_hospital_locations.csv")
library(tidyverse)

# Returns a dataframe of the number of open hospitals in each state
open_hospitals_per_state <- us_hospital_locations %>% 
  group_by(STATE) %>% 
  filter(STATUS == "OPEN") %>% 
  count() %>% 
  arrange(STATE) %>% 
  summarise(
    open_hospitals = n
  )

# Finds a vector of unique values in the "OWNER" column to use in making hospital_owners_by_state
owner_types_vector <- us_hospital_locations %>% 
  distinct(OWNER) %>% 
  pull(OWNER)
## Returns 8 types: NOT AVAILABLE, PROPRIETARY, LIMITED LIABILITY COMPANY, NON-PROFIT, 
## GOVERNMENT - FEDERAL, GOVERNMENT - STATE, GOVERNMENT - DISTRICT/AUTHORITY, GOVERNMENT - LOCAL, 

# All of this code gives the df hospital_owners_by_state
 owner_not_available <- us_hospital_locations %>% 
   group_by(STATE) %>% 
   arrange(STATE) %>% 
   summarise(owner = OWNER == "NOT AVAILABLE") %>% 
   filter(owner == TRUE) %>% 
   count() %>% 
   summarise(owner_not_available = n)
 owner_proprietary <- us_hospital_locations %>% 
   group_by(STATE) %>% 
   arrange(STATE) %>% 
   summarise(owner = OWNER == "PROPRIETARY") %>% 
   filter(owner == TRUE) %>% 
   count() %>% 
   summarise(owner_proprietary = n)
 
 hospital_owners_by_state_a <- full_join(owner_not_available, owner_proprietary, by = "STATE")
 
 owner_llc <- us_hospital_locations %>% 
   group_by(STATE) %>% 
   arrange(STATE) %>% 
   summarise(owner = OWNER == "LIMITED LIABILITY COMPANY") %>% 
   filter(owner == TRUE) %>% 
   count() %>% 
   summarise(owner_llc = n)
 owner_nonprofit <- us_hospital_locations %>% 
   group_by(STATE) %>% 
   arrange(STATE) %>% 
   summarise(owner = OWNER == "NON-PROFIT") %>% 
   filter(owner == TRUE) %>% 
   count() %>% 
   summarise(owner_nonprofit = n)
 
 hospital_owners_by_state_b <- full_join(owner_llc, owner_nonprofit, by = "STATE")
 
 owner_fed_govt <- us_hospital_locations %>% 
   group_by(STATE) %>% 
   arrange(STATE) %>% 
   summarise(owner = OWNER == "GOVERNMENT - FEDERAL") %>% 
   filter(owner == TRUE) %>% 
   count() %>% 
   summarise(owner_fed_govt = n)
 owner_state_govt <- us_hospital_locations %>% 
   group_by(STATE) %>% 
   arrange(STATE) %>% 
   summarise(owner = OWNER == "GOVERNMENT - STATE") %>% 
   filter(owner == TRUE) %>% 
   count() %>% 
   summarise(owner_state_govt = n)
 
 hospital_owners_by_state_c <- full_join(fed_govt, state_govt, by = "STATE")
 
 owner_dist_govt <- us_hospital_locations %>% 
   group_by(STATE) %>% 
   arrange(STATE) %>% 
   summarise(owner = OWNER == "GOVERNMENT - DISTRICT/AUTHORITY") %>% 
   filter(owner == TRUE) %>% 
   count() %>% 
   summarise(owner_dist_govt = n)
 owner_local_govt <- us_hospital_locations %>% 
   group_by(STATE) %>% 
   arrange(STATE) %>% 
   summarise(owner = OWNER == "GOVERNMENT - LOCAL") %>% 
   filter(owner == TRUE) %>% 
   count() %>% 
   summarise(owner_local_govt = n)
 
 hospital_owners_by_state_d <- full_join(dist_govt, local_govt, by = "STATE")
 
 hospital_owners_by_state_e <- full_join(hospital_owners_by_state_a, hospital_owners_by_state_b, by = "STATE")
 hospital_owners_by_state_f <- full_join(hospital_owners_by_state_c, hospital_owners_by_state_d, by = "STATE")
 hospital_owners_by_state <- full_join(hospital_owners_by_state_e, hospital_owners_by_state_f, by = "STATE")
 ## Returns the dataframe hospital_owners_by_state
 
 # The following 
 
 