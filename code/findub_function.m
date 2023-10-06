function [new_ub] = findub_function(p)

global stock_mean
global stock_cov
global expect_return

p1_index=find(p==1);
p_mean = stock_mean(p1_index);
p_cov = stock_cov(p1_index,p1_index);
e=ones(length(p_mean),1);
ai=(e'/p_cov)';
pi=(p_mean/p_cov)';
re=p_mean*ai;
rr=p_mean*pi;
ee=e'*ai;
n=(expect_return*ee-re)/(rr*ee-re*re);
u=(re*n-1)/ee;
x=-u*ai+n*pi;
new_ub=0.5*x'*p_cov*x;
if n<0
    u=-1/ee;
    x=-u*ai;
    new_ub=0.5*x'*p_cov*x;
end
end