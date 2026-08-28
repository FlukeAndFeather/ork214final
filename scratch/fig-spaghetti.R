library(tidyverse)
source("R/moving-average.R")

#Read in the data
Q1_data <- read_csv("data/QuebradaCuenca1-Bisley.csv")
Q2_data <- read_csv("data/QuebradaCuenca2-Bisley.csv")
Q3_data <- read_csv("data/QuebradaCuenca3-Bisley.csv")
PRM_data <- read_csv("data/RioMameyesPuenteRoto.csv")
random_change <- "This is to confuse you" #And to force a merge conflict

#Cut out the extra stuff
Q1_simple <- Q1_data |>
  select(Sample_ID, Sample_Date, K, Mg, Ca, `NH4-N`, `NO3-N`) |>
  filter(year(ymd(Sample_Date)) >= 1988 & year(ymd(Sample_Date)) < 1995)
Q2_simple <- Q2_data |>
  select(Sample_ID, Sample_Date, K, Mg, Ca, `NH4-N`, `NO3-N`) |>
  filter(year(ymd(Sample_Date)) >= 1988 & year(ymd(Sample_Date)) < 1995)
Q3_simple <- Q3_data |>
  select(Sample_ID, Sample_Date, K, Mg, Ca, `NH4-N`, `NO3-N`) |>
  filter(year(ymd(Sample_Date)) >= 1988 & year(ymd(Sample_Date)) < 1995)
PRM_simple <- PRM_data |>
  select(Sample_ID, Sample_Date, K, Mg, Ca, `NH4-N`, `NO3-N`) |>
  filter(year(ymd(Sample_Date)) >= 1988 & year(ymd(Sample_Date)) < 1995)
random_variable <- "This is to confuse you even more"

#Combine them!
all_together <- bind_rows(list(Q1_simple, Q2_simple, Q3_simple, PRM_simple))

#Reformat
all_longer <- all_together |>
  pivot_longer(
    cols = c(K, Mg, Ca, `NH4-N`, `NO3-N`),
    names_to = "Nutrient",
    values_to = "Concentration"
  )


#Let's see the plot without moving averages
ggplot(
  data = all_together,
  mapping = aes(x = Sample_Date, y = K, color = Sample_ID)
) +
  geom_point()

ggplot(
  data = all_longer,
  mapping = aes(x = Sample_Date, y = Concentration, color = Nutrient)
) +
  geom_point() +
  facet_wrap(~Sample_ID)


#Testing the moving average function
Q1_moving_average <- moving_average(Q1_simple)
Q2_moving_average <- moving_average(Q2_simple)
Q3_moving_average <- moving_average(Q3_simple)
PRM_moving_average <- moving_average(PRM_simple)

#Combine them!
all_together <- bind_rows(list(
  Q1_moving_average,
  Q2_moving_average,
  Q3_moving_average,
  PRM_moving_average
))

#Pivot it longer
all_together_pivot <- all_together |>
  pivot_longer(
    cols = c(k_mgl, mg_mgl, ca_mgl, nh4_n_ugl, no3_n_ugl),
    names_to = "Nutrient",
    values_to = "Concentration"
  )

#Plot the big one
ggplot(
  data = all_together_pivot,
  mapping = aes(x = ymd(window_start), y = Concentration, color = sample_id)
) +
  geom_point() +
  geom_line() +
  facet_wrap(~Nutrient) +
  scale_x_continuous(name = "Date") +
  scale_y_continuous(name = "Concentration")


#Pivot it longer
Q1_avg_pivot <- Q1_moving_average |>
  pivot_longer(
    cols = c(k_mgl, mg_mgl, ca_mgl, nh4_n_ugl, no3_n_ugl),
    names_to = "Nutrient",
    values_to = "Concentration"
  )

#Moving average plot
ggplot(
  data = Q1_avg_pivot,
  mapping = aes(x = window_start, y = Concentration, color = Nutrient)
) +
  geom_point() +
  geom_line() +
  scale_x_continuous(name = "Date") +
  scale_y_continuous(name = "Concentration (mg/L)")


four_stream_avg_plot <- read_csv("output/four_stream_avg_long.csv")
#four_stream_avg_plot <- read_csv(../output/four_stream_avg_long.csv)
nutrient_labels <- c(
  k_mgl = "K mg/L",
  ca_mgl = "Ca mg/L",
  mg_mgl = "Mg mg/L",
  nh4_n_ugl = "NH4-N ug/L",
  no3_n_ugl = "NO3-N ug/L"
)
ggplot(
  data = four_stream_avg_long,
  mapping = aes(
    x = window_start,
    y = Concentration,
    color = sample_id,
    linetype = sample_id
  )
) +
  geom_line() +
  facet_grid(
    Nutrient ~ .,
    scales = "free",
    switch = "y",
    labeller = labeller(Nutrient = nutrient_labels),
    axes = "all",
    axis.labels = "all_y",
  ) +
  labs(color = "Site", linetype = "Site") +
  scale_y_continuous(name = "Concentration") +
  scale_x_date(name = "Year") +
  geom_vline(xintercept = as.Date("1989-09-01"), linetype = "dashed") +
  theme(
    panel.background = element_blank(),
    strip.background = element_blank(),
    strip.placement = "outside",
    axis.ticks = element_line(color = "black"),
    axis.minor.ticks.x.top = element_line(),
    axis.minor.ticks.x.bottom = element_line(),
    axis.minor.ticks.y.left = element_line(),
    axis.line = element_line(color = "black")
  )
