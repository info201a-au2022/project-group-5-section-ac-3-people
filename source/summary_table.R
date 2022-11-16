source("../source/summary_info.R")
library(tidyverse)

hospital_info <- hospital_info

# Table blurb: 
# We are interested in seeing how Race and location (within the USA) affect the maternal mortality rate. We will need more data to relate these variables, so for now we are finding patterns in the data we already have. This chart computes the number of hospitals in each US State, territory, and DC, as well as who owns these hospitals. The number of hospitals in each state is relevant because how many hospitals are available in an area is likely to affect the health outcome of the people in that state, such as maternal mortality. We also included who owns the hospitals in each state, because who owns and operates a hospital might affect the quality of care. 
