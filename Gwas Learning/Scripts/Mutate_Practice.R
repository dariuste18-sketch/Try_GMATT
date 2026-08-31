# Use the mutate function to give all of my strains the same line ID
#Practice merging multiple data frames together for statistical analysis 


#Create phenotables first 

Trait <- tibble( ID = 1:8, CT_Max = c(36.5, 29.4, 37.4, 32.2, 34.9, 43.1, 33.0, 32.0)
)

#save as RDS
saveRDS(Trait, file="Gwas Learning/Data/Trait.rds")

Sex <- tibble(Line_collumn = paste0("Line_", 1:8),Sex = c("M", "F", "M", "M", "F", "F", "M", "F"))

#Create wolbachia status frame 
Wolbachia_Status <- tibble(Line_collumn = paste0("Line_", 1:8), Wolbach = c("Y","N","N","Y","N","Y","N","Y"))

#Save wolbachia status frame 
saveRDS(Wolbachia_Status,"Gwas Learning/Data/Wol_Stat.rds")

#recover wolbachia status frame 
Wolbachia_Status <-read_rds("Gwas Learning/Data/Wol_Stat.rds")

# Create Sex frame
Sex <- tibble(Line_collumn = paste0("Line_", 1:8), Sex = c("M", "F", "M", "M", "F", "F", "M", "F"))
# Save as an RDS
saveRDS(Sex,"Gwas Learning/Data/Sex.rds")
#Let get out the Pheno table 
Pheno_Table <- readRDS("Gwas Learning/Data/Pheno_Table.rds")

# Lets use the mutate function to change the ID number in pheno table to Line_Id
Pheno_Table <- Pheno_Table %>% mutate(id = paste("Line",id, sep = "_"))

# change the other column to line 
Sex <- dplyr::rename(Sex, Line = Line_collumn)

Traits <- read_rds("Gwas Learning/Data/Trait.rds")
Wol_Status <- read_rds("Gwas Learning/Data/Wol_Stat.rds")
Sex <- read_rds("Gwas learning/Data/Sex.rds")

Traits$ID <- paste("Line",Traits$ID, sep= "_")

Traits <- Traits %>% rename(Line = ID)

Phenotype <- Traits %>% full_join(Wol_Status, by = "Line") %>% full_join(Sex, by = "Line")

Phenotype <- Phenotype %>% mutate(Sex = replace_na(Sex, 1)) 

Phenotype <- Phenotype %>% mutate(WolbNum = case_when(WolbNum == "Y" ~ 1, WolbNum == "N" ~ 0))
Phenotype <- Phenotype %>% mutate(Wolbnum = case_when(WolbNum == 1 ~ "Y", WolbNum == 0 ~ "N"))

Phenotype <- Phenotype %>% mutate(Wolbnum = NULL)
saveRDS(results,file= "Gwas Learning/Data/GLMMSCORE.rds") 
