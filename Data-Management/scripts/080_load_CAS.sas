* Assumptions: DM caslib (change location to match your environment) and SAS Compute library (User folder);

cas mysession sessopts=(caslib=casuser metrics=true);

%let gateuserid=&sysuserid ;
%put My Userid is: &gateuserid ;
options msglevel=i ;

/* assign a BASE SAS libname */ 
/* CHANGE location to match your environmnet */
libname indata "/home/&gateuserid./";

/* save .sas7bdat file under user’s home directory */
data indata.prdsale(replace=yes); 
set sashelp.prdsale ; 
run;

/* path type CASLIB, source located on CAS controller */
/* commented since its pre-defined */
/* CHANGE location to match your environmnet */

caslib DM path="/home/student/Courses/PGVY35/data/" type=path;


/* drop in-memory CAS table  */
proc casutil ;
   droptable casdata="&gateuserid._DATA_prdsale" incaslib="DM" quiet;
quit ;

/* load SAS datasets from client machine to CAS */  
/* notice where clause, repeat, and compress statement during data load */ 
proc casutil ;
    load data=indata.prdsale(where=(country="U.S.A."))
        outcaslib="DM" casout="&gateuserid._DATA_prdsale" replace copies=0 ; 
quit ;

/* list in-memory table from path CASLIB DM  */
proc casutil ;
   list tables incaslib="DM" ;
quit ;

/* drop again in-memory CAS table  */
proc casutil ;
   droptable casdata="&gateuserid._DATA_prdsale" incaslib="DM" quiet;
quit ;

cas mysession terminate;
