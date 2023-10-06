function [optimal_ub,best_p] = ub_function()

global stock_mean
global stock_cov
global k
global expect_return
e=ones(1,length(stock_mean));
[x,~]=quadprog(stock_cov,[],-stock_mean,-expect_return,e,1);
[~,index]=sort(abs(x),"descend");
index=index(1:k);
best_p=-e;
best_p(index)=1;

e=ones(1,k);
p_mean=stock_mean(index);
p_cov=stock_cov(index,index);
[~,fval]=quadprog(2*p_cov,[],-p_mean,-expect_return,e,1);
optimal_ub=fval;
end