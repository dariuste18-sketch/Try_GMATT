pheno.file <- system.file("extdata", "pheno.txt", package = "GMMAT")
pheno <- read.table(pheno.file, header = TRUE)
dim(pheno)

# Applying GLMM

model0 <- glmmkin(disease ~ age + sex, data = pheno, kins = GRM,
    id ="id", family = binomial(link = "logit"))

#show varience components 
model0$theta

# show coefficients 
model0$coefficients

# Covarience Matrix
model0$cov

#cleaning
file.rename(".gitignore", "Gwas Learning/.gitignore")
file.rename("Data", "Gwas Learning/Data")

