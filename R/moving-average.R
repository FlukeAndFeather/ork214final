library(tidyverse)
# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(streamdata) {
  # Initialize a tibble to contain the results
  result <- tibble(
    window_start = seq(
      ymd(min(streamdata$Sample_Date)),
      ymd(max(streamdata$Sample_Date)),
      by = "9 weeks"
    ),
    sample_id = NA,
    k_mgl = NA,
    mg_mgl = NA,
    ca_mgl = NA,
    no3_n_ugl = NA,
    nh4_n_ugl = NA
  )

  # Iterator and sequence
  for (i in 1:nrow(result)) {
    # Variables for the start and end of the current window for the moving average
    w1 <- result$window_start[i]
    w2 <- w1 + weeks(9)
    # A logical vector, called "in_window", that says which samples are inside the window
    # It compares sample dates to the start and end of the window
    in_window <- streamdata$Sample_Date >= w1 & streamdata$Sample_Date < w2

    # Indexing pulls out the ion concentrations for the dates that fall inside the window
    k_window <- streamdata$K[in_window]
    mg_window <- streamdata$Mg[in_window]
    ca_window <- streamdata$Ca[in_window]
    no3_n_window <- streamdata$`NO3-N`[in_window]
    nh4_n_window <- streamdata$`NH4-N`[in_window]

    # Calculates the mean of each ion concentration and fill in the result tiblle
    result$k_mgl[i] <- mean(k_window, na.rm = TRUE)
    result$mg_mgl[i] <- mean(mg_window, na.rm = TRUE)
    result$ca_mgl[i] <- mean(ca_window, na.rm = TRUE)
    result$no3_n_ugl[i] <- mean(no3_n_window, na.rm = TRUE)
    result$nh4_n_ugl[i] <- mean(nh4_n_window, na.rm = TRUE)
    result$sample_id[i] <- streamdata$Sample_ID[i]
  }

  # Returns the result tibble
  return(result)
}
