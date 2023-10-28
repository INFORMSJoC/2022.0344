clc
clear
tic;
tstart =tic; 
global stock_mean
global stock_cov
global stock_data
global k
global expect_return

expect_return=0.1;
k=3;
stock_table = xlsread('C:\Users\Lenovo\Desktop\data\100 stocks.xlsx'); % add the path for the stock data
stock_data=stock_table(:,:);
stock_mean = mean(stock_data);                      
stock_cov = cov(stock_data);                          

nodes=0;
[optimal_ub,best_p] = ub_function();
pool=[[-1*ones(1,length(stock_mean))]];
matrix_name=[[-1*ones(1,length(stock_mean))]];
matrix_store={};
matrix_store{1}=inv(stock_cov);
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
    [new_lb,branch_name,matrix,hit]=findlb_gradient(p,matrix_name,matrix_store); % choose the lower bound
    if new_lb >= optimal_ub
        continue;                      
    end
    pool = branch_function(p,pool,branch_name);  
    if hit==1
        [matrix_name,matrix_store]=process_matrix(pool,matrix_name,matrix_store);
        p(p==1)=-1;
        matrix_name=[matrix_name;p];
        matrix_store{end+1}=matrix;
    end
    tused = toc(tstart);   
    if tused > 1800   
        disp(optimal_ub);
        disp(find(best_p==1));
        disp(nodes);
        toc;
        return  
    end
end

disp(optimal_ub);
disp(find(best_p==1));
disp(nodes);
toc;