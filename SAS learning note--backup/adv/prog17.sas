*sysbaff;
 %macro printz/parmbuff;
    %put Syspbuff contains: &syspbuff;
    %let num=1;
    %let dsname=%scan(&syspbuff,&num);
    %do %while(&dsname ne);
       proc print data=sasuser.&dsname;
       run;
       %let num=%eval(&num+1);
       %let dsname=%scan(&syspbuff,&num);
    %end;
 %mend printz;
 *create global var;
 %macro printdsn;
    %global dsn vars;
    %let dsn=sasuser.courses;
    %let vars=course_title course_code days;
    proc print data=&dsn;
       var &vars;
    title "Listing of &dsn data set";
    run;
 %mend;
 *delete var;
 %symdel dsn;
 *local table;
%let dsn=sasuser.courses;
%macro printdsn;
   %local dsn;
   %let dsn=sasuser.register;
   %put The value of DSN inside Printdsn is &dsn;
%mend;

%printdsn
%put The value of DSN outside Printdsn is &dsn;

The value of DSN inside Printdsn is sasuser.register
The value of DSN outside Printdsn is sasuser.courses

*show macro nested info;
OPTIONS MPRINTNEST | NOMPRINTNEST;
OPTIONS MLOGICNEST | NOMLOGICNEST;

%macro choice(status);
   data fees;
      set sasuser.all;
      %if &status=PAID %then %do;
         where paid='Y';
         keep student_name course_code begin_date totalfee;
      %end;
      %else %do;
         where paid='N';
         keep student_name course_code
              begin_date totalfee latechg;
         latechg=fee*.10;
      %end;
      /* add local surcharge */
      if location='Boston' then totalfee=fee*1.06;
      else if location='Seattle'  then totalfee=fee*1.025;
      else if location='Dallas'  then totalfee=fee*1.05;
   run;
%mend choice;