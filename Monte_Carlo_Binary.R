init_price <- 50
K <- 50 
r<- 0.0175
sigma <- 0.2
T <- 5

BS_V0 <- function(S_0, K, r, sigma, T){
  d2 <- (log(S_0/K) + (r - sigma^2/2)*T)/(sigma * sqrt(T)) 
  res <- pnorm(d2) * exp(-r * T)
  return(res)
}


# BS_P <- BS_V0(init_price, K, r, sigma, T)


MC_V0 <- function(S_0, K, r, sigma, T, N, M){
  payoff <- rep(0,M)
  for (i in 1:M){
    s <- S_0
    for (n in 1:N){
      s <- s + r*s*(T/N) + sigma * s * sample(c(-1,1), 1) * sqrt(T/N)
    }
    if (s>=K){
      payoff[[i]] <- 1
    } else {
      payoff[[i]] <- 0
    }
  }
  res <- (1 + r * (T/N))^-N * mean(payoff)
}


samplesMC <- rep(0, 10)

# for (i in 1:10){
#   data[[i]] <- MC_V0(init_price, K, r, sigma, T, 1000, 1000)
#   
# }

MC <- c(0:19)
BS <- c(0:19)

for (i in 0:20){
  MC[i] <- MC_V0(init_price, K+i, r, sigma, T, 1000, 1000)
  BS[i] <- BS_V0(init_price, K+i, r, sigma, T)
  print(i)
}

plot(50:69, MC, main = "plot K = 50,...,70, M=N=1000", ylab = "price", type = "l", col = "blue")
lines(50:69, BS, col = "red")
legend("topleft",
       c("MonteCarlo","BlackScholes"),
       fill=c("blue","red"))



