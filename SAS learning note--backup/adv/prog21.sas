To reduce I/O operations on a small data set, allocate as 
many buffers as there are pages in the data set so that 
the entire data set can be loaded into memory. This technique 
is most effective if you read the same observations several times 
during processing.

Under the z/OS operating environment, as the size of the data set 
increases, increase the number of buffers allocated, rather than 
the size of each buffer, to minimize I/O consumption.

 sasfile company.sales load;
 proc print data=company.sales;
    var Customer_Age_Group;
 run;
 proc tabulate data=company.sales;
    class Customer_Age_Group;
    var Customer_BirthDate;
    table Customer_Age_Group,Customer_BirthDate*(mean median);
 run;
 sasfile company.sales close;
 
*The SASFILE statement can also be used to reduce CPU time 
and I/O in SAS programs that repeatedly read one or more 
SAS data views;

If you need to repeatedly process a SAS data file that will fit entirely 
in memory, use the SASFILE statement to reduce I/O and some CPU usage.

If you use the SASFILE statement and the SAS data file will not fit 
entirely in memory, the code will execute, but there might be a 
degradation in performance.

If you need to repeatedly process part of a SAS data file and the entire 
file won't fit into memory, use a DATA step with the SASFILE statement to 
create a subset of the file that does fit into memory, and then process 
that subset repeatedly. This saves CPU time in the processing steps because 
those steps will read a smaller file, in addition to the benefit of the file
eing resident in memory.;

*index opt;
IBUFSIZE= MIN | MAX | n