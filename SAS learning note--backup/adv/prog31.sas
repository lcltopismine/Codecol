 proc format lib=library.formats cntlin=sasuser.routes;
 run;
 
  data sasuser.aports;
    keep Start Label FmtName;
    retain FmtName '$airport';
    set sasuser.acities (rename=(Code=Start 
        City= Label));
 run;

 proc print data=sasuser.aports(obs=10) noobs;
 run;
 
 proc format lib=sasuser cntlout=sasuser.fmtdata;
    select $airport;
 run;
 
 data work.results;
   array awards{3,4} _temporary_
         (65,55,45,35,80,70,60,50,70,60,50,40);
   set sasuser.compete;
   Score=awards{Event,Finish};
run;

 data work.lookup1;
   array Targets{1997:1999,12} _temporary_; 
   if _n_=1 then do i= 1 to 3;
       set sasuser.ctargets;
       array mnth{*} Jan--Dec;
       do j=1 to dim(mnth);
          targets{year,j}=mnth{j};
       end;
   end;
   set sasuser.monthsum(keep=salemon revcargo monthno);
   year=input(substr(salemon,4),4.); 
   Ctarget=targets{year,monthno};
   format ctarget dollar15.2; 
 run;
*transpose matrix; 
  proc transpose data=sasuser.ctargets 
      out=work.ctarget2
      name=Month
      prefix=Ctarget;
 run;
 
  proc transpose data=sasuser.ctargets 
      out=work.ctarget2 (rename=(col1=Ctarget1 
          col2=Ctarget2 col3=Ctarget3))
      name=Month;
      by year
 run;
 
 proc transpose data=work.sales out=work.sales2;
 
  proc sort data=work.ctarget2;
    by year month;
 run; 
 
 The original SAS data set must be sorted or indexed prior 
 to using a BY statement with PROC TRANSPOSE unless you 
 use the NOTSORTED option.