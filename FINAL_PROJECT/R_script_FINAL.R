library(tidyverse)
library(car)
library(flexplot)
library(gtsummary)
library(corrplot)
library(readstata13)
library(ggthemes)
library(flextable)
library(lmtest)
library(sandwich)
library(moments)
library(margins)
options(scipen = 999)
#Full Data
delinquency.data<- read.dta13("delinquency_data.dta") %>% 
  filter(age != 11) %>% # only 1 observation
  filter(age !=21) # only 2 observations
################
# DATA CLEANING
################
# Step 1: Get Demographic Info & sample size
# N = 11,223 (nice, large sample size. Can make appropriate inferences)
#
# Age descriptives
summary(delinquency.data$age) # M = 15.58, range = 12-20
sd(delinquency.data$age)
# Gender descriptives
summary(delinquency.data$gender) # female = 5908, male = 5312
# Race/Ethnicity descriptives
summary(delinquency.data$ethnicity)
# Asian & PI    Black     Latinx Mixed    ethnic     Native Am      White 
#   928         2117          804          937          342         6092
# making ethnicity proportions
ethnicity.prop <- data.frame( 
  asian.prop = (928/11220)*100,
  black.prop = (2117/11220)*100,
  latinx.prop = (804/11220)*100,
  ethnic.prop = (937/11220)*100,
  nativeam.prop = (342/11220)*100,
  white.prop = (6092/11220)*100)
#
# Step 2: Standardize the appropriate variables for easier interpretation
## GPA, low selfcontrol, and friend delinquency are already standardized
delinquency.data <- delinquency.data %>% 
  mutate(age_c = age-min(age)) %>%  #minimum centering for easier interpretation
  mutate(gender = relevel(gender, "male")) #releveling gender

#####################
# RESEARCH QUESTIONS
#####################
# Step 3: Hypothesize and Formulate RQ
#
## RQ1: Primary interest is understanding how low self-control is
#       related to alcohol use.
#  Hypothesis 1: Higher low self-control will be associated with greater alcohol use
#
## RQ2: How friend's delinquency is related to alcohol use
#       as well as how friend's delinquency may influence the 
#       relationship between low self-control and alcohol use.
#  Hypothesis 2: Greater friend's delinquency will be associated with greater
#                individual alcohol use
#  Hypothesis 3: Friend's delinquency moderates the relationship between low self-control
#                and alcohol use, such that the negative relationship between
#                low self-control and alcohol use will be stronger when Friend's 
#                Delinquency is high
#
############################
# EXPLORATORY DATA ANALYSIS
############################
# Step 4: EDA
#
# Age Distribution on Alcohol Consumption
ggplot(delinquency.data,aes(x=age, y= alcohol, group = age_c))+
  geom_boxplot()+
  scale_x_continuous(breaks = seq(12, 20, 1), labels = seq(12, 20, 1),
                     limits = c(11.6,20.4)) +
  theme_stata()+
  theme(plot.background = element_rect(fill = "white"))
#
# Gender distribution on Alcohol consumption
ggplot(delinquency.data, aes(x= gender, y = alcohol, fill = gender))+
  geom_boxplot(width = 0.4)+
  theme_stata()+
  theme(plot.background = element_rect(fill = "white"))
#
# ALCOHOL (outcome varage_c# ALCOHOL (outcome variable)
summary(delinquency.data$alcohol)
sd(delinquency.data$alcohol)
ggplot(delinquency.data, aes(alcohol))+
  geom_histogram(bins = 30, fill = "steelblue", color = "black")+
  scale_x_continuous(breaks = seq(0, 6, 1), labels = seq(0, 6, 1),
                     limits = c(-0.2,6)) +
  labs(
    # title = "Figure 1.",
    # subtitle = "Distribution of Alcohol",
    x = "# of Alcohol Drinks Consumed in Year",
    y = "Frequency")+
  theme_stata()+
  theme(
        # plot.title = element_text(face = "bold", size = 14, hjust = 0),
        # plot.subtitle = element_text(face = "italic", size = 12, hjust = 0),
        axis.title = element_text(size = 12),
        plot.background = element_rect(fill = "white"))

# LOW SELF-CONTROL (cov 1)
summary(delinquency.data$selfcontrol) #standardized
sd(delinquency.data$selfcontrol)
hist(delinquency.data$selfcontrol) #normal
Lin.Plot1 <- ggplot(delinquency.data, aes(x=selfcontrol, y=alcohol))+
  geom_point(alpha = 0.2, color = "gray20")+
  geom_smooth(method = "lm", color = "red3")+
  scale_x_continuous(breaks = seq(-2, 3, 1), labels = seq(-2, 3, 1),
                     limits = c(-1.6,3)) +
  labs(
       # title = "Figure 2.",
       # subtitle = "Relationship Between Low Self-Control and Alcohol Consumption",
       x = "Low Self-Control (standardized)",
       y = "# of Alcohol Drinks")+
  theme_stata()+
  theme(
        # plot.title = element_text(face = "bold", size = 14),
        # plot.subtitle = element_text(face = "italic", size = 12),
        axis.title = element_text(size = 14),
        plot.background = element_rect(fill = "white"))

