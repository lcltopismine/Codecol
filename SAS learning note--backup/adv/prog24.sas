 proc sort data=company.organization
           out=company.managers;
    by job_title;
    where job_title in('Sales Manager',
                       'Account Manager',
                       'Finance Manager');
 run;
 *dataset option;
  proc datasets lib=company;
    modify organization;
    rename Job_title=Title;
 quit;
 
  proc datasets lib=retail;
    modify newcustomer;
    rename Country_ID=country;
    format birth_date date9.;
 quit;
 
 WHERE statements work on variables that are already in SAS data sets. IF 
 statements can work on any variable in the program data vector, including 
 new or old variables.
 
 To save CPU resources, use a WHERE statement instead of a subsetting IF 
 statement to subset a SAS data set.
 
 Converting raw character fields to SAS character variables requires less 
 CPU time than converting raw numeric fields to the real binary encoding 
 of SAS numeric variables.
 
 The SAS data set can be larger than an external file because the SAS 
 data set includes a descriptor portion.
 
 The DATA step is the only technique that can be used to modify both 
 data values and variable attributes. The DATASETS procedure enables 
 you to modify only variable attributes
 
 Create a temporary SAS data set when the external file on which the 
 data set is based might change between SAS sessions.
 
 To conserve resources, use sort order rather than an index for BY-group processing.

Although using an index for BY-group processing is less efficient than using sort 
order, it might be the best choice if resource limitations make sorting a file difficult.
*not sorted;
 proc print data=retail.europe;
    by country_name notsorted;
 run;
 