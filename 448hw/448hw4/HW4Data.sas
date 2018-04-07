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
