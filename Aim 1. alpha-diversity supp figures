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

###### setting up plots ########
sampdata <- data.frame(sample_data(COLOMBIA_final))

# make vector of column names
allPredictors <- colnames(sampdata)

# saving column names for reference 
capture.output(allPredictors, file = "col_names_all_predictors.txt")

# calculate richness metric
estrich <- estimate_richness(COLOMBIA_final)
# make a vector that is just shannon
shannon_vec <- estrich$Shannon

##### plots #####

#### adiponectin plot ####
adiponectin_plot <- plot_richness(COLOMBIA_final, x = "adiponectin", 
                                  measures = c("Shannon"), color = "adiponectin") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5), 
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 15),) +
  labs(x = "Adiponectin levels (µg/ml)", color = "Adiponectin (µg/ml)") + 
  scale_color_gradient(low="darkgreen", high="pink")

adiponectin_plot

ggsave("alpha_adiponectin_figure.png", 
       adiponectin_plot, 
       height = 4, width = 6)

#### animal protein plot ####
per_animal_protein_plot <- plot_richness(COLOMBIA_final, x = "per_animal_protein", 
                                  measures = c("Shannon"), color = "per_animal_protein") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5), 
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 15),) +
  labs(x = "Daily Animal Protein Intake (%)", color = "Daily Animal Protein Intake (%)") + 
  scale_color_gradient(low="darkgreen", high="pink")

per_animal_protein_plot

ggsave("alpha_per_animal_protein_plot_figure.png", 
       per_animal_protein_plot, 
       height = 4, width = 6)

#### body fat percentage plot ####
bfp_plot <- plot_richness(COLOMBIA_final, x = "Body_Fat_Percentage", 
                                measures = c("Shannon"), color = "Body_Fat_Percentage") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5), 
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 15),) +
  labs(x = "Body fat percentage (%)", color = "Body fat percentage (%)") +
  scale_color_gradient(low="darkgreen", high="pink")

bfp_plot

ggsave("alpha_bfp_figure.png", 
       bfp_plot, 
       height = 4, width = 6)

#### city plot ####
city_plot <- plot_richness(COLOMBIA_final, x = "city", measures = c("Shannon"), color = "city") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5), 
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 15)) +
  geom_boxplot(alpha = 0.5) +
  stat_compare_means(method = "anova", label.y.npc = 0) +
  labs(x = "City", color="City") 
city_plot + scale_colour_brewer (palette = "Set2")

ggsave("alpha_city_figure.png", 
       city_plot, 
       height = 4, width = 6)
