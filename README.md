# clparlysearch - update

A set of tools to download and process data on Members of Parliament's activities in Parliament: their contributions to debates, the questions they ask and the Early Day Motions they sign. This package is principally designed for use by researchers in the House of Commons Library, but may be of use to other users. Data is retrieved from the Parliamentary Search website, which is currently only available (with full functionality) on the Parliamentary Estate.  

This package is in active development and I welcome any feedback.

## Installation
Install from GitHub using devtools. 

```{r eval = FALSE}
install.packages("devtools")
devtools::install_github("eliseuberoi/clparlysearch")
```

## Download data
There are six functions to download data on parliamentary activities:

* `fetch_all_contributions` downloads all contributions made in the Chamber and Westminster Hall in a specified period
* `fetch_contributions` downloads all contributions made in the Chamber in a specified period
* `fetch_debate` downloads all contributions made in a specific debate
* `fetch_questions` downloads all Parliamentary Questions asked in a specific period
* `fetch_session_EDMs` downloads all Early Day motions signed by Members in a session
* `fetch_EDMs_dates` downloads all Early Day motions signed by Members in a specified period

### Contributions
The `fetch_contributions` and `fetch_all_contributions` functions enable researchers to download all contributions made by Members of Parliament to parliamentary proceedings in the Commons Chamber or the Commons Chamber and Westminster Hall, respectively. The functions download data for a specified period which needs to be defined as per the below.

#### Arguments
The functions takes four arguments, two to define the period for which data is downloaded, and two to define the session in which this period fell. 

The functions work by downloading data by week. This means that the period specified needs to be a multiple of 7 (days) for best results. If a given period is not a multiple of 7, the function will only retrieve data for the full weeks falling inside the period. For example, if the period is defined as 2019-03-01 to 2019-03-31, data will be returned for 2019-03-01 to 2019-03-29. 

* `start_date` is the first day of the period for which contributions are downloaded. The date needs to be entered as "yyyy-mm-dd"
* `end_date` is the last day of the period for which contributions are downloaded. The date needs to be entered as "yyyy-mm-dd"

* `session_start` denotes the start of the session in which the specified period falls. It needs to be entered as yy
* `session_end` denotes the end of the session in which the specified period falls. It needs to be entered as yy

### Debates 
The `fetch_debate` function enables researchers to download all contributions made to a specific debate. 

#### Arguments
The function takes six arguments: 

* `keywords` is the title of the debate, entered as one string "connected+like+this"
* `day` is the day of the date of the debate, entered as dd
* `month` is the month of the date of the debate, entered as mm
* `year` is the year of the date of the debate, entered as yyyy
* `session_start` denotes the start of the session in which the specified period falls. It needs to be entered as yy
* `session_end` denotes the end of the session in which the specified period falls. It needs to be entered as yy

The function works by downloading all contributions that are associated with the keywords defined in the function. Note that this could include contributions made on the same day mentioning these words, outside of the specified debate. 

### Parliamentary Questions
The `fetch_questions` function enables researchers to download all Parliamentary Questions asked in a specified period. The period is defined in the same way as in the `fetch_contributions` function. 

#### Arguments
The function takes four arguments, two to define the period for which data is downloaded, and two to define the session in which this period fell. 

The function works by downloading data by week. This means that the period specified needs to be a multiple of 7 (days) for best results. If a given period is not a multiple of 7, the function will only retrieve data for the full weeks falling inside the period. For example, if the period is defined as 2019-03-01 to 2019-03-31, data will be returned for 2019-03-01 to 2019-03-29. 

* `start_date` is the first day of the period for which questions are downloaded. The date needs to be entered as "yyyy-mm-dd"
* `end_date` is the last day of the period for which questions are downloaded. The date needs to be entered as "yyyy-mm-dd"

* `session_start` denotes the start of the session in which the specified period falls. It needs to be entered as yy
* `session_end` denotes the end of the session in which the specified period falls. It needs to be entered as yy

### Early Day Motions
The `fetch_session_EDMs` and `fetch_EDMs_dates` functions enable researchers to download data on Early Day Motions (EDMs) signed by Members in a given session or a specified period. 

#### Arguments
The `fetch_session_EDMs` function takes two arguments: 

* `session_start` denotes the start of the session. It needs to be entered as yy
* `session_end` denotes the end of the session. It needs to be entered as yy

The `fetch_EDMs_dates` function takes six arguments to define the download for which to download data:
* `start_day` as dd
* `start_month` as mm
* `start_year` as yyyy
* `end_day` as dd
* `end_month` as mm
* `end_year` as yyyy

## Process data
The `process_contributions` function performs some basic processing on data downloaded using the contributions functions or the `fetch_debate` functions. It performs three actions:

* attributing contributions to a single Member (the first Member listed). Where two Members are listed, the second one is moved to a new column 
* removing rows without contributions (which occur where a Member rose or otherwise intervened in a debate, without using any words)
* counting the number of words per contribution

Note that Speakers have both their name and role listed, so "Speaker" will appear in the second_member column. 

### Arguments
The function takes one argument, `df`, which is the name of the dataframe containing contributions data. 

This function is designed to work on outputs from the above functions (or dataframes formatted similarly); it refers to certain columns by name ('content', containing the content of contributions; and 'member', containing the names of members making the contribution). 

### Examples

To download data on contributions made by Members of Parliament between 1 March 2019 and 15 March 2019 (which was in the 2017/19 session), run the following code: 

``` {r eval= FALSE} 
contributions <- fetch_contributions("2019-03-01", "2019-03-15", 17, 19)
```

If you are not sure which session the dates you are interested fall in, [this page](https://www.parliament.uk/about/faqs/house-of-commons-faqs/business-faq-page/recess-dates/recess/) has information on start and end dates of all sessions since 1979. 

If you want data for a specific debate, find out the title of the debate and the date it took place (for example from [Hansard](https:://www.hansard.parliament.uk)). Then use this information in the `fetch_debate` function. 

``` {r eval= FALSE} 
animal_rescue_homes <- fetch_debate("animal+rescue+homes", 26, 02, 2019, 17, 19)
```

Once you have downloaded data, you can start cleaning it using the `process_contributions` function, for example:

``` {r eval= FALSE} 
contributions <- process_contributions(contributions)
```
Note that this will usually result in a warning message: most contributions do not have a second member listed, so the function will fill the second_member column with NA. 

