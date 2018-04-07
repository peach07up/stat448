* ods html close; 
* ods preferences;
* ods html newfile=proc;
data drinking;
 input country $ 1-12 alcohol cirrhosis;
cards;
France        24.7  46.1
Italy         15.2  23.6
W.Germany     12.3  23.7
Austria       10.9   7.0
Belgium       10.8  12.3
USA            9.9  14.2
Canada         8.3   7.4
E&W            7.2   3.0
Sweden         6.6   7.2
Japan          5.8  10.6
Netherlands    5.7   3.7
Ireland        5.6   3.4
Norway         4.2   4.3
Finland        3.9   3.6
Israel         3.1   5.4
;
run;
* get a labeled scatter plot of the data;
proc sgplot data=drinking;
	scatter x=alcohol y=cirrhosis/ datalabel=country;
run;
*all data with intercept;


/* obtain Cook distances to identify highly influential points and include them in an output data set;
   noprint option used to supress output of results
*/


* see the resulting data set;

* look at points with Cook distance greater than 1;


* fit using output data set and removing influential point;


* no intercept;


* no intercept with highly influential points removed;
