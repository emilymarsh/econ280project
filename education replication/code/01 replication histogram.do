********************************************
** Author: Emily Marsh
** Date: 10/25/2025
** Replication Project, histogram
*******************************************

** Globals
global mindspark "C:\Users\emi\Desktop\Computing Class\education replication"

///	folder globals

global data "$mindspark/data/"
global output "$mindspark/output/"

********************************************************************************
** Loading in data to make first figure so I can describe it for assignment.

	use "${data}ms_blel_jpal_long", clear
	
	isid st_id round
	
************************************************************
** Creating histogram of hours of extra math tutoring per week

	hist tot_math if round==1, color(navy) title("Histogram of baseline math scores") note("This figure shows the distribution of math scores at the baseline exam for all study participants, both treatment and control.")
	gr export "$output/math_test_hist.png", replace