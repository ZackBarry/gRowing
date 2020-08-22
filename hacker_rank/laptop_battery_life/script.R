input_time <- suppressWarnings(read.table("stdin", sep=" "))
input_time <- as.double(input_time)

input_time <- 0.09

train_data <- read.csv('trainingdata.txt', header = FALSE, sep = ',')
colnames(train_data) <- c('x', 'y')
model <- lm(y ~ x, data = train_data)

prediction <- predict(model, data.frame(x = input_time))
write(prediction, stdout())