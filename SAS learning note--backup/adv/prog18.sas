%macro attend(crs,start=01jan2001,stop=31dec2001);
   %let start=%upcase(&start);
   %let stop=%upcase(&stop);
   proc freq data=sasuser.all;
      where begin_date between "&start"d and "&stop"d;
      table location / nocum;
      title "Enrollment from &start to &stop";
      %if &crs=  %then %do;
         title2 "for all Courses";
      %end;
      %else %do;
         title2 "for Course &crs only";
         where also course_code="&crs";
      %end;
   run;
%mend;

%macro counts (cols=_all_,rows=,dsn=&syslast);
   title "Frequency Counts for %upcase(&dsn) data set";
   proc freq data=&dsn;
      tables
      %if &rows ne  %then &rows *;
      &cols;
   run;
%mend counts;

data _null_;
       set sasuser.schedule end=no_more;
       call symput('teach'||left(_n_),(trim(teacher)));
       if no_more then call symput('count',_n_);
    run;

%macro putloop;
   %local i;
   %do i=1 %to &count;
      %put TEACH&i is &&teach&i;
   %end;
%mend putloop;

%putloop
*sysevalf use float point;
%put value=%eval(10+2);
%let y=%sysevalf(&a+&b);