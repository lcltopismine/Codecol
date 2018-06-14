*conserve precision;
 data company.discount_short;
    length Discount 4;
    set Company.Discount;
 run;
 
 proc compare base=company.discount
              compare=company.discount_short;
 run;
*consider compress; 
It is large.
It contains many long character values.
It contains many values that have repeated characters or binary zeros.
It contains many missing values.
It contains repeated values in variables that are physically stored next to one another.

OPTIONS COMPRESS= NO | YES | CHAR | BINARY ;
 data company.customer_compressed (compress=char);
    set company.customer;
 run;
*Use binary compression only if the observation length is several hundred bytes or more.;

 *change pointer in compress mode;
 data company.customer_compressed (compress=yes pointobs=no/5);
    set company.customer;
 run;
 *reuse deleted space;
 OPTIONS REUSE= NO | YES;
  data company.customer_compressed (compress=yes reuse=yes);   
    set company.customer;
 run;
 *data view;
 data view=company.newdata;
    describe;
 run;
 *logical control;
Use IF-THEN/ELSE statements when

the data values are character values
the data values are not uniformly distributed
there are few conditions to check.

Use SELECT statements when

you have a long series of mutually exclusive numeric conditions
data values are uniformly distributed.