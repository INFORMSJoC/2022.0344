[![INFORMS Journal on Computing Logo](https://INFORMSJoC.github.io/logos/INFORMS_Journal_on_Computing_Header.jpg)](https://pubsonline.informs.org/journal/ijoc)

# An Efficient Global Optimal Method for Cardinality Constrainted Portfolio Optimization

This archive is distributed in association with the [INFORMS Journal on
Computing](https://pubsonline.informs.org/journal/ijoc) under the [GNU General Public License v3.0](LICENSE).

This repository contains supporting material for the paper
[An Efficient Global Optimal Method for Cardinality Constrainted Portfolio Optimization](https://doi.org/10.1287/ijoc.2022.0344) by W. Xu, J. Tang, K. F. C. Yiu and J. W. Peng. 

## Cite

To cite the contents of this repository, please cite both the paper and this repo, using their respective DOIs.

https://doi.org/10.1287/ijoc.2022.0344

https://doi.org/10.1287/ijoc.2022.0344.cd

Below is the BibTex for citing this snapshot of the respoitory.

```
@article{Xu2022.0344,
  author =        {Wei Xu and Jie Tang and Ka Fai Cedric Yiu and Jian Wen Peng},
  publisher =     {INFORMS Journal on Computing},
  title =         {An Efficient Global Optimal Method for Cardinality Constrainted Portfolio Optimization},
  year =          {2023},
  doi =           {10.1287/ijoc.2022.0344.cd},
  url =           {https://github.com/INFORMSJoC/2022.0344},
}  
```

## Content

This repository includes:

1. The folder [data](data) contains the stock data for numerical experiments, which is selected from the component stocks of the S&P 500 Index.
2. The folder [code](code) contains the matlab code for general problems.
3. The folder [code for sdp](code_for_sdp) contains the matlab code for SDP problems.
4. The folder [results](results) contains all the figures and tables.

## Data files

In the folder [data](data), [50 stocks](data/50_stocks.xlsx) and [100 stocks](data/100_stocks.xlsx) represent the weekly returns for sample sizes of n=50 and n=100, respectively. 

The horizontal heading of the table displays the stock names. The vertical title shows the transaction dates from Sept. 2006 to Dec. 2021. 

Additionally, [port1 mean](data/port1_mean.txt) and [port1 covariance](data/port1_covariance.txt) are files containing the mean and covariance matrix of the port1 data, respectively. The data for ports 2-4 are the same as described above.

## Code files

The folder [code](code) contains the main programs [main](code/main.m) and [main2](code/main2.m) for general problems. 
Both programs utilize the branch and bound method as their basic framework. The code [traverse](code/traverse.m) is designed for the method of exhaustion.

To compare different calculation methods, various functions can be employed. The core of the branch and bound
algorithm is the lower bound. The pruning efficiency is better when the lower bound is higher. 
[findlb_function](code/findlb_function.m) provides the lower bound for the interval spilt method.
[findlb_gradient](code/findlb_gradient.m) provides the lower bound for the supergradient method.
[findlb_ball](code/findlb_ball.m) provides the lower bound for the ball bound.
[findlb_box](code/findlb_box.m) provides the lower bound for the box bound.
[findlb_continuous](code/findlb_continuous.m) provides the lower bound for the continuous relaxation.

In addition, [cplex_lizi](code/cplex_lizi.m) and [scip_cpr](code/scip_cpr.m) contain the codes for CPLEX and SCIP, respectively. CPLEX and SCIP are both
well-known integer programming solvers. The comparison with these commercial solvers can judge the effectiveness of our algorithm.

In the folder [code for sdp](code_for_sdp), [main4](code_for_sdp/main4.m) is the main program for SDP problems.
To test different methods in calculations, various functions can be utilized. Here, we provide algorithms for different diagonal matrices.
[findlb_our](code_for_sdp/findlb_our.m) corresponds to our proposed method.
[findlb_sdp](code_for_sdp/findlb_sdp.m) corresponds to the SDP method.
[findlb_eig](code_for_sdp/findlb_eig.m) is for the method using the minimum eigenvalue.

## Results

The results are presented in the numerical experiments section of the paper. 
[Table 1](results/Table_1_Verification_of_the_global_optimality.xlsx) shows the results obtained by our algorithm and the exhaustive algorithm. 
[Figure 1](results/Figure_1_Searching_process_of_our_method.png) explains the searching process and the pruning effect of the lower bound. 
[Table 2](results/Table_2_Comparison_among_different_lower_bounds_based_on_S&P_500.xlsx) displays the results of different bounds based on [50 stocks](data/50_stocks.xlsx) and [100 stocks](data/100_stocks.xlsx). 
[Table 3](results/Table_3_Comparison_among_different_lower_bounds_on_common_data_sets.xlsx) also illustrates the results of different bounds based on [port1 mean](data/port1_mean.txt), [port1 covariance](data/port1_covariance.txt) and so on. 
[Table 4](results/Table_4_Comparison_among_different_diagonal_matrices.xlsx) demonstrates the results of different diagonal matrices based on [50 stocks](data/50_stocks.xlsx) and [100 stocks](data/100_stocks.xlsx). 
[Table 5](results/Table_5_Comparison_among_different_methods_based_on_S&P_500.xlsx) presents the results of different methods based on [50 stocks](data/50_stocks.xlsx) and [100 stocks](data/100_stocks.xlsx).
