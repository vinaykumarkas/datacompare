##Data Processer
The tool to process the data
### Requirement

We're after a command-line based thing.
This thing reads the attached CSV files (`data1.csv` and `data2.csv`), and validates the data using these rules:

1. Names cannot be less than four characters 
2. The code denoting state must be in the file states.csv
3. The salary must be an integer, and not a float
4. The postcode must exist

If any of the first three rules are broken then we should get a warning message.
If the fourth rule is broken then we need an error message.


### Overview

This tool in simple style tool which parses the data from csv files and validates the data aginst set of pre-defined rules.
Results will be written to a file. Warnings and Errors will be displayed on the screen during eexecution.

### Installation
Clone the project from [Git](https://github.com/vinaykumarkas/datacompare) and execute bundle command.

	$ bundle install

### Execution

From the command prompt, from project root directory, execute the below command

	$ ./bin/data_parser.rb data/data1.csv
	$ ./bin/data_parser.rb data/data1.csv
	
The ERROR and WARNING Messages will be displayed on the console and the results with out any errors will be written to results.csv file.


### Test
To execute the rspec testcases, execute the below command from the project root directory

	$ rspec spec

### ToDo
1. Extend the code functionality
2. Improvise the display of results
3. Improvise the ERROR and WARNING Messages, may be add to a file
4. Code refractor
5. Additional spec classes if required

