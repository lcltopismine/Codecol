*add of for variable computation;
*only allow comma separation;
mean(x1,x2,x3);
mean(of x1-x3);
mean(of newarray {*});

*explict transformation char to numeric;
 data hrd.newtemp;
    set hrd.temp;
    Salary=input(payrate,2.)*hours;
 run;
 
*connect string and number;
 SiteCode=site||dept;
Region=substr(site,1,4);

*change numeric to char remerber to conform the format;
 data hrd.newtemp;
    set hrd.temp;
    Assignment=put(site,2.)||'/'||dept;
 run;
 
 


