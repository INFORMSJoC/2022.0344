function [new_lb,branch_name,matrix,hit]=findlb_function(p,matrix_name,matrix_store)

global stock_mean
global stock_cov
global k
global expect_return

pf_index=find(p==-1);
p(p==1)=-1;
pf1_index=find(p==-1);
p_mean = stock_mean(pf1_index);
[m,n]=size(matrix_name);
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
pcov_n=v;
q_e=(e'*pcov_n)';
q_r=(p_mean*pcov_n)';
v=1./sum(abs(pcov_n),1);
break_list=[];
ai=(v.^0.5).*q_e';
ui=(v.^0.5).*q_r';
for i=1:length(p_mean)-1
    for j = i+1:length(p_mean)
        k1=(ai(i)-ai(j))/(ui(i)-ui(j));
        k2=(ai(i)+ai(j))/(ui(i)+ui(j));
        break_list = [break_list k1 k2];
    end
end
break_list = sort(break_list);
max_dual = -Inf;
is_name=ismember(pf1_index,pf_index);
v=v(is_name);
q_e=q_e(is_name);q_r=q_r(is_name);
ai=ai(is_name);ui=ui(is_name);
for i=0:length(break_list)
    n=10;
    if i==0
        u=n*(break_list(1)-1);
        A1=[1 -break_list(1); 0 -1];
        b=[0;0];
    elseif i==length(break_list)
        u=n*(break_list(i)+1);
        A1=[-1 break_list(i);0 -1];
        b=[0;0];
    else
        u=n*(break_list(i)+break_list(i+1))*0.5;
        A1=[-1 break_list(i);1 -break_list(i+1);0 -1];
        b=[0;0;0];
    end
    m=(u*q_e-n*q_r)';
    element_list=v.*m.*m;
    [~,index]=sort(element_list,"ascend");
    index=index(1:length(p_mean)-k);
    a_min=ai(index);
    u_min=ui(index);
    H=[sum(a_min.*a_min) -sum(a_min.*u_min);-sum(a_min.*u_min) sum(u_min.*u_min)];
    t=[e -p_mean'];
    H=H-t'*pcov_n*t;
    H=0.5*(H+H');
    f=[-1;expect_return];
    [~,fval1] = quadprog(-H,-f,A1,b);
    if max_dual<-fval1
        max_dual=-fval1;
        children_index=element_list;
    end  
end
new_lb=max_dual;
[~,index]=sort(children_index,"descend");
branch_name=pf_index(index(1));

end
