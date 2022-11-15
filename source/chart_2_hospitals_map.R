source("../source/summary_info.R")
library(ggplot2)
library(tidyverse)

# Attempting to make choropleth map of hospital locations
state_shape <- map_data("state")

state_shape_w_data <- state_shape %>% 
  rename(STATE = region) %>% 
  mutate(across('STATE', str_replace, 'alabama', 'AL')) %>%  #1
  mutate(across('STATE', str_replace, 'arizona', 'AZ')) %>%  #2
  mutate(across('STATE', str_replace, 'arkansas', 'AK')) %>%  #3
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #4
  mutate(across('STATE', str_replace, 'colorado', 'CO')) %>%  #5
  mutate(across('STATE', str_replace, 'connecticut', 'CT')) %>%  #6
  mutate(across('STATE', str_replace, 'delaware', 'DE')) %>%  #7
  mutate(across('STATE', str_replace, 'district of columbia', 'DC')) %>%  #8
  mutate(across('STATE', str_replace, 'florida', 'FL')) %>%  #9
  mutate(across('STATE', str_replace, 'georgia', 'GA')) %>%  #10
  mutate(across('STATE', str_replace, 'idaho', 'ID')) %>%  #11
  mutate(across('STATE', str_replace, 'illinois', 'IL')) %>%  #12
  mutate(across('STATE', str_replace, 'indiana', 'IN')) %>%  #13
  mutate(across('STATE', str_replace, 'iowa', 'IA')) %>%  #14
  mutate(across('STATE', str_replace, 'kansas', 'KS')) %>%  #15
  mutate(across('STATE', str_replace, 'kentucky', 'KY')) %>%  #16
  mutate(across('STATE', str_replace, 'louisiana', 'LA')) %>%  #17
  mutate(across('STATE', str_replace, 'maine', 'ME')) %>%  #18
  mutate(across('STATE', str_replace, 'maryland', 'MD')) %>%  #19
  mutate(across('STATE', str_replace, 'massachusetts', 'MA')) %>%  #20
  mutate(across('STATE', str_replace, 'michigan', 'MI')) %>%  #21
  mutate(across('STATE', str_replace, 'minnesota', 'MN')) %>%  #22
  mutate(across('STATE', str_replace, 'mississippi', 'MS')) %>%  #23
  mutate(across('STATE', str_replace, 'missouri', 'MO')) %>%  #24
  mutate(across('STATE', str_replace, 'montana', 'MT')) %>%  #25
  mutate(across('STATE', str_replace, 'nebraska', 'NE')) %>%  #26
  mutate(across('STATE', str_replace, 'nevada', 'NV')) %>%  #27
  mutate(across('STATE', str_replace, 'new hampshire', 'NH')) %>%  #28
  mutate(across('STATE', str_replace, 'new jersey', 'NJ')) %>%  #29
  mutate(across('STATE', str_replace, 'new mexico', 'NM')) %>%  #30
  mutate(across('STATE', str_replace, 'new york', 'NY')) %>%  #31
  mutate(across('STATE', str_replace, 'north carolina', 'NC')) %>%  #32
  mutate(across('STATE', str_replace, 'north dakota', 'ND')) %>%  #33
  mutate(across('STATE', str_replace, 'ohio', 'OH')) %>%  #34
  mutate(across('STATE', str_replace, 'oklahoma', 'OK')) %>%  #35
  mutate(across('STATE', str_replace, 'oregon', 'OR')) %>%  #36
  mutate(across('STATE', str_replace, 'pennsylvania', 'PA')) %>%  #37
  mutate(across('STATE', str_replace, 'rhode island', 'RI')) %>%  #38
  mutate(across('STATE', str_replace, 'south carolina', 'SC')) %>%  #39
  mutate(across('STATE', str_replace, 'south dakota', 'SD')) %>%  #40
  mutate(across('STATE', str_replace, 'tennessee', 'TN')) %>%  #41
  mutate(across('STATE', str_replace, 'texas', 'TX')) %>%  #42
  mutate(across('STATE', str_replace, 'utah', 'UT')) %>%  #43
  mutate(across('STATE', str_replace, 'vermont', 'VT')) %>%  #44
  mutate(across('STATE', str_replace, 'virginia', 'VA')) %>%  #45
  mutate(across('STATE', str_replace, 'washington', 'WA')) %>%  #46
  mutate(across('STATE', str_replace, 'west virginia', 'west VA')) %>%  #47
  mutate(across('STATE', str_replace, 'wisconsin', 'WI')) %>%  #48
  mutate(across('STATE', str_replace, 'wyoming', 'WY')) %>%  #49
  left_join(hospital_info, by = "STATE")

blank_theme <- theme_bw()+
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
  )

hospitals_map <- ggplot(state_shape_w_data) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = open_hospitals),
    color = "black",
    size = .1
  ) + 
  coord_map()+
  scale_fill_continuous(low = "Red", high = "white") + 
  labs(fill = "Number of Open Hospitals") +
  blank_theme

