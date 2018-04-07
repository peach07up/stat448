* ods html close; 
* ods preferences;
* ods html newfile=proc;
* the hypertension data set;
data hyper;
  * modify path to point to your files;
  infile 'c:\Stat 448\hypertension.dat';
  input n1-n12;
  if _n_<4 then biofeed='P';
           else biofeed='A';
  if _n_ in(1,4) then drug='X';
  if _n_ in(2,5) then drug='Y';
  if _n_ in(3,6) then drug='Z';
  array nall {12} n1-n12;
  do i=1 to 12;
      if i>6 then diet='Y';
                 else diet='N';
          bp=nall{i};
          cell=drug||biofeed||diet;
          output;
  end;
  drop i n1-n12;
run;
proc print data=hyper;
run;
/* tabulation of blood pressure means, standard deviations and counts by drug */
proc tabulate data=hyper;
  class drug;
  var bp;
  table drug,
        bp*(mean std n);
run;
/* cross-tabulation by drug, diet, and biofeedback */
proc tabulate data=hyper;
  class  drug diet biofeed;
  var bp;
  table drug*diet*biofeed,
        bp*(mean std n);
run;
/* one-way ANOVA with only drug main effect */
proc anova data=hyper;
  class drug;
  model bp = drug;
run;
/* two-way main effects ANOVA with drug and diet effects */

/* one-way main effects ANOVA with cell main effect */


/* three-way main effects model */


/* three-way model with all interactions;
   get and output means */
proc anova data=hyper;

  /* fill in model and mean estimation code */ 

  ods output means=outmeans;
run;

/* see entries in output data set */
proc print data=outmeans;
run;
/* introduce the interaction plot to visualize interaction means */
proc sgpanel data=outmeans;
	panelby drug/rows=3;
	series y =mean_bp x=biofeed/ group=diet;
run;
/* test equal variance and check for significant differences of 
  group means using Tukey's comparison */
proc anova data=hyper;
  class drug;
  model bp = drug;
  means drug /hovtest tukey cldiff;
run;

/* add Welch adjustment as an example */

/* get model with all interactions to consider significant and insignificant terms */


/* Tukey comparison for three-way main effects model */


/* adding log terms to model log(bp) as suggested in book */
data hyper;
	set hyper;
	logbp=log(bp);
run;
/* modeling logbp as suggested in book */
proc anova data=hyper;
  class drug diet biofeed;
  model logbp=drug|diet|biofeed;
run;
/* consider significant main effects and slightly insignificant interaction for bp model */


/* get results for the final model and extract tables and results we want to address questions from class */

