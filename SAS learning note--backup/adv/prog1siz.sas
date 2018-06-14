proc sql;
   create view subcrsid as
      select student_name,student_company,paid
         from sasuser.all
         where course_code=symget('crsid'),
         course_number=input(symget('crsnum'),2.);
quit;

%let crsid=C003;
proc print data=subcrsid noobs;
   title "Status of Students in Course Code &crsid";
run;
%let crsid=C004;
proc print data=subcrsid noobs;
   title "Status of Students in Course Code &crsid";
run;
*SCL;
call symputn('unitvar', 500);
unit=symgetn('unitvar');
*def a macro program;
%macro prtlast;
   proc print data=&syslast (obs=5);
   title "Listing of &syslast data set";
   run;
%mend;
*enable macro option check error enable command output;
*Mlogic:start,end,math cmp;
 options mcompilenote=all;
 OPTIONS MPRINT | NOMPRINT;
 OPTIONS MLOGIC | NOMLOGIC;
 %macro mymacro;
 %mend mymacro;
 
 *positional para;
 %macro printdsn(dsn,vars);
    proc print data=&dsn;
       var &vars;
    title "Listing of %upcase(&dsn) data set";
    run;
 %mend;
 %printdsn(sasuser.courses,course_code course_title days)
 *keywork para;
 %macro printdsn(dsn=sasuser.courses,vars=course_code 
                course_title days);
    proc print data=&dsn;
       var &vars;
    title "Listing of %upcase(&dsn) data set";
    run;
 %mend;
 %printdsn()
 *mixed style;
*pos listed before key;
 %macro printdsn(dsn, vars=course_title course_code days);
    proc print data=&dsn;
       var &vars;
    title "Listing of %upcase(&dsn) data set";
    run;
 %mend;