proc sql;
   create table work.departments
          (Dept char(15),
          Code num label='Dept Code',
          constraint code_nodupe unique(code));
*describe data constrain;
 proc sql;
    describe table constraints work.discount4;
*use undo to control readin;
proc sql undo_policy=none;
   insert into work.campers
       set campid=1001,fname='Mara',
           lname='Tolerud',dob='17JUL1993'd
       set campid=1002,fname='Kino',
           lname='Parks',dob='22SEP1995'd
       set campid=1002,fname='Adele',
           lname='Ruiz',dob='01DEC1992'd;
quit;
*update;
 proc sql;
    update work.payrollmaster_new
       set salary=salary*1.05
       where jobcode like '__1';
 
 proc sql;
   update work.payrollmaster_new
      set salary=salary*1.05
         where substr(jobcode,3,1)='1';
   update work.payrollmaster_new
      set salary=salary*1.10
         where substr(jobcode,3,1)='2';
   update work.payrollmaster_new
      set salary=salary*1.15
         where substr(jobcode,3,1)='3';
         
 	
proc sql;
   update work.payrollmaster_new 
      set salary=salary*
         case 
              when substr(jobcode,3,1)='1'
                 then 1.05
              when substr(jobcode,3,1)='2'
                 then 1.10
              when substr(jobcode,3,1)='3'
                 then 1.15
              else 1.08
         end;

 proc sql;
    update work.payrollmaster_new2 
       set salary=salary*
          case substr(jobcode,3,1)
             when '1'
                  then 1.05
             when '2'
                  then 1.10
             when '3'
                  then 1.15
             else 1.08