library(tidyverse)
library(ggplot2)
library(dplyr)

# task I
df <- read.csv("cleaned_covid_data.csv")

# task II
A_states <- df %>% filter(grepl("^A", Province_State, ignore.case = TRUE))

# task III
A_states$Last_Update <- as.Date(A_states$Last_Update)

ggplot(A_states, aes(x=Last_Update, y=Deaths)) + 
  geom_point() +
  geom_smooth(method="loess", se=FALSE) +
  facet_wrap(~Province_State, scales="free_y") +
  labs(title="Deaths over Time for A-States",
       x="Date",
       y="Deaths") +
  theme_minimal()

# task IV
state_max_fatality_rate <- df %>%
  group_by(Province_State) %>%
  summarise(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio, na.rm = TRUE)) %>%
  arrange(desc(Maximum_Fatality_Ratio))  

# task V
state_max_fatality_rate$Province_State <- 
  factor(
    state_max_fatality_rate$Province_State, 
    levels = state_max_fatality_rate$Province_State)

ggplot(state_max_fatality_rate, aes(x = Province_State, y = Maximum_Fatality_Ratio)) +
  geom_bar(stat = "identity", fill = "orange") +
  labs(title = "Maximum Fatality Ratio by State",
       x = "Province_State",
       y = "Maximum_Fatality_Ratio") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))


# task VI
df$Last_Update <- as.Date(df$Last_Update)

cumulative_deaths <- df%>%
  group_by(Last_Update) %>%
  summarise(Cumulative_Deaths = sum(Deaths, na.rm=TRUE))

ggplot(cumulative_deaths, aes(x = Last_Update, y = Cumulative_Deaths)) +
  geom_line(color = "blue") +
  labs(title = "Cumulative Deaths for the Entire US Over Time",
       x = "Date",
       y = "Cumulative Deaths") +
  theme_minimal()


