clc
tic;
tstart =tic;
expect_return =  0.1;
k =4;
stock_table = xlsread('C:\Users\Lenovo\Desktop\读论文\代码\month100 stocks.xlsx');
stock_data=stock_table(:,1:50);
stock_mean = mean(stock_data); 
stock_cov = cov(stock_data);  
size=length(stock_mean);
cov_q=[stock_cov,zeros(size,size);zeros(size,size),zeros(size,size)];
f=zeros(1,2*length(stock_mean));
ai=[-diag(ones(1,size)),-diag(ones(1,size));diag(ones(1,size)),-diag(ones(1,size));-stock_mean,zeros(1,size)];
bi=[zeros(2*size,1);-expect_return];
ae=[ones(1,size),zeros(1,size);zeros(1,size),ones(1,size)];
be=[1;k];
lb=[-ones(size,1)*0;zeros(size,1)];
ub=[ones(size,1)*0.4;ones(size,1)];
ctype='';
for i=1:size
    ctype=[ctype,'C'];
end
for i=1:size
    ctype=[ctype,'I'];
end
options = cplexoptimset('cplex');
options.display = 'on';
options.timelimit= 1800;
[x_value,fval]=cplexmiqp (cov_q,f,ai,bi,ae,be,[],[],[],lb,ub,ctype,[],options);

stock_name=[];
for i=1:length(stock_mean)
    stock_name=[stock_name "s"+num2str(i)];
end
for i=1:size
    if x_value(i) ~=0
        disp(stock_name(i));
    end
end
disp(fval);
toc;
