* ods html close; 
* ods preferences;
* ods html newfile=proc;
data uscrime;
    infile 'c:\Stat 448\uscrime.dat' expandtabs;
    input R Age S Ed Ex0 Ex1 LF M N NW U1 U2 W X;
run;
proc print data=uscrime;
run;


* pairwise scatter plot;


* all predictors and vifs;


* model and vifs with explanatory variable with largest vif removed;


* stepwise results;
proc reg data=uscrime;
	model R = Age--X / selection=stepwise sle=.05 sls=.05;
run;
* if we perform an automatic selection process but only really want the 
  results and diagnostics from the final model, we could obtain the 
  SelectionSummary to see the final terms and then refit the model with 
  just those terms;
proc reg data=uscrime;
	model R = Age--X / selection=stepwise sle=.05 sls=.05;
	ods select SelectionSummary;
run;
* full default diagnostics for that chosen model;


* forward results;


* backward results;

* for a rougher tabular summary, we could create an output data set with some additional results included;
proc reg data=uscrime outest=results tableout;
	/* insert model here */
run;
proc print data=results;
run;
* example of selection based on adjusted R^2;
