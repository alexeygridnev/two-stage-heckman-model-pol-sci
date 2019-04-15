library(sampleSelection)
library(panelAR)

#load the data:
df=read.csv("Dataset.csv")

#simple probit model for the probability of being formally institutionalized and informally constrained
heck -> glm(full_inst ~ loggdp+logpop+inf_mort+resource+dem_legacy, 
         data=df,
         family=binomial("probit"))

#inverse of Mill's Ratio for being (mill1) and not being (mill0) fully instituionalized: 
df$mill1 -> invMillsRatio(heck)$IMR1
df$mill0 -> invMillsRatio(heck)$IMR0

#splitting the dataset into fully institutionalized regimes and all the others:
df_noinst -> subset(df, df$full_inst==0)
df_inst -> subset(df, df$full_inst==1)

#simple OLS model for the Rule of Law index for regimes which are not fully institutionalized;
#Inverse of Mill's Ratio included to correct for self-selection
sim1.0 -> lm(RL.EST ~ loggdp+logpop+inf_mort+resource+gwf_duration+dem_legacy+mill0, data=df_noinst)

#applying the coefficients model "sim 1.0" for the entire dataset, to generate the simulated values of RL.EST
#they reflect what the values of RL.EST would have been if all country-years WERE NOT fully institutionalized:
df$yhat_sim1.0 -> predict(sim1.0, newdata=df)

#same procedure to generate the simulated values of RL.EST, to model what the values of RL.EST would have been
#if all country-years WERE fully-institutuinalized
sim1.1 -> lm(RL.EST ~ loggdp+logpop+inf_mort+resource+gwf_duration+dem_legacy+mill1, data=df_inst)
df$yhat_sim1.1 -> predict(sim1.1, newdata=df)

#regular t-test to compare the means 
t.test(df$yhat_sim1.0, df$yhat_sim1.1)

#same procedure, but with panel-corrected standard errors for models:
#PTS_S, AR(1)
sim2.0 -> panelAR(RL.EST ~ loggdp+logpop+inf_mort+resource+gwf_duration+dem_legacy+mill0,
               data=df_noinst,
               panelVar="country",
               timeVar="year",
               autoCorr="ar1",
               panelCorrMethod="pcse",
               seq.times=TRUE,
               rho.na.rm=TRUE)
df$yhat_sim2.0 -> predict(sim2.0, newdata=df)$fit

sim2.1 -> panelAR(RL.EST ~ loggdp+logpop+inf_mort+resource+gwf_duration+dem_legacy+mill1,
               data=df_inst,
               panelVar="country",
               timeVar="year",
               autoCorr="ar1",
               panelCorrMethod="pcse",
               seq.times=TRUE,
               rho.na.rm=TRUE)
df$yhat_sim2.1 -> predict(sim2.1, newdata=df)$fit

t.test(df$yhat_sim2.0, df$yhat_sim2.1)

#PTS-A, pooling

sim3.0 -> lmsim1.0=lm(RL.EST ~ loggdp+logpop+inf_mort+resource+gwf_duration+dem_legacy+mill0, data=df_noinst)
df$yhat_sim3.0 -> predict(sim3.0, newdata=df)

sim3.1 -> lm(RL.EST ~ loggdp+logpop+inf_mort+resource+gwf_duration+dem_legacy+mill1, data=df_inst)
df$yhat_sim3.1 -> predict(sim3.1, newdata=df)

t.test(df$yhat_sim3.0, df$yhat_sim3.1)

