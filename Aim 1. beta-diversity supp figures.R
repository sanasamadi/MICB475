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

# unweighted unifrac distance metric
dm_unifrac <- UniFrac(COLOMBIA_final, weighted = FALSE)
pcoa_dm_unifrac <- ordinate(COLOMBIA_final, method = "PCoA", distance = dm_unifrac)

#### BMI plot ####
# object for superscript
BMIm2 <- expression(BMI (kg/m^"2"))

unifrac_bmi <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "BMI") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = BMIm2) + 
  scale_color_gradient(low="darkgreen", high="pink")
unifrac_bmi 

ggsave("unifrac_bmi.png", 
       unifrac_bmi, 
       height = 4, width = 6)

#### BMI class plot ####
unifrac_bmi_class <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "BMI_class") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "BMI class") +
  scale_colour_brewer (palette = "Set2")
unifrac_bmi_class 

ggsave("unifrac_bmi_class.png", 
       unifrac_bmi_class, 
       height = 4, width = 6)

#### calorie intake plot ####
unifrac_Calorie_intake <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "Calorie_intake") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "Calorie Intake (kcal/day)") + 
  scale_color_gradient(low="darkgreen", high="pink")
unifrac_Calorie_intake 

ggsave("unifrac_Calorie_intake.png", 
       unifrac_Calorie_intake, 
       height = 4, width = 6)

#### city plot ####
unifrac_city <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "city") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "City") +
  scale_colour_brewer (palette = "Set2")
unifrac_city 

ggsave("unifrac_city.png", 
       unifrac_city, 
       height = 4, width = 6)

#### diastolic bp plot ####
unifrac_diastolic_bp <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "diastolic_bp") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "Diastolic Blood Pressure (mmHg)") + 
  scale_color_gradient(low="darkgreen", high="pink")
unifrac_diastolic_bp 

ggsave("unifrac_diastolic_bp.png", 
       unifrac_diastolic_bp, 
       height = 4, width = 6)

#### fiber plot ####
unifrac_fiber <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "fiber") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "Fiber (g/day)") + 
  scale_color_gradient(low="darkgreen", high="pink")
unifrac_fiber 

ggsave("unifrac_fiber.png", 
       unifrac_fiber, 
       height = 4, width = 6)

#### latitude plot ####
unifrac_latitude <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "latitude") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "Latitude (degrees)") + 
  scale_color_gradient(low="darkgreen", high="pink")
unifrac_latitude 

ggsave("unifrac_latitude.png", 
       unifrac_latitude, 
       height = 4, width = 6)

#### HDL plot ####
unifrac_HDL <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "HDL") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "High-density lipoprotein (mg/dL)") + 
  scale_color_gradient(low="darkgreen", high="pink")
unifrac_HDL

ggsave("unifrac_HDL.png", 
       unifrac_HDL, 
       height = 4, width = 6)

#### VLDL plot ####
unifrac_VLDL <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "VLDL") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "Very low density lipoprotein (mg/dL)") + 
  scale_color_gradient(low="darkgreen", high="pink")
unifrac_VLDL

ggsave("unifrac_VLDL.png", 
       unifrac_VLDL, 
       height = 4, width = 6)

#### triglycerides plot ####
unifrac_Triglycerides <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "Triglycerides") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "Triglycerides (mg/dL)") + 
  scale_color_gradient(low="darkgreen", high="pink")
unifrac_Triglycerides

ggsave("unifrac_TriglyceridesL.png", 
       unifrac_Triglycerides, 
       height = 4, width = 6)

#### medication plot ####
unifrac_medication <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "medication") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "Medication") +
  scale_colour_brewer (palette = "Set2")
unifrac_medication

ggsave("unifrac_medication.png", 
       unifrac_medication, 
       height = 4, width = 6)

#### animal protein plot ####
unifrac_per_animal_protein <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "per_animal_protein") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "Daily Animal Protein Intake (%)") +
  scale_color_gradient(low="darkgreen", high="pink")
unifrac_per_animal_protein

ggsave("unifrac_per_animal_protein.png", 
       unifrac_per_animal_protein, 
       height = 4, width = 6)

#### sex plot ####
unifrac_sex <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "sex") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "Sex") +
  scale_colour_brewer (palette = "Set2")
unifrac_sex

ggsave("unifrac_sex.png", 
       unifrac_sex, 
       height = 4, width = 6)

#### stool consistency plot ####
unifrac_stool_consistency <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "stool_consistency") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "Stool Consistency") +
  scale_colour_brewer (palette = "Set2")
unifrac_stool_consistency

ggsave("unifrac_stool_consistency.png", 
       unifrac_stool_consistency, 
       height = 4, width = 6)

#### systolic bp plot ####
unifrac_systolic_bp <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "systolic_bp") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "Systolic Blood Pressure (mmHg)") +
  scale_color_gradient(low="darkgreen", high="pink")
unifrac_systolic_bp

ggsave("unifrac_systolic_bp.png", 
       unifrac_systolic_bp, 
       height = 4, width = 6)

#### waist circumference plot ####
unifrac_waist_circumference <- plot_ordination(COLOMBIA_final, pcoa_dm_unifrac, color = "waist_circumference") +
  labs(x = "PCo1 5.6%", y = "PCo2 3.3%", color = "Waist Circumference (cm)") +
  scale_color_gradient(low="darkgreen", high="pink")
unifrac_waist_circumference

ggsave("unifrac_waist_circumference.png", 
       unifrac_waist_circumference, 
       height = 4, width = 6)
