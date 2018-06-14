*reading dataset one-to-one;
 data one2one;
    set c;
    set d;
 run;
 
 *read dataset concat;
 data concat;
    set a b c d;
 run;
 
 *read dataset interleaving;
 data interlv;
    set c d;
    by num;
 run;
 
 *merge;
 data merged;
    merge a b;
    by num;
 run;
 
 *merge desc id;
 proc sort data=clinic.demog;
    by descending id;
 run;
 proc sort data=clinic.visit;
    by descending id;
 run;
 data clinic.merged;
    merge clinic.demog clinic.visit;
    by descending id;
 run;
 proc print data=clinic.merged;
 run;
 
 *rename var to prevent problem;
 data clinic.merged;       
    merge clinic.demog(rename=(date=BirthDate dateH=HireDate))
          clinic.visit(rename=(date=VisitDate)); 
    by id;
 run;
 proc print data=clinic.merged;
 run;
 *Excluding Unmatched Observations ;
 data clinic.merged;
    merge clinic.demog(in=indemog) 
          clinic.visit(in=invisit
                       rename=(date=BirthDate));
    by id;
 run;
 
 
 