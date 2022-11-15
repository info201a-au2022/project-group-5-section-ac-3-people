source("../source/summary_info.R")
library(ggplot2)

# You can use either of these dataframes to make a boxplot or violin plot
maternal_mortality_race_df

maternal_mortality_by_race_chart <- ggplot(data = maternal_mortality_race_df) +
  geom_col(mapping = aes(x = pregnancy_related_mortality_ratio, y = race_ethnicity))
           