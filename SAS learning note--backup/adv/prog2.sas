*add title;
  proc sql outobs=15;
     title 'Current Bonus Information';
     title2 'Employees with Salaries > $75,000';
        select empid label='Employee ID';
               jobcode label='Job Code',
               salary,
               'bonus is:';
               *this line add text between two columns as comments.;

*grouping data;
     proc sql;
        select membertype, avg(milestraveled)
               as AvgMilesTraveled
           from sasuser.frequentflyers
           group by membertype;
           
*count  1 means ist columns;
     proc sql;
        select substr(jobcode,1,2)
               label='Job Category',
               count(*) as Count
           from sasuser.payrollmaster
           group by 1;
  select count(distinct jobcode) as Count;
  
*When a column contains missing values, 
PROC SQL treats the missing values as a 
single group. This can sometimes produce
 unexpected results.;
 
 
 proc sql;
    select jobcode, 
           avg(salary) as AvgSalary
           format=dollar11.2
       from sasuser.payrollmaster
       group by jobcode
       having avg(salary) > 56000;
       having AvgSalary >56000;
 * the HAVING clause could specify the column alias AvgSalary;

*subquery;
 proc sql;
    select jobcode, 
           avg(salary) as AvgSalary 
           format=dollar11.2
       from sasuser.payrollmaster
       group by jobcode
       having avg(salary) >
          (select avg(salary)
             from sasuser.payrollmaster);
