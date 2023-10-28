function [p,pool,max_number] = select_p(pool)
[m,~]=size(pool);
if m==1
    max_number=sum(pool(1,:)==1);
    p = pool(1,:);
    pool=[];
else
    maxl=sum(pool(m-1:m,:)==1,2);
    maxl=maxl';
    if maxl(2)>maxl(1)
        max_number=maxl(2);
        p = pool(m,:);
        pool(m,:)=[];
    else
        max_number=maxl(1);
        p = pool(m-1,:);
        pool(m-1,:)=[];
    end
end
% [m,n]=size(pool);
% total_0=zeros(1,n);
% total_1=ones(1,n);
% if m==1
%     max_number=sum(pool(1,:)==total_1);
%     p = pool(1,:);
%     pool=[];
% else
%     numberof_0=sum(pool(m-1:m,:)==total_0,2);
%     numberof_0=numberof_0';
%     if numberof_0(2)>numberof_0(1)
%         p=pool(m,:);
%         pool(m,:)=[];
%         max_number=sum(p==total_1);
%     else
%         p = pool(m-1,:);
%         pool(m-1,:)=[];
%         max_number=sum(p==total_1);
%     end
% end

end