/* Solution code for Homework 2 in Stat 448 sections A1 and C1 at 
   University of Illinois, Spring 2017 */
ods html; 
options nodate nonumber;
title;
ods rtf file='C:\Stat 448\HW2_Sp17_Solution.rtf' 
	nogtitle startpage=no;
ods noproctitle; 
/* data for exercises 1 and 2 */
data diy;
/* to run code, modify file path to point to you text book data files;
   remember to change the path back in your submitted homework code */
infile 'c:\Stat 448\diy.dat' expandtabs;
  input y1-y6 / n1-n6;
  if _n_ in (1,2) then work='skilled';
  if _n_ in (3,4) then work='unskilled';
  if _n_ in (5,6) then work='office';
  array yall {6} y1-y6;
  array nall {6} n1-n6;
  do i=1 to 6;
    agegrp='youngest';
	if i in(2,3,5,6) then agegrp='older';
    yes=yall{i};
	no=nall{i};
	output;
  end;
  drop i y1--n6;
/* after the following modification, the data set will contain:
  	work (skilled, unskilled, or office)
  	agegrp (group 1 from the text is in the youngest group, 
  		and groups 2 and 3 are in the older group)
  	response (yes or no answer to question about whether the individual 
  		hired someone to do home improvements they would have previously 
  		done themseleves
  	n (count variable)
*/
data diy;
	set diy;
	response = 'yes'; n = yes; output;
    response = 'no'; n = no; output;
	drop no yes;
run;
/* Exercise 1:
   expected included for comment on apparent associations in part a, 
   chisq for testing association in part b,
   riskdiff for risk difference test in part c
*/
proc freq data=diy;
	tables agegrp*response/ chisq riskdiff expected nocol norow nopercent;
	weight n;
	ods select CrossTabFreqs ChiSq RiskDiffCol2;
run;
/* Exercise 2: 
   expected included for comment on apparent associations in part a
   chisq included for testing association in part b
   note: sample is large enough that we do not need or want Fisher's Exact test
*/
proc freq data=diy;
	tables work*response/ chisq expected nocol norow nopercent;
	weight n;
	ods select CrossTabFreqs ChiSq;
run;
/* Exercise 3: 
   HOVTest to test equal variance assumption and welch to get 
   adjusted ANOVA in part b
   tukey and cldiff to tests of pairwise differences for part c
*/
proc anova data=sashelp.iris;
	class species;
	model petallength = species;
	means species/ HOVtest welch tukey cldiff;
	ods select OverallANOVA FitStatistics HOVFTest Welch CLDiffs;
run;quit;
ods rtf close;
