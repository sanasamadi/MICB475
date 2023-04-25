# name required packages
list.of.packages <- c("MASS", "phyloseq", "ape", "tidyverse", "vegan", "data.table")

# install required packages if necessary, and load them
{
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  lapply(list.of.packages, require, character.only = TRUE)
}

# sourcing code from the other files
source("AIC_for_adonis2.R")
source("COLOMBIA_final.R")


# setting seed for repeatable data
set.seed(10001)

# extracting sample data from phyloseq object
sampdata <- data.frame(sample_data(COLOMBIA_final))

# filtering out NAs in the dataset
sampdata_filt <- sampdata |>
  drop_na()

# filtering phyloseq object to remove dropped samples
COLOMBIA_no_na <- prune_samples(rownames(sampdata_filt), COLOMBIA_final)

######## stepAIC for alpha diversity ############

# calculate richness metric
estrich <- estimate_richness(COLOMBIA_final)

# make a vector that is just shannon
shannon_vec <- estrich$Shannon

allPredictors <- colnames(sampdata)

# make a model with ALL predictors
model_full <- lm(shannon_vec ~ ., data = sampdata)
stepaic_results <- stepAIC(model_full)
alpha_model <- summary(stepaic_results)
alpha_model
stepaic_results <- as.data.frame(stepaic_results$anova)

# comparing AIC values:
AIC(model_full) # full model (all predictors)
AIC(stepaic_results) # best fit model AIC

capture.output(alpha_model, file = "stepaic_alpha.txt")

######## stepAIC for PERMANOVA (unweighted unifrac) ##########

#Create distance matrix response variable
dm_unifrac <- UniFrac(COLOMBIA_no_na, weighted = TRUE)

# This is a list of predictors we are going to change
currentPredictorSet <- allPredictors
# This is the current AIC of the full model
frml_currentBest <- formula(paste0("dm_unifrac ~", paste0(currentPredictorSet, collapse=" + ")))
permanova_results_currentBest <- adonis2(frml_currentBest, data=sampdata_filt, permutations = 10000)
aic_currentBest <- AICc.PERMANOVA2(permanova_results_currentBest)
aic_currentBest

capture.output(aic_currentBest, file = "aic_currentBest_weighted.txt")

#capture.output(permanova_results_currentBest, file = "unweighted_unifrac_full_model_results.txt")
#capture.output(aic_currentBest, file = "aic_full_model_values.txt")

# Loop thorugh all variables, dropping each one to see if it should be kept or not
for ( d in allPredictors ) {
  # d="depth"
  # make a new vector that is "potential set of predictors"
  # That is-- the next model we are trying to test against our current model
  # This new model formula is our "old" model formula MINUS the current variable 'd'
  # match() returns the index (location) of where d matches currentPredictorSet
  potentialPredictorSet <- currentPredictorSet[-match(d,currentPredictorSet)] 
  # This if loop is to check whether the new predictor set has anything in it
  # If potentialPredictorSet is "blank" (no predictor), then we set it to "1", which is a "null" model
  if (length(potentialPredictorSet)==0) {
    potentialPredictorSet <- "1"
  }
  # Make a model formula for new set
  frml_new <- formula(paste0("dm_unifrac ~", paste0(potentialPredictorSet, collapse=" + ")))
  # Run PERMANOVA
  permanova_results_new <- adonis2(frml_new, data=sampdata, permutations = 10000)
  # Use the custom sourced AICc.PERMANOVA2 function to calculate AIC value from PERMANOVA
  aic_new <-AICc.PERMANOVA2(permanova_results_new)
  ## Test which AIC is better; new or old? if new is better (lower), update currentPredictorSets and aic_old
  if ( aic_currentBest$AIC < aic_new$AIC ) {
    # If the above is true, we keep OLD models
    print(paste0("Keeping variable ",d)) # This is not needed, but nice to have some text feedback when running a long loop
  } else {
    print(paste0("Dropping variable ",d)) # This is not needed, but nice to have some text feedback when running a long loop
    # else, we update model with removed predictor
    currentPredictorSet <- potentialPredictorSet
    frml_currentBest <- frml_new
    permanova_results_currentBest <- permanova_results_new
    aic_currentBest <- aic_new
  }
}
# Save these as our best forward models
permanova_best <- permanova_results_currentBest
aic_best <- aic_currentBest

capture.output(aic_best, file = "aic_final_model_weighted.txt")
