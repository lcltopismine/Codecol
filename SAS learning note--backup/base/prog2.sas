*if cond;
data sasuser.stress;
   infile tests;
   input ID 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33
         RecHR 35-37 TimeMin 39-40 TimeSec 42-43
         Tolerance $ 45;
   if tolerance='D';
   TotalTime=(timemin*60)+timesec;
run;

*if you want to read the Sasuser.Stress data set and write it to a 
raw data file that is referenced by the fileref Newdat, you would
begin your program with the following SAS statements.;
data _null_;
       set sasuser.stress;
       file newdat;
   
 data _null_;
       set sasuser.stress;
       file 'c:\clinic\patients\stress.dat';
       
data _null_;
       set sasuser.stress;
       file 'c:\clinic\patients\stress.dat';
       put id 1-4 name  6-25 resthr 27-29 maxhr 31-33
             rechr 35-37 timemin 39-40 timesec 42-43
             tolerance 45 totaltime 47-49;
    run;
*end of example to output file;
*combined if-else check;
 data work.test;
    infile loan;
    input Code $ 1 Amount 3-10 Rate 12-16
          Account $ 18-25 Months 27-28;
    if code='1' then type='variable';
    else if code='2' then type='fixed';
    else put 'MY NOTE: invalid value: '
         code=;
    *or put 'MY NOTE: The condition was met.';
 run;
 *Another example,pay attention to ();
data sasuser.sales;
   infile saledata;
   input LastName $ 1-7 Month $ 9-11
         Residential 13-21 Commercial 23-31;
   if month in ('JAN','FEB') then
      Total=residential+commercial;
   else put 'your message ' month=;
run;