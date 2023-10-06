The folder 'data' contains the stock data for numerical experiments, which is selected from the component stocks of the S&P 500 Index.
The folder 'code' contains the matlab code for general problems.
The folder 'code for sdp' contains the matlab code for SDP problems.

In the folder 'data', '50 stocks.xlsx' and '100 stocks.xlsx' represent the weekly returns for sample sizes of n=50 and n=100, respectively. 
The horizontal heading of the table displays the stock names. The vertical title shows the transaction dates from Sept. 2006 to Dec. 2021. 
Additionally, 'port1 mean.txt' and 'port1 covariance.txt' are files containing the mean and covariance matrix of the port1 data, respectively. 
The data for ports 2-4 are the same as described above.

The folder 'code' contains the main programs 'main.m' and 'main2.m' for general problems. 
Both programs utilize the branch and bound method as their basic framework.    
'traverse.m' is designed for the method of exhaustion.

To compare different calculation methods, various functions can be employed. The core of the branch and bound
algorithm is the lower bound. The pruning efficiency is better when the lower bound is higher. 
'findlb_function.m' provides the lower bound for the interval spilt method.
'findlb_gradient.m' provides the lower bound for the supergradient method.
'findlb_ball.m' provides the lower bound for the ball bound.
'findlb_box.m' provides the lower bound for the box bound.
'findlb_continuous.m' provides the lower bound for the continuous relaxation.

In addition, 'cplex_lizi.m' and 'scip_cpr.m' contain the codes for CPLEX and SCIP, respectively. CPLEX and SCIP are both
well-known integer programming solvers. The comparison with these commercial solvers can judge the effectiveness of our algorithm.

In the folder 'code for sdp', 'main4.m' is the main program for SDP problems.
To test different methods in calculations, various functions can be utilized. Here, we provide algorithms for different diagonal matrices.
'findlb_our.m' corresponds to our proposed method.
'findlb_sdp.m' corresponds to the method proposed by Zheng et al. (2014).
'findlb_eig.m' is for the method using the minimum eigenvalue.

The results are presented in the numerical experiments section of the paper. 
Table 1 shows the results obtained by our algorithm and the exhaustive algorithm. 
Figure 1 explains the searching process and the pruning effect of the lower bound. 
Table 2 displays the results of different bounds based on '50 stocks.xlsx' and '100 stocks.xlsx'. 
Table 3 also illustrates the results of different bounds based on 'port1 mean.txt', 'port1 covariance.txt' and so on. 
Table 4 demonstrates the results of different diagonal matrices based on '50 stocks.xlsx' and '100 stocks.xlsx'. 
Table 5 presents the results of different methods based on '50 stocks.xlsx' and '100 stocks.xlsx'.
