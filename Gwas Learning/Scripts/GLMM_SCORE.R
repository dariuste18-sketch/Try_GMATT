
library(GMMAT)
library(tidyverse)
library(magrittr)

# Now lets try a GLMM.Score

#Load phenotype data 

Pheno.file <- system.file("extdata","pheno.txt", package= "GMMAT")

pheno <- read.table(Pheno.file, header = TRUE)
head(pheno)
dim(pheno)
str(pheno)

#Load GRM 

GRM.file <- system.file("extdata", "GRM.txt.bz2", package = "GMMAT")
GRM <- as.matrix(read.table(GRM.file, check.names = FALSE))

#Create Null Model
model0 <- glmmkin(fixed = disease ~ age + sex, data = pheno, kins = GRM,
                  id = "id", family = binomial(link = "logit"))

model0$theta
model0$coefficients
model0$cov

#find example genotype file 
geno.file <- system.file("extdata", "geno.txt", package = "GMMAT")
readLines(geno.file, n = 10)
#Run glmm.score 
glmm.score(
  model0,
  infile = geno.file,
  outfile = "glmm.score.results.txt",
  infile.nrow.skip = 5,
  infile.ncol.skip = 3,
  infile.ncol.print = 1:3,
  infile.header.print = c(
    "SNP",
    "Allele1",
    "Allele2"
  )
)

file.exists("glmm.score.results.txt")
results <- read.table("glmm.score.results.txt",
                      header = TRUE
)

