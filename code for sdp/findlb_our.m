function [new_lb,branch_name]=findlb_our(p)

global stock_cov
global stock_mean
global k
global expect_return

pf_index=find(p==-1);
p(p==1)=-1;
pf1_index=find(p==-1);
p_cov=stock_cov(pf1_index,pf1_index);
p_mean = stock_mean(pf1_index);
len=length(p_mean);
e=ones(len,1);
dia=1./sum(abs(inv(p_cov)));
c_dia=p_cov-diag(dia);
cvx_begin sdp quiet
    variable t 
    variable s nonnegative
    variable pai nonnegative
    variable mu nonnegative
    variable eta nonnegative
    variable la(len) 
    variable v(len) nonnegative 
    maximize ( -k*s-e'*v-t)
    subject to
    for i=1:len
        [dia(i) 0.5*la(i);0.5*la(i) v(i)+s] >= 0;
    end
    [c_dia 0.5*(-la-eta*p_mean'+pai*e-mu*e);
        0.5*(-la-eta*p_mean'+pai*e-mu*e)' eta*expect_return-pai+mu+t] >= 0;
cvx_end
new_lb=cvx_optval;
ai=(e'/p_cov)';
pi=(p_mean/p_cov)';
re=p_mean*ai;
rr=p_mean*pi;
ee=e'*ai;
n=(expect_return*ee-re)/(rr*ee-re*re);
u=(re*n-1)/ee;
x=-u*ai+n*pi;
if n<0
    u=-1/ee;
    x=-u*ai;
end
[~,index]=sort(abs(x),"descend");
branch_index=pf1_index(index);
is_name=ismember(branch_index,pf_index);
branch_index=branch_index(is_name);
branch_name=branch_index(1);
end