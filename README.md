# Machbase with R Analytics

This source code repository is an example of R analytics with Machbase DBMS.

1. generation of humidity.csv

"sh merge.sh"

Due to the limitation of upload file size, the humidity.csv file has been spilitted.
After download all files, just execute merge.sh to re-construct "humidity.csv".
The original size of this file is 256489K.

2. data cleansing
"sh run.sh" will do it the data cleansing automatically. 

3. analytics
humidity.R has all analytic script you want.

== FILES ==

calendarHeatmap.R    # HeatMap R Library 

cleansing.sql        # data cleasing SQL for Machbase

create_table.sql     # table creation SQL for Machbase

humidity.R           # R script for humidity analytics

run.sh               # auto run script 


humidity1.split      # 1st split file of humidity.csv.gz

humidity2.split      # 2nd split file of humidity.csv.gz

merge.sh             # merge the split files into humidity.csv.gz and uncompress to make "humidity.csv"


