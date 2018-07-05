k = 0.3;
t = 0.4;
m = 0.001;
r = -0.3;

global options;
options = zeros(10,1);
options(1) = optByHestonFFT(0.02,190,datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',193,0.2,t,k,m,r);
options(2) = optByHestonFFT(0.02,190,datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',190,0.2,t,k,m,r);
options(3) = optByHestonFFT(0.02,190,datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',195,0.2,t,k,m,r);
options(4) = optByHestonFFT(0.02,190,datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',187,0.2,t,k,m,r);
options(5) = optByHestonFFT(0.02,190,datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',182,0.2,t,k,m,r);
options(6) = optByHestonFFT(0.02,190,datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',199,0.2,t,k,m,r);
options(7) = optByHestonFFT(0.02,190,datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',181,0.2,t,k,m,r);
options(8) = optByHestonFFT(0.02,190,datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',188,0.2,t,k,m,r);
options(9) = optByHestonFFT(0.02,190,datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',197,0.2,t,k,m,r);
options(10) = optByHestonFFT(0.02,190,datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',202,0.2,t,k,m,r);

global strikes;
strikes = [193,190,195,187,182,199,181,188,197,202];

opts = optimoptions(@lsqnonlin, 'MaxFunctionEvaluations', 15000, 'MaxIterations',15000,'OptimalityTolerance',1e-30,'FunctionTolerance',1e-30,'StepTolerance', 1.000e-30);
params = lsqnonlin(@dummyOpt, [0.2, 0.3], [0.0001,0.0001], [Inf,Inf], opts);

x = 0.05:0.001:1;
y = 0.05:0.001:0.5;
size(x)
size(y)
z = zeros(length(y),length(x));
size(z)
for k = 0.05:0.001:1
    for t = 0.05:0.001:0.5
        z(int32(t*1000-49),int32(k*1000-49)) = sum(dummyOpt([k,t,0.001, -0.3]).^2);
    end
end

mesh(x,y,z)


function f = dummyOpt(param_vecs)
      global options;
      global strikes;
      a = param_vecs(1);
      theta = param_vecs(2);
      %miu = param_vecs(3);
      %rho = param_vecs(4);
      kappa = (a + 0.01^2)/(2*theta);
      s = size(strikes);
      sv_est = zeros(s(2),1);
      for (i = 1:s(2))
        sv_est(i) = optByHestonFFT(0.02,190,datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',strikes(i),0.2,theta,kappa,0.001,-0.3); 
      end 
      f = sv_est - options;
end




