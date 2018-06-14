OPTIONS NOSYMBOLGEN | SYMBOLGEN;
%put &name;
*show macro val;

*str fcn  "data new; x=1; run;";
%let prog=%str(data new; x=1; run;);

%let prog=data new%str(;) x=1%str(;)run%str(;);

%let s=%str(;);
%let prog=data new&s x=1&s run&s;

%let text=%str(Joan%'s Report);
%let text=Joan%str(%')s Report;

*output & and afterwards;
%let Period=%nrstr(May&Jun);

paid="%upcase(&paidval)"

*begin &A
%let a=begin;
%let b=%nrstr(&a);

%put UPCASE produces: %upcase(&b);
%put QUPCASE produces: %qupcase(&b);
%substr(&var,%length(&var)-1)
%put With QSUBSTR: %qsubstr(&c,1,2);

*index ans is 3,only return 1st one;
 %let a=a very long value;
 %let b=%index(&a,v);
 %put V appears at position &b.;
 
*scan;
data work.thisyear;
   set sasuser.schedule;
   where year(begin_date) =
         year("&sysdate9"d);
run;

%let libref=%scan(&syslast,1,.);
%let dsname=%scan(&syslast,2,.);
proc datasets lib=&libref nolist;
title "Contents of the Data Set &syslast";
   contents data=&dsname;
run;
quit;
 