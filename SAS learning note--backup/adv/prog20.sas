 libname macrolib 'c:\storedlib';
 options mstored sasmstore=macrolib;

 %macro words(text,root=w,delim=%str( ))/store;
    %local i word;
    %let i=1;
    %let word=%scan(&text,&i,&delim);
    %do %while (&word ne );
       %global &root&i;
       %let &root&i=&word;
       %let i=%eval(&i+1);
       %let word=%scan(&text,&i,&delim);
    %end;
    %global &root.num;
    %let &root.num=%eval(&i-1);
 %mend words;
 
 *access compiled macro;
libname macrolib 'c:\storedlib';
options mstored sasmstore=macrolib;
  
%words(This is a test)
%put Number of Words (wnum): &wnum;
%put Word Number 1 (w1): &w1;
%put Word Number 2 (w2): &w2;
%put Word Number 3 (w3): &w3; 
%put Word Number 4 (w4): &w4; 

*check rule;
*The macro processor checks the temporary catalog Work.Sasmacr first. If 
the macro is not found there, the macro processor looks in the permanent 
Sasmacr catalog, if one has been specified. Finally, the macro processor 
checks the autocall library.;

*control page size all time vaild;
 options bufsize=30720;
 filename orders 'c:\orders.dat';
 data company.orders_fact;
    infile orders;
    <more SAS code>
 run;
 
 *control how many pages of data are loaded into memory with each I/O transfer.;
*current session available;
options bufno=4;
     filename orders 'c:\orders.dat';
     data company.orders_fact;
     
  data work.orders (bufsize=6144 bufno=5);
    set retail.order_fact;
 run;    

