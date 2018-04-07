* ods html close; 
* ods preferences;
* ods html newfile=proc;
data water;
	* modifiy path to match your files;
	infile 'c:\Stat 448\water.dat';
    input flag $ 1 Town $ 2-18 Mortal 19-22 Hardness 25-27;
    if flag='*' then location='north';
        else location='south';
run;
proc print data=water;
run;
/* get a scatter plot of hardness vs. mortality */
proc sgplot data=water;
	scatter x=hardness y=mortal;
run;
/* get basic univariate results for mortality and hardness individually */
proc univariate data=water;
	var mortal hardness;
run;
proc univariate data=water;
	var mortal hardness;
	/* add univariate visualizations */

	/* add ods statement to just grab the plots */
run;
/* one sample t tests assume an underlying normal population, 
   so should check if that assumption seems reasonable 
   if we want to use a t test for location;
   option to histogram for general EDF tests */
proc univariate data=water;
  var mortal hardness;
  histogram mortal hardness /normal;
  ods select Histogram GoodnessOfFit; 
run;
/* option to proc for normality tests */
proc univariate data=water normal;
  var mortal hardness;
  ods select TestsForNormality;
run;
/* use both options to get a histogram and pdf, and to see difference in tests */
proc univariate data=water normal;
  var mortal hardness;
  histogram mortal hardness /normal;
  ods select Histogram GoodnessOfFit TestsForNormality;
run;
/* check correlations */
proc corr data=water;
run;
/* scatter plots by location */
proc sgplot data=water;
	scatter x=hardness y=mortal/group=location;
run;
/* univariate results by location (will need to sort by location first....) */

/* correlations by location */

/* location test for mortal and hardness by geographic location with mu0=1500 45 */

/* location test for mortality ignoring geographic location */

/* just the t-test using proc ttest */

/* again, this could be done by location to test the north and south samples separately */

/* one-sided test to see if mortality is significantly greater than the null value */

/* t-test for equal mean mortality in each geographic location */

/* demonstrate upper and lower tailed tests */
proc ttest data=water sides=u;
  class location;
  var mortal;
  ods select ConfLimits TTests Equality;
run;

/* add lower tail case */

/* rank sum test for calcium concentration */


/* add variable for log of hardness to data set */
data water;
  set water;
  lhardnes=log(hardness);
run;
/* check normality assumption for entire sample 
  if we wanted to perform a test on the entire population */

/* test by group (geographic location in this case) if 
  we want to test for group differences */


/* given the normality tests, we shouldn't trust a t-test;
   if we could trust a t-test, we could use the following
   and pick out any results of interest */ 


/* a rank based test could be used on lhardnes */
