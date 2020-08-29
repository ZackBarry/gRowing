input_time <- suppressWarnings(read.table("stdin", sep=" "))
input_time <- as.double(input_time)

train_data <- read.csv('trainingdata.txt', header = FALSE, sep = ',')
colnames(train_data) <- c('x', 'y')

prediction = ifelse(input_time < 4, input_time * 2, 8)

write(prediction, stdout())