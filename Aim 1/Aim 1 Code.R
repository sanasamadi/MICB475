# name required packages
list.of.packages <- c("MASS", "phyloseq", "ape", "tidyverse", "vegan", "RColorBrewer", "cowplot", "ggpubr")

# install required packages if necessary, and load them
{
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  lapply(list.of.packages, require, character.only = TRUE)
}

# setting seed for repeatable data
set.seed(10001)

# extracting code for phyloseq object
source("COLOMBIA_final.R")

###### Extracting sample data ########
sampdata <- data.frame(sample_data(COLOMBIA_final))

# make vector of column names
allPredictors <- colnames(sampdata)

######## Setting up richness loop ########
# calculate richness metric
estrich <- estimate_richness(COLOMBIA_final)
# make a vector that is just shannon
shannon_vec <- estrich$Shannon

######## Alpha diversity loop to test each individual predictor ###########
# create new folder for alpha diversity if you want
dir.create("AlphaDiversity")
setwd("AlphaDiversity")


# make a data frame
results_table_alpha <- data.frame()

for ( x in allPredictors ) {
  # making linear model
  model <- lm(shannon_vec ~ get(x), data = sampdata)
  
  # adjusting p values
  pvalues <- summary(model)$coefficients[,4]
  adjusted_pvalues <- p.adjust(pvalues, method = "BH")
  
  #inserting values in data frame
  new_results <- summary(model)$coefficients |>
    as.data.frame() |> 
    rownames_to_column(var="CoefficientName") |> # this makes the rownames a column
    mutate(predictor = x, adjusted_pvalues) # this tells you which predictor you are using
  results_table_alpha <- rbind(results_table_alpha, new_results)
  
}

# view data frame
results_table_alpha

# removing intercept from table 
results_table_alpha_filt <- results_table_alpha |>
  filter(CoefficientName != "(Intercept)") |> # filters out intercept coefficient
  rowwise() |> 
  mutate(CoefficientName = gsub("get(x)", predictor, CoefficientName, fixed=TRUE)) |> 
  ungroup() 

# view table
results_table_alpha_filt

# open file to save as txt format
write.table(results_table_alpha_filt, file="results_table_alpha.txt", 
            quote = FALSE, sep="\t", row.names = FALSE)

#### loop for alpha diversity plots ####
richness_plots <- list()

for (x in allPredictors) {
  richness_plots[[x]] <- plot_richness(COLOMBIA_final, x = x, measures = c("Shannon"), 
                                       color = x) +
    theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5))
  
}

richness_plots

# save all plot objects 
for (x in seq_along(allPredictors)) {
  ggsave(filename = paste0("plot_richness_", allPredictors[x], ".png"), 
         plot = richness_plots[[x]], 
         height = 4, width = 6)
 
}

# go back to parent directory if a new directory was made
setwd("..")


#### Beta diversity #####
#create new folder for beta diversity
dir.create("BetaDiversity")
setwd("BetaDiversity")


#### PERMANOVA using unweighted unifrac metric ####
# object for distance matrix
dm_unifrac <- UniFrac(COLOMBIA_final, weighted = FALSE)

# creating data frame to store values
results_table_unifrac <- data.frame()

### loop ###
for ( x in allPredictors ) {
  
  # making linear model
  permanova_results <- adonis2(dm_unifrac ~ get(x), data = sampdata, permutations = 10000)
  
  # adjusting p values
  adjusted_pvalues <- p.adjust(permanova_results$`Pr(>F)`, method = "BH")
  permanova_results$`Pr(>F)` <- adjusted_pvalues
  
  #inserting values in data frame
  new_results <- permanova_results |>
    as.data.frame() |>
    rownames_to_column(var="CoefficientName") |>
    mutate(predictor = x, adjusted_pvalues)
  results_table_unifrac <- rbind(results_table_unifrac, new_results)
  
}

# view 
results_table_unifrac

# removing residual and total from table 
results_table_unifrac_filt <- results_table_unifrac |>
  subset(CoefficientName == "get(x)") |> 
  rowwise() |> 
  mutate(CoefficientName = gsub("get(x)", predictor, CoefficientName, fixed=TRUE)) |> 
  ungroup() 


# view table
results_table_unifrac_filt

# open file to save
write.table(results_table_unifrac_filt, file="results_table_unweighted_unifrac.txt", 
            quote = FALSE, sep="\t", row.names = FALSE)



#### loop for beta diversity plots ####


##### unweighted unifrac plots #####
pcoa_dm_unifrac <- ordinate(COLOMBIA_final, method = "PCoA", distance = dm_unifrac)

unifrac_plots <- list()

for (x in allPredictors) {
  unifrac_plots[[x]] <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = x) +
    labs(title = x) 
}

unifrac_plots


# save all plot objects 
for (x in seq_along(allPredictors)) {
  ggsave(filename = paste0("plot_pcoa_unweighted_unifrac_", allPredictors[x], ".png"), 
         plot = unifrac_plots[[x]], 
         height = 4, width = 6)
  
}


# go back to parent directory if a new directory was made
setwd("..")
