*Do a subtotal, supress index and show in spearate page;
*check by,id,pageby;
proc sort data= Sasuser.Admit out=Work.Report;
by descending Age;
run;
     proc sort data=clinic.admit out=work.activity;
        by actlevel;
     run;
     proc print data=work.activity;
        var age height weight fee;
        where age>30;
        sum fee;
        by actlevel;
        id actlevel;
        pageby actlevel;
     run;
     
 *add title/footnote for program; num for lines;
 title1 'Heart Rates for Patients with';
 title3 'Increased Stress Tolerance Levels';
 footnote1 'Data from Treadmill Tests';
 footnote3 '1st Quarter Admissions';
proc print data = Work.Report;
var = Age Height Weight Fee;
where Age>30;
run;
*cancel title or footnote by type in nothing;
     title1;
     footnote1 'Data from Treadmill Tests';
     footnote3 '1st Quarter Admissions';
     proc print data=clinic.stress;
        var resthr maxhr rechr;
        where tolerance='I';
     run;
     footnote;
     proc tabulate data=clinic.stress;
        var timemin timesec;
        table max*(timemin timesec);
     run;
*change column name,note label in first row;
*use proc print data=clinic.admit double to enable double space;
 proc print data=clinic.admit label;
    var actlevel height weight;
    label actlevel='Activity Level'
           height='Height in Inches'
           weight='Weight in Pounds';
   run;

