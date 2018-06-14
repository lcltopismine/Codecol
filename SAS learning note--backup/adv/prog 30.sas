 proc format;
    value dates (multilabel) 
          '01jan2000'd - '31mar2000'd = '1st Quarter'
          '01apr2000'd - '30jun2000'd = '2nd Quarter'
          '01jul2000'd - '30sep2000'd = '3rd Quarter'
          '01oct2000'd - '31dec2000'd = '4th Quarter'
          '01jan2000'd - '30jun2000'd = 'First Half of Year'
          '01jul2000'd - '31dec2000'd = 'Second Half of Year';
 run; 
 
  proc tabulate data = sasuser.sale2000 format = dollar15.2;
    format Date dates.;
    class Date / mlf;
    var RevCargo;
    table Date, RevCargo*(mean median);
 run;
 
  proc format lib=library;
    value $routes
          'Route1' = 'Zone 1'
          'Route2' - 'Route4' = 'Zone 2'
          'Route5' - 'Route7' = 'Zone 3'
          ' ' = 'Missing'
          other = 'Unknown';
          
  *document format;
 libname library 'c:\sas\newfmt';
 proc format lib=library fmtlib;
    select $routes;
    exclude $geoarea geopop;
 run;
 *The format $DEST. is associated with the variable 
Dest and the format is removed from the variable Baggage;
  proc datasets lib=Mylib;
    modify flights;
    format dest $dest.;
    format baggage;
 quit;
 *you have formats stored in the Rpt library 
and in the Prod.Newfmt catalog;
  options fmtsearch=(rpt prod.newfmt);
 *If you use a format that SAS cannot load, 
SAS issues an error message and stops processing the step. 
To prevent this, you must change the system option FMTERR 
to NOFMTERR. When NOFMTERR is in effect, SAS substitutes 
a format for the missing format and continues processing.;
 OPTIONS FMTERR | NOFMTERR;
  options nofmterr;
 proc print data=sasuser.cargorev(obs=10);
    format Route $route.;
 run;
 
 