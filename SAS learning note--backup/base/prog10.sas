 *readin data without null;
 data clinic.merged;
    merge clinic.demog(in=indemog 
                       rename=(date=BirthDate))
          clinic.visit(in=invisit
                       rename=(date=VisitDate));  
    by id;
    if indemog=1 and invisit=1;
 run;
 proc print data=clinic.merged;
 run;
 *drop vars;
merge clinic.demog(in=indemog 
                      rename=(date=BirthDate))
         clinic.visit(drop=weight in=invisit
                      rename=(date=VisitDate));
 *specify in data if needed for if-else;
data clinic.merged(drop=id);    

*proc sql no comma in final select,have se-co after order, need a quit to safeguard;
 proc sql;
    select empid,jobcode,salary,
           salary*.06 as bonus
       from sasuser.payrollmaster
       where salary<32000
       order by empid desc;
       order by jobcode,empid;       
       order by 2;
 *sql inner join;
 proc sql;
    select salcomps.empid,lastname,
           newsals.salary,newsalary
       from sasuser.salcomps,sasuser.newsals
       where salcomps.empid=newsals.empid
       order by lastname;
  quit;
*agge sum by group by;
 proc sql;
    select membertype,
           sum(milestraveled) as TotalMiles
       from sasuser.frequentflyers
       group by membertype;  
*having;
 proc sql;
    select jobcode,avg(salary) as Avg
       from sasuser.payrollmaster
       group by jobcode
       having avg(salary)>40000
       order by jobcode;
*create a table;
 proc sql;
    create table work.miles as
       select membertype,
              sum(milestraveled) as TotalMiles
          from sasuser.frequentflyers
          group by membertype; 
          
          