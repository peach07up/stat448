* define data set from raw data;
data bodyfat;
 input age pctfat sex $;
cards;
23  9.5 M
23 27.9 F
27  7.8 M
27 17.8 M
39 31.4 F
41 25.9 F
45 27.4 M
49 25.2 F
50 31.1 F
53 34.7 F
53 42.0 F
54 29.1 F
56 32.5 F
57 30.3 F
58 33.0 F
58 33.8 F
60 41.1 F
61 34.5 F
;
/* view data */ 
proc print data=bodyfat;
run;
* read in slimmingclub data using list format;
data slimmingclub;
  * modifiy path to match your files;
  infile 'c:\Stat 448\slimmingclub.dat';
  input idno team $ startweight weightnow;
run;
/* view data with proc print */
proc print data=slimmingclub;
run;
* read in slimmingclub2 data using column format;
data slimmingclub2;
  * modifiy path to match your files;
  infile 'c:\Stat 448\slimmingclub2.dat';
  input name $ 1-18 team $ 20-25 startweight 27-29 weightnow 31-33;
run;
/* view data */
proc print data=slimmingclub2;
run;
/* read in the same data using informats.
   note that this particular comment is written using the 
   slash-asterisk syntax for example purposes, 
   while the previous comments used the asterisk-semicolon syntax */
data slimmingclub3;
  * modifiy path to match your files;
  infile 'c:\Stat 448\slimmingclub2.dat';
  input name $19. team $7. startweight 4. weightnow 3.;
run;
/* view the data */
proc print data=slimmingclub3;
run;
/* add a new variable for the weight loss to the slimmingclub data set */
data slimmingclub;
	set slimmingclub;
	weightloss=startweight-weightnow;
run;
/* see that the variable has been added to the data set using proc print */
proc print data=slimmingclub;
run;
/* construct and view a new data set containing only the women from the bodyfat data set */
data females;
	set bodyfat;
	where sex='F';
run;
/* similarly for an age range-- people in their 40's */

/* begin proc examples */
/* just print age and pctfat variables using a var statement */

/* just print the female observations in the data set using where */

/* just print age and pctfat for female observations */

/* sort slimmingclub data by team */

/* print to see that the data set is now sorted */

/* obtain means by team using proc means */

/* produce a scatter plot of age vs. pctfat */

/* add an option to plot the two genders separately */

/* add a linear regression line ignoring gender in the regression */

/* leave out the data markers in the regression 
   plot so the markers from the grouped scatter plot
   do not get covered up... at least in the html result... */

