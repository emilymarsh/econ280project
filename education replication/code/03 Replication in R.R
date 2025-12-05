# ============================================================
# Globals
# ============================================================

mindSpark <- "C:/Users/emi/Desktop/Computing Class/education replication"

# Folder globals
data_dir <- file.path(mindSpark, "data")
output_dir <- file.path(mindSpark, "output")

# ============================================================
# Table 2: Intent-to-treat effects in a regression framework
# ============================================================

# --- Load J-PAL data (wide format)
data <- read.csv(file.path(data_dir, "ms_blel_jpal_wide.csv"))

# ============================================================
# Relabel variables
# ============================================================
#attr(data$m_theta_mle1, "label") <- "Baseline score"
#attr(data$h_theta_mle1, "label") <- "Baseline score"

# ============================================================
# Run regressions
# ============================================================

library(lmtest)
library(sandwich)
library(broom)
library(fixest)
library(openxlsx)

# --- Create output Excel workbook
wb <- createWorkbook()

# --- Regression 1: m_theta_mle2 on treat and baseline score
model1 <- lm(m_theta_mle2 ~ treat + m_theta_mle1, data = data)
coeftest(model1, vcov = vcovHC(model1, type = "HC1"))
addWorksheet(wb, "m_theta_mle2_ols")
writeData(wb, "m_theta_mle2_ols", tidy(coeftest(model1, vcov = vcovHC(model1, type = "HC1"))))

# --- Regression 2: h_theta_mle2 on treat and baseline score
model2 <- lm(h_theta_mle2 ~ treat + h_theta_mle1, data = data)
coeftest(model2, vcov = vcovHC(model2, type = "HC1"))
addWorksheet(wb, "h_theta_mle2_ols")
writeData(wb, "h_theta_mle2_ols", tidy(coeftest(model2, vcov = vcovHC(model2, type = "HC1"))))

# ============================================================
# Fixed-effects regressions
# ============================================================

# --- Regression 3: with strata fixed effects
model3 <- feols(m_theta_mle2 ~ treat + m_theta_mle1 | strata, data = data, vcov = "hetero")
addWorksheet(wb, "m_theta_mle2_fe")
writeData(wb, "m_theta_mle2_fe", broom::tidy(model3))

# --- Regression 4: with strata fixed effects
model4 <- feols(h_theta_mle2 ~ treat + h_theta_mle1 | strata, data = data, vcov = "hetero")
addWorksheet(wb, "h_theta_mle2_fe")
writeData(wb, "h_theta_mle2_fe", broom::tidy(model4))

# ============================================================
# Export results
# ============================================================

saveWorkbook(wb, file.path(output_dir, "table2_Rversion.xlsx"), overwrite = TRUE)
