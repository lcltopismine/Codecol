*select statement;
 data retail.order_info_2;
    set retail.order_fact;
    select(order_type);
       when (1) 
          do;                                    /* Retail Sale */
             Float=delivery_date-order_date;
             RevenueQuarter=qtr(order_date);
             AveragePrice=total_retail_price/quantity;
             if discount=. then NetPrice=total_retail_price;
             else NetPrice=total_retail_price-discount;
             Profit=netprice-(quantity*costprice_per_unit)*1.05;
          end;
          end;
          run;
  
  											IF-THEN/ELSE Statements					SELECT/WHEN Statements
The number of conditions									few							many
The distribution of a variable's 				values	not uniform						uniform
The type of variable								character							numeric

 data retail.customers;
    length Customer_Group $ 26 Customer_Activity $ 15;
    set retail.customer_hybrid;
    select(substr(put(customer_type_ID,4.),1,2));
       when ('10') 
          do;
             customer_group='Orion Club members';
             select(substr(put(customer_type_ID,4.),3,2));
                when ('10') customer_activity='inactive';
                when ('20') customer_activity='low activity';
                when ('30') customer_activity='medium activity';
                when ('40') customer_activity='high activity';
                otherwise;
             end;
          end;
       when ('20') 
          do;
             customer_group='Orion Club Gold members';
             select(substr(put(customer_type_ID,4.),3,2));
                when ('10') customer_activity='inactive';
                when ('20') customer_activity='low activity';
                when ('30') customer_activity='medium activity';
                when ('40') customer_activity='high activity';
                otherwise;
             end;
          end;
       when ('30') customer_group='Internet/Catalog Customers';
       otherwise;
    end;
 run;