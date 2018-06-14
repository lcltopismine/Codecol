*insert data data type=data value;
 proc sql;
    insert into work.discount
       set destination='LHR',
           begindate='01MAR2000'd,
           enddate='05MAR2000'd,
           discount=.33
       set destination='CPH',
           begindate='03MAR2000'd,
           enddate='10MAR2000'd,
           discount=.15;
    select *
      from discount;
      
 proc sql;
    insert into work.discount (destination, 
           begindate,enddate,discount)
       values ('ORD','05MAR2000'd,'15MAR2000'd,.25)
       values ('YYZ','06MAR2000'd,'20MAR2000'd,.10);
    select *
       from work.discount;
*insert result from sql query;
 proc sql; 
    insert into Schedule_East(Cnum,CCode,Loc,Instructor,BeginDt)
       select empid, jobcode, salary 
          from sasuser.mechanicslevel2
          where empid='1653';
    select *
       from work.mechanicslevel3_new;
       
*constrain check inside or outside;
 proc sql;
    create table work.employees
       (ID char (5) primary key,
       Name char(10),
       Gender char(1) not null check(gender in ('M','F')),
       HDate date label='Hire Date');
 
 proc sql;
    create table work.discount3 
           (Destination char(3),
           BeginDate num Format=date9.,
           EndDate num format=date9.,
           Discount num,
           constraint ok_discount check (discount le .5),
           constraint notnull_dest not null(destination));