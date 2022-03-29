# lichen-revised-pls

Revised pls code and work flow for the aging lichen project.

## Scripts

[generatePLSData](https://github.com/LanceStasinski/lichen-revised-pls/blob/main/lichen-revised-pls/generatePLSData.R) is the main function that calls all other functions in this package. It takes in a spectra object, a className (unit of classification such as Family), a boolean for whether age should be included as covariate in the model, the initial number of components to start with, the number of iterations to run each PLS procedure for, and a directory for where files should be stored. This directory needs a setup as follows:

output
| - class (eg. family)
  |- no-age
    | - accuracies (accuracy rds files that are used to calculate optimal number of components)
    | - cm-final (confusion matrix figure)
    | - confusion-matrices (raw confusion matrices)
    | - metrics (rds file that stores average raw confusion matrix and confusion matrix of standard deviations, average overall accuracy, and number of components used)
    | - upsampled-modles (model objects generated during upsampling procedure)
    | - variable-importance (variable importance plots)
  | - with-age (same stucture as 'no-age' directory)

This function runs PLSDA using parallelization so that multiple cores on the machine can be used at a time in contrast to single threading. The function is set to use half of the available cores on your machine. The main products are the summary metrics (overall accuracy, number of components used), a confusion matrix, and variable importance plots that show the importance of the top 5 and bottom 5 components.

The functions called within this function are as follows:

- [plsda](https://github.com/LanceStasinski/lichen-revised-pls/blob/main/lichen-revised-pls/plsda.R): This function runs PLSDA with 10-fold cross validation repeated three times. Seventy percent of the data is used to train the model, and 30% is used to test the model. The sampling is conducted with replacement. This means that each iteration of the PLSDA function (not to be confused by the 10-fold cross validation) splits the data into a random 70/30 split. This function is called twice within the `generatePLSData` function. The first time, the `plsda` function is set to run with downsampled data. This step generates accuracy metrics that are used to determine the optimal number of components to use in the next call of the `plsda` function with upsampled data. This second call generates model objects which are then used to make the final interpretations about the data.
