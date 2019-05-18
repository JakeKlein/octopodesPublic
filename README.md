# Octopodes

Octopodes is a data science shell.  It can be run interactively via the command line or in batch mode, by passing a file containing a list of commands to run.

## Getting Started

### Pre-reqs

Octopodes is built in R.  As such, please be sure to have R installed on your local machine or compute cluster.   

### Installation

Octopodes can be installed by cloning from the octopodesPublic GitHub repository: https://github.com/JakeKlein/octopodesPublic.git.  

Please note that this is a public mirror of the actual Octopodes repo.  Only collaborators on the private Octpodes project can make pull requests.  Do **not** make pull requests to octopodesPublic: they will be erased at the next sync.

### Local Development

To open an interactive Octopodes shell, navigate to Octopodes directory, open an R session, and run the command `source('main.R')`.

### Dependency Management

Octopodes manages its own R dependencies.  You can find a list of installed dependencies in the Dependencies directory, in the file `loadDependencies.R`.  Do **not** remove or alter any of the listed packages.  The application will not run correctly.  You may, however, add any packages you need for local development.     
