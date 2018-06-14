*union operation;
 proc sql;
    select *
       from sasuser.stress98
    union (all has dup/corr cast key)
    select *
       from sasuser.stress99;
*When processing set operators, PROC SQL follows 
a default order of precedence, unless this order 
is overridden by parentheses in the expression(s). 
By default, INTERSECT is evaluated first. OUTER UNION, 
UNION, and EXCEPT all have the same level of precedence.;

proc sql;
   select *
      from one
   intersect(all/corr) all
   select *
      from two;
      
proc sql;
   select *
      from number2
   union/outer union
   select *
      from number1;
      
*create table;
*char(3) type char width 3 default 8;
 proc sql;
    create table work.discount 
           (Destination char(3) label='Department',
           BeginDate num Format=date9.,
           EndDate num format=date9.,
           Discount num);
 *check table structure;          
 proc sql;
    describe table work.discount;
*create table with same structure,use drop or keep as needed;
 proc sql;
    create table work.flightdelays2 (drop=delaycategory destinationtype)
       like sasuser.flightdelays;
*create table from query;
 proc sql;
    create table work.ticketagents as
       select lastname, firstname,
              jobcode, salary
          from sasuser.payrollmaster,
               sasuser.staffmaster
          where payrollmaster.empid
                = staffmaster.empid
                and jobcode contains 'TA';
*copy table;
 proc sql;
    create table work.supervisors2 as
       select *
          from sasuser.supervisors;