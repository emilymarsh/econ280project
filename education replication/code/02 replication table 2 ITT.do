**********************************************************************************
** Date: 11/15/2025
** Replicating the main result of the paper
**********************************************************************************

** Globals
global mindspark "C:\Users\emi\Desktop\Computing Class\education replication"

///	folder globals

global data "$mindspark/data/"
global output "$mindspark/output/"



/// table 2: intent-to-treat effects in a regression framework
		
	/// load j-pal data wide

		use "${data}ms_blel_jpal_wide", clear
		export delimited using "${data}ms_blel_jpal_wide.csv", replace
		
	///	relabel vars
	
		lab var m_theta_mle1	"Baseline score"
		lab var h_theta_mle1	"Baseline score"
		
	/// run regressions
		
		reg m_theta_mle2 treat m_theta_mle1, robust
		outreg2 using "${output}table2.xls", label less(1) replace noaster

		reg h_theta_mle2 treat h_theta_mle1, robust
		outreg2 using "${output}table2.xls", label less(1) append noaster
		
		xtreg m_theta_mle2 treat m_theta_mle1, robust  i(strata) fe
		outreg2 using "${output}table2.xls", label less(1) append noaster
		
		xtreg h_theta_mle2 treat h_theta_mle1, robust i(strata) fe
		outreg2 using "${output}table2.xls", label less(1) append noaster
		