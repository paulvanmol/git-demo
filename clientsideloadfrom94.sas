options cashost="server.demo.sas.com" casport=5570; 
options casncharmultiplier=2; 
cas mysession; 
libname locdata  "D:\Workshop\Basics\data"; 


proc contents data=locdata.customers_clean; 
run; 
proc casutil; 
droptable casdata="customers_clean" incaslib="CASUSER" quiet;
load data=locdata.customers_clean 
casout="customers_clean" outcaslib="CASUSER" promote; 
quit; 
