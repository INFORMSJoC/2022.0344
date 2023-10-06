clc
clear
tic;
tstart =tic;
global stock_mean
global stock_cov
global k
global expect_return
load ("port1 mean.txt");
load ("port1 corr.txt");
expect_return =  0.5;
k = 10;
stock_mean = unnamed;                      
stock_cov = unnamed1;                          
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
    if max_number == k      %判断所有元素是否固定，若固定，则为最优组合
        new_ub = findub_function(p);
        
        if optimal_ub>new_ub
            optimal_ub=new_ub;
            best_p=p;
        end
        continue;
    end
    [new_lb,branch_name,matrix,hit]=findlb_gradient(p,matrix_name,matrix_store); 
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
    if tused > 1200
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