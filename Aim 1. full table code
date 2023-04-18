# name required packages
list.of.packages <- c("gapminder", "gt", "tidyverse", "webshot2", "gtsummary", "readxl")

# install required packages, if necessary, and load them ----
{
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  lapply(list.of.packages, require, character.only = TRUE)
}

#### entire alpha diversity table #### 

all_alpha <- read_excel("results_table_alpha.xlsx") |>
  select(-c(`Std. Error`, `t value`, `Pr(>|t|)`, `predictor`)) |>
  gt() 

all_alpha <- all_alpha |>
  tab_header(title = "Table 1: Alpha-diversity of entire Colombia metadata", 
             subtitle = ("Evaluating alpha-diversity (metric = Shannon) of every predictor in the Colombia metadata")) |>
  opt_align_table_header("left") |>
  tab_options(table.font.name = "Arial") |> 
  fmt_number(columns = c("Estimate", "adjusted_pvalues"), decimals = 3) |>
  cols_width(CoefficientName~px(200), Estimate~px(120), adjusted_pvalues~px(120)) |>
  cols_align(align = "center", columns = "Estimate") |>
  cols_align(align = "center", columns = "adjusted_pvalues") |>
  cols_align(align = "center", columns = "Significant Level") |>
  
  #highlights row
#  tab_style(style = list(cell_fill(color="lightyellow")), 
#            locations = cells_body(columns = c(CoefficientName, Estimate, adjusted_pvalues), 
#                                   rows = 1)) |>
  
  
  cols_label(adjusted_pvalues = md("P-value"), CoefficientName = md("Predictor")) |>
  tab_footnote(footnote = "ns (not significant), * (0.05), ** (0.01), and *** (<0.001)",
               locations = cells_column_labels(columns = `Significant Level`),
               placement = "left") |>
  opt_row_striping()


all_alpha

gtsave(all_alpha, file = "aim1_all_alpha.png")

#### entire bray beta diversity table ####

all_beta_bray <- read_excel("results_table_bray.xlsx") |>
  select(-c(`Df`, `SumOfSqs`, `F`, `Pr(>F)`,`predictor`)) |>
  gt() 

all_beta_bray <- all_beta_bray |>
  tab_header(title = "Table 2: Beta-diversity (Bray-Curtis) of entire Colombia metadata", 
             subtitle = ("Evaluating microbial composition (metric = Bray-Curtis) of every predictor in the Colombia metadata")) |>
  opt_align_table_header("left") |>
  tab_options(table.font.name = "Arial") |> 
  fmt_number(columns = c("R2", "adjusted_pvalues"), decimals = 3) |>
  cols_width(CoefficientName~px(200), R2~px(120), adjusted_pvalues~px(120)) |>
  cols_align(align = "center", columns = "R2") |>
  cols_align(align = "center", columns = "adjusted_pvalues") |>
  cols_align(align = "center", columns = "Significant Level") |>
  cols_label(adjusted_pvalues = md("P-value"), CoefficientName = md("Predictor")) |>
  cols_label(R2 = html("R<sup>2</sup>")) |>
  tab_footnote(footnote = "ns (not significant), * (0.05), ** (0.01), and *** (<0.001)",
               locations = cells_column_labels(columns = `Significant Level`),
               placement = "left") |>
  opt_row_striping()


all_beta_bray

gtsave(all_beta_bray, file = "aim1_all_beta_bray.png")


#### entire unweighted unifrac beta diversity table ####

all_beta_unweighted_unifrac <- read_excel("results_table_unweighted_unifrac.xlsx") |>
  select(-c(`Df`, `SumOfSqs`, `F`, `Pr(>F)`,`predictor`)) |>
  gt() 

all_beta_unweighted_unifrac <- all_beta_unweighted_unifrac |>
  tab_header(title = "Table 3: Beta-diversity (Unweighted Unifrac) of entire Colombia metadata", 
             subtitle = ("Evaluating microbial composition (metric = Unweighted Unifrac) of every predictor in the Colombia metadata")) |>
  opt_align_table_header("left") |>
  tab_options(table.font.name = "Arial") |> 
  fmt_number(columns = c("R2", "adjusted_pvalues"), decimals = 3) |>
  cols_width(CoefficientName~px(200), R2~px(120), adjusted_pvalues~px(120)) |>
  cols_align(align = "center", columns = "adjusted_pvalues") |>
  cols_align(align = "center", columns = "R2") |>
  cols_align(align = "center", columns = "Significant Level") |>
  cols_label(adjusted_pvalues = md("P-value"), CoefficientName = md("Predictor")) |>
  cols_label(R2 = html("R<sup>2</sup>")) |>
  tab_footnote(footnote = "ns (not significant), * (0.05), ** (0.01), and *** (<0.001)",
               locations = cells_column_labels(columns = `Significant Level`),
               placement = "left") |>
  opt_row_striping()


all_beta_unweighted_unifrac

gtsave(all_beta_unweighted_unifrac, file = "aim1_all_beta_unweighted_unifrac.png")


#### entire weighted unifrac beta diversity table ####

all_beta_weighted_unifrac <- read_excel("results_table_weighted_unifrac.xlsx") |>
  select(-c(`Df`, `SumOfSqs`, `F`, `Pr(>F)`,`predictor`)) |>
  gt() 

all_beta_weighted_unifrac <- all_beta_weighted_unifrac |>
  tab_header(title = "Table 4: Beta-diversity (Weighted Unifrac) of entire Colombia metadata", 
             subtitle = ("Evaluating microbial composition (metric = Weighted Unifrac) of every predictor in the Colombia metadata")) |>
  opt_align_table_header("left") |>
  tab_options(table.font.name = "Arial") |> 
  fmt_number(columns = c("R2", "adjusted_pvalues"), decimals = 3) |>
  cols_width(CoefficientName~px(200), R2~px(120), adjusted_pvalues~px(120)) |>
  cols_align(align = "center", columns = "adjusted_pvalues") |>
  cols_align(align = "center", columns = "R2") |>
  cols_align(align = "center", columns = "Significant Level") |>
  cols_label(adjusted_pvalues = md("P-value"), CoefficientName = md("Predictor")) |>
  cols_label(R2 = html("R<sup>2</sup>")) |>
  tab_footnote(footnote = "ns (not significant), * (0.05), ** (0.01), and *** (<0.001)",
               locations = cells_column_labels(columns = `Significant Level`),
               placement = "left") |>
  opt_row_striping()


all_beta_weighted_unifrac

gtsave(all_beta_weighted_unifrac, file = "aim1_all_beta_weighted_unifrac.png")

