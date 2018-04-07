data uscrime;
    infile 'c:\Stat 448\uscrime.dat' expandtabs;
    input R Age S Ed Ex0 Ex1 LF M N NW U1 U2 W X;
run;
proc print data=uscrime;
run;
* pairwise scatter plot;
proc sgscatter data=uscrime;
	matrix R--X;
run;
* all predictors and vifs;
proc reg data=uscrime;
	model R = Age--X / vif;
run;
* model and vifs with explanatory variable with largest vif removed;
proc reg data=uscrime;
	model R = Age--Ex0 LF--X / vif;
run;
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
proc reg data=uscrime;
	model R = Ex0 X Ed Age U2;
run;
* forward results;
proc reg data=uscrime;
	model R = Age--X / selection=forward sle=.05;
run;
* backward results;
proc reg data=uscrime;
	model R = Age--X / selection=backward sls=.05;
run;
* the model chosen by all selection methods in this particular case;
proc reg data=uscrime;
	model R = Ex0 X Ed Age U2;
run;
* for a rougher tabular summary, we could create an output data set with some additional results included;
proc reg data=uscrime outest=results tableout;
	model R = Ex0 X Ed Age U2;
run;
proc print data=results;
run;
* example of selection based on adjusted R^2;
proc reg data=uscrime;
	model R = Age--X / selection=adjrsq;
run;
