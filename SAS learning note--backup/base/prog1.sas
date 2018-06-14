*set workbase;
libname mylib '/folders/myshortcuts/myfolder';
*view all nodes;
proc contents data=mylib._all_ nods;
     run;
*view description of single file;
proc contents data=mylib.m1;
     run;
*dataset for libref,contents not;
 proc datasets;
    contents data=sasuser._all_ nods;
 quit;
 proc contents data=sasuser._all_ nods;
 run;
*display in num order;     
 proc datasets;
    contents data=sasuser.admit varnum;
 quit;
 proc contents data=mylib.m1 varnum;
 run;
 *import file;
filename m1 '/folders/myshortcuts/myfolder/m1.csv';
data mylib.m1;
	Infile m1 obs=100;
	input first 1-7 sec 8-14 thrid 15-28 fourth $fifth $sixth $jiu $joi$afc$q$r$t$v$b$u$;
run;
proc print data=mylib.m1;
run;
*example;
data sasuser.stress;        
   infile tests obs=10;  
   input ID 1-4 Name $ 6-25 
         RestHR 27-29 MaxHR 31-33        
         RecHR 35-37 TimeMin 39-40 
         TimeSec 42-43 Tolerance $ 45;       
run;
*add date and var;
   data sasuser.stress;
       infile tests;
       input ID 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33
             RecHR 35-37 TimeMin 39-40 TimeSec 42-43
             Tolerance $ 45;
       TotalTime=(timemin*60)+timesec;
       TestDate='01jan2000'd;
   run;
*You can also use SAS time constants and SAS datetime constants in assignment statements ;
Time='9:25't;
DateTime='18jan2005:9:27:05'dt;
*End;

 

 

