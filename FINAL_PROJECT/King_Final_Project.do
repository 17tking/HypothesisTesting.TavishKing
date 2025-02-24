*clearing any previous data
clear all

* loading data
use "delinquency_data"

* viewing codebook
codebook, compact
// no missing values
// gpa, selfcontrol, and frienddelinquency are standardized

* Research Questions:
// How is self-control related to alcohol use?
// How is friend's delinquency related to alcohol use?
// How does friend's delinquency influence the relationship between self-control and alcohol use?

**********************
* Viewing Variables **
**********************

***AGE (predictor 5)
summarize age
summarize age, detail
tabulate age
// will need to remove ages 11 (1 observation) and 21 (2 observations)

***GENDER (predictor 6)
tabulate gender

***ETHNICITY
tabulate ethnicity

****************
* Data Cleaning
****************
// steps:
// 1. remove age values 11 & 21
// 2. center age to the minimum
// 3. dummycode male as the baseline in the gender variable (1 level, j-1)

**step 1:
drop if age == 11
drop if age == 21
summarize age // range = 12-20. GOOD!

**step 2:
summarize age
gen age_c = age - r(min)
// age_c = age_centered 

**step 3:
generate male_dummy = 1 if gender == 1 //female is coded as 1 and male will be 0
replace male_dummy = 0 if gender != 1
// male is now the baseline

******************************
* Exploratory Data Analysis **
******************************
pwcorr alcohol selfcontrol frienddelinquency cigarettes marijuana age_c male_dummy
** Descriptives

***ALCOHOL (outcome)
summarize alcohol
summarize alcohol, detail
histogram alcohol, start(-0.1) scheme(s1mono) percent
tabulate alcohol
// right skewed with 25.88% of responses reporting 0 instances of alcohol use in the year
// do not need to normalize as it is the response variable

***SELF-CONTROL (predictor 1)
// measured as low self-control, indicating higher responses equals greater low self-control (bad)
summarize selfcontrol
summarize selfcontrol, detail
histogram selfcontrol, scheme(s1mono) frequency
// appears normally distributed with some skewness and maybe outliers

***FRIEND DELINQUENCY (predictor 2)
summarize frienddelinquency
summarize frienddelinquency, detail
histogram frienddelinquency, scheme(s1mono) percent
tabulate frienddelinquency
// right skewed, non-normal, may consider transformation
// 35.53% reporting friend delinquency 0.75 SDs below the mean of frienddelinquency which indicates that 35.53% have no frienddelinquency. Will not transform

***CIGARETTES (predictor 3)
summarize cigarettes
summarize cigarettes, detail
histogram cigarettes
tabulate cigarettes
// similar to alcohol variable, largely right skewed with 37.24% of the sample reporting no cigarette use in the year. Will not transform. 

***MARIJUANA (predictor 4)
summarize marijuana
summarize marijuana, detail
histogram marijuana
tabulate marijuana
// largely right skewed with 29.57% of the sample reporting no marijuana use in the past year. Will not transform as it wont fix the skewness

***AGE AND ALCOHOL
graph box alcohol, over(age)
bysort age: summarize alcohol

***GENDER AND ALCOHOL
graph box alcohol, over(gender)
bysort gender: summarize alcohol
ttest alcohol, by(gender)

**linear relationship between selfcontrol and alcohol (supp. figure 2)
twoway (scatter alcohol selfcontrol, msymbol(o) mcolor(black%30) mlwidth(vvthin)) (lfit alcohol selfcontrol, lcolor(red) lwidth(thick)), xscale(r(-1.6 3)) xlabel(-2(1)3, labsize(small)) ylabel(, labsize(small)) xtitle("Low Self-Control (standardized)", size(medium)) ytitle("# of Alcohol Drinks", size(medium)) legend(off) graphregion(color(white)) plotregion(margin(zero))


**linear relationship between frienddelinquency and alcohol (supp. figure 3)
twoway (scatter alcohol frienddelinquency, msymbol(o) mcolor(black%30) mlwidth(vvthin)) (lfit alcohol frienddelinquency, lcolor(red) lwidth(thick)), xscale(r(-1 2.2)) xlabel(-1(1)2, labsize(small)) ylabel(, labsize(small)) xtitle("Friend Delinquency (standardized)", size(medium)) ytitle("# of Alcohol Drinks", size(medium)) legend(off) graphregion(color(white)) plotregion(margin(zero))


***********
* Analysis 
***********
* correlation analysis
pwcorr alcohol selfcontrol frienddelinquency cigarettes marijuana age, sig star(.05) obs

** multiple regression analysis

/// baseline model
regress alcohol c.selfcontrol c.frienddelinquency c.selfcontrol#c.frienddelinquency
// r-squared = 0.10
estat ic
// AIC = 26244.94

/// full model
regress alcohol c.selfcontrol c.frienddelinquency c.selfcontrol#c.frienddelinquency c.cigarettes c.marijuana c.age_c i.male_dummy
// r-sqaured = 0.58
estat ic
// AIC = 17577.72

vif // checking for multicollinearity

* interaction plot
margins, at(selfcontrol = (-1.5(1)2.5) frienddelinquency = (-1 0 2)) //min, mean, max
marginsplot, noci ///
    scheme(s1mono) ///
    legend(pos(6) row(1)) ///
    legend(subtitle("Level of Friend Delinquency")) ///
    title("") ///
    ytitle("Predicted Alcohol Consumption") ///
    xtitle("Average level of Self-Control - {it:z} score") ///
    legend(order(1 "-1 SD" 2 "Mean" 3 "2 SD"))
	

* Additional Figures

** (supp. figure 4)
rvfplot, msymbol(o) mcolor(black%15) yline(0)











