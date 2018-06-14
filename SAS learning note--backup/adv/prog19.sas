%macro prtlast;
   %if &syslast ne _NULL_ %then %do;
      proc print data=&syslast(obs=5);
         title "Listing of &syslast data set";
      run;
   %end;
   %else
      %put No data set has been created yet.;
%mend;
*use include to store data;
%include 'c:\sasfiles\prtlast.sas' /source2;

proc sort data=sasuser.courses out=bydays;
   by days;
run;

%prtlast
*read saved file;
proc catalog cat=work.sasmacr;
   contents;
   title "Default Storage of SAS Macros";
quit;
*auto locate file;
filename prtlast catalog 'sasuser.mymacs.prtlast.source';
%include prtlast;
proc sort data=sasuser.courses out=bydays;
   by days;
run;
%prtlast

filename prtsort catalog 'sasuser.mymacs';
%include prtsort(prtlast) / source2;
%include prtsort(sortlast) / source2;

data current(keep=student_name course_title begin_date location);
   set sasuser.all;
   if year(begin_date)=2001;
   diff=year(today())-year(begin_date);
   begin_date=begin_date+(365*diff);
run; 

%sortlast(begin_date)
%prtlast

The MAUTOSOURCE system option controls whether the autocall facility is available.;
OPTIONS MAUTOSOURCE | NOMAUTOSOURCE;

The SASAUTOS system option controls where the macro facility looks for autocall macros.;
options sasautos=('c:\mysasfiles',sasautos);

The MSTORED system option controls whether the Stored Compiled Macro Facility is available.;
OPTIONS MSTORED | NOMSTORED;

The SASMSTORE system option controls where the macro facility looks for stored compiled macros.;
OPTIONS SASMSTORE=libref;