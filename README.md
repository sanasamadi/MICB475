# MICB475
Group 6 Repository

This GitHub repository contains code and data related to our research project, focusing on the diversity analysis of a dataset obtained from https://doi.org/10.1038%2Fs41598-018-29687-x.

Dataset Source:
- https://doi.org/10.1038%2Fs41598-018-29687-x

Qiime2 Code and COLOMBIA_final.R:
- We used Qiime2 code to convert directories from external repositories into Qiime2 format.
- COLOMBIA_final.R is the phyloseq object created from colombia_metadata, feature-table, taxonomy, and tree.

Aim 1 - Alpha and Beta Diversity Analysis:
- Aim 1 code: Conducts full alpha-diversity (linear model; Shannon Index) statistical analysis on each of the 35 predictors from Colombia metadata.
- Aim 1 code: Performs full beta-diversity statistical analysis (PERMANOVA; unweighted unifrac distance metric) on each of the 35 predictors from Colombia metadata.
- Aim 1 full table code: Generates complete tables containing the statistical values in a presentable format.
- Aim 1 alpha/beta-diversity supp figures: Includes supplemental plots found in the manuscript.

Aim 2 - Obesity Metrics Analysis:
- Contains code related to the analysis of defined obesity metrics.

Aim 3 - Model Selection:
- Aim 3. Model selection: Conducts alpha-diversity (linear model; Shannon Index) model selection of Colombia metadata (full model = 35 predictors).
- Aim 3. Model selection: Performs beta-diversity (PERMANOVA; weighted distance metric) model selection (full model = 35 predictors).
  Note: The beta-diversity model selection code portion is suggested to be run as a background job due to its extensive computing time (~12 hrs).
- Aim 3: Tables S1-S4: Includes supplemental model selection analysis code for the manuscript.
- Aim 3: Model selection Tables: Contains code used to create presentable tables for presentation.
  Uses custom AIC code (AIC for adonis2) sourced from: https://github.com/kdyson/R_Scripts/blob/master/AICc_PERMANOVA.R.

We hope that the code and data provided here will be useful to the research community. Please feel free to explore the repository, and don't hesitate to contact us if you have any questions or feedback.

Thank you for your interest in our work!
