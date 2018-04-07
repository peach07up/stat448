 ods html close; 
 ods preferences;
 ods html newfile=proc;
data uscrime;
	infile 'c:\Stat 448\uscrime.dat' expandtabs;
    input R Age S Ed Ex0 Ex1 LF M N NW U1 U2 W X;
run;
proc glm data=uscrime;
	model R = ex0 x ed age u2/ ss1 ss3;
	ods select ParameterEstimates ModelANOVA;
run;
proc genmod data=uscrime;
	* normal and identity are defaults for dist and link when response is 
	  not given as events/trials, so there is no need to set those options 
	  here but we could set like in the textbook;
	model R = ex0 x ed age u2/ type1 type3
		dist=normal link=identity;
	ods select ModelInfo ParameterEstimates Type1 Type3;
run;
data ghq;
  infile 'c:\Stat 448\ghq.dat' expandtabs;
  input ghq sex $ cases noncases;
  total=cases+noncases;
run;
proc logistic data=ghq;
   	class sex / param=ref;
   	model cases/total=ghq sex;
   	ods select ModelInfo ClassLevelInfo 
		ParameterEstimates Type3;
run;
proc genmod data=ghq;
   	class sex ;
   	model cases/total=ghq sex/ type3
		dist=binomial link=logit;
   	ods select ModelInfo ParameterEstimates Type3;
run;
data ozkids;
	infile 'c:\Stat 448\ozkids.dat' dlm=' ,' expandtabs missover;
    input cell origin $ sex $ grade $ type $ days @;
        do until (days=.);
          output;
          input days @;
        end;
run;
* Poisson log-linear model;
proc genmod data=ozkids;
	class origin grade sex type;
	model days = origin grade sex type/type1 type3
		dist=poisson link=log;
run;
* overdispersed Poisson log-linear model;
proc genmod data=ozkids;
	class origin grade sex type;
	model days = origin grade sex type/type1 type3
		dist=poisson link=log scale=d;
run;

















* previous ANOVA model for comparison;
proc glm data=ozkids;
	class origin sex grade type;
	model days = origin sex grade type/ ss3 ss1;
	ods select OverallANOVA FitStatistics ModelANOVA;
run;
















* FAP data set;
data fap;
  infile 'c:\Stat 448\fap.dat';
  input male treat base_n age resp_n;
run;
proc print data=fap;
run;

* gamma model;

* overdispersed Poisson model;

* plot standardized Pearson and deviance residuals vs. predicted values for both models;

* getting plots of standardized Pearson and deviance residuals for both model
  and just displaying the model info and plots;


