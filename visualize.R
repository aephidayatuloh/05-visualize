library(ggplot2)
library(dplyr)

mpg

qplot(x = manufacturer, data = mpg, geom = "bar")

# Barplot

ggplot(data = mpg, mapping = aes(x = class)) +
  geom_bar()

ggplot(data = mpg, 
       mapping = aes(x = reorder(class, class, function(x){-length(x)}))) +
  geom_bar()

sum_tbl <- as.data.frame(table(mpg$class, 
                               dnn = list("class")), 
                         responseName = "n")

ggplot(data = sum_tbl, 
       mapping = aes(x = class, y = n)) +
  geom_bar(stat = "identity")

ggplot(data = sum_tbl, 
       mapping = aes(x = reorder(class, -n), y = n)) +
  geom_bar(stat = "identity")


# mengurutkan barplot berdasarkan value
# # 1. Buat dulu tabel frekuensi dari kategori yang diinginkan
# # 2. gunakan fungsi reorder() pada aestethic x dan n sbg y
# # 3. gunakan stat = "identity" pada geom_bar()

ggplot(data = sum_tbl, 
       mapping = aes(x = reorder(class, -n), y = n)) +
  geom_bar(stat = "identity", fill = "lightblue")

ggplot(data = sum_tbl, mapping = aes(x = reorder(class, n), y = n)) +
  geom_bar(stat = "identity", fill = "lightblue") +
  coord_flip()


# Histogram & Density

ggplot(mpg, aes(x = displ, fill = class)) +
  geom_histogram()

ggplot(mpg, aes(x = displ)) +
  geom_histogram(bins = 20, fill = "skyblue", color = "white")

ggplot(mpg, aes(x = displ)) +
  geom_histogram(aes(y = ..density..), bins = 20, fill = "skyblue", color = "white")

ggplot(mpg, aes(x = displ)) +
  geom_density(fill = "skyblue", 
               alpha = 0.8)

ggplot(mpg, aes(x = displ, fill = class, color = class)) +
  geom_density(alpha = 0.8)

# Boxplot

ggplot(data = mpg, mapping = aes(x = "", y = displ)) +
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = displ, fill = class)) +
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = displ, fill = class)) +
  geom_boxplot() +
  coord_flip() +
  theme(legend.position = "none")

# https://ggplot2.tidyverse.org/reference/geom_boxplot.html


# Scatter plot

ggplot(mpg, aes(x = displ, y = cty)) + 
  geom_point()

ggplot(mpg, aes(x = displ, y = cty, color = class)) + 
  geom_point()


# Line plot/time series plot

USAccDeaths

dt_times <- data.frame(
  dates = seq.Date(from = as.Date("1973-01-01"), 
                   to = as.Date("1978-12-01"), 
                   by = "month"),
  accidents = as.vector(USAccDeaths)
)

dt_times <- subset(dt_times, dates >= as.Date("1978-01-01"))

ggplot(dt_times, aes(x = dates, y = accidents)) + 
  geom_line()

ggplot(dt_times, aes(x = dates, y = accidents)) + 
  geom_line(size = 1, color = "skyblue")

ggplot(dt_times, aes(x = dates, y = accidents)) + 
  geom_line(color = "skyblue") +
  geom_point() +
  scale_x_date(breaks = "month", date_labels = "%b-%y") 


# Facet

ggplot(mpg, aes(x = displ, fill = class, color = class)) +
  geom_density(alpha = 0.8) +
  facet_wrap(facets = vars(class)) 

# Annotation
ggplot(mpg, aes(x = displ, fill = class, color = class)) +
  geom_density(alpha = 0.8) +
  labs(title = "Density Chart of Engine Displacement",
       x = "Engine Displacement (litres)", y = "Density",
       fill = "Car Type", color = "Car Type")

# Theme
g <- ggplot(mpg, aes(x = displ, fill = class, color = class)) +
  geom_density(alpha = 0.8) +
  labs(title = "Density Chart of Engine Displacement",
       x = "Engine Displacement (litres)", y = "Density",
       fill = "Car Type", color = "Car Type")
g +
  theme_bw()
g +
  theme_minimal()

g +
  theme_minimal() +
  theme(legend.position = "none",
        panel.grid.minor = element_blank())

ggsave("plotR.jpg")
