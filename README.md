# ACTR_SFT

This repository contains code for the paper *Using systems factorial technology for global model analysis of ACT-R's core architectural assumptions*.

# Installation 

The main simulations were performed in the Julia programming language using version 1.10. You may download the Julia from the official [download page](https://julialang.org/downloads/). The code should work with newer versions in the 1.0 series, but you may download 1.10 from the [old releases page](https://julialang.org/downloads/oldreleases/) once it is no longer the most current version. You can run Julia directly from the REPL (i.e., command line), or via the [VSCode](https://www.julia-vscode.org/) IDE. 

# Running the Code

After installing Julia, use `git clone` to download the code to your desired directory. Next, you must instantiate the environment the first time you run the code. You only need to do this once. In the REPL, enter `;` to enter the Shell mode and cd to the directory where the code is located. Hit `Esc` to exit Shell mode, and hit `]` to enter Package mode. Enter `instantiate` to initialize the project environment. It should look like this: 

```julia 
(ACTR_SFT) pkg> instantiate
```

Once the project environment has been created, you can run the desired code. 

# Directory Structure

The subfolder `/simulations` contains the simulations used in the paper. Figure 2 was generated with the script `/simulations/generate_sic_plots.jl`, which is the primary simulation used in the paper. The core double factorial experiment simulations were performed in Julia due to ease of use and faster simulation time. The core code can be found in `/src`. 

We also developed models with standard production rule sytax in Lisp. The subfolder `/simulations/lisp_models` contains example ACT-R models written in Lisp. You can run that code by opening lisp via `/ACT-R/run-act-r.bat` or `/ACT-R/run-act-r-only.bat` and loading the disired model in `/simulations/lisp_models`. Simulations with the ACT-R lisp library can be slow. So the output was saved to `/simulation_output`. Analyses of the output, such as gantt plots, are performed in Julia in `/analyses`. 

Approved for public release; distribution unlimited. Cleared 12/21/2023; Case Number: AFRL-2023-6387