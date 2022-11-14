source("../source/summary_info.R")
source("../source/summary_table.R")
library(ggplot2)

# Makes a bar chart of the number of hospitals in each state using open_hospitals df (draft, NOT used in index.Rmd)
hospitals_per_state_chart <- ggplot(data = hospital_info) +
  geom_col(
    mapping = aes(x = STATE, y = open_hospitals)
  ) +
  scale_y_continuous()

# Makes a bar chart of number of hospitals in each state PLUS who owns them, included in index.Rmd!
hospitals_per_state_chart_w_owner <- ggplot(data = hospitals_per_state_chart_df) +
  geom_col(
    mapping = aes(x = STATE, y = num_hospitals, fill = owner)
  ) + 
  scale_y_continuous()