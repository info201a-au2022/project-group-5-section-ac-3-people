source("../source/summary_info.R")
library(tidyverse)

hospital_info <- full_join(open_hospitals_per_state, hospital_owners_by_state)

