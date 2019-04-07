library(tidyverse)
library(lubridate)
library(janitor)
library(Cairo)
library(cowplot)

df1 <- read_csv("new-scenario-1-efficiency-tabledata.csv") %>% clean_names()
df1 <- df1 %>% mutate(date = make_date(2009, 1, 15) + months(tick),
                      irrigation_efficiency = ordered(irrigation_efficiency)) %>%
  group_by(run, tick, date, irrigation_efficiency) %>%
  summarize_all(mean) %>%
  ungroup() %>% filter(date > "2009-01-15")

df2 <- read_csv("new-scenario-2-price-elasticity-tabledata.csv") %>% clean_names()
df2 <- df2 %>% mutate(date = make_date(2009, 1, 15) + months(tick),
                      water_price_elasticity = ordered(water_price_elasticity)) %>%
  group_by(run, tick, date, water_price_elasticity) %>%
  summarize_all(mean) %>%
  ungroup() %>% filter(date > "2009-01-15") %>%
  arrange(desc(water_price_elasticity), run, date)

df1 %>% ggplot(aes(x = date, y = energy_output_this_month,
                   color = irrigation_efficiency,
                   group = run)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 180)) +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Irrigation Efficiency",
                        guide = "none") +
  labs(x = "Year", y = "Hydropower (MW)") +
  theme_bw(base_size = 20) -> p4_1a

df2 %>% ggplot(aes(x = date, y = energy_output_this_month,
                   color = water_price_elasticity,
                   group = -run)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 180)) +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Demand Elasticity",
                        guide = "none") +
  labs(x = "Year", y = "Hydropower (MW)") +
  theme_bw(base_size = 20) -> p4_2a

df1 %>% ggplot(aes(x = date, y = v_display, color = irrigation_efficiency,
                   group = run)) +
  geom_line() +
  scale_y_continuous(label = comma_format(), limits = c(0, 9.5E5)) +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Irrigation Efficiency",
                        guide = "none") +
  labs(x = "Year", y = "Storage (ML)") +
  theme_bw(base_size = 20) -> p4_1b

df2 %>% ggplot(aes(x = date, y = v_display, color = water_price_elasticity,
                   group = -run)) +
  geom_line() +
  scale_y_continuous(label = comma_format(), limits = c(0, 9.5E5)) +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Demand Elasticity",
                        guide = "none") +
  labs(x = "Year", y = "Storage (ML)") +
  theme_bw(base_size = 20) -> p4_2b


df1 %>% ggplot(aes(x = date, y = reduction_this_month,
                   color = irrigation_efficiency,
                   group = run)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 1)) +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Irrigation Efficiency") +
  labs(x = "Year", y = "Water Use Reduction") +
  theme_bw(base_size = 20) -> p4_1c

df2 %>% ggplot(aes(x = date, y = reduction_this_month,
                   color = water_price_elasticity,
                   group = -run)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 1)) +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Demand Elasticity") +
  labs(x = "Year", y = "Water Use Reduction") +
  theme_bw(base_size = 20) -> p4_2c

p4 <- plot_grid(p4_1a, p4_1b, p4_1c, p4_2a, p4_2b, p4_2c,
               labels = c("a", "b", "c", "d", "e", "f"),
               ncol = 3, rel_widths = c(1, 1, 1.5) )

ggsave("figure_4.pdf", p4, cairo_pdf, height = 8, width = 20, units = "in")


df1 %>% ggplot(aes(x = date, y = ag_allocation_this_month,
                   color = irrigation_efficiency,
                   group = run)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 38E3)) +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Irrigation Efficiency",
                        guide = "none") +
  labs(x = "Year", y = "Ag. Allocation (ML)") +
  theme_bw(base_size = 20) -> p5_1a

df2 %>% ggplot(aes(x = date, y = ag_allocation_this_month,
                   color = water_price_elasticity,
                   group = -run)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 38E3)) +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Demand Elasticity",
                        guide = "none") +
  labs(x = "Year", y = "Ag. Allocation (ML)") +
  theme_bw(base_size = 20) -> p5_2a


df1 %>% ggplot(aes(x = date, y = mu_allocation_this_month,
                   color = irrigation_efficiency,
                   group = run)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 38E3)) +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Irrigation Efficiency",
                        guide = "none") +
  labs(x = "Year", y = "Urban Allocation (ML)") +
  theme_bw(base_size = 20) -> p5_1b

df2 %>% ggplot(aes(x = date, y = mu_allocation_this_month,
                   color = water_price_elasticity,
                   group = -run)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 38E3)) +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Demand Elasticity",
                        guide = "none") +
  labs(x = "Year", y = "Urban Allocation (ML)") +
  theme_bw(base_size = 20) -> p5_2b

df1 %>% ggplot(aes(x = date, y = total_allocation_this_month,
                   color = irrigation_efficiency,
                   group = run)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 73E3)) +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Irrigation Efficiency") +
  labs(x = "Year", y = "Total Allocation (ML)") +
  theme_bw(base_size = 20) -> p5_1c

df2 %>% ggplot(aes(x = date, y = total_allocation_this_month,
                   color = water_price_elasticity,
                   group = -run)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 73E3)) +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Demand Elasticity") +
  labs(x = "Year", y = "Total Allocation (ML)") +
  theme_bw(base_size = 20) -> p5_2c

p5 <- plot_grid(p5_1a, p5_1b, p5_1c, p5_2a, p5_2b, p5_2c,
               labels = c("a", "b", "c", "d", "e", "f"),
               ncol = 3, rel_widths = c(1, 1, 1.5) )

ggsave("figure_5.pdf", p5, cairo_pdf, height = 8, width = 20, units = "in")

df2 %>% ggplot(aes(x = date, y = water_price_this_month,
               color = water_price_elasticity,
               group = -run)) +
  geom_line() +
  scale_color_viridis_d(option = "magma", end = 0.8, direction = -1,
                        name = "Demand Elasticity") +
  labs(x = "Year", y = "Water Price (R/kL)") +
  theme_bw(base_size = 20) -> p6

ggsave("s2-price.pdf", p6, cairo_pdf, height = 4, width = 8, units = "in")
