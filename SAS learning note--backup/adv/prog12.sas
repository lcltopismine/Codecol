*macro vars;
%let year=2002;
proc print data=sasuser.schedule;
   where year(begin_date)=&year;
   title "Scheduled Classes for &year";
run;
proc means data=sasuser.all sum;
   where year(begin_date)=&year;
   class location;
   var fee;
   title1 "Total Fees for &year Classes";
   title2 "by Training Center";
run;

*Referencing Macro Variables: &;
data new;
   set perm.mast;
   where fee>&amount;
run;
*Created 11:16 Wednesday, 05JUN2002
on the WIN system using Release 9.00;
 footnote1 "Created &systime &sysday, &sysdate9";
 footnote2 "on the &sysscp system using Release &sysver";
 
* value can be any string from 0 to 65,534 characters.
if either variable or value contains a reference to another 
macro variable (such as &macvar), the reference is evaluated 
before the assignment is made.；

All values are stored as character strings.
Mathematical expressions are not evaluated.
The case of the value is preserved.
Quotation marks that enclose literals are stored as part of the value.
Leading and trailing blanks are removed from the value before the assignment is made.

in order for the macro reference in the WHERE statement to be resolved, 
it must be enclosed in double quotation marks rather than single quotation marks

The maximum length of any token in command processing is 32767 characters.;

data new;
   set sasuser.all;
   where fee>&amount;
   where also city_state contains "&city";
   where also student_company contains '&company';
run;