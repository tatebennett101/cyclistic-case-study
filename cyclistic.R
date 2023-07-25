library(tidyverse)
library(lubridate)
library(ggplot2)
library(dplyr)
library(magrittr)
library(janitor)
library(tidyr)

tripdata_2022_07 <- read.csv("202207-divvy-tripdata.csv")
tripdata_2022_08 <- read.csv("202208-divvy-tripdata.csv")
tripdata_2022_09 <- read.csv("202209-divvy-publictripdata.csv")
tripdata_2022_10 <- read.csv("202210-divvy-tripdata.csv")
tripdata_2022_11 <- read.csv("202211-divvy-tripdata.csv")
tripdata_2022_12 <- read.csv("202212-divvy-tripdata.csv")
tripdata_2023_01 <- read.csv("202301-divvy-tripdata.csv")
tripdata_2023_02 <- read.csv("202302-divvy-tripdata.csv")
tripdata_2023_03 <- read.csv("202303-divvy-tripdata.csv")
tripdata_2023_04 <- read.csv("202304-divvy-tripdata.csv")
tripdata_2023_05 <- read.csv("202305-divvy-tripdata.csv")
tripdata_2023_06 <- read.csv("202306-divvy-tripdata.csv")


## combine all the CSV files into 1
tripdata_pastyear <- rbind(tripdata_2022_07, tripdata_2022_08, tripdata_2022_09, tripdata_2022_10,
                           tripdata_2022_11, tripdata_2022_12, tripdata_2023_01, tripdata_2023_02,
                           tripdata_2023_03, tripdata_2023_04, tripdata_2023_05, tripdata_2023_06)

## confirm total rows
rowtotal <- sum(nrow(tripdata_2022_07), nrow(tripdata_2022_08), nrow(tripdata_2022_09), nrow(tripdata_2022_10),
                nrow(tripdata_2022_11), nrow(tripdata_2022_12), nrow(tripdata_2023_01), nrow(tripdata_2023_02),
                nrow(tripdata_2023_03), nrow(tripdata_2023_04), nrow(tripdata_2023_05), nrow(tripdata_2023_06))
rowtotal

print(nrow(tripdata_pastyear))


head(tripdata_pastyear)

## change formatting
tripdata_pastyear$date <- as.Date(tripdata_pastyear$started_at)
tripdata_pastyear$month <- format(as.Date(tripdata_pastyear$date), "%b")
tripdata_pastyear$day <- format(as.Date(tripdata_pastyear$date), "%d")
tripdata_pastyear$year <- format(as.Date(tripdata_pastyear$date), "%y")

## make columns for day of week and ride length
tripdata_pastyear <- tripdata_pastyear %>% 
mutate(dow = weekdays(as.Date(tripdata_pastyear$started_at))) %>%
mutate(ride_length = (ended_at - started_at) / 60, unit = "mins")

## remove blanks and duplicates
tripdata_pastyear <- tripdata_pastyear %>% clean_names() %>% unique()
tripdata_pastyear <- drop_na(tripdata_pastyear)

## filter out rides with time < 0
tripdata_pastyear <- tripdata_pastyear %>% filter(ride_length > 0)

## write to a new csv to save the cleaned one
write_csv(tripdata_pastyear, "pastyear-divvy-tripdata.csv")
tripdata_pastyear <- read_csv("pastyear-divvy-tripdata.csv")

## see how many members vs. casual riders there are
typetotal <- table(tripdata_pastyear$member_casual)
view(typetotal)

## compare casual users and members' ride stats
aggregate(tripdata_pastyear$ride_length ~ tripdata_pastyear$member_casual, FUN = mean)
aggregate(tripdata_pastyear$ride_length ~ tripdata_pastyear$member_casual, FUN = median)
aggregate(tripdata_pastyear$ride_length ~ tripdata_pastyear$member_casual, FUN = max)
aggregate(tripdata_pastyear$ride_length ~ tripdata_pastyear$member_casual, FUN = min)

## sort by days of the week, then view the average ride time by each day for member vs. casual
tripdata_pastyear$dow <- ordered(tripdata_pastyear$dow, levels = c("Sunday", "Monday", "Tuesday", "Wednesday",
                                                                   "Thursday", "Friday", "Saturday"))
aggregate(tripdata_pastyear$ride_length ~ tripdata_pastyear$member_casual + tripdata_pastyear$dow, FUN = mean)

## determine the day on which most rides are taken generally (the mode; found the function on tutorialspoint.com)
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

mode_wkdy <- getmode(tripdata_pastyear$dow)
mode_wkdy

## view average ride lengths per day by type of rider
tripdata_pastyear$dow <- ordered(tripdata_pastyear$dow, levels = c("Monday", "Tuesday", "Wednesday", "Thursday",
                                                                   "Friday", "Saturday", "Sunday"))
tripdata_pastyear %>% group_by(member_casual, dow) %>% summarize(typetotal = n(), average_ride_length = mean(ride_length)) %>%
  arrange(member_casual, dow)

## determine the most popular stations for casual vs. member
tripdata_pastyear %>% group_by(member_casual, start_station_name) %>% summarize(number_of_starts = n()) %>%
  filter(start_station_name != "") %>% arrange(- number_of_starts, member_casual)

## view number of rides per day for each user type
tripdata_pastyear %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>% group_by(member_casual, weekday) %>%
  summarize(number_of_rides = n(), average_duration = mean(ride_length)) %>% arrange(member_casual, weekday)

## create a graph of average duration of rides by user type
tripdata_pastyear %>% mutate(weekday = wday(started_at, label = TRUE)) %>% group_by(member_casual, weekday) %>%
  summarize(number_of_rides = n(), average_duration = mean(ride_length)) %>% arrange(member_casual, weekday) %>%
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) + geom_col(position = "dodge")

## graphs for each day of the week in terms of ride duration
tripdata_pastyear$start_hour <- format(as.POSIXct(tripdata_pastyear$started_at), '%H')
ggplot(data = tripdata_pastyear) + aes(x = start_hour, fill = member_casual) + facet_wrap(~dow) + geom_bar() +
  labs(x = "Start hour", y = "# of rides", fill = "Member type") + theme(axis.text = element_text(size = 5))
                             
## create separate CSVs for further analysis
weekly_summary <- tripdata_pastyear %>% mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>% summarize(number_of_rides = n(), average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday)
write_csv(weekly_summary, "weekly_ride_lengths.csv")
monthly_summary <- tripdata_pastyear %>% mutate(month = month(started_at, label = TRUE)) %>%
  group_by(member_casual, month) %>% summarize(number_of_rides = n(), average_duration = mean(ride_length)) %>%
  arrange(member_casual, month)
write_csv(monthly_summary, "monthly_ride_lengths.csv")
