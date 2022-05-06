# read dataset
snp500Stocks = read.csv("/Users/shubhammandhare/Desktop/Shubh/Stocks Project/Dataset/snp500Stocks.csv")
financials = read.csv("/Users/shubhammandhare/Desktop/Shubh/Stocks Project/Dataset/Financials.csv")
informationTechnology = read.csv("/Users/shubhammandhare/Desktop/Shubh/Stocks Project/Dataset/InformationTechnology.csv")
healthCare = read.csv("/Users/shubhammandhare/Desktop/Shubh/Stocks Project/Dataset/HealthCare.csv")
realEstate = read.csv("/Users/shubhammandhare/Desktop/Shubh/Stocks Project/Dataset/RealEstate.csv")

#######################################
###### ARIMA data from R #######
install.packages("quantmod")
install.packages("tseries")
install.packages("timeSeries")
install.packages("forecast")
install.packages("xts")
install.packages("BatchGetSymbols")

library(BatchGetSymbols)
library(quantmod)
library(tseries)
library(timeSeries)
library(forecast)
library(xts)

#get all stock prices from snp500 
first.date <- Sys.Date()-365
last.date <- Sys.Date()

df.SP500 <- GetSP500Stocks()
tickers <- df.SP500$Tickers

l.out <- BatchGetSymbols(tickers = tickers,
                         first.date = first.date,
                         last.date = last.date)

print(l.out$df.control)
print(l.out$df.tickers)

###############################################################
getSymbols("DIS", from="2010-01-01", to="2021-10-25" )
class(DIS)

#OHLC Vol AdjClose
AAPL_closePrices = DIS[,4]
tail(AAPL_closePrices)
plot(AAPL_closePrices)

par(mfrow=c(1,1))

fitA <- auto.arima(AAPL_closePrices, seasonal = FALSE)
term = 100
pred <- forecast(fitA, h=term)
plot(pred)
accuracy(pred) #98.65