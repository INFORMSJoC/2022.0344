function [new_lb,branch_name,matrix,hit]=findlb_gradient(p,matrix_name,matrix_store)

global stock_cov
global stock_mean
global k
global expect_return

pf_index=find(p==-1);
p(p==1)=-1;
pf1_index=find(p==-1);
p_cov=stock_cov(pf1_index,pf1_index);
[m,n]=size(matrix_name);
p_mean = stock_mean(pf1_index);
for i=m:-1:1
    is_number=[matrix_name(i,:)==p];
    if sum(is_number)>n-2 
        max_number=sum(is_number);
        parent_p=i;
        parent_node=find(is_number==0);
        break;
    end
end

if max_number==n
    v=matrix_store{parent_p};
    matrix=0;
    hit=0;
else
    parent_index=find(matrix_name(parent_p,:)==-1);
    index=find(parent_index == parent_node);
    parent_bn=matrix_store{parent_p};
    m=length(parent_index);
    t=1:m;t(index)=[];
    children_u=parent_bn(t,t);
    ucol=parent_bn(t,index);
    brow=stock_cov(pf1_index,parent_node);
    m=m-1;
    A=children_u;
    xiangliang=A(end,:)/ucol(end);
    for i=1:m-1
        A(i,:)=A(i,:)-xiangliang*ucol(i);
    end
    A(end,:)=A(end,:)/ucol(end);
    for i=1:m-1
        A(end,:)=A(end,:)+brow(i)*A(i,:);
    end
    A(end,:)=A(end,:)*ucol(end)/(1-ucol'*brow);
    xiangliang=A(end,:)/ucol(end);
    for i=1:m-1
        A(i,:)=A(i,:)+xiangliang*ucol(i);
    end
    v=A;
    matrix=A;
    hit=1;
end
e=ones(length(p_mean),1);
ai=(e'*v)';
pi=(p_mean*v)';
v=1./sum(abs(v),1);
ee=e'*ai;
n=0;
u=-1/ee;
x=-u*ai;
best_lb=0.5*x'*p_cov*x;
% re=p_mean*ai;
% rr=p_mean*pi;
% ee=e'*ai;
% n=(expect_return*ee-re)/(rr*ee-re*re);
% u=(re*n-1)/ee;
% x=-u*ai+n*pi;
% best_lb=0.5*x'*p_cov*x;
% if n<0
%     n=0;
%     u=-1/ee;
%     x=-u*ai;
%     best_lb=0.5*x'*p_cov*x;
% end
wucha=100;
disp("a");
while wucha>0.1
    s1=abs(u);
    s2=abs(u);
    m=(u*ai-n*pi)';
    m2=m.^2;
    element_list=m2.*v;
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
    min_diag=diag(is_name2.*v);
    d1=m*min_diag*ai-m*e-1;
    d2=-m*min_diag*pi+m*p_mean'+expect_return;
    u=u+s1*d1;
    n=n+s2*d2;
    if n<0
        n=0;
    end
end
new_lb=best_lb;
[~,index]=sort(element_list2,"descend");
branch_name=pf_index(index(1));
end