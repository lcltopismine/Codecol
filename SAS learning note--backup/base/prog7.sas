*sumsec = sumsec+totaltime
missing value as zero;
*use retain to set initial value;
*use if-else delete to stop processing;
*if you do not want to keep timemin,use drop;
data sasuser.sales(drop=timemin timesec);
   infile saledata;
   input LastName $ 1-7 Month $ 9-11
         Residential 13-21 
         Commercial 23-31;
   Total = Residential+ Commercial;
   Retain CumTotal 1254657;
   CumTotal+Total;
   if totaltime>800 then TestLength='Long';
   else if 750<=totaltime<=800 then TestLength='Normal';
   else if totaltime<750 then TestLength='Short';
   if resthr<70 then delete;
   drop timemin timesec;
   label sumsec='Cumulative Total Seconds (+5,400)';
   format sumsec comma6.;
run;
proc print data=sasuser.sales label;
run;

*initialize variable length add $ for char;
* length Type $ 8;
* length Address1 Address2 Address3 $ 200;
* length FirstName $ 12 LastName $ 16;

*select group;
 data emps(keep=salary group);
    set sasuser.payrollmaster;
    length Group $ 20;
    select(jobcode);
       when ("FA1") group="Flight Attendant I";
       when ("FA2") group="Flight Attendant II";
       when ("FA3") group="Flight Attendant III";
       when ("ME1") group="Mechanic I";
       when ("ME2") group="Mechanic II";
       when ("ME3") group="Mechanic III";
       when ("NA1") group="Navigator I";
       when ("NA2") group="Navigator II";
       when ("NA3") group="Navigator III";
       when ("NA1") group="Navigator I";
       when ("NA2") group="Navigator II";
       when ("NA3") group="Navigator III";
       when ("PT1") group="Pilot I";
       when ("PT2") group="Pilot II";
       when ("PT3") group="Pilot III";
       when ("TA1","TA2","TA3") group="Ticket Agents";
       otherwise group="Other";
    end;
 run;
