/* The raw data in housing.data is from
   and described on https://archive.ics.uci.edu/ml/datasets/Housing
   Bache, K. & Lichman, M. (2013). UCI Machine Learning Repository 
   [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, 
   School of Information and Computer Science.
*/
data housing;
	infile 'C:\\Stat 448\housing.data';
	input crim zn indus chas nox rm age dis rad tax ptratio b lstat medv;
	logmedv = log(medv);
	over25kSqFt = 'none';
	if zn > 0 then over25kSqFt = 'some';
	taxlevel = 'higher';
	if tax < 500 then taxlevel = 'lower';
	ptlevel = 'medium';
	if ptratio < 15 then ptlevel = 'lower';
	if ptratio > 20 then ptlevel = 'higher';
	drop zn tax ptratio b lstat rad dis chas;
run;
data housing;
	set housing;
	where medv<50;
	drop medv;
run;
