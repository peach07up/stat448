* ods html close; 
* ods preferences;
* ods html newfile=proc;
/* create the data set */
data ozkids;
	* modify path to point to your files;
	infile 'c:\Stat 448\ozkids.dat' dlm=' ,' expandtabs missover;
    input cell origin $ sex $ grade $ type $ days @;
	do until (days=.);
	  output;
	  input days @;
	end;
	input;
run;
/* see data */
proc print data=ozkids;
run;
/* get cell means and counts for days absent */

/* four-way cross-tabulation */

/* fit the two-way main effects model with origin and grade */
proc glm data=ozkids;
	class origin grade;
	model days = origin grade;
run;
/* switch the order of terms */
proc glm data=ozkids;
	class grade origin;
	model days = grade origin;
run;
/* add the interaction term */
proc glm data=ozkids;
	class origin grade;
	model days = origin|grade;
run;
/* switch ordering of main effects */
proc glm data=ozkids;
	class grade origin;
	model days = grade|origin;
run;
/* four-way main effects getting only Type III SS and the resulting ANOVA tables and fit statistics */

/* get all the one-way results */

/* best main effects and all interactions between them;
   get Tukey tests for least squares means and main effect means */
proc glm data=ozkids;
	class /* insert classification variables */;
	model days= /* insert model terms */;
	lsmeans /* insert model terms */ /pdiff=all cl;
	ods select OverallANOVA ModelANOVA LSMeans LSMeanDiffCL;
run;
/* consider model with all categorical variables and interactions and get the type I and type III sums of squares */

