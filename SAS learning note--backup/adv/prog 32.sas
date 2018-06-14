*modify data;
 data capacity;
    modify capacity;
    CapEcon = int(CapEcon * .95);
    CapBusiness = int(CapBusiness * .90);
 run;
 
 *modify data with transaction dataset newrtnum;
 data capacity;
    modify capacity sasuser.newrtnum;
    by flightid;
 run;
 *no missing check: update miss with trans data;
 data empdata;
   modify empdata missing
          updatemode=nomissingcheck;
   by empid;
run;
*use index to update;
 data cargo99;
    set sasuser.newcgnum (rename = 
        (capcargo = newCapCargo 
        cargowgt = newCargoWgt
        cargorev = newCargoRev));
    modify cargo99 key=flghtdte;
    capcargo = newcapcargo;
    cargowgt = newcargowgt;
    cargorev = newcargorev;
 run;
 *3 diff cases;
  data master;
    set transaction;
    modify master key = id;
    a = b;
    if code = 'no' then remove;
    else if code = 'yes' then replace;
    else if code = 'new' then output;
 run;
 
  data master;
    set transaction;
    modify master key = id;
    if _IORC_=%sysrc(_sok) then
       do;
          a = b;
          replace;
       end;
    else
       if _IORC_=%sysrc(_dsenom) then
          do;
             output;
             _ERROR_ = 0;
          end;
 run;