*loop example;
 data finance.earnings;
    set finance.master;
    Earned=0;
    do count=1 to 12 by 1;
       earned+(amount+earned)*(rate/12);
    end;
 run;

*
When the DO loop executes, it executes once for each item in the series. 
The index variable equals the value of the current item. 
You must use commas to separate items in the series.
To list items in a series, you must specify either
all numeric values
     DO index-variable=2,5,9,13,27
        SAS statements
     END;
*all character values, with each value enclosed in quotation marks
     DO index-variable='MON','TUE','WED','THR','FRI'
        SAS statements
     END;
*all variable names — the index variable takes on the values of the specified variables.
column name for example
     DO index-variable=win,place,show
        SAS statements
     END;
*Variable names must represent either all numeric or all character values. 
Do not enclose variable names in quotation marks.;

*Do until must run 1 time;
 data work.invest;
    do until(Capital>=50000);
       capital+2000;
       capital+capital*.10;
       Year+1;
    end;
 run;
 
*Do while can run 0 time the condition in both cases are not the same;
 data work.invest;
    do while(Capital<50000);
       capital+2000;
       capital+capital*.10;
       Year+1;
    end;
 run;
 
*combined loop;
 data work.invest(drop=i);
    do i=1 to 10 until(Capital>=50000); 
       Year+1;
       capital+2000;
       capital+capital*.10;
    end;
 run;