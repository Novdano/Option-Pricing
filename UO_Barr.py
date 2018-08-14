import math
from scipy.stats import norm

def uo_barr(S_0, K, U, r, sigma, T):
  lamb = (r+ 0.5*sigma**2) / (sigma**2)
  x1 = math.log(S_0/U)/(sigma*math.sqrt(T))+lamb*sigma*math.sqrt(T)
  y1 = math.log(U/S_0)/(sigma*math.sqrt(T))+lamb*sigma*math.sqrt(T)
  y = math.log(U**2/(S_0*K))/(sigma*math.sqrt(T))+lamb*sigma*math.sqrt(T)
  d1 = (math.log(S_0/K) + (r + sigma**2/2)*T)/(sigma * math.sqrt(T))
  d2 = (math.log(S_0/K) + (r - sigma**2/2)*T)/(sigma * math.sqrt(T))
  first = S_0*(norm.cdf(d1)-norm.cdf(x1)+(U/S_0)**(2*lamb)*(norm.cdf(-y)-norm.cdf(-y1)))
  second = K*math.exp(-r*T)*(-norm.cdf(d2)+norm.cdf(x1-sigma*math.sqrt(T))-((U/S_0)**(2*lamb-2))*(norm.cdf(-y+sigma*math.sqrt(T))-norm.cdf(-y1+sigma*math.sqrt(T))))

print(uo_barr(50,50,60,0.175, 0.02, 1))
