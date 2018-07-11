global options
global K
global S
options = [7.7;6.4;5.02;2.79;1.42];
K = [95,97.5,100,105,110];
S = 100;

% opts = optimoptions(@lsqnonlin, 'MaxFunctionEvaluations', 15000, 'MaxIterations',15000,'OptimalityTolerance',1e-20,'FunctionTolerance',1e-20,'StepTolerance', 1.000e-20);
% params = lsqnonlin(@msftOPT, [0.2, 0.3], [0,0], [Inf,Inf], opts);

x = 0.05:0.01:1.5;
y = 0.05:0.01:1;
size(x)
size(y)
z = zeros(length(y),length(x));
size(z)
for k = x
    for t = y
        z(int32(t*100-4),int32(k*100-4)) = sum(msftOPT([k,t,0.001, -0.3]).^2);
    end
end

mesh(x,y,z)



function f = msftOPT(param_vecs)
      global options
      global K 
      global S
      a = param_vecs(1);
      theta = param_vecs(2);
      %miu = param_vecs(3);
      %rho = param_vecs(4);
      kappa = (a + 0.01^2)/(2*theta);
      s = size(K);
      sv_est = zeros(s(2),1);
      for (i = 1:s(2))
        sv_est(i) = optByHestonFFT(0.02,S,datenum('20-10-2018','dd-mm-yyyy'),datenum('21-10-2018','dd-mm-yyyy'),'call',K(i),0.2,theta,kappa,0.001,-0.3); 
      end 
      f = sv_est - options;
end

