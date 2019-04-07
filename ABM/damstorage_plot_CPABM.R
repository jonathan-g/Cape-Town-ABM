# setwd("~/Desktop/2019 Spring/CapeTownABM/DATA")
library(tidyverse)
library(lubridate)
library(janitor)
library(cairo)

df = read_csv("Monthly_urban_agriculture_water_use.csv") %>%
  clean_names() %>%
  mutate(date = make_date(year, month, day = 15)) %>%
  select(date, dam_storage, urban, ag) %>%
  gather(-date, key = category, value = quantity) %>%
  mutate(category = ordered(category,
                            levels = c("dam_storage", "urban", "ag"),
                            labels = c("Dam Storage (ML)",
                                       "Urban Consumption (ML/day)",
                                       "Agricultural Consumption (ML/day")))

p <- ggplot(df, aes(x = date, y = quantity)) +
  geom_line(size = 0.5) +
  facet_wrap(~category, ncol = 1, scale = "free_y") +
  scale_y_continuous(labels = scales::comma_format()) +
  labs(x = "Year", y = NULL) +
  theme_bw(base_size = 10)+
  theme(strip.background = element_rect(color = "black", fill = "white"))

plot(p)

ggsave("reservoir_storage.pdf", device = cairo_pdf, width = 6, height = 4,
       units = "in")
