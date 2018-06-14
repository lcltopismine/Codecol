*&&delay macro activation;
%let crs=3;
proc print data=sasuser.register noobs;
   where course_number=&crs;
   var student_name paid;
   title1 "Roster for Course &crs";
   title2 "Taught by &&teach&crs";
run;
*symget;
data teachers;
   set sasuser.register;
   length Teacher $ 20;
   teacher=symget('teach'||left(course_number));
run;
*from sql;
proc sql noprint;
   select sum(fee) format=dollar10. into :totalfee
      from sasuser.all;
quit;
%let totalfee=&totalfee;
*get number in order from table;
proc sql;
   select course_code, location, begin_date format=mmddyy10.
   into :crsid1-:crsid3,
        :place1-:place3,
        :date1-:date3
      from sasuser.schedule
      where year(begin_date)=2002
      order by begin_date;
quit;
*query;
proc sql noprint;
   select count(*) into :numrows
      from sasuser.schedule
      where year(begin_date)=2002;
   %let numrows=&numrows;
   %put There are &numrows courses in 2002;
   select course_code, location,
          begin_date format=mmddyy10.
      into :crsid1-:crsid&numrows,
           :place1-:place&numrows,
           :date1-:date&numrows
      from sasuser.schedule
      where year(begin_date)=2002
      order by begin_date;
   %put _user_;
quit;
*combine one line together;
proc sql noprint;
   select distinct location into :sites separated by ' '
      from sasuser.schedule;
quit;