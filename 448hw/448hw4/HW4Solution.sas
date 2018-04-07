/* Solution code for Homework 4 in Stat 448 sections A1 and C1 at 
   University of Illinois, Spring 2017 */
ods html close; 
options nodate nonumber;
title;
ods rtf file='C:\Stat 448\HW4_Sp17_Solution.rtf' 
	nogtitle startpage=no;
ods noproctitle;
/* The raw data in imports-85.data is from
   and described on http://archive.ics.uci.edu/ml/datasets/Automobile
   Bache, K. & Lichman, M. (2013). UCI Machine Learning Repository 
   [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, 
   School of Information and Computer Science.
*/
data autos;
  infile 'C:\Stat 448\imports-85.data' dlm=',';
  input symbol loss make $ fuel $ aspiration $ doors $ style $ drive $ engineloc $ 
        base length width height weight enginetype $ cylinders $ enginesize fuelsys $
        bore stroke comp hp rpm citympg hwaympg price;
  cityover30mpg = citympg > 30;
  hwaympg=round(hwaympg); * convert to integer;
  price1k=price/1000;
  keep cityover30mpg price1k rpm fuel drive enginesize hwaympg hp cylinders;
data autos;
	set autos;
	* only keep common numbers of cylinders;
	where cylinders in("four", "six", "eight") and drive ne "4wd";
run;
* Exercise 1a;
proc freq data=autos;
	tables cylinders*cityover30mpg/ norow nocol nopercent expected;
run;
proc freq data=autos;
	tables fuel*cityover30mpg/ norow nocol nopercent expected;
run;
proc freq data=autos;
	tables drive*cityover30mpg/ norow nocol nopercent expected;
run;
* Exercise 1b;
proc logistic data = autos desc;
	class cylinders fuel drive/ param=ref;
	model cityover30mpg = cylinders fuel drive/selection=backward;
	ods select ResidualChiSq  ModelBuildingSummary;
run;
* Exercise 1c;
proc logistic data = autos desc;
	class fuel drive/ param=ref;
	model cityover30mpg = fuel drive/ lackfit;
	ods select OddsRatios ParameterEstimates 
		GlobalTests ModelInfo FitStatistics LackFitChiSq;
run;
* Exercise 2a;
proc logistic data = autos desc;
	model cityover30mpg = price1k rpm enginesize hp;
	ods select OddsRatios ParameterEstimates 
		GlobalTests ModelInfo FitStatistics;
run;
* Exercise 2b;
proc logistic data = autos desc;
	model cityover30mpg = price1k rpm enginesize hp/selection=backward;
	ods select ResidualChiSq  ModelBuildingSummary;
run;
* Exercise 2c;
proc logistic data = autos desc;
	model cityover30mpg = hp/ lackfit;
	ods select OddsRatios ParameterEstimates 
		GlobalTests ModelInfo FitStatistics LackFitChiSq;
run;
* Exercise 3 a;
proc genmod data = autos;
	class fuel drive cylinders;
	model hwaympg = fuel drive hp enginesize cylinders price1k rpm/ dist=p type1 type3;
	ods select ModelInfo ModelFit;
run;
proc genmod data = autos;
	class fuel drive cylinders;
	model hwaympg = fuel drive hp enginesize cylinders price1k rpm/ dist=p dscale type1 type3;
	ods select Type1 Type3 ModelInfo ModelFit;
run;
proc genmod data = autos;
	class fuel drive cylinders;
	model hwaympg = fuel drive hp enginesize cylinders price1k/ dist=p dscale type1 type3;
	ods select Type1 Type3 ModelInfo ModelFit;
run;
proc genmod data = autos;
	class fuel drive cylinders;
	model hwaympg = fuel drive hp enginesize cylinders rpm/ dist=p dscale type1 type3;
	ods select Type1 Type3 ModelInfo ModelFit;
run;
* final model;
proc genmod data = autos;
	class fuel drive cylinders;
	model hwaympg = fuel drive hp enginesize cylinders/ dist=p dscale type1 type3;
	ods select Type1 Type3 ParameterEstimates ModelInfo ModelFit;
run;
ods rtf close;
