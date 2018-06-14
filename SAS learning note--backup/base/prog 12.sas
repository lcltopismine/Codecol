 *drew random sample, DATA step looping trap;
 data work.subset;
    do sample=10 to 5000 by 10;
       set factory.widgets point=sample;
       output;
    end;
    stop;
 run;
 
 *array usage;
 data work.report(drop=i);
    set master.temps;
    array wkday{7} mon tue wed thr fri sat sun;
    do i=1 to dim(wkday);
       wkday{i}=5*(wkday{i}-32)/9;
    end;
 run;
* if not given number；
 array sales{*} qtr1 qtr2 qtr3 qtr4;=array sales{4} qtr1-qtr4;
array sales{*} _numeric_; *numeric;
array sales{*} _character_; * char;
*_ALL_ specifies all variables that have already been defined in the current DATA step. 
*The variables must all be of the same type: all character or all numeric.
array sales{*} _all_;

*char array;
array firstname{5} $;
*change length of char array from 8 to 24;
array firstname{5} $ 24;
*initial value;
array goal{4} g1 g2 g3 g4 (9000 9300 9600 9900);
*initialize temp dataset;
array goal{4} _temporary_ (9000 9300 9600 9900);
*def multi-row array;
array new{r,c} x1-x12;
new(2,3)=0;
array new{3,4} x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12;

*
