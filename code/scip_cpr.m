clc;
tic;
expect_return =  0.1;
k =4;
stock_table = xlsread('C:\Users\Lenovo\Desktop\dulunwen\paper1\代码\month100 stocks.xlsx');
stock_data=stock_table(:,:);
stock_mean = mean(stock_data); 
stock_cov = cov(stock_data);  
size=length(stock_mean);
cov_q=[stock_cov,zeros(size,size);zeros(size,size),zeros(size,size)];
f=zeros(1,2*length(stock_mean))';
ai=[-diag(ones(1,size)),-diag(ones(1,size));diag(ones(1,size)),-diag(ones(1,size));-stock_mean,zeros(1,size)];
bi=[zeros(2*size,1);-expect_return];
ae=[ones(1,size),zeros(1,size);zeros(1,size),ones(1,size)];
be=[1;k];
lb=[-ones(size,1)*inf;zeros(size,1)];
ub=[ones(size,1)*inf;ones(size,1)];
ctype='';
for i=1:size
    ctype=[ctype,'C'];
end
for i=1:size
    ctype=[ctype,'I'];
end
A=[ai;ae];
ru=[bi;be];
rl=[-inf*ones(length(bi),1);be];
opts = optiset('maxtime',1800);
[x,fval,exitflag,info] = opti_scip(cov_q,f,A,rl,ru,lb,ub,ctype,[],[],[],opts)

toc;