ggsave("Lin_Plot1.png", Lin.Plot1, width = 7, height = 5, units = "in")


# FRIEND DELINQUENCY (cov 2)
summary(delinquency.data$frienddelinquency) #standardized
sd(delinquency.data$frienddelinquency)
hist(delinquency.data$frienddelinquency) #not normal
Lin.Plot2 <- ggplot(delinquency.data, aes(x=frienddelinquency, y=alcohol))+
  geom_point(alpha = 0.2, color = "gray20")+
  geom_smooth(method = "lm", color = "red3")+
  scale_x_continuous(breaks = seq(-1, 2, 1), labels = seq(-1, 2, 1),
                     limits = c(-1,2.2)) +
  labs(
       # title = "Figure 3.",
       # subtitle = "Relationship Between Friend Delinquency and Alcohol Consumption",
       x = "Friend Delinquency (standardized)",
       y = "# of Alcohol Drinks")+
  theme_bw()+
  theme(
        # plot.title = element_text(face = "bold", size = 14),
        # plot.subtitle = element_text(face = "italic", size = 12),
        axis.title = element_text(size = 14),
        plot.background = element_rect(fill = "white"))

ggsave("Lin_Plot2.png", Lin.Plot2, width = 7, height = 5, units = "in")

# INTERACTION between LOW SELF-CONTROL & FRIEND DELINQUENCY
flexplot(alcohol ~ selfcontrol | frienddelinquency,
         data = delinquency.data,
         alpha = 0.3,
         method = "lm")+
  labs(
       # title = "Figure 4.",
       # subtitle = "Interaction Between Low Self-Control and Friend Delinquency on Alcohol",
       x = "Low Self-Control (standardized)",
       y = "# of Alcohol Drinks")+
  theme_stata()+
  theme(
        # plot.title = element_text(face = "bold", size = 14),
        # plot.subtitle = element_text(face = "italic", size = 12),
        axis.title = element_text(size = 12),
        plot.background = element_rect(fill = "white"))
#
hist(delinquency.data$cigarettes) #not normal
hist(delinquency.data$marijuana) #not normal

###########
# ANALYSIS
###########
# Step 5: Analysis 
#
null.mod <- lm(alcohol~1, data = delinquency.data)
summary(null.mod)
#
mod1 <- lm(alcohol~selfcontrol*frienddelinquency, data = delinquency.data)
summary(mod1)
# Interpretation: 
#
# Intercept = 0.77; the expected value of alcohol consumed for those at the mean level of 
#             low self-control (0) and the mean level of friend delinquency (0).
#
# selfcontrol = 0.02; the slope for low self-control when friend delinquency is at
#               the mean (0).
#
# frienddelinquency = 0.31; the slope for friend delinquency when low self-control 
#                     is at the mean (0).
#
# Interaction = -0.04; the difference in the slopes for low self-control and friend
#               delinquency.
############################################
mod2 <- lm(alcohol~selfcontrol*frienddelinquency + cigarettes + marijuana + age_c + gender,
           data = delinquency.data)
summary(mod2)
avPlots(mod2, id=F, col = carPalette()[1],
        col.lines = carPalette()[8],
        grid = F,
        main = paste("Partial Slopes"),
        marginal.scale=T,
        pch=1, lwd = 2)
# Interpretation:
# 
## Adj. R-squared = 0.5813; 58.13% of the variability in alcohol use can be
#                   explained by our 6 predictors. F(7, 11,215) = 2227, p<.001.
#
## Intercept = -0.07; the expected value of alcohol consumed...
#
#
#
#
##############
# ASSUMPTIONS
##############
#
# Heteroskedasticity
plot(mod2) #evidence of heteroskedasticity
qplot(mod2$residuals, data = delinquency.data) #appears normal
skewness(mod2$residuals) #low skewness
kurtosis(mod2$residuals) # leptokurtic
bptest(mod2) #statistical test for heteroskedas.
coeftest(mod2, vcov = vcovHC(mod2, type = "HC3")) # HCCM procedure

# Conclusion: Residuals are approximately normal, but there is
#             evidence of heteroskedasticity. Therefore, we run
#             the risk of having biased standard errors and p-values.
#             Using a Heteroskedastic Corrected Covariance Matrix, we
#             compared our original models SE's and p-values to their
#             corrected values and found no substantial differences that 
#             would change our original conclusions.
#
#############################################
# TABLES
##########
# Regression Table
tbl_regression(mod2)
#
#############
# CONCLUSION
#############
# Step 7: Conclusio	0.07	0.05, 0.09	<0.001
