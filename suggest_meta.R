# For a full description of this case study, open suggest_meta.Rmd file.
# This file only contain the code 

# Import data
df <- read.csv('main.csv', na.strings=c(""," ","NA"))

# Cleaning data
df$Event.ID <- factor(df$Event.ID)
df$Customer.ID <- factor(df$Customer.ID)
df$Postal.Code <- factor(df$Postal.Code)

# Representing the information about the dataset
# install.packages("devtools")
# install.packages('choroplethr')
# install_github('arilamstein/choroplethrZip@v1.5.0')
library(tidyverse)
library(devtools)
library(choroplethr)
library(choroplethrZip)
library(ggplot2)
map_df <- as.data.frame(table(df$Postal.Code))
colnames(map_df) <- c("region", "value")
zip_choropleth(map_df, num_colors = 1,
               state_zoom = "ohio",
               title = "Ticket Sales Heatmap - Ohio") + 
  coord_map() + 
  scale_fill_distiller(name="Tickets", palette="Reds", trans = "reverse", na.value = "Grey")

# Manipulate the dataset
ardf <- data.frame(matrix(NA, 
                          ncol = length(unique(df$Event.ID)) + 1, 
                          nrow = length(unique(df$Customer.ID))))
ardf$X1 <- sort(unique(df$Customer.ID))
colnames(ardf)[1] <- 'Customer.ID'

for (i in 1:5262){
  events <- sort(unique(df[df$Customer.ID == i,'Event.ID']))
  events <- c(events, rep('', 44 - length(events)))
  ardf[i,] <- c(i, events)
}

head(ardf, 10)

# Export the list as csv file
write.table(ardf[,-1], 'list.csv', sep = ',', col.names = FALSE, row.names = FALSE)

# Packages 'arules' and 'arulesViz'
# install.packages('arules')
# install.packages('arulesViz')
library(arules)
library(arulesViz)
dataset <- read.transactions('list.csv', sep = ',', rm.duplicates = TRUE)
summary(dataset)

# Frequency Plot
itemFrequencyPlot(dataset, topN = 44)

# Apriori Training 1
apriori_rule <- apriori(data = dataset, 
                        parameter = list(support = 0.03800836, confidence = 0.8, minlen = 2, maxlen = 44))
inspect(head(sort(apriori_rule, by = 'lift'), 10))
plot(apriori_rule, method = 'grouped')
plotly_arules(apriori_rule)

# Apriori Training 2
apriori_rule <- apriori(data = dataset, 
                        parameter = list(support = 0.00950209, confidence = 0.6, minlen = 2, maxlen = 44))
inspect(head(sort(apriori_rule, by = 'lift'), 10))
plot(apriori_rule, method = 'grouped')
plotly_arules(apriori_rule)

# Eclat Training 1
eclat_rule <- eclat(data = dataset, parameter = list(support = 0.03800836, minlen = 2, maxlen = 44))
inspect(head(sort(eclat_rule, by = "support"), 10))
plot(eclat_rule, method = "graph")

# Eclat Training 2
eclat_rule <- eclat(data = dataset, parameter = list(support = 0.00950209, minlen = 2, maxlen = 44))
inspect(head(sort(eclat_rule, by = "support"), 10))
plot(eclat_rule, method = "graph")


