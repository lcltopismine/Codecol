*drop view;
 proc sql;
    drop view sasuser.raisev;
*Restricting Row Processing inobs check readin rows and outobs check output rows;   
 proc sql inobs=5; 
select *
   from sasuser.mechanicslevel1
outer union corr
select *
   from sasuser.mechanicslevel2; 
*you are prompted to stop or continue processing ;   
proc sql inobs=5 prompt;
select flightnumber, destination 
   from sasuser.internationalflights;
*output trend col;
 proc sql inobs=10 number;            
    select flightnumber, destination 
       from sasuser.internationalflights;
*double space output;
proc sql inobs=10 double/Nodouble; 
   select flightnumber, destination 
      from sasuser.internationalflights;
*limit chars in a line;      
 proc sql inobs=5 flow=10 15;
    select ffid, membertype, name, address, city, 
           state, zipcode
       from sasuser.frequentflyers
       order by pointsused;
*writes timing information for each statement to the SAS log;
proc sql stimer
    run;
    
*change state in single sql max output in second statement;
 proc sql outobs=5;
    select flightnumber, destination 
       from sasuser.internationalflights;
 reset outobs= number;
    select flightnumber, destination 
       from sasuser.internationalflights
       where boarded gt 200;
*check dict table name is the col name with '';
 proc sql;
    describe table dictionary.tables; 
 proc sql;
    select memname
       from dictionary.columns
       where libname='SASUSER'
             and name='EmpID';
*The LOOPS= option restricts the number of 
iterations of the inner loop in PROC SQL;
 