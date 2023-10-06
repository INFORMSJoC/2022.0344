function pool = branch_function(p,pool,branch_name)

% global k

r_stock = branch_name;
p1=p;
p2=p;
p1(r_stock)=1;
p2(r_stock)=0;
pool = [pool;p1;p2];
% if length(find(p == 0)) == length(p)-k
%     p1(r_stock)=1;
%     pool = [pool;p1];
% else
%     p1(r_stock)=1;
%     p2(r_stock)=0;
%     pool = [pool;p1;p2];
% end
end