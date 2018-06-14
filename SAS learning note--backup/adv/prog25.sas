 proc format;
    value qtrfmt '01jan2002' d - '31mar2002' d = '1'
                 '01apr2002' d - '30jun2002' d = '2'
                 '01jul2002' d - '30sep2002' d = '3' 
                 '01oct2002' d - '31dec2002' d = '4';
 run;         
 data company.quarters(keep=count order_date
            rename=(order_date=Quarter));
    set retail.orders;
    format order_date qtrfmt.;
    by  order_date groupformat notsorted;
    where year(order_date)=2002;
    if first.order_date then Count=0;
    Count +1;
    if last.order_date;
  run;
 
  proc means data=company.orders(keep=order_type
    quantity total_retail_price 
    costprice_per_unit discount) mean;
    by/class order_type;
    var total_retail_price -- discount;
    freq quantity;
 run;
 *already sorted specify SORTEDBY=_NULL_ to remove the Sorted flag;
 data company.transactions (sortedby=invoice);
    infile extdata;
    input Invoice 1-4 Item $6-20 Amount comma 6.;
 run;
 
 bytes required = (key-variable-length + observation-length) * number-of-observations * 2
 
a small SORTSIZE= value can increase CPU and I/O resource utilization
a large SORTSIZE= value can decrease CPU and I/O resource utilization.

Use a DATA step rather than PROC APPEND to re-create a large data set from smaller subsets. 
Use a constant rather than a SAS function because calling a function repeatedly increases CPU usage.
Use a subsetting IF with either a constant or a function rather than a WHERE statement with a function.

Use a DATA step rather than PROC APPEND to re-create a large data set from smaller subsets.

 proc sort data=company.orders tagsort;
    by customer_id order_date;
 run;
 *compare all by vars;
  proc sort data=company.reorder nodupkey;
    by product_line product_name;
 run;
