*use order variable to control order of display variable;
 proc report data=flights.europe nowd headline headskip;
    where dest in ('LON','PAR'); 
    column flight orig dest mail freight revenue;
    define revenue / format=dollar15.2;
    define flight / order descending 'Flight/Number' width=6 center;
    define orig / width=6 spacing=5 'Flight/Origin' center;
    define dest / width=11 spacing=5 'Flight/Destination' 
                  center;
 run;
 
 *def group variable to group summary keyword group;
 proc report data=flights.europe nowd headline headskip;
    where dest in ('LON','PAR'); 
    column flight orig dest mail freight revenue;
    define flight / group 'Flight/Number' width=6 center;
    define orig / group width=6 spacing=5 'Flight/Origin' 
                  center;
    define dest / group width=11 spacing=5 
                 'Flight/Destination' center;
 	define revenue / mean format=dollar15.2
         	'Average/Revenue';
 run;
 *compute frequency/across of given variable;
 proc report data=flights.europe nowd headline headskip;
    where dest in ('LON','PAR'); 
    column flight dest mail freight revenue;
    define revenue / format=dollar15.2;
    define flight / across 'Flight/Number' width=6 center;
    define dest / across width=11 spacing=5 
                  'Flight/Destination' center;
 run;
 *def compute variable declear in column,define,compute;
 proc report data=flights.europe nowd;
    where dest in ('LON','PAR'); 
    column flight capacity deplaned emptyseats;
    define flight / width=6;
    define emptyseats / computed 'Empty Seats';
    compute emptyseats;
       emptyseats=capacity.sum-deplaned.sum;
    endcomp;
 run;