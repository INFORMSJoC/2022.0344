clc
clear
tic;
tstart =tic;
global stock_mean
global stock_cov
global k
global expect_return

expect_return=0.1;
k=2;
stock_table = xlsread('C:\Users\Lenovo\Desktop\dulunwen\paper2 code\sz180.xlsx');
stock_data=stock_table(:,1:10);
stock_mean = mean(stock_data);                      
stock_cov = cov(stock_data);                         
nodes=0;
avglb_n=0;
avglb_d=0;
[optimal_ub,best_p] = ub_function();
pool=-1*ones(1,length(stock_mean));
while ~isempty(pool) 
    nodes=nodes+1;
    [p,pool,max_number] = select_p(pool);
    if max_number == k      
        new_ub=findub_function(p);
        if optimal_ub>new_ub
            optimal_ub=new_ub;
            best_p=p;
        end
        continue;
    end
    [new_lb,branch_name]=findlb_eig(p);
    avglb_n=avglb_n+new_lb;
    avglb_d=avglb_d+1;
    if new_lb >= optimal_ub
        continue;                      %若下界大于最优下界，进行下一次循环
    end
    pool = branch_function(p,pool,branch_name);  %进行分支
    tused = toc(tstart);    
    if tused > 3600
        disp(optimal_ub);
        disp(find(best_p==1));
        disp(nodes);
        toc;
        return  
    end
end
disp('optimal_ub');
disp(optimal_ub);
disp("avg_lb");
disp(avglb_n/avglb_d);
disp('best_stock');
index=find(best_p==1);
disp(index);
p_mean=stock_mean(index);
p_cov=stock_cov(index,index);
e=ones(1,k);
options.Display='off';
[x]=quadprog(2*p_cov,[],-p_mean,-expect_return,e,1,[],[],[],options);
disp("best_weight");
disp(x');
disp("nodes");
disp(nodes);
toc;