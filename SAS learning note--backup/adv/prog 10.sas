*describe view;
 proc sql;
    describe view sasuser.faview;
    
*notice for view;
*Avoid using an ORDER BY clause in a view definition, which 
causes the data to be sorted every time the view is executed. 
Users of the view might differ in how or whether they want 
the data to be sorted, so it is more efficient to specify 
an ORDER BY clause in a query that references the view.

If the same data is used many times in one program or in 
multiple programs, it is more efficient to create a table rather 
than a view because the data must be accessed at each view reference. 
(This table can be a temporary table in the Work library.)

Avoid creating views that are based on tables whose structure 
might change. A view is no longer valid when it references a 
nonexistent column.

If a view resides in the same SAS data library as the contributing 
table(s), it is best to specify a one-level name in the FROM clause.;

*example for final point;
 proc sql;
    create view sasuser.payrollv as
       select *
          from payrollmaster;
          
*airline will use sas two while view executes.;
 libname airline 'SAS-library one';
 proc sql;
    create view sasuser.payrollv as
       select*
          from airline.payrollmaster
          using libname airline 'SAS-library two';
 quit;
 proc print data=sasuser.payrollv;
 run;   
 
*You can only update a single table through a view. The table 
cannot be joined or linked to another table, nor can it 
contain a subquery.

You can update a column using the column's alias, but you 
cannot update a derived column (a column that is produced by an expression).

You can update a view that contains a WHERE clause. The WHERE 
clause can be specified in the UPDATE clause or in the view. 
You cannot update a view that contains any other clause such 
as an ORDER BY or a HAVING clause. 

You cannot update a summary view (a view that contains a GROUP BY clause).;
