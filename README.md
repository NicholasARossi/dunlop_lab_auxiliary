# dunlop_lab_auxiliary
![banner](logos/banner.png)

### A collection of Scripts to make lab work easier
This repository is a central location for making day to day lab tasks more automated and easier. Below is a description of each one and its intended function. These scripts were written by Zachary Hiens and Nicholas Rossi.


### List of functions:

## parser.py: 
Copies tiffs (leaving originals) into new directories based on group numbers extracted from the filename. This function is used to split up large datasets that will break the supper segger code (eg >1500 tiffs)
You call this function from the terminal in the following manner: 
```bash
$ python parser.py tiff_directory num_groups
```

## snap_parser.py: 
If you take a series of snaps with multiple replicates and multiple positions, it may be necesarry to break up the tiffs into groups based on the conditions, not based alone on xy position. 
This script takes one argument, just the director that you want to break up.
```bash
$ python snap_parser.py tiff_directory 
```

## test.m:
Main matlab script I used to process all the data. Calls parse_experiment_data, which in turn calls fitdata.

## parse_experiment_data.m:
Goes through the processed data and makes a matrix containing the data from the clist files. Kinda ugly, but whatever.

## parse_experiment_data_struct.m:
Super ugly. Same as parse_experiment_data, but returns a struct. Didn't feel like changing some other code for keeping track of iptg levels so made this slightly better function for subsequent stuff. Ideally this would replace the other function if you continued using it.

## fitdata.m: 
Function that does the differential evolution minimization. Pretty much just used the demo from the library but put my function and parameters into it.

## activation_funtion.m:
The function I minimized using fitdata.

## plot_activation_data.m: 
Pretty much what it sounds like.

## get_analytical_output_activation.m:
Uses the parameters from fitting and returns a list of values of the supplied range.
