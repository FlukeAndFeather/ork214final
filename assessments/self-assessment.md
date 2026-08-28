# Self Assessment

## Automate
### The entire analysis is automated: Not yet
#### To change
While the data reading, cleaning, and analysis is planned in the spaghetti code, it needs to be isolated into a standalone script.

The script still needs to be added to the Quarto document.

Since code has not yet been finalized, I am unsure if it runs completely without errors.  However, initial runs seem to be producing a rough version of the expected graph.

#### Completed
Files in the R/ folder exclusively define functions.

### The analysis produces the expected output: Not yet
#### To change
Code has not been added to the document yet, but the code creates a rough approximation of the original.  I still need to add additional formatting in ggplot to improve its readability and resemblance to the original.

## Organize
### Data are properly organized: Not yet
#### To change:
Outputs have not been isolated from the code, though code is in a separate folder from the raw data.  Polished code needs to be separated from scratch/.

#### Completed:
Raw data is contained in its own folder

### Code is properly organized: Meets spec
The function moving_average() is defined in R/ and used in the spahetti code in scratch/.  It will be used in the polished code.

Technically, all code in the repo outside of scratch/ is required for the analysis, but there is no code outside of scratch/.  Most of the code for analysis is included in scratch/ and still needs to be isolated.


## Document

### The repo has an effective README: Meets spec
#### To change
Add an image comparing the original graph and the reproduction.

Reformat some sections to tables to improve readability.

#### Completed
The README contains all required information, but formatting can be improved.

### Code follows a professional style: Not yet
Code isolated to perform the analysis does not contain comments.

Code defining the moving_average function includes comments where needed and meaningful variable names.

Code roughly follows a consistent style, but implementing te Air formatter will improve it.