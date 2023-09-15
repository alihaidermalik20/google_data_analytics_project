library(dplyr)

# after downloading all the zip files, go to your downloads folder and get all the zip files
downloads_folder <- "C:/Users/HP/Downloads"
zip_files <- list.files(downloads_folder, pattern = ".zip")

# Ensure the "bike_trip_data" folder exists
if (!dir.exists("bike_trip_data")) {
  dir.create("bike_trip_data")
}

# Loop through the zip files, unzip them, and move the CSV files to "bike_trip_data" folder
for (zip_file in zip_files) {
  # Unzip the file into the "bike_trip_data" folder
  unzip(zip_file, exdir = "bike_trip_data")
}

# create a copy of your data in the appropriate folder
# Set the source folder path
source_folder <- "C:/Users/HP/Downloads/bike_trip_data"

# Set the destination folder path
destination_folder <- "C:/Users/HP/WorkDir/google_data_analytics_project"

# Copy the folder and its contents to the destination
file.copy(from = source_folder, to = destination_folder, recursive = TRUE)

data_folder <- "C:/Users/HP/WorkDir/google_data_analytics_project/bike_trip_data"

csv_files <- list.files(data_folder, pattern = ".csv")

data_frames <- list()

# List all CSV files in the folder
for (file in csv_files) {
  # Remove the ".csv" extension to get the dataset name
  dataset_name <- gsub(".csv", "", file)
  
  # Load the CSV file into RStudio as a dataset with the same name
  data_frames[[dataset_name]] <- read.csv(file.path(data_folder, file))
}

# Combine all data frames into one
merged_data <- bind_rows(data_frames)

# end_lat and end_lng has 5858 NA's for some reason
summary(`merged_data`)

# Define the path and filename for the output CSV file. Use the CSV file in Tableau for pivots and other analysis
output_file <- file.path(data_folder, "merged_data.csv")

# Save the merged data as a CSV file
write.csv(merged_data, file = output_file, row.names = FALSE)