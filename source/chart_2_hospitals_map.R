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
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #6
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #7
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #8
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #9
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #10
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #11
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #12
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #13
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #14
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #15
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #16
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #17
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #18
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #19
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #20
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #21
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #22
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #23
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #24
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #25
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #26
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #27
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #28
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #29
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #30
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #31
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #32
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #33
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #34
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #35
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #36
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #37
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #38
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #39
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #40
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #41
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #42
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #43
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #44
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #45
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #46
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #47
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #48
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%  #49
  mutate(across('STATE', str_replace, 'california', 'CA')) %>%   #50
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