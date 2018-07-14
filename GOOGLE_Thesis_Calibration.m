apr = csvread("GOOG04062013.dat");
sep = csvread("GOOG09202013.dat");
jan = csvread("GOOG01172014.dat");

global option_data = [apr;sep;jan];


function f = opt(param_vecs)
    global option_data;
    a = param_vecs(1);
    theta = param_vecs(2);
    miu = param_vecs(3);
    rho = param_vecs(4);
    kappa = (a + miu^2)/(2*theta);
    s = size(option_data);
    num_opt = s(1);
    sv_est = zeros(num_opt, 1);
    market_price = option_data(:,5);
    for i = 1:num_opt
         r = option_data(i,1);
         tau = option_data(i,2);
         S = option_data(i,3);
         K = option_data(i,4);
         C = option_data(i,5);
         sv_est(i) = optByHestonFFT(r,S,datenum('06-04-2013','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',K,0.2,theta,kappa,miu,rho);
    end
    f = sv_est - shortmat_px;
end