*def your own format;
 libname library 'c:\sas\formats\lib';
 proc format lib=library;
    value jobfmt
          103='manager'
          105='text processor'
          111='assoc. technical writer'
          112='technical writer'
          113='senior technical writer';
 run;
 *char example;
 proc format lib=library;
    value $grade
          'A'='Good'
          'B'-'D'='Fair'
          'F'='Poor'
          'I','U'='See Instructor';
 run;
 *range exp;
 proc format lib=library;
    value agefmt
          low-<13='child'
          13-<20='teenager'
          20-<65='adult'
          65-high='senior citizen'
          other='unknown';
 run;
 *use two single quotation marks if you want an apostrophe to appear in the label, as in this example:
     000='employee''s jobtitle unknown';
 
 *check of details of self-def format;
 libname library 'urlib';
 proc format library=library fmtlib;
 run;
 
 *generate a report,no window mode,selected vars;
 proc report data=flights.europe nowd;
    column flight orig dest mail freight revenue;
 run;
 *define format,width,spacing,title,try to cut lines by / or do this;
*def location('center') headline: underline column var>> 
headskip leave first line blank;
  proc report data=flights.europe nowd split=' ';
    where dest in ('LON','PAR'); 
    column flight orig dest mail freight revenue;
    define flight / order descending 'Flight Number' 
                    center width=6 spacing=5; 
    define orig / 'Flight Origin' center width=6;
    define revenue / format=dollar15.2;
    format weight comma6.2;
    define flight / width=6;
    define orig / width=4 spacing=5 'Flight Origin';;
    define dest / width=4 spacing=5 'Flight Destination';
 run
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 