 *case in sql;    
 proc sql outobs=10;
    select lastname, firstname, jobcode, 
           case substr(jobcode,3,1)
              when '1'
                   then 'junior'
              when '2'
                   then 'intermediate'
              when '3'
                   then 'senior'
              else 'none'
           end as JobLevel
       from sasuser.payrollmaster,
            sasuser.staffmaster
       where staffmaster.empid=
             payrollmaster.empid;
 *delete;
 proc sql;
    delete from work.frequentflyers2
       where pointsearned-pointsused <= 0;
 *alter table;
 proc sql;
    alter table work.payrollmaster4
       add Bonus num format=comma10.2,
           Level char(3);
*drop variable directly;   
 proc sql;
    alter table work.payrollmaster4
       drop bonus, level;
       
 proc sql;
    alter table work.payrollmaster4
       modify salary format=dollar11.2 label="Salary Amt";
 
 proc sql;
    alter table work.payrollmaster4
       add Age num 
       modify dateofhire date format=mmddyy10.
       drop dateofbirth, gender;
       
 proc sql;
    drop table work.payrollmaster4;
    
proc sql;
   create table work.newadmit3
      like sasuser.newadmit;
   describe table work.newadmit3;
quit;