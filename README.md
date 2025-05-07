# Alcohol Use and Delinquency - Hypothesis Testing
This was my final project for a **graduate-level psychological statistics course (Fall 2024)**. I independently cleaned and explored a dataset, developed hypotheses, and conducted statistical analyses using course concepts. The project emphasized **data wrangling**, **hypothesis testing**, and **exploratory data analysis (EDA)** while encouraging creativity in research questions.

**Key words:** regression analyses, modeling, data cleaning, statistics, visualization, research, R

## Project Objective
### Instructions
Some of your other colleagues ask you to help analyze data about about delinquency and drug use among adolescents. Their primary interest is understanding **how self-control is related to alcohol use.** They also want to know **how friends’ delinquency is related to alcohol use** as well as **how friends’ delinquency may influence the relationship between selfcontrol and alcohol use.** The dataset (delinquency_drugs.dta) also includes other demographic, education, and substance use variables that you will want to consider in your analysis as covariates.

Your task is to conduct analyses that will answer your colleagues’ questions. We have covered during this semester all the statistics and analysis approaches you will need to fully answer these questions. You should use concepts/analyses from throughout the semester to address the questions (e.g., descriptive statistics, graphs, confidence intervals, effect sizes, etc.). Additionally, you also need to write a memo to your colleagues that describes and interprets your results (you may need to create tables or construct figures to explain your results).

### Data Set Used + Codebook
- [delinquency_data.dta](FINAL_PROJECT/delinquency_data.dta)
- [Codebook](https://github.com/17tking/HypothesisTesting.TavishKing/blob/main/FINAL_PROJECT/Codebook%20for%20DelinquencyDrugs%20dataset.pdf)
  
### Hypotheses
1. Controlling for key predictors in our model, we hypothesize that lower self-control will be associated with greater alcohol use.
2. We also predict that higher levels of friend delinquency will be associated with greater alcohol use.
3. Finally, we hypothesize that friend delinquency will moderate the relationship between low self-control and alcohol use.
   
### Analysis Plan
#### Data Cleaning
- removing ages 11 and 20 due to low observations
- center age to the easily intepretable minimum (13yrs)
- dummy code Male as the baseline in the gender variable
#### EDA
- view selected variables' correlation with alcohol use (DV)
- create histograms to analyze distribution of data
#### Analysis
- Linear Regression Analyses
- Check Assumptions

### Project Insights
- 17-year-olds showed highest average consumption of alcohol in the year (*M* = 0.93, *SD* = 0.91)
- Females showed significantly higher average alcohol use than Males (*t* = 8.12, *M* = 0.83, *p* < .001)
- Predictors in the final model explained 58% of the variability in alcohol use
  
### Conclusions
Our analysis found that <sup>*(Hyp.1)*</sup>**lower self-control was linked to reduced alcohol consumption** and <sup>*(Hyp.2)*</sup>**greater friend delinquency was positively associated with alcohol use**. For Hypothesis 3, an interaction effect revealed that individuals with **high self-control and delinquent friends** (2 SD above the mean) had the greatest risk of alcohol use.

A **residual vs. fitted (RVF) plot** indicated heteroskedasticity. To assess potential bias, we applied a **Heteroskedasticity-Corrected Covariance Matrix** in **R**, comparing original and corrected SEs and p-values. Results confirmed no meaningful differences, reinforcing our conclusions. (This analysis was done for my own curiosity and fun.)

## Relevant Skills Used
- Hypothesis Testing
- Critical Thinking
- Problem Solving
- Data Cleaning & Manipulation
- Exploratory Data Analysis (EDA)
- Data Interpretation and Reporting
- Statistical Modeling
- R
- STATA
- Data Visualization
  -  [Interaction Plot](https://github.com/17tking/HypothesisTesting.TavishKing/blob/main/FINAL_PROJECT/Int_Plot.png)
  -  [Linear Regress Plot1](https://github.com/17tking/HypothesisTesting.TavishKing/blob/main/FINAL_PROJECT/Lin_Plot1.png)
  -  [Linear Regress Plot2](https://github.com/17tking/HypothesisTesting.TavishKing/blob/main/FINAL_PROJECT/Lin_Plot2.png)
  -  [RVF Plot](https://github.com/17tking/HypothesisTesting.TavishKing/blob/main/FINAL_PROJECT/rvf_Plot.png)
