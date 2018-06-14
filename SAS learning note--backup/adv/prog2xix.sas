*compare one previous all vars;
 proc sort data=company.reorder noduprecs;
    by product_line;
 run;
*not equal;
 proc sort data=company.products out=work.new
      nodupkey noequals;
    by product_line;
 run;
 proc sort data=company.onorder
           out=work.sorted;
    by product_name;
 run;

data work.onorder2;
   set work.sorted;
   by product_name;
   if first.product_name;
run;

To remove duplicate observations from a SAS data set, use PROC SORT 
with the NODUPKEY option rather than a PROC SORT step followed by a 
DATA step that uses FIRST. processing.

*whether to use the SAS sort, to use the host sort, or to 
determine which sort utility is best for the data set.
OPTIONS SORTPGM= BEST | HOST | SAS;
*check data info;
 proc contents data=company.organization centiles;
 run;

The SORTCUTP= system option specifies the number 
of bytes above which the host sort utility is used 
instead of the SAS sort utility.
OPTIONS SORTCUTP=n | nK | nM | nG | MIN | MAX | hexX;

 options sortpgm=best sortcutp=10000 
         sortname=syncsort;

 proc sort data=company.orders out=company.deliveries;
    by delivery_date;
 run;