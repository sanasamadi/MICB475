# name required packages
list.of.packages <- c("gapminder", "gt", "tidyverse", "webshot2", "gtsummary", "readxl")

# install required packages if necessary, and load them
{
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  lapply(list.of.packages, require, character.only = TRUE)
}

#### model selection alpha table ####


model_selection_alpha <- read_excel("model_selection_data.xlsx", sheet="Sheet1") |>
  gt() 

  
#model_selection_alpha <- data.frame(
#  Predictors = c("Age (years)", "Body fat percentage", "City (Bogota)", "City (Bucaramanga)",
#                 "City (Cali)", "City (Medellin)", "Insulin", "Medication (yes)", "Carbohydrates",
#                 "Total fat", "Animal protein", "Sex (Male)"),
#  Estimate = c(0.0111, -0.0169, 0.4943, 0.0290, -0.2454, 0.4111, 0.0083, -0.1242, -0.0751,
#               -0.0888, -0.0292, -0.2208),
#  `P-value` = c(0.01299, 0.1019, 0.0001, 0.8236, 0.0703, 0.000804, 0.1304, 0.1466, 0.0106, 
#              0.0086, 0.0008, 0.0157),
#  stringsAsFactors = FALSE
#) |>
#  gt()

model_selection_alpha <- model_selection_alpha |>
  tab_header(title = "Table 5: Alpha-diversity Model Selection", 
             subtitle = ("Combination of predictors that best explain
             Shannon diversity from 35 original variables")) |>
  opt_align_table_header("left") |>
  tab_options(table.font.name = "Arial") |> 
#  sub_values(values = 0.01299, replacement = "0.01299 *") |>
#  sub_values(values = 0.0001, replacement = "0.0001 ***") |>
#  sub_values(values = 0.000804, replacement = "0.00080 ***") |>
#  sub_values(values = 0.0106, replacement = "0.0106 *") |>
#  sub_values(values = 0.0086, replacement = "0.0086 **") |>
#  sub_values(values = 0.0008, replacement = "0.0008 ***") |>
#  sub_values(values = 0.0157, replacement = "0.0157 *") |>
  fmt_number(columns = c("Estimate", "P-value"), decimals = 3) |>
  cols_width(Predictors~px(160), Estimate~px(120), `P-value`~px(120)) |>
  cols_align(align = "center", columns = c("Estimate", "P-value", "Significant Level")) |>
#  cols_label(P_value = md("P-value")) |>
  tab_footnote(footnote = "ns (not significant), * (0.05), ** (0.01), and *** (<0.001)",
               locations = cells_column_labels(columns = `Significant Level`),
               placement = "left")|>
  opt_row_striping()

  
model_selection_alpha


gtsave(model_selection_alpha, file = "aim2_model_selection_alpha.png")

#### model selection beta table ####
model_selection_beta <- read_excel("model_selection_data.xlsx", sheet="Sheet2") |>
  gt()


model_selection_beta <- model_selection_beta |>
  tab_header(title = "Table 6: Beta-diversity Model Selection", 
             subtitle = "Combination of predictors that best explain
             microbial composition (Weighted Unifrac) from 35 original variables") |>
  opt_align_table_header("left") |>
  tab_options(table.font.name = "Arial") |>
  fmt_number(columns = c("R2", "P-value"), decimals = 3) |>
  cols_align(align = "center", columns = "Significant Level") |>
  cols_width(Predictors~px(200), R2~px(100), `P-value`~px(100), `Significant Level`~px(150)) |>
  cols_align(align = "center", columns = c("R2", "P-value", "Significant Level")) |>
  cols_label(R2 = html("R<sup>2</sup>")) |>
  tab_footnote(footnote = "ns (not significant), * (0.05), ** (0.01), and *** (<0.001)",
    locations = cells_column_labels(columns = `Significant Level`),
    placement = "left") |>
  opt_row_striping()


model_selection_beta


gtsave(model_selection_beta, filename="aim2_model_selection_beta.png")


