################################################################################
# Run pls and generate data and figures for all classes
################################################################################
################################################################################
# Install libraries
################################################################################

install.packages(c('parallel', 'spectrolab', 'caret', 'dplyr', 'rlist',
                   'matrixStats', 'mlbench', 'MASS', 'corrplot', 'naniar'))

library(spectrolab)

#spectra = readRDS("spectra/lichen_spectra.rds")
spectra = readRDS("spectra/traindata_fgcint_spectra.rds")

generatePLSData = readRDS('functions/generatePLSData.rds')
base = 'output'

################################################################################
# Run for each class  
################################################################################

#dawson's data

generatePLSData(spectra = spectra, className = 'species', includeAge = F,
                ncomps = 5, numIterations = 4, baseDirectory = base)

# Species (scientificName)

generatePLSData(spectra = spectra, className = 'scientificName', includeAge = F,
                ncomps = 40, numIterations = 100, baseDirectory = base)

generatePLSData(spectra = spectra, className = 'scientificName', includeAge = T,
                ncomps = 40, numIterations = 100, baseDirectory = base)

# Family

generatePLSData(spectra = spectra, className = 'Family', includeAge = F,
                ncomps = 40, numIterations = 100, baseDirectory = base)

generatePLSData(spectra = spectra, className = 'Family', includeAge = T,
                ncomps = 40, numIterations = 100, baseDirectory = base)

# Order

generatePLSData(spectra = spectra, className = 'Order', includeAge = F,
                ncomps = 40, numIterations = 100, baseDirectory = base)

generatePLSData(spectra = spectra, className = 'Order', includeAge = T,
                ncomps = 40, numIterations = 100, baseDirectory = base)

# Class

generatePLSData(spectra = spectra, className = 'Class', includeAge = F,
                ncomps = 4, numIterations = 4, baseDirectory = base)

generatePLSData(spectra = spectra, className = 'Class', includeAge = T,
                ncomps = 4, numIterations = 4, baseDirectory = base)