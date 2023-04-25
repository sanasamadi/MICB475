# MICB475
Group 6

Dataset comes from: https://doi.org/10.1038%2Fs41598-018-29687-x

**Qiime2 Code** used to convert directories from external repositories into Qiime2
**COLOMBIA_final.R** is the phyloseq object created from colombia_metadata, feature-table, taxonomy, and tree

**Aim 1 includes codes for:**
- Aim 1 code: full alpha-diversity (linear model; Shannon Index) statistical analysis on each predictor (total = 35) from Colombia metadata
- Aim 1 code: full beta-diversity statistical analysis (PERMANOVA; unweighted unifrac distance metric) on each predictor (total = 35) from Colombia metadata
- Aim 1 full table code: complete tables containing the statistical values in a presentable format
- Aim 1 alpha/beta-diversity supp figures: suppplemental plots found in manuscript 


**Aim 2** includes codes on defined obesity metrics

**Aim 3 includes code for:**
- Aim 3. Model selection: alpha-diversity (linear model; Shannon Index) model selection of Colombia metadata (full model = 35 predictors)
- Aim 3. Model selection: beta-diversity (PERMANOVA; weighted distance metric) model selection (full model = 35 predictors)
*note: beta-diversity model selection code portion is suggested to be run as background job due to the extensive time it needs for computing (~12 hrs)*
- Aim 3: Tables S1-S4: supplemental model selection analysis code for manuscript
- Aim 3: Model selection Tables: code used to create presentable tables for presentation
- uses custom AIC code (AIC for adonis2) sourced from: https://github.com/kdyson/R_Scripts/blob/master/AICc_PERMANOVA.R 
