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
allPredictors
capture.output(allPredictors, file = "col_names_all_predictors.txt")

######## Setting up richness loop ########
# calculate richness metric
estrich <- estimate_richness(COLOMBIA_final)
# make a vector that is just shannon
shannon_vec <- estrich$Shannon

# add + scale_color_gradient(low="black", high="lightgrey") for continuous variables
# add  + geom_boxplot(alpha = 0.5) + scale_colour_brewer (palette = "Set2") for discrete variables
# change titles in labs function 

adiponectin_plot <- plot_richness(COLOMBIA_final, x = "adiponectin", 
                                  measures = c("Shannon"), color = "adiponectin") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5), 
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 15),) +
  labs(x = "Adiponectin levels (µg/ml)", color = "Adiponectin (µg/ml)") + 
  scale_color_gradient(low="black", high="lightgrey")

adiponectin_plot

ggsave("alpha_adiponectin_figure.png", 
       adiponectin_plot, 
       height = 4, width = 6)

age_y_plot <- plot_richness(COLOMBIA_final, x = "age_years", 
                                  measures = c("Shannon"), color = "age_years") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5), 
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 15),) +
  labs(x = "Age (years)", color = "Age (years)") + 
  scale_color_gradient(low="black", high="lightgrey")

age_y_plot

ggsave("alpha_age_y_figure.png", 
       age_y_plot, 
       height = 4, width = 6)

age_r_plot <- plot_richness(COLOMBIA_final, x = "age_range", 
                            measures = c("Shannon"), color = "age_range") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5), 
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 15),) +
  labs(x = "Age (range)", color = "Age (range)") + 
  geom_boxplot(alpha = 0.5) +
  scale_colour_brewer (palette = "Set2")

age_r_plot

ggsave("alpha_age_range_figure.png", 
       age_r_plot, 
       height = 4, width = 6)

BMI_plot <- plot_richness(COLOMBIA_final, x = "BMI", 
                            measures = c("Shannon"), color = "BMI") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5), 
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 15),) +
  labs(x = "BMI", color = "BMI") + 
  scale_color_gradient(low="black", high="lightgrey")

BMI_plot

ggsave("alpha_BMI_figure.png", 
       BMI_plot, 
       height = 4, width = 6)

BMI_plot <- plot_richness(COLOMBIA_final, x = "BMI", 
                          measures = c("Shannon"), color = "BMI") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5), 
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 15),) +
  labs(x = "BMI", color = "BMI") + 
  scale_color_gradient(low="black", high="lightgrey")

BMI_plot

ggsave("alpha_BMI_figure.png", 
       BMI_plot, 
       height = 4, width = 6)

BMI_class_plot <- plot_richness(COLOMBIA_final, x = "BMI_class", 
                          measures = c("Shannon"), color = "BMI_class") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5), 
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 15),) +
  labs(x = "BMI class", color = "BMI class") + 
  geom_boxplot(alpha = 0.5) +
  scale_colour_brewer (palette = "Set2")

BMI_class_plot

ggsave("alpha_BMI_class_figure.png", 
       BMI_class_plot, 
       height = 4, width = 6)

bfp_plot <- plot_richness(COLOMBIA_final, x = "Body_Fat_Percentage", 
                                measures = c("Shannon"), color = "Body_Fat_Percentage") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5), 
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 15),) +
  labs(x = "Body fat percentage (%)", color = "Body fat percentage (%)") +
  scale_color_gradient(low="black", high="lightgrey")

bfp_plot

ggsave("alpha_bfp_figure.png", 
       bfp_plot, 
       height = 4, width = 6)

Calorie_intake_plot <- plot_richness(COLOMBIA_final, x = "Calorie_intake", 
                          measures = c("Shannon"), color = "Calorie_intake") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5), 
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 15),) +
  labs(x = "Calorie intake", color = "Calorie intake") +
  scale_color_gradient(low="black", high="lightgrey")

Calorie_intake_plot

ggsave("alpha_Calorie_intake_figure.png", 
       Calorie_intake_plot, 
       height = 4, width = 6)









