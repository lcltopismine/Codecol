 proc datasets nolist;
    modify capinfo;
    ic create PKIDInfo=primary key(routeid)
       message='You must supply a Route ID Number';
    ic create Class1=check(where=(cap1st<capbusiness or capbusiness=.)) 
       message='Cap1st must be less than CapBusiness';
 quit;
 
 ic create val_gender=check(where=(gender in ('M','F')));
 
 The APPEND, COPY, CPORT, CIMPORT, and SORT procedures 
 preserve integrity constraints when their operation 
 results in a copy of the original data file. Integrity 
 constraints are also preserved if you copy a data set 
 using the SAS Explorer window.
 
  proc datasets;
    modify capinfo;
    ic delete pkidinfo;
    ic delete class1;
 quit;
 *create audit;
  proc datasets nolist;
    audit capinfo;
    initiate;
 quit;
 
  proc datasets nolist;
    audit capinfo;
    initiate;
    user_var who $20 label = 'Who made the change'
             why $20 label = 'Why the change was made';
 quit;
 
  proc datasets nolist;
    audit capinfo;
    terminate;
 quit;
 
 *modifies the data set Cargorev and requests 
that up to four versions be kept (one base 
version and three historical versions;
  proc datasets nolist;
    modify cargorev (genmax=4);
 quit;
 

 