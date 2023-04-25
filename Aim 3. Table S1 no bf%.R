# name required packages
list.of.packages <- c("MASS", "phyloseq", "ape", "tidyverse", "vegan", "data.table")

# install required packages if necessary, and load them
{
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  lapply(list.of.packages, require, character.only = TRUE)
}


###### filtered COLOMBIA phyloseq object ###########

# load data
otu <- read_tsv("feature-table.txt", skip = 1)
meta <- read_tsv("colombia_metadata.txt")
tax <- read_tsv("taxonomy.tsv")
phylotree <- read.tree("tree.nwk")

# filtering out body fat percentage from metadata
select <- dplyr::select
meta_select <- meta |>
  select(-country, -Body_Fat_Percentage)
colnames(meta_select)

#### Format OTU table ####
# save everything except first column (OTU ID) into a matrix
otu_mat <- as.matrix(otu[,-1])
# make first column (#OTU ID) the rownames of the new matrix
rownames(otu_mat) <- otu$`#OTU ID`
# use the "otu_table" function to make an OTU table
OTU <- otu_table(otu_mat, taxa_are_rows = TRUE) 


#### Format sample metadata ####
# save everything except sampleid as new data frame
samp_df <- as.data.frame(meta_select[,-1])
# make sampleids the rownames
colnames(meta)
rownames(samp_df)<- meta_select$`#SampleID`
# make phyloseq sample data with sample_data() function
SAMP <- sample_data(samp_df)

#### Formatting taxonomy ####
# convert taxon strings to a table with separate taxa rank columns
colnames(tax)
tax_mat <- tax |>
  separate(col=Taxon, sep="; "
           , into = c("Domain", "Phylum", "Class", 
                      "Order", "Family", "Genus", "Species")) |>
  as.matrix() # Saving as a matrix
# save everything except feature IDS
tax_mat <- tax_mat[,-1]
# make sampleids the rownames
rownames(tax_mat) <- tax$`Feature ID`
# make taxa table
TAX <- tax_table(tax_mat)

#### Create phyloseq object ####
# merge all into a phyloseq object
COLOMBIA <- phyloseq(OTU, SAMP, TAX, phylotree)

# removing mitochondria and chloroplasts
COLOMBIA_filt <- subset_taxa(COLOMBIA, Domain == "d__Bacteria" 
                             & Class!="c__Chloroplast" & Family!="f__Mitochondria")

# removing NA's from systolic bp entry
COLOMBIA_final <- subset_samples(COLOMBIA_filt, !is.na(systolic_bp))


# extracting sample data from phyloseq object
sampdata <- data.frame(sample_data(COLOMBIA_final))


######## stepAIC for alpha diversity ############

# calculate richness metric
estrich <- estimate_richness(COLOMBIA_final)

# make a vector that is just shannon
shannon_vec <- estrich$Shannon

allPredictors <- colnames(sampdata)

# make a model with ALL predictors
model_full <- lm(shannon_vec ~ ., data = sampdata)
stepaic_results_nobfp <- stepAIC(model_full)
alpha_model_nobfp <- summary(stepaic_results_nobfp)
alpha_model_nobfp
stepaic_results_nobfp <- as.data.frame(stepaic_results_noins_ormeds$anova)

# comparing AIC values:
AIC(model_full) # full model (all predictors)
AIC(stepaic_results_nobfp) # best fit model AIC

capture.output(alpha_model_nobfp, file = "stepaic_alpha_nobfp.txt")
