*You cannot create an index on a view.;
 proc sql;
    create unique index empid 
       on work.payrollmaster(empid);
    describe table work.payrollmaster;

*index instruction;
*Keep the number of indexes to a minimum to reduce disk storage and update costs.
Do not create an index for small tables. Sequential access is faster on small tables.
Do not create an index based on columns that have a very small number of distinct values (low cardinality), 
for example, a Gender column that contains only the two values Male and Female.
Use indexes for queries that retrieve a relatively small subset of rows—that is, less than 15%.
Do not create more than one index that is based on the same column as the primary key.;
 proc sql;
    create unique index EmpID
       on work.payrollmaster(empid);

 proc sql;
    create unique index daily
       on work.marchflights(flightnumber,date);
*check built index;       
 proc sql;
    describe table marchflights;
*report index usage by indicate msg do not use index/must use this index/ cannot use both option;
*do not add 'daily';
 options msglevel=i;
 proc sql;
    select *
       from marchflights (idxwhere=no)/(idxname=daily) 
       where flightnumber='182';

 proc sql;
    drop index daily
       from work.marchflights;   
 
 *sql view;
proc sql;
   create view airline.pilotv as
      select *
         from airline.employee
         where jobcode in ('PT1', 'PT2', 'PT3');
 proc sql;
    select *
       from sasuser.faview;
 