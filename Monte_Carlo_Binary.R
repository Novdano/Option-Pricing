init_price <- 500
K <- 50 
r<- 0.0175
sigma <- 0.2
T <- 5
M <- 1000
N <- 1000

BS_V0 <- function(S_0, K, r, sigma, T){
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

#test 
# for (i in 1:10){
#   data[[i]] <- MC_V0(init_price, K, r, sigma, T, 100, 100)
# }

#vary sigma
sigmas = c(0.01, 0.1, 0.2, 0.5, 1, 2, 5, 10)
priceMC = rep(0, length(sigmas))
priceBS = rep(0, length(sigmas))
for (i in 1:length(sigmas)){
  print(sigmas[i])
  priceMC[[i]] <- MC_V0(init_price, K, r, sigmas[i], T, M, N)
  priceBS[[i]] <- BS_V0(init_price, K, r, sigmas[i], T)
}
plot(sigmas, priceMC, main = "Price against Sigma", ylab="Price", type="l", col="blue")
lines(sigmas, priceBS, col="red")
legend("topleft", c("Monte Carlo", "Black Scholes"), fill = c("blue", "red"))



