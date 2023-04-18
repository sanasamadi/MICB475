# name required packages
list.of.packages <- c("gapminder", "gt", "tidyverse", "webshot2", "gtsummary", "readxl")

# install required packages if necessary, and load them
{
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  lapply(list.of.packages, require, character.only = TRUE)
}

#### model selection alpha table ####

# reading in data
model_selection_alpha <- read_excel("model_selection_data.xlsx", sheet="Sheet1") |>
  gt() 

# table
model_selection_alpha <- model_selection_alpha |>
  tab_header(title = "Table 5: Alpha-diversity Model Selection", 
             subtitle = ("Combination of predictors that best explain
             Shannon diversity from 35 original variables")) |>
  opt_align_table_header("left") |>
  tab_options(table.font.name = "Arial") |> 
  fmt_number(columns = c("Estimate", "P-value"), decimals = 3) |>
  cols_width(Predictors~px(160), Estimate~px(120), `P-value`~px(120)) |>
  cols_align(align = "center", columns = c("Estimate", "P-value", "Significant Level")) |>
  tab_footnote(footnote = "ns (not significant), * (0.05), ** (0.01), and *** (<0.001)",
               locations = cells_column_labels(columns = `Significant Level`),
               placement = "left")|>
  opt_row_striping()

# call table
model_selection_alpha

# saving table
gtsave(model_selection_alpha, file = "aim2_model_selection_alpha.png")

#### model selection beta table ####

# reading in data
model_selection_beta <- read_excel("model_selection_data.xlsx", sheet="Sheet2") |>
  gt()

# table
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

# call table
model_selection_beta

# saving table
gtsave(model_selection_beta, filename="aim2_model_selection_beta.png")
