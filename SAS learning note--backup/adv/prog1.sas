*control output num;
proc sql outobs=10;

*The OUTOBS= and INOBS= options will 
affect tables that are created by 
using the CREATE TABLE statement and 
your report output.;

*remove dumplicate;
     proc sql;
        select distinct flightnumber, destination
           from sasuser.internationalflights
           order by 1;
       
*not between an interval to control;
where salary not between 70000 
      and 80000
 
where name contains 'ER';
where name ? 'ER';
where jobcategory in ('PT','NA','FA')
where boarded is missing;
where boarded is null;
 where boarded = .;
 where flight = ' ';
 
*like operation;
*underscore ( _ )	any single character;
*percent sign (%)	any sequence of zero or more characters;


 proc sql;
    select ffid, name, address
       from sasuser.frequentflyers
       where address like '% P%PLACE';
  
 12 PIEDPIPER PLACE
 39 PEPPER PLACE
 12 PINEY PLACE
 
 *sound-like operator
 where lastname =* 'Smith';
 
*You can also use a calculated column in the WHERE clause to subset rows. However, because of 
the way in which SQL queries are processed, you cannot just specify the column 
alias in the WHERE clause;

;use calculated to solve this;
 proc sql outobs=10;
    select flightnumber, date, destination,
           boarded + transferred + nonrevenue
           as Total,
           calculated total/2 as Half
       from sasuser.marchflights;


 
