# Two-staged Heckman Model; application to authoritarian institutions
An implementation of two-staged Heckman model needed to correct self-selection bias of of authoritarian institutions.

This model is frequently used in studies on authroritarian institutions (such as parties, parliaments, and elections). Manu scholars try to identify the impact of these institutions on regime performance. However, the problem occurs: authoritarian institutions are not randomly distributed across the regimes. Dictators have a strong impact on how these institutions are shaped, and, while some of the factors which affect their choices can be observed, some others (such as, for example dictators' motives) are not. It is still possible that, for one reason or another, dictators who choose to improve the rule of law in their countries tend to also also prefer to open a legislature, allow for multiple parties and have regular elections. If this is the case, it might happen that the observable impact of institutionson the rule of law is in fact the impact of dictator's good motives, and that, on their own, institutions do not have any effect.

To deal with that, several scholars (such as Gandhi 2008, 2008a, Wright 2008, Escribà-Folch 2010) apply a modified two-staged Heckman model. In a classical Heckman model, an outcome variable for some observations is not observable (for example, Heckman used this model for modelling female labor force participation and wages; in that example, the salaries of women who chose not to work were not observable, and a decision not to work is not random but depends on a number of factors). In the current case, the outcome of authoritarian regimes is observed in all cases; howeverm the problem of self-selection of authoritarian institution remains and has to be solved.

Unfortunately, this partucular modfication of two-stage Heckman model, which is quite complex, is usually taken for granted by scholars working in the field, with the exception of Gandhi (2008a) who described in some details how the model works. Thus, I publish here an R script for how the model can be done in R, applied to my own data and research question.

The steps for the model can be described as follows:

1) estimate a probit model which estimate the impact of factors  affecting the selection of institutions
2) calculate from this model an inverse of Mill's ratio, for every institutional outcome of interest; that will serve as a proxy of random errors from the model from the step (1)
3) construct a regression model for each institution separately including an
    inverse of Mill's ratio for each institutional outcome as an explanatory variable; one can use a
    simple linear regression or also a regression correcting for
    autocorrelation of errors in panel data; this way, one gets unbiased estimates of
    coefficients, controlling for self-selection;
4) use the regression coefficients from step
    3 to calculate predicted value of the dependent variable (Ŷ) for
    **all the data**; in this way, for every institutional outcome, one estimates what the value of Y would
    have been if all country-years had the this particular institution;
5) use a simple t-test, to determine if the difference between predicted Y-s is statistically significant and
    has an expected sign.

In my example, I use WGI Rule of Law index as an the dependent variable and the main independent variable is being both fully formally institutionalized (meaning, having parliaments, parties, and multiparty elections) and informally constrained (belonging to "military" or "party-based" authoritarian regimes, according to classification of B. Geddes; the idea is that in these regimes the ruling group is genuinely able to affect dictator's decision-making).

Control varaibles:
1) Logged GDP per capita (PPP, 2011 international dollars)
2) Logged population
3) Infant mortality(deaths before 1 years of age per 1000 live births)
4) Resource dependence (sum of oil, gas, and mineral rents)
5) Regime longevity (years)
6) Democratic legacy (dummy; 1 if previous regime was democratic)

Requred packaged: "sampleSelection", "panelAR". 

References:

Gandhi, J. (2008). "Dictatorial Institutions and their Impact on Economic Growth". European Journal of Sociology,
49-1, 3-30.

Gandhi, J. (2008a). Political Institutions under Dictatorship. Cambridge: Cambrige University Press.

Escribà-Folch, A. (2009). "Do authoritarian institutions mobilize economic
cooperation?" Constitutional Political Economy, 20, 71-93.

Wright, J.(2008). "Do Authoritarian Institutions Constrain? How Legislatures Affect Economic Growth and Investment".
American Journal of Political Science, 52-2, 322-343.

