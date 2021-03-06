With a press of a function key convert the highlighted dataset to a mySQL database table.

I think the programmer was dismayed about the amount of mouse surfing,
program complexity, and the typing of long
datasets names in EG stored process windows.

SAS Forum
https://communities.sas.com/t5/SAS-Enterprise-Guide/SAS-Stored-process-use-input/m-p/492896

Pressing PF1 converts the  highlighted SAS dataset into mySQL database table.

Much more is possilble because all of SAS, Python, Perl and R can
be executed from the 1980s SAS IDE.


INPUT
=====

 This is what the 1080 editor looks like

COMMAND==>

000001  data class;
000002          set sashelp.class;
000003  run;quit;
000004
000005  Highlight class and hit function key PF1
000006
000007  proc contents data=class;
000008  run;quit;
000009

EXAMPLE OUTPUT

* SAS Class table sent to mySQL database table Class
NOTE: The data set mySQL.class has 19 observations and 5 variables.


PROCESS
=======

Put this on PF1

store;note;notesubmit '%xptha';

* store this macro in your autocall library;
%macro xptha;
   %symdel fyl / nowarn;
   filename clp clipbrd ;
   data _null_;
     infile clp;
     input;
     call symputx('fyl',_infile_);
     rc=dosubl('
       libname mysqllib mysql user=root password="xxxxxxxx" database=sakila port=3306;
       proc sql; drop table mysqllib.class;quit;
       data mysqllib.class;
          set &fyl;
       run;quit;
       libname mysqllib clear;
     ');
    run;quit;
%mend xptha;

OUTPUT
======

MLOGIC(XPTHA):  Beginning execution.
MLOGIC(XPTHA):  %SYMDEL  FYL / NOWARN
MPRINT(XPTHA):   filename clp clipbrd ;
MPRINT(XPTHA):   data _null_;
MPRINT(XPTHA):   infile clp;
MPRINT(XPTHA):   input;
MPRINT(XPTHA):   call symputx('fyl',_infile_);
MPRINT(XPTHA):   rc=dosubl('
libname mysqllib mysql user=root password="xxxxxxxx" database=sakila port=3306;
proc sql; drop table mysqllib.class;quit;
data mysqllib.class;
  set &fyl;
run;quit;
libname mysqllib clear;     ');
MPRINT(XPTHA):   run;

NOTE: The infile CLP is:
      (no system-specific pathname available),
      (no system-specific file attributes available)

NOTE: Libref MYSQLLIB was successfully assigned as follows:
      Engine:        MYSQL
      Physical Name:
NOTE: Table MYSQLLIB.class has been dropped.
NOTE: PROCEDURE SQL used (Total process time):
      real time           0.10 seconds
      user cpu time       0.00 seconds
      system cpu time     0.00 seconds
      memory              931.28k
      OS Memory           16112.00k
      Timestamp           09/06/2018 06:56:46 PM
      Step Count                        455  Switch Count  0


SYMBOLGEN:  Macro variable FYL resolves to class
NOTE: There were 19 observations read from the data set WORK.CLASS.

NOTE: The data set MYSQLLIB.class has 19 observations and 5 variables.

NOTE: DATA statement used (Total process time):
      real time           0.57 seconds
      user cpu time       0.01 seconds
      system cpu time     0.00 seconds
      memory              1283.65k
      OS Memory           16368.00k
      Timestamp           09/06/2018 06:56:46 PM
      Step Count                        455  Switch Count  0


NOTE: Libref MYSQLLIB has been deassigned.
NOTE: 1 record was read from the infile CLP.
      The minimum record length was 5.
      The maximum record length was 5.
NOTE: DATA statement used (Total process time):
      real time           0.91 seconds
      user cpu time       0.09 seconds
      system cpu time     0.04 seconds
      memory              1283.65k
      OS Memory           16368.00k
      Timestamp           09/06/2018 06:56:46 PM
      Step Count                        455  Switch Count  2


MPRINT(XPTHA):  quit;
MLOGIC(XPTHA):  Ending execution.


