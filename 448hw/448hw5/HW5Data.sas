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
