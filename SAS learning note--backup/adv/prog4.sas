*Validating Query Syntax;
 proc sql noexec;
    select empid, jobcode, salary
       from sasuser.payrollmaster
       where jobcode contains 'NA'
       order by salary;
 *if no error NOTE: Statement not executed due to 
NOEXEC option.Effect all;

 proc sql;
    validate
    select empid, jobcode, salary
       from sasuser.payrollmaster
       where jobcode contains 'NA'
       order by salary;
  *if no errorNOTE: PROC SQL statement has valid syntax.
Effect current one;

*inner join eliminate duplicate col by specifying name;
 proc sql;
    select one.x (one.*), a, b
       from one, two
       where one.x = two.x;
 
 proc sql;
    select one.x as ID, two.x, a, b
       from one, two
       where one.x = two.x;
 
*table allais;
 proc sql;
 title 'Employee Names and Job Codes';
    select s.empid, lastname, firstname, jobcode
       from sasuser.staffmaster as s, 
            sasuser.payrollmaster as p
       where s.empid=p.empid;     
       
*final inner join;
 proc sql outobs=15;
 title 'Avg Age of New York Employees';
    select jobcode,
           count(p.empid) as Employees,
           avg(int((today() - dateofbirth)/365.25))
           format=4.1 as AvgAge
       from sasuser.payrollmaster as p,
            sasuser.staffmaster as s
       where p.empid =
             s.empid
             and state='NY'
       group by jobcode
       order by jobcode;
   
  



