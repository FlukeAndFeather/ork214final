library(tidyverse)


#Read in the data
Q1_data <- read_csv("data/QuebradaCuenca1-Bisley.csv")
Q2_data <- read_csv("data/QuebradaCuenca2-Bisley.csv")
Q3_data <- read_csv("data/QuebradaCuenca3-Bisley.csv")
PRM_data <- read_csv("data/RioMameyesPuenteRoto.csv")

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



#Make the tibble
#Somehow we need to add in the Sample_ID
Q1_move_avg <- tibble(
  window_start = seq(ymd(min(Q1_simple$Sample_Date)), ymd(max(Q1_simple$Sample_Date)), by = "9 weeks"),
  Sample_ID = NA,
  K = NA,
  Mg = NA,
  Ca = NA,
  NO3_N = NA,
  NH4_N = NA
)

#Load in the moving average
for (i in 1:nrow(Q1_move_avg)) {
  window_start <- Q1_move_avg$window_start[i]
  window_end <- window_start + weeks(9)
  print(window_start)
  print(window_end)
  #Create variables!
  k_mean <- mean(Q1_simple$K[Q1_simple$Sample_Date >= window_start & Q1_simple$Sample_Date < window_end], na.rm = TRUE)
  mg_mean <- mean(Q1_simple$Mg[Q1_simple$Sample_Date >= window_start & Q1_simple$Sample_Date < window_end], na.rm = TRUE)
  ca_mean <- mean(Q1_simple$Ca[Q1_simple$Sample_Date >= window_start & Q1_simple$Sample_Date < window_end], na.rm = TRUE)
  NO3_N_mean <- mean(Q1_simple$`NO3-N`[Q1_simple$Sample_Date >= window_start & Q1_simple$Sample_Date < window_end], na.rm = TRUE)
  NH4_N_mean <- mean(Q1_simple$`NH4-N`[Q1_simple$Sample_Date >= window_start & Q1_simple$Sample_Date < window_end], na.rm = TRUE)
  Q1_move_avg$Sample_ID <- Q1_simple$Sample_ID[i]
  Q1_move_avg$K[i] <-  k_mean
  Q1_move_avg$Mg[i] <-  mg_mean
  Q1_move_avg$Ca[i] <-  ca_mean
  Q1_move_avg$NO3_N[i] <-  NO3_N_mean
  Q1_move_avg$NH4_N[i] <-  NH4_N_mean
}

#Pivot it longer
 Q1_avg_pivot <- Q1_move_avg |> pivot_longer(
    cols = c(K, Mg, Ca,NH4_N, NO3_N), 
    names_to = "Nutrient", 
    values_to = "Concentration")

#Moving average plot
ggplot(data = Q1_avg_pivot,
mapping = aes(x = window_start, y = Concentration, color = Nutrient)) + geom_point() +
  geom_line() + scale_x_continuous(name = "Date") + scale_y_continuous(name = "Concentration (mg/L)")
