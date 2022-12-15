cas mysession; 
proc casutil ; 
	list files incaslib="CASUSER"; 
	quit; 
	cas mysession terminate; 