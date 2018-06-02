init_price <- 500
K <- 50 
r<- 0.0175
sigma <- 0.2
T <- 5

BS_V0 <- function(S_0, K, r, sigma, T){
  d2 <- (log(S_0/K) + (r - sigma^2/2)*T)/(sigma * sqrt(T)) 
  res <- pnorm(d2) * exp(-r * T)
  return(res)
}


BS_P <- BS_V0(init_price, K, r, sigma, T)


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

for (i in 1:10){
  data[[i]] <- MC_V0(init_price, K, r, sigma, T, 100, 100)
}
