function [optimal_ub,best_p] = ub_function()

global stock_mean
global stock_cov
global k
global expect_return
p=-1*ones(1,length(stock_mean));
p1_index=find(p==1);
pf_index=find(p==-1);
pf1_index=[pf_index,p1_index];
pf1_index=sort(pf1_index);
p_mean = stock_mean(pf1_index);
p_cov = stock_cov(pf1_index,pf1_index);
d_m=diag(ones(1,length(p_mean)));
v=d_m/p_cov;
v=abs(v);
v=sum(v,1);
v=diag(v);
v_n=d_m/v;
e=ones(length(p_mean),1);
ai=(e'/p_cov)';
pi=(p_mean/p_cov)';
re=p_mean*ai;
rr=p_mean*pi;
ee=e'*ai;
n=(expect_return*ee-re)/(rr*ee-re*re);
u=(re*n-1)/ee;
x=-u*ai+n*pi;
best_lb=0.5*x'*p_cov*x;
wucha=100;
while wucha>0.01
    s1=-u/2;
    s2=-n/2;
    if abs(u)<0.1
        s1=0.1;
    end
    if abs(n)<0.1
        s2=0.1;
    end
    m=(u*ai-n*pi)';
    m2=m.^2;
    element_list=m2*v_n;
    is_name=ismember(pf1_index,pf_index);
    element_list2=element_list(is_name);
    [~,index]=sort(element_list2,"ascend");
    index=index(1:length(element_list)-k);
    f=0.5*sum(element_list2(index))-0.5*(u*e-n*p_mean')'*m'+n*expect_return-u;
    wucha=abs(f-best_lb);
    if best_lb<f
        best_lb=f;
    end
    is_name2=ismember(pf1_index,pf_index(index));
    min_diag=diag(is_name2*v_n);
    d1=m*min_diag*ai-m*e-1;
    d2=-m*min_diag*pi+m*p_mean'+expect_return;
    u=u+s1*d1;
    n=n+s2*d2;
end
[~,index]=sort(element_list2,"descend");
p_name=pf_index(index(1:k));
p_name=sort(p_name);
p_mean = stock_mean(p_name);
p_cov = stock_cov(p_name,p_name);
e=ones(1,k);
[~,fval]=quadprog(p_cov,[],[],[],[-p_mean;e],[-expect_return;1]);
optimal_ub=fval;
p(p_name)=1;
best_p=p;
end