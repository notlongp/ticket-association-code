# Ticket Sale Suggestion - A Case Study Using Association Rules
## Introduction
Marketing data is important because it helps executive officers understand the demographic of ticket buyers around the venue's area. By studying the insights of a given dataset from the trends shaped by the data, an analyst can bring about the best suggestions for the marketing team for effective advertisement. 
  
## About the data
This study takes data from a local performing arts venue in Cleveland, Ohio. Although ticket buyers come from many different states in the US and Canada, this study will only focus on the tickets coming from the state of Ohio.
  
## Goal
The goal of this case study is to understand what events are closely correlated based on each event's transactions. In order to achieve this goal, this report makes use of association rules modeling, namely Apriori algorithm and Eclat algorithm.

## Method
Counting each customer as a 'transaction' with respect to the original example given by 'arules' vignette, there is a total of 5262 transactions. In this report, I ran each association rule twice, one with higher support and higher confidence and one with lower support and lower confidence. This enabled me to take into account groups of events that are closely related, as well as their connection to other shows.

For this case study, I ran 4 trainings, 2 for each algorithm (Apriori and Eclat). For Apriori algorithm, I set a minimum support value of 200/5262 with 80% minimum confidence for the first training and a minimum support value of 50/5262 with 60% minimum confidence for the second training. For Eclat algorithm, I set a minimum support value of 200/5262 and 50/5262 for the first and second training, respectively.
  
## Result
From all 4 trainings, there are 4 distinct groups of closely-related events:
- Group 1: #6, #10, #25, #32, #35, #44 
- Group 2: #8, #14, #28, #33
- Group 3: #2, #9, #13, #39
- Group 4: #41, #42

Cross-checking these Event.IDs with the nature of each event, I can see the connection within the nature of each group of events:
- All events from Group 1 are book events featuring famous novelists, which attract avid readers and aspiring writers.
- All events from Group 2 are academic lectures and talks hosted by famous public figures ( doctors, artists, scientists, etc.), which attracts scholars and students.
- All events from Group 3 are harmonies of classical instrumental artists and bands, which attracts classical music listeners.
- Two events from Group 4 are related, back-to-back events. These are essentially one event split into two.
  
Apriori algorithm is a better algorithm for bigger datasets. For the original dataset, Eclat algorithm is more straightforward, creates more insights, and takes significantly less time to execute due to the smaller number of calculations. The graph generated using Eclat algorithm Training #2 is especially intuitive because it presents clearly which groups of events are frequently bought with one another.
 
## Suggestions
The purpose case study was to inform the venue's marketing manager of the current distribution of tickets sold and help guide the venue's future marketing campaigne and customers relation. Through the results of this case study, events such as #1, #17, and #18 are also harmonies composed by classical instrumental artists, yet the relationship between them and events of group 3 is not significant enough to be considered. This leads me to believe that better marketing advertisements can be done to connect classical music listeners who attended events of group 3 to purchase tickets from event #1, #17, and #18 as well.

## Acknowledgements
Great thanks to the developers who created packages 'arules' and 'arulesViz' for providing the code that utilizes Apriori and Eclat algorithm intuition. 
Also special thanks to Alia Basar for her help in compiling this case study.
