/* The following data set is a subset of the sashelp.cars data set */
data cars2;
	set sashelp.cars;
	logMSRP = log(MSRP);
	drop Cylinders DriveTrain Make Model Origin Invoice MSRP;
	where Type in('Sedan','Truck','SUV');
run;
