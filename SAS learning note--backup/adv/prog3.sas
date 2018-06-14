*subquery with multiple return value;
 proc sql;
    select empid, lastname, firstname, 
           city, state
       from sasuser.staffmaster
       where empid in
          (select empid
             from sasuser.payrollmaster
             where month(dateofbirth)=2);
             
*any operator;
*> ANY >min
<any <max
=any =equal to any value in subquery;
proc sql;
   select empid, jobcode, dateofbirth
      from sasuser.payrollmaster
      where jobcode in ('FA1','FA2')
            and dateofbirth < any
               (select dateofbirth
                  from sasuser.payrollmaster
                  where jobcode='FA3');
                  
 *all operator;
*>all >max every domestic flight.
<all <min

*Correlated Subqueries;
proc sql;
   select lastname, firstname
      from sasuser.staffmaster
      where 'NA'=
         (select jobcategory
            from sasuser.supervisors
            where staffmaster.empid = 
                  supervisors.empid);
                  
 *EXISTS	the subquery returns at least one row
NOT EXISTS	the subquery returns no data;
 proc sql;
    select lastname, firstname
       from sasuser.flightattendants
       where not exists
          (select *
             from sasuser.flightschedule
	         where flightattendants.empid=
	               flightschedule.empid);