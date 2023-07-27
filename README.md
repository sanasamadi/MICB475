# MICB475
Group 6 Repository

This GitHub repository contains code and data related to our research project, focusing on the diversity analysis of a dataset obtained from https://doi.org/10.1038%2Fs41598-018-29687-x.

Dataset Source:
- https://doi.org/10.1038%2Fs41598-018-29687-x

## Qiime2 Code and Files:

- Qiime2 Code.sh
- colombia_metadata.txt
- feature-table.txt
- taxonomy.tsv
- tree.nwk

## Aim 1 - Alpha and Beta Diversity Analysis:

### Code.R:

- Conducts full alpha-diversity (linear model; Shannon Index) statistical analysis on each of the 35 predictors from Colombia metadata.
- Performs full beta-diversity statistical analysis (PERMANOVA; unweighted unifrac distance metric) on each of the 35 predictors from Colombia metadata.

### Supplementary Figures:

- alpha-diversity_supp_figures.R: Includes supplemental plots found in the manuscript.
- beta-diversity_supp_figures.R: Includes supplemental plots found in the manuscript.

### Full Table Code:

- full_table_code.R: Generates complete tables containing the statistical values in a presentable format.

## Aim 2 - Obesity Metrics Analysis:

### Obesity Code.R:

- Contains code related to the analysis of defined obesity metrics.

## Aim 3 - Model Selection:

### AIC_for_adonis2.R:

- Conducts alpha-diversity (linear model; Shannon Index) model selection of Colombia metadata (full model = 35 predictors).

### Tables S1-S4:

- table_S1_no_bf.R: Includes supplemental model selection analysis code for the manuscript.
- table_S2_no_insulin.R: Includes supplemental model selection analysis code for the manuscript.
- table_S3_no_meds.R: Includes supplemental model selection analysis code for the manuscript.
- table_S4_no_insulin_or_meds.R: Includes supplemental model selection analysis code for the manuscript.

### Model Selection Tables:

- model_selection_tables.R: Contains code used to create presentable tables for presentation. Uses custom AIC code (AIC for adonis2) sourced from: https://github.com/kdyson/R_Scripts/blob/master/AICc_PERMANOVA.R.

We hope that the code and data provided here will be useful to the research community. Please feel free to explore the repository, and don't hesitate to contact us if you have any questions or feedback.

Thank you for your interest in our work!


