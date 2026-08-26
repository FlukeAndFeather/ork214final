library(tidyverse)
source("R/moving-average.R")

#Read in the data
Q1_data <- read_csv("data/QuebradaCuenca1-Bisley.csv")
Q2_data <- read_csv("data/QuebradaCuenca2-Bisley.csv")
Q3_data <- read_csv("data/QuebradaCuenca3-Bisley.csv")
PRM_data <- read_csv("data/RioMameyesPuenteRoto.csv")
random_change <- "This is to confuse you"

#Cut out the extra stuff
Q1_simple <- Q1_data |> 
  select(Sample_ID, Sample_Date, K, Mg, Ca, `NH4-N`, `NO3-N`) |> 
  filter(year(ymd(Sample_Date)) >= 1988 & year(ymd(Sample_Date)) < 1995)
Q2_simple <- Q2_data |> 
  select(Sample_ID, Sample_Date, K, Mg, Ca, `NH4-N`, `NO3-N`)|> 
  filter(year(ymd(Sample_Date)) >= 1988 & year(ymd(Sample_Date)) < 1995)
Q3_simple <- Q3_data |> 
  select(Sample_ID, Sample_Date, K, Mg, Ca, `NH4-N`, `NO3-N`) |> 
  filter(year(ymd(Sample_Date)) >= 1988 & year(ymd(Sample_Date)) < 1995)
PRM_simple <- PRM_data |> 
  select(Sample_ID, Sample_Date, K, Mg, Ca, `NH4-N`, `NO3-N`)|> 
  filter(year(ymd(Sample_Date)) >= 1988 & year(ymd(Sample_Date)) < 1995)
random_variable <- "This is to confuse you even more"

#Combine them!
all_together <- bind_rows(list(Q1_simple, Q2_simple, Q3_simple, PRM_simple))

#Reformat
all_longer <- all_together |> 
  pivot_longer(
    cols = c(K, Mg, Ca,`NH4-N`, `NO3-N`), 
    names_to = "Nutrient", 
    values_to = "Concentration")


#Let's see the plot without moving averages
ggplot(data = all_together,
  mapping = aes (x = Sample_Date, y = K, color = Sample_ID)
) + geom_point()

ggplot(data = all_longer,
  mapping = aes (x = Sample_Date, y = Concentration, color = Nutrient)
) + geom_point() + facet_wrap(~Sample_ID)



#Testing the moving average function
Q1_moving_average <- moving_average(Q1_simple)

#Pivot it longer
 Q1_avg_pivot <- Q1_move_avg |> pivot_longer(
    cols = c(K, Mg, Ca,NH4_N, NO3_N), 
    names_to = "Nutrient", 
    values_to = "Concentration")

#Moving average plot
ggplot(data = Q1_avg_pivot,
mapping = aes(x = window_start, y = Concentration, color = Nutrient)) + geom_point() +
  geom_line() + scale_x_continuous(name = "Date") + scale_y_continuous(name = "Concentration (mg/L)")
