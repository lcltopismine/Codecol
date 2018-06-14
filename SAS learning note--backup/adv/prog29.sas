 data work.quarter; 
    do i = 9, 10, 11; 
    nextfile="c:\sasuser\month"
             !!compress(put(i,2.)!!".dat",' ');
          do until (lastobs); 
          infile temp filevar=nextfile end=lastobs;
          input Flight $ Origin $ Dest $ Date : date9.
                RevCargo : comma15.2;
          output;
       end;
    end;
    stop;
 run;

 proc append base=work.cap2001 
             data=work.capacity;
 run;
 
 proc append base=work.capacity
             data=work.cap2001 force;
 run;
 
 proc means data=sasuser.monthsum noprint;
 
 data work.profit;
   set sasuser.dnunder;
   set sasuser.sale2000(keep=routeid flightid date rev1st
                        revbusiness revecon revcargo)
                        key=flightdate;
   Profit=sum(rev1st, revbusiness, revecon, revcargo, 
             -expenses);
run;
*If the value of _IORC_ is zero, SAS found a matching 
observation. If the value of _IORC_ is not zero, SAS 
did not find a matching observation;

 data work.profit3 work.errors;
    set sasuser.dnunder;
    set sasuser.sale2000(keep=routeid flightid date rev1st 
        revbusiness revecon revcargo)key=flightdate;
    if _iorc_=0 then do;
       Profit=sum(rev1st, revbusiness, revecon, revcargo,
             -expenses);
       output work.profit3;
    end;
    else do;
       _error_=0;
       output work.errors;
    end;
 run;