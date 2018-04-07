ods html close; 
ods preferences;
ods html newfile=proc;
proc print data=sashelp.iris; 
run;
* use complete linkage and show last 15 merges;
proc cluster data=sashelp.iris method=complete print=15;
   var petal: sepal:;
   copy species;
run;
* try 3 clusters because we know there are 3 species;
proc tree noprint ncl=3 out=out;
   copy petal: sepal: species;
run;
proc print data=out;
run;
* cross-tabulation to see how well clusters match up with species;
proc freq data=out;
  tables cluster*species/ nopercent norow nocol;
run;
* use single linkage and show last 15 merges;
proc cluster data=sashelp.iris method=single 
	outtree= clustersngl print=15;
   var petal: sepal:;
   copy species;
run;
proc tree data= clustersngl noprint ncl=2 out=outs;
   copy petal: sepal: species;
run;
proc print data=outs;
run;
proc freq data=outs;
  tables cluster*species/ nopercent norow nocol;
run;
* use average linkage and show last 15 merges;
proc cluster data=sashelp.iris outtree=clustera
	method=average print=15;
   var petal: sepal:;
   copy species;
run;
proc tree data= clustera noprint ncl=4 out=outa;
   copy petal: sepal: species;
run;
proc print data=outa;
run;
proc freq data=outa;
  tables cluster*species/ nopercent norow nocol;
run;
* get ccc and pseudo t^2 and F stats and diagnostic plots for average linkage case;
proc cluster data=sashelp.iris method=average 
		ccc pseudo print=15 plots=all;
	var petal: sepal:;
   	copy species;
run;
* U.S. air quality data set;
data usair;
  infile 'c:\Stat 448\usair2.dat' expandtabs;
  input city $16. so2 temperature factories 
		population windspeed rain rainydays;
run;
proc print data=usair;
run;
* use univariate analysis to identify extreme observations;
proc univariate data=usair;
  var temperature--rainydays;
  id city;
  ods select ExtremeObs;
run;
*remove Chicago and Phoenix which are deemed extreme on several variables;
data usair2;
  set usair;
  if city not in('Chicago','Phoenix');
run;














* variables are on very different scales, so standardize measurements;
* use complete linkage and obtain ccc values for number of clusters;
proc cluster data=usair2 method=complete ccc std 
	outtree=complete;
  var temperature--rainydays;
  id city;
  copy so2;
run;





* obtain the desired number of clusters for analysis and retain original variables for later analyses;

* sort by cluster so we can do analysis by cluster;

* do means analysis on variables by cluster;

* perform principal components analysis on cluster data to extract 2 most prominent features;

* visualize the data points in the first two principal 
  coordinates and see where the clustered values are in this space;

* visualize the distribution of SO2 values by cluster;

* perform an analysis of variance on the SO2 levels as a function of cluster;

* nonparametric tests to avoid normality assumption;
