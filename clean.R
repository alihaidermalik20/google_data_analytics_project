# Load the required libraries
library(lubridate)
library(dplyr)

# Create a new column "ride_length" in the data frame
bike_data <- merged_data %>%
  mutate(
    started_at = ymd_hms(started_at), # Convert "started_at" to datetime
    ended_at = ymd_hms(ended_at),     # Convert "ended_at" to datetime
    ride_length = as.period(ended_at - started_at, unit = "second"), # Calculate ride length in seconds
    day_of_week = wday(started_at, label=TRUE)
  )

# Format the "ride_length" column as HH:MM:SS
bike_data$ride_length <- format(bike_data$ride_length, format = "%H:%M:%S")

# check the result
str(bike_data)