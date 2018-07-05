global stock_px; 
global shortmat_px;
global longmat_px;

stockData = load('Stock.mat');
shortMatData= load('ShortMat.mat');
longMatData = load('LongMat.mat');

Stock = stockData.BABAStock;
ShortMat = shortMatData.BABA190K20th7;
LongMat = longMatData.BABA190K21st9;  

stock = rmmissing(Stock);
shortmat = rmmissing(ShortMat);
longmat = rmmissing(LongMat);

stock_px = table2array(stock(1:27,3));
shortmat_px = table2array(shortmat(1:27,6));
longmat_px = table2array(longmat(1:27,6));

options = optimoptions(@lsqnonlin, 'MaxFunctionEvaluations', 1500);
params = lsqnonlin(@shortOpt, [0.3*2*0.4 - 0.0001^2, 0.4, 0.0001, 0], [0.0001,0.0001,0.00000000001,-1], [Inf,Inf,Inf,1], options);

a = params(1);
theta = params(2);
miu = params(3);
rho = params(4);
kappa = (a + miu^2)/(2*theta);


new_call_px = zeros(27,1);

for (i = 1:27)
   new_call_px(i) = optByHestonFFT(0.02,stock_px(i),datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',190,0.2,theta,kappa,miu,rho); 
end

difference = new_call_px - shortmat_px;


table = [shortmat_px new_call_px];

s = size(new_call_px);
MSE = sum(difference.^2)/s(1);




