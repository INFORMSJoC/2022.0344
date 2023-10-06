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
% t=ones(1,size(pool,2));
% is_number=sum(pool==t,2);
% [max_number,r]=max(is_number);
% p = pool(r,:);
% pool(r,:)=[];
end