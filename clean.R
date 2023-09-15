# Load the required libraries
library(lubridate)
library(dplyr)

# Create a new column "ride_length" in the data frame
bike_data <- merged_data %>%
  mutate(
    started_at = ymd_hms(started_at), # Convert "started_at" to datetime
    ended_at = ymd_hms(ended_at),     # Convert "ended_at" to datetime
    ride_length = as.period(ended_at - started_at, unit = "second") # Calculate ride length in seconds
  )

# Format the "ride_length" column as HH:MM:SS
bike_data$ride_length <- format(bike_data$ride_length, format = "%H:%M:%S")

bike_data$day_of_week <- as.numeric(weekdays(your_data_frame$started_at))

# Adjust the numeric representation to match your specification (1 = Sunday, 7 = Saturday)
bike_data$day_of_week <- ifelse(your_data_frame$day_of_week == 1, 6, your_data_frame$day_of_week - 1)

# check the result
str(bike_data)