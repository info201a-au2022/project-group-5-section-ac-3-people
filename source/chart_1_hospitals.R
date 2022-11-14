source("../source/summary_info.R")
source("../source/summary_table.R")
library(ggplot2)

# Make a bar chart of the number of hospitals in each state and who owns them
hospitals_per_state_chart <- ggplot(data = hospital_info) +
  geom_col(
    mapping = aes(x = STATE, y = open_hospitals)
  ) +
  scale_y_continuous()


