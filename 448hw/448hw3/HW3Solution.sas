/* Solution code for Homework 3 in Stat 448 sections A1 and C1 at 
   University of Illinois, Spring 2017 */
ods html close; 
options nodate nonumber;
title;
ods rtf file='C:\Stat 448\HW3_Sp17_Solution.rtf' 
	nogtitle startpage=no;
ods noproctitle;
/* The raw data in housing.data is from
   and described on https://archive.ics.uci.edu/ml/datasets/Housing
   Bache, K. & Lichman, M. (2013). UCI Machine Learning Repository 
   [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, 
   School of Information and Computer Science.
*/
data housing;
	infile 'C:\\Stat 448\housing.data';
	input crim zn indus chas nox rm age dis rad tax ptratio b lstat medv;
	logmedv = log(medv);
	over25kSqFt = 'none';
	if zn > 0 then over25kSqFt = 'some';
	taxlevel = 'higher';
	if tax < 500 then taxlevel = 'lower';
	ptlevel = 'medium';
	if ptratio < 15 then ptlevel = 'lower';
	if ptratio > 20 then ptlevel = 'higher';
	drop zn tax ptratio b lstat rad dis chas;
run;
data housing;
	set housing;
	where medv<50;
	drop medv;
run;
* Exercise 1;
proc glm data=housing;
	class over25kSqFt ptlevel taxlevel;
	model logmedv = ptlevel over25kSqFt taxlevel;
	lsmeans ptlevel over25kSqFt taxlevel/ pdiff=all cl;
	ods select OverallAnova ModelAnova FitStatistics LSMeans LSMeanDiffCL;
run;
* Exercise 2;
proc glm data=housing;
	class over25kSqFt ptlevel taxlevel;
	model logmedv = ptlevel|over25kSqFt|taxlevel@2;
	ods select ModelAnova;
run;
proc glm data=housing;
	class over25kSqFt ptlevel taxlevel;
	model logmedv = ptlevel over25kSqFt 
		taxlevel over25kSqFt*ptlevel;
	lsmeans ptlevel over25kSqFt 
		taxlevel over25kSqFt*ptlevel/ pdiff=all cl;
	ods select OverallAnova ModelAnova FitStatistics LSMeans LSMeanDiffCL;
run;
* Exercise 3;
proc reg data=housing;
	model logmedv = age;
	where crim<1;
	output out=diag3a CookD=cd;
	ods select DiagnosticsPanel;
run;
proc reg data=diag3a;
	model logmedv = age;
	where crim<1 and cd <.06;
	ods select ANOVA ParameterEstimates FitStatistics DiagnosticsPanel;
run;
* Exercise 4;
proc reg data=housing;
	model logmedv = age indus nox rm
		/selection=stepwise sle=.05 sls=.05;
	where crim<1;
	output out=diag4a CookD=cd;
	ods select SelectionSummary DiagnosticsPanel;
run;
proc reg data=diag4a;
	model logmedv = age indus nox rm;
	where crim<1 and cd<.1;
	output out=diag4a2 CookD=cd2;
	ods select DiagnosticsPanel;
run;
proc reg data=diag4a2;
	model logmedv = age indus nox rm;
	where crim<1 and cd2<.06;
	ods select ANOVA ParameterEstimates FitStatistics 
		DiagnosticsPanel ResidualPlot;
run;quit;
ods rtf close;
