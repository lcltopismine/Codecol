*sql index;
 proc sql;
    create index Tofrom 
       on sasuser.sale2000(origin, dest);
    drop index origin from sasuser.sale2000;
 quit;
 *copy database with index;
 proc datasets library=sasuser nolist;
    copy out=work;
    select sale2000;
 quit;
 
 proc copy out=work in=sasuser;
    select sale2000;
 quit;
 *rename dataset;
 proc copy out=work in=sasuser;
    select revenue;
 run;

 proc datasets library=work nolist;
    change revenue=income;
 quit;
 *will keep index;
  proc datasets library=work nolist;
    modify income;
    rename flightid=FlightNum;
 quit;
 *read multi files once;
 filename qtr1 ('c:\sasuser\month1.dat''c:\sasuser\month2.dat'
                'c:\sasuser\month3.dat');
 data work.firstqtr;
    infile qtr1;
    input Flight $ Origin $ Dest $
          Date : date9. RevCargo : comma15.2;
 run;
 *compress remove space from nextfile;
  data work.quarter;
    do i = 9, 10, 11;
       nextfile="c:\sasuser\month"
                !!put(i,2.)!!".dat";
       nextfile=compress (nextfile,' ');
       infile temp filevar=nextfile;
       input Flight $ Origin $ Dest $ 
             Date : date9. RevCargo : comma15.2;
    end;
 