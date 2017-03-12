# Readme
Fernando Cagua  

## Usage

`Rscript fixtures.R --input=#input_csv --seed=#random_seed`

The csv must contain people names in first column & dates in first row. Values 0 for not available, 0.5 for available but not preferred, and 1 for preferred.

## Fixtures

### April - August 2017


```bash
Rscript fixtures.R --input=doodle_results_Feb2017.csv --seed=2017
```

```
## Warning message:
## Not enough people to fill all the meetings 
## Warning message:
## Only one person in last meeting 
##      person         date
## 1   Melissa April.Thu.13
## 2     Jason April.Thu.13
## 3    Bernat April.Thu.27
## 4     Paula April.Thu.27
## 5      Zane    Aug.Thu.3
## 6    Sophie  July.Thu.20
## 7      Lupe  July.Thu.20
## 8   Warwick   July.Thu.6
## 9    Rogini   July.Thu.6
## 10     Lily  June.Thu.22
## 11   Daniel  June.Thu.22
## 12 Matthias   June.Thu.8
## 13    Carli   June.Thu.8
## 14 Fernando   May.Thu.11
## 15  Johanna   May.Thu.11
```
