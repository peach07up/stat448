/* Solution code for Homework 5 in Stat 448 sections A1 and C1 at 
   University of Illinois, Spring 2017 */
ods html close; 
options nodate nonumber;
title;
ods rtf file='C:\Stat 448\HW5_Sp17_Solution.rtf' 
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
/* The following data is based on the data from Keyfitz and Flieger (1972) described on page
   page 316 of A Handbook of Statistical Analyses Using SAS, 3rd Edition by Der and Everitt.
   The life.dat data file is distributed with the data sets for that text. 
*/
data life;
    infile 'c:\Stat 448\life.dat';
	input country $20. m0 m25 m50 m75 f0 f25 f50 f75;
data life;
	set life;
	/* omit Trinidad (62) because tehre appears to be a typo in one of its values */
	where country ne "Trinidad (62)";
run;
* Exercise 1;
proc genmod data = autos plots=cooksd;
	class fuel drive cylinders;
	model hwaympg = fuel drive hp enginesize cylinders/ dist=p dscale;
	output out=pdiagnostics cooksd=cd;
	ods select CooksDPlot;
run;
proc genmod data = pdiagnostics plots=cooksd;
	class fuel drive cylinders;
	model hwaympg = fuel drive hp enginesize cylinders/ dist=p dscale;
	where cd<1;
	output out=pdiagnostics2 cooksd=cd2;
	ods select CooksDPlot;
run;
proc genmod data = pdiagnostics2 plots=(cooksd stdresdev);
	class fuel drive cylinders;
	model hwaympg = fuel drive hp enginesize cylinders/ dist=p dscale type1 type3;
	where cd2<.1;
	output out=pres pred=phwympg stdresdev=dresids;
	ods select DiagnosticPlot Type1 Type3 ParameterEstimates ModelInfo ModelFit;
run;
proc sgplot data=pres;
	scatter y= dresids x=phwympg;
run;
* Exercise 2;
proc princomp data=life plots=score(ellipse ncomp=3);
    var m0--f75;
    id country;
    ods select Eigenvalues Eigenvectors Screeplot Scoreplot;
run;
* Exercise 3;
proc princomp data=life cov plots=score(ellipse ncomp=2) out=pcoutCovariance;
    var m0--f75;
    id country;
    ods select Eigenvalues Eigenvectors TotalVariance Screeplot Scoreplot;
run;
* Exercise 4;
proc cluster data=pcoutCovariance method=average pseudo ccc print=10;
	var m0--f75;
    id country;
	copy Prin:;
	ods select Dendrogram ClusterHistory CccPsfAndPsTSqPlot;
run;
proc tree ncl=5 out=covresults noprint;
	copy country Prin: ;
run;
proc sort data=covresults;
	by cluster;
proc means data=covresults;
	var Prin1 Prin2;
	by cluster;
run;
proc sgplot data=covresults;
	scatter x=Prin1 y=Prin2/ group=cluster datalabel=country;
run;
ods rtf close;
