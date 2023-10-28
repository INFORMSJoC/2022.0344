clc
clear
tic;
tstart =tic;
global stock_mean
global stock_cov
global k
global expect_return
mean = load ("C:\Users\Lenovo\Desktop\data\port1 mean.txt"); % add the path for the mean of the port
cov = load ("C:\Users\Lenovo\Desktop\data\port1 covariance.txt"); % add the path for the covariance matrix of the port
expect_return =  0.1;
k = 4;   
stock_mean = mean';
stock_cov = cov;
nodes=0;
[optimal_ub,best_p] = ub_function();
pool=[[-1*ones(1,length(stock_mean))]];
matrix_name=[[-1*ones(1,length(stock_mean))]];
matrix_store={};
matrix_store{1}=inv(stock_cov);
lb_list=[];
while ~isempty(pool) 
    nodes=nodes+1;
    [p,pool,max_number] = select_p(pool);
    lb_list=[lb_list;nodes optimal_ub];
    if max_number == k
        new_ub = findub_function(p);
        
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