# Automate

## The entire analysis is automated.

### Data reading and cleaning is handled in a standalone script that creates intermediate output(s) - Not yet.

### The analysis is performed in a Quarto document that reads intermediate outputs - Not yet.

### Files in the R/ folder exclusively define functions and have no other side effects. - Meets spec.

### All scripts run without errors. - Meets spec.

#### *Explanation: The quarto document should include the necessary code snippets for background, data, and methods. A standalone script that reads and cleans the data and creates an intermediate output needs to be made.*

## The analysis produces the expected output.

### The Quarto document performs the data analysis (moving average) - Not yet.

### The Quarto document creates a figure that is a reasonable approximation of the original - Close to met. 

#### *Explanation: Include the moving average code snippet from your fig-spaghetti.R file into the quarto doc. You are really close to the original graph! I think the your X-axis might be on days/hours from 1970 rather than showing an actual date. Also, setting the appropriate boundaries for the x-axis will cut the blank space in your graph. Otherwise good work.*

# Organize

## Data are properly organized.

### Raw data is contained in its own folder - Met.

### Outputs are contained in a separate folder from raw data - Met.

## Code is properly organized.

### At least one function is defined in a script in R/ and used elsewhere in the workflow - Met.

### All code in the repo (except in the scratch/ folder) is required for the analysis (i.e., no “safety blanket” code remaining) - Met

# Document

## The repo has an effective README.

### A short, but descriptive title - Met.

### A brief explanation of the repository’s purpose - Met.

### A concise description of what's housed in the repository - Met.

### Details regarding data acess - Met.

### A list of authors or current contributors - Met.

### References - Met.

## Code follows a professional style.

### All code files follow a consistent style (the Air formatter automates this). - Met. 

### The code has an appropriate amount of comments - Not yet.

#### *Explanation: Need more detailed comments on the quarto, but there's good comments on the fig-spaghetti.R file.*