heart=read.table("/Users/jing/Desktop/235/heart.txt",sep=' ',header=F)
heart<-heart[,-c(3,7,11,13)]
n = dim(heart)[1]
p = dim(heart)[2]
heart$V14<-as.factor(heart$V14)


index <- sample(1:nrow(heart),round(0.75*nrow(heart)))
train <- heart[index,]
test <- heart[-index,]
set.seed(12345)
#maxs <- apply(heart, 2, max) 
#mins <- apply(heart, 2, min)
#scaled <- as.data.frame(scale(heart, center = mins, scale = maxs - mins))
#train_$V14<-as.factor(train_$V14)
#test_$V14<-as.factor(test_$V14)


library(neuralnet)
n <- names(train)
f <- as.formula(paste("V14 ~", paste(n[!n %in% "V14"], collapse = " + ")))
nn <- neuralnet(f,data=train,hidden=c(5,2,1),linear.output=F)
plot(nn)
nn$net.result
pr.nn <- compute(nn,test)
pr.nn_ <- pr.nn$net.result*(test$V14)

#max(heart$V14)-min(heart$V14))+min(heart$V14
test.r <- (test$V14)*(max(heart$V14)-min(heart$V14))+min(heart$V14)
MSE.nn <- sum((test.r - pr.nn_)^2)/nrow(test)

par(mfrow=c(1,2))
plot(test$V14,pr.nn,col='red',main='Real vs predicted NN',pch=18,cex=0.7)
abline(0,1,lwd=2)
legend('bottomright',legend='NN',pch=18,col='red', bty='n')





library(nnet)
ideal <- class.ind(heart$V14)
hNN = nnet(heart[index,-10], ideal[index,], size=10, softmax=TRUE)
pred.class <- predict(hNN, heart[-index,-10], type="class")
act.class <- test_$V14
table(act.class, pred.class)
mean(act.class == pred.class)
