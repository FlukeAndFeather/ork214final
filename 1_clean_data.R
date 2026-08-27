# This code takes data from 4 stream data sets, combines them, and summarizes
#key nutrients with a 9-week moving average

library(tidyverse)
source("R/moving-average.R")

# Read in the source data files
Q1_data <- read_csv("data/QuebradaCuenca1-Bisley.csv")
Q2_data <- read_csv("data/QuebradaCuenca2-Bisley.csv")
Q3_data <- read_csv("data/QuebradaCuenca3-Bisley.csv")
PRM_data <- read_csv("data/RioMameyesPuenteRoto.csv")

#Simplify each file to the target date range (1988 - 1995)
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

#Fit each dataframe with a 9-week moving average for each key nutrient
Q1_moving_average <- moving_average(Q1_simple)
Q2_moving_average <- moving_average(Q2_simple)
Q3_moving_average <- moving_average(Q3_simple)
PRM_moving_average <- moving_average(PRM_simple)

#Combine them into one dataframe
four_stream_avg <- bind_rows(list(
  Q1_moving_average,
  Q2_moving_average,
  Q3_moving_average,
  PRM_moving_average
))

#Pivot longer to facilitate analysis
four_stream_avg_long <- four_stream_avg |>
  pivot_longer(
    cols = c(k_mgl, mg_mgl, ca_mgl, nh4_n_ugl, no3_n_ugl),
    names_to = "Nutrient",
    values_to = "Concentration"
  ) |>
  arrange(window_start, sample_id, Nutrient)

#Convert to a csv
write_csv(four_stream_avg_long, "output/four_stream_avg_long.csv", na = "NaN")
