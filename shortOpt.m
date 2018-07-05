function f = shortOpt(param_vecs)
      global stock_px;
      global shortmat_px;
      a = param_vecs(1);
      theta = param_vecs(2);
      miu = param_vecs(3);
      rho = param_vecs(4);
      kappa = (a + miu^2)/(2*theta);
      sv_est = zeros(size(stock_px));
      for (i = 1:size(sv_est))
        sv_est(i) = optByHestonFFT(0.02,stock_px(i),datenum('20-07-2018','dd-mm-yyyy'),datenum('21-07-2018','dd-mm-yyyy'),'call',190,0.2,theta,kappa,miu,rho); 
      end 
      f = sv_est - shortmat_px;
end

