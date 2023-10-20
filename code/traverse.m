clc
tic;
global stock_mean
global stock_cov
global stock_data
global k
global expect_return

expect_return =  0.1;
k =5;
stock_table = xlsread('C:\Users\Lenovo\Desktop\data\100 stocks.xlsx'); % add the path for the stock data
stock_data=stock_table;
stock_mean = mean(stock_data,1);                   
stock_cov = cov(stock_data);                       
pool=nchoosek(1:length(stock_mean),k);
optimal_ub=100;
for i=1:length(pool) 
    p1_index= pool(i,:); 
    p=-1*ones(1,length(stock_mean));
    p(p1_index)=1;
    new_ub = findub_function(p);
    if optimal_ub>new_ub
        optimal_ub=new_ub;
        best_p=p;
    end
end
disp(optimal_ub);
disp(find(best_p==1));
disp(length(pool));
toc;