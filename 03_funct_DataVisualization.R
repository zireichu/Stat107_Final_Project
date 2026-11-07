source("C:/Users/zirei/OneDrive/Documents/GitHub/Stat107_Final_Project/00_requirements.R")
load("C:/Users/zirei/OneDrive/Documents/GitHub/Stat107_Final_Project/22_DataSaving.RData")
head(state_summary)
head(state_analysis)
graduation_plot <- ggplot(
  four_year_data,
  aes(x = C150_4)
) +
  geom_histogram(
    bins = 30,
    fill = "steelblue",
    color = "white",
    na.rm = TRUE
  ) +
  labs(
    title = "Distribution of Four-Year University Graduation Rates",
    x = "Graduation Rate",
    y = "Number of Universities"
  ) +
  theme_minimal()
graduation_plot
ggsave(
  "C:/Users/zirei/OneDrive/Documents/GitHub/Stat107_Final_Project/31_GraduationHistogram.png",
  graduation_plot,
  width = 8,
  height = 5)
stem_plot <- ggplot(
  four_year_data,
  aes(x = STEM_SHARE)
) +
  geom_histogram(
    bins = 30,
    fill = "darkgreen",
    color = "white",
    na.rm = TRUE
  ) +
  geom_vline(
    xintercept = 0.50,
    linetype = "dashed",
    color = "red"
  ) +
  labs(
    title = "Distribution of STEM Degree Proportions",
    subtitle = "Red line represents the 50% STEM classification threshold",
    x = "Proportion of STEM Degrees",
    y = "Number of Universities"
  ) +
  theme_minimal()
stem_plot
ggsave(
  "C:/Users/zirei/OneDrive/Documents/GitHub/Stat107_Final_Project/32_STEMHistogram.png",
  stem_plot,
  width = 8,
  height = 5)
state_stem_plot <- ggplot(
  state_summary,
  aes(
    x = reorder(STABBR, STEM_PROPORTION),
    y = STEM_PROPORTION
  )
) +
  geom_col(
    fill = "steelblue"
  ) +
  geom_hline(
    yintercept = 0.40,
    linetype = "dashed",
    color = "red"
  ) +
  coord_flip() +
  labs(
    title = "Proportion of STEM-Focused Universities by State",
    subtitle = "Red line represents the 40% state classification threshold",
    x = "State",
    y = "Proportion of STEM-Focused Universities"
  ) +
  theme_minimal()
state_stem_plot
ggsave(
  "C:/Users/zirei/OneDrive/Documents/GitHub/Stat107_Final_Project/33_StateSTEMProportions.png",
  state_stem_plot,
  width = 9,
  height = 10)
graduation_boxplot <- ggplot(
  state_analysis,
  aes(
    x = STATE_GROUP,
    y = AVG_GRAD_RATE,
    fill = STATE_GROUP
  )
) +
  geom_boxplot(
    alpha = 0.7
  ) +
  geom_jitter(
    width = 0.15,
    alpha = 0.6
  ) +
  labs(
    title = "Average Graduation Rates by STEM University Group",
    x = "State STEM University Group",
    y = "Average State Graduation Rate"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none")
graduation_boxplot
ggsave(
  "C:/Users/zirei/OneDrive/Documents/GitHub/Stat107_Final_Project/34_GraduationBoxplot.png",
  graduation_boxplot,
  width = 8,
  height = 5)
relationship_plot <- ggplot(
  state_analysis,
  aes(
    x = STEM_PROPORTION,
    y = AVG_GRAD_RATE
  )
) +
  geom_point(
    size = 3,
    alpha = 0.7
  ) +
  geom_smooth(
    method = "lm",
    se = TRUE
  ) +
  geom_vline(
    xintercept = 0.40,
    linetype = "dashed",
    color = "red"
  ) +
  labs(
    title = "STEM University Concentration vs. Graduation Rates",
    x = "Proportion of STEM-Focused Universities",
    y = "Average State Graduation Rate"
  ) +
  theme_minimal()
relationship_plot
ggsave(
  "C:/Users/zirei/OneDrive/Documents/GitHub/Stat107_Final_Project/35_STEMGraduationScatterplot.png",
  relationship_plot,
  width = 8,
  height = 5)
group_statistics <- state_analysis %>%
  group_by(STATE_GROUP) %>%
  summarise(
    NUMBER_OF_STATES = n(),
    MEAN = mean(AVG_GRAD_RATE),
    MEDIAN = median(AVG_GRAD_RATE),
    STANDARD_DEVIATION = sd(AVG_GRAD_RATE),
    MINIMUM = min(AVG_GRAD_RATE),
    MAXIMUM = max(AVG_GRAD_RATE),
    .groups = "drop"  )
group_statistics
write_csv(
  group_statistics,
  "C:/Users/zirei/OneDrive/Documents/GitHub/Stat107_Final_Project/36_GroupStatistics.csv")

