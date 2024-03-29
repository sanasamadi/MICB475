# name required packages
list.of.packages <- c("phyloseq", "ape", "tidyverse", "vegan", "readxl", 
                      "ggplot2", "dplyr", "ggpubr", "DESeq2", "ggVennDiagram", "microbiome",
                      "indicspecies")

# install required packages if necessary, and load them
{
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  lapply(list.of.packages, require, character.only = TRUE)
}

# setting seed for repeatable data
set.seed(10001)

# filtering out metadata based on defined obesity metrics
meta_23 <- "colombia_metadata.txt"
meta <- read_delim (meta_23, delim="\t") 

meta_1 <- meta|>
  filter(sex == "female") |>
  filter(waist_circumference >= 80) |>
  filter(Body_Fat_Percentage >= 25)
meta_1 
meta_2 <- meta|>
  filter(sex == "male") |>
  filter(waist_circumference >= 90) |>
  filter(Body_Fat_Percentage >= 30)
meta_2
meta_data1 <- rbind(meta_1, meta_2) |>
  mutate(obese = "yes")
meta_data1

meta_3 <- meta |>
  filter(sex == "female") |>
  filter(waist_circumference < 80) |>
  filter(Body_Fat_Percentage < 25)
meta_3 
meta_4 <- meta |>
  filter(sex == "male") |>
  filter(waist_circumference < 90) |>
  filter(Body_Fat_Percentage < 30)
meta_4
meta_data2 <- rbind(meta_3, meta_4) |>
  mutate(obese = "no")
meta_data2

meta_data <- rbind(meta_data1, meta_data2)
meta_data
colnames(meta_data)

otufp <- "feature-table.txt"
otu_table <- read_delim(file = otufp, delim="\t", skip=1)

taxfp <- "taxonomy.tsv"
taxonomy <- read_delim(taxfp, delim="\t")

phylotreefp <- "tree.nwk"
phylotree <- read.tree(phylotreefp)

# format OTU table
otu_mat <- as.matrix(otu_table[,-1])
rownames(otu_mat) <- otu_table$`#OTU ID`
OTU <- otu_table(otu_mat, taxa_are_rows = TRUE) 

# format metadata
samp_df <- as.data.frame(meta_data[,-1])

rownames(samp_df)<- meta_data$`#SampleID`
SAMP <- sample_data(samp_df) 
class(SAMP)

tax_mat <- taxonomy %>% select(-Confidence)%>%
  separate(col=Taxon, sep="; "
           , into = c("Domain","Phylum","Class","Order","Family","Genus","Species")) %>%
  as.matrix()

tax_mat <- tax_mat[,-1]
rownames(tax_mat) <- taxonomy$`Feature ID`
TAX <- tax_table(tax_mat)

# creating phyloseq object with filtered metadata
coloumbia <- phyloseq (OTU, SAMP, TAX, phylotree)
otu_table(coloumbia)
sample_data(coloumbia)
tax_table(coloumbia)
phy_tree(coloumbia)

columbia_filt <- subset_taxa(coloumbia, Domain == "d__Bacteria" & Class!="c__Chloroplast" & Family !="f__Mitochondria")
columbia_filt_nolow <- filter_taxa(columbia_filt, function(x) sum(x)>5, prune = TRUE)
columbia_filt_nolow_samps <- prune_samples(sample_sums(columbia_filt_nolow)>100, columbia_filt_nolow)
columbia_final <- columbia_filt_nolow_samps


#rarecurve(t(as.data.frame(otu_table(columbia_final))), cex = 0.1)
columbia_rare <- rarefy_even_depth(columbia_final,rngseed = 7, sample.size = 5000)

# saving files
save(columbia_final, file="columbia_final.RData")
save(columbia_rare, file="columbia_rare.RData")

# load the files
load("columbia_final.RData")
load("columbia_rare.RData")
summary(columbia_rare)

# Load the files
load("columbia_rare.RData")


# unweighted unifrac plot
sampdata_aim3 <- sample_data(columbia_rare)
dm_unifrac_aim3 <- UniFrac(columbia_rare, weighted = FALSE)
pcoa_dm_unifrac_aim3 <- ordinate(columbia_rare, method = "PCoA", distance = dm_unifrac_aim3)
facet_label_sex <- c("Female", "Male")

pcoa_unifrac_plot_facet <- plot_ordination(columbia_rare, pcoa_dm_unifrac_aim3, 
                                           color = "obese") +
  labs(x = "PCo1 5.9%", y = "PCo2 3.4%", color="Obese Status") +
  facet_wrap(~sex, labeller = labeller(sex=c("female"="Female", "male"="Male"))) +
  scale_size(0.1)
pcoa_unifrac_plot_facet

ggsave("aim3_pcoa_unweighted_facet.png", 
       pcoa_unifrac_plot_facet, 
       height = 4, width = 6)

# PERMANOVA for unweighted
permanova_aim3_unweighted <- adonis2(dm_unifrac_aim3 ~ sampdata_aim3$obese, permutations=10000)

capture.output(permanova_aim3_unweighted, file = "aim3_permanova_unweighted.txt")


#### core ####
columbia_core<- transform_sample_counts(columbia_final, fun=function(x) x/sum(x))


columbia_core1 <- subset_samples(columbia_core, obese=="yes")
columbia_core2 <- subset_samples(columbia_core, obese=="no")
columbia_core3 <- core_members(columbia_core1, detection=0.001, prevalence = 0.10)
columbia_core4 <- core_members(columbia_core2, detection=0.001, prevalence = 0.10)

#### venn diagram ####
venndiagram <- ggVennDiagram(x=list( Obese = columbia_core3, Non_obese = columbia_core4), 
                             filename = "Project2/venndiagram.png", output=TRUE) +
  labs(fill="Count") +
  scale_fill_distiller (palette = "RdBu")
venndiagram
ggsave(filename = "venndiagram.png"
       , venndiagram
       , height=4, width=6)

columbia_genus <- tax_glom(columbia_final, "Genus", NArm = FALSE)
columbia_genus_RA <- transform_sample_counts(columbia_genus, fun=function(x) x/sum(x))

isa_columbia <- multipatt(t(otu_table(columbia_genus_RA)), cluster = sample_data(columbia_genus_RA)$obese)
summary(isa_columbia)
taxtable <- tax_table(columbia_final) %>% as.data.frame() %>% rownames_to_column(var="ASV")

aim3_ASV_table <- isa_columbia$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(taxtable) %>%
  filter(p.value<0.05) 

write_excel_csv(aim3_ASV_table, file = "aim3_ASV_table.csv")
