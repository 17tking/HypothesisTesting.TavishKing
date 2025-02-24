# Alcohol Use and Delinquency - Hypothesis Testing
This was the final project for my graduate level psychological statistics course during the 2024 Fall semester. Individually, we were given a data set to clean, conduct exploratory data analyses, develop hypotheses, and test our hypotheses using the content we had learned that semester. The instructor's goal was to have us be creative and thoughtful about the research questions we were given. Below were the project instructions.

## Project Objective
### Instructions
Some of your other colleagues ask you to help analyze data about about delinquency and drug use among adolescents. Their primary interest is understanding **how self-control is related to alcohol use.** They also want to know **how friends’ delinquency is related to alcohol use** as well as **how friends’ delinquency may influence the relationship between selfcontrol and alcohol use.** The dataset (delinquency_drugs.dta) also includes other demographic, education, and substance use variables that you will want to consider in your analysis as covariates.

Your task is to conduct analyses that will answer your colleagues’ questions. We have covered during this semester all the statistics and analysis approaches you will need to fully answer these questions. You should use concepts/analyses from throughout the semester to address the questions (e.g., descriptive statistics, graphs, confidence intervals, effect sizes, etc.). Additionally, you also need to write a memo to your colleagues that describes and interprets your results (you may need to create tables or construct figures to explain your results).

### Data Set Used + Link to Codebook
- [delinquency_data.dta](FINAL_PROJECT/delinquency_data.dta)
- [Codebook](https://github.com/17tking/HypothesisTesting.TavishKing/blob/main/FINAL_PROJECT/Codebook%20for%20DelinquencyDrugs%20dataset.pdf)
  
### Hypotheses
1. Controlling for key predictors in our model, we hypothesize that lower self-control will be associated with greater alcohol use.
2. We also predict that higher levels of friend delinquency will be associated with greater alcohol use.
3. Finally, we hypothesize that friend delinquency will moderate the relationship between low self-control and alcohol use.
   
### Analysis Plan
#### Data Cleaning
  - removing ages with <= 2 observations
  - center age to the easily intepretable minimum
  - dummy code Male as the baseline in the gender variable
#### EDA
  -  view selected variables' correlation with alcohol use (DV)
  -  create histograms to analyze distribution of data
- Linear Regression Analyses
- Check Assumptions

### Project Insights
- 17-year-olds showed highest average consumption of alcohol in the year (*M* = 0.93, *SD* = 0.91)
- Females showed significantly higher average alcohol use than Males (*t* = 8.12, *M* = 0.83, *p* < .001)
- Predictors in the final model explained 58% of the variability in alcohol use
  
### Conclusions
Greater low self-control is associated with a reduction in the number of alcohol units consumed. For hypothesis 2, our results supported this hypothesis. For hypothesis 3, the interaction effect between self-control and friend delinquency showed that individuals with greater self-control (moving backward on the plot) and friends with those who engage in high delinquent behavior (2 SD above the mean) are at the greatest risk of consuming alcohol. Residual vs. fitted (RVF) plot from our final model shows evidence of heteroskedasticity due to the funneling shape of the data points. Further analyses were done in R to determine if we run the risk of having biased standard errors and p-values. Using a Heteroskedastic Corrected Covariance Matrix, we compared our original models SE's and p-values to their corrected values and found no substantial differences that would change our original conclusions. (this one was for my own sanity and fun).

### Final Thoughts
Going forward, I would have preferred to model the data to account for the zero-inflated distributions. Unfortunately, steps to model a zero-inflated model were not covered in that semester. 

## Relevant Skills Used
- Hypothesis Testing
- Critical Thinking
- Problem Solving
- Data Cleaning & Manipulation
- Exploratory Data Analysis (EDA)
- Statistical Modeling
- R
- STATA
- Data Visualization
  -  [Interaction Plot](https://github.com/17tking/HypothesisTesting.TavishKing/blob/main/FINAL_PROJECT/Int_Plot.png)
  -  [Linear Regress Plot1](https://github.com/17tking/HypothesisTesting.TavishKing/blob/main/FINAL_PROJECT/Lin_Plot1.png)
  -  [Linear Regress Plot2](https://github.com/17tking/HypothesisTesting.TavishKing/blob/main/FINAL_PROJECT/Lin_Plot2.png)
  -  [RVF Plot](https://github.com/17tking/HypothesisTesting.TavishKing/blob/main/FINAL_PROJECT/rvf_Plot.png)
