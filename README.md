# two-stage-heckman-model-pol-sci
An implementation of two-staged Heckman model needed to correct self-selection bias of of authoritarian institutions.

This model is frequently used in studies on authroritarian institutions (such as parties, parliaments, and elections). Manu scholars try to identify the impact of these institutions on regime performance. However, the problem occurs: authoritarian institutions are not randomly distributed across the regimes. Dictators have a strong impact on how these institutions are shaped, and, while some of the factors which affect their choices can be observed, some others (such as, for example dictators' motives) are not. It is still possible that, for one reason or another, dictators who choose to improve the rule of law in their countries tend to also also prefer to open a legislature, allow for multiple parties and have regular elections. If this is the case, it might happen that the observable impact of institutionson the rule of law is in fact the impact of dictator's good motives, and that, on their own, institutions do not have any effect.

To deal with that, several scholars (such as Gandhi 2008, 2008a, Wright 2008, Escribà-Folch 2010) apply a modified two-staged Heckman model. Unfortunately, this partucular model, which is quite complex, is quite poorly documented by them, with the exception of Gandhi (2008a). Thus, I publish here an R script for how the model can be done in R, applied to my own data and research question.

(Model desrtiption: to be continured)

Requred packaged: "sampleSelection", "panelAR". 

References:

Gandhi, J. (2008). "Dictatorial Institutions and their Impact on Economic Growth". European Journal of Sociology,
49-1, 3-30.

Gandhi, J. (2008a). Political Institutions under Dictatorship. Cambridge: Cambrige University Press.

Escribà-Folch, A. (2009). "Do authoritarian institutions mobilize economic
cooperation?" Constitutional Political Economy, 20, 71-93.

Wright, J.(2008). "Do Authoritarian Institutions Constrain? How Legislatures Affect Economic Growth and Investment".
American Journal of Political Science, 52-2, 322-343.

