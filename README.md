# Scheduling the Stouffer-Tylianakis meetings
Fernando Cagua  

Managing lab meetings can be a pain in the ass. This should help make it all easier. 

### Usage

1. Create a doodle poll and allow answers to be if-needed-be
2. When everyone answers the poll download the excel file with the results
3. Manually convert the file to a csv and edit it so that yes=1, if_needed_be=0.5, and no=0. Make sure that the first row has dates as the column name
4. Run `fixtures.R` to randomise the meetings
5. Run `export_icalendar.py` to create a calendar file that can be be easily imported into Google Calendar

### Script arguments

The R script should have the following arguments: --input, --output, --seed, and --date_format (in a strmptime compliant string). Run `fixtures.R --help` for more details.

The python script should have the input file, the output file and the meeting time as arguments in that order. Time should be in `%H:%M:%S` format.

### Fixtures

#### April - August 2017


```bash
Rscript fixtures.R --input=doodle_results_Feb2017.csv --output=fixtures_result2017A.csv --seed=2017 --date_format="%B %a %d"

python export_icalendar.py fixtures_result2017A.csv meetings2017A.ics '14:00:00'
```
