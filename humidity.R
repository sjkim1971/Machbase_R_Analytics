Sys.setlocale("LC_ALL", locale ="C")

library('RODBC')
library('lattice')
library('grid')
library('chron')
source("./calendarHeatmap.R");

conn <- odbcConnect('machbase', believeNRows=FALSE, case="toupper");

# generate humidity aggretation
dat <- sqlQuery(conn, "SELECT TO_CHAR(s_year)||'-'||LPAD(TO_CHAR(s_month),2,'0')||'-'||LPAD(TO_CHAR(s_day),2,'0') AS s_date, s_min, s_max, s_avg FROM (SELECT S_YEAR, S_MONTH, S_DAY, MIN(S_VALUE) s_min, MAX(S_VALUE) s_max, AVG(S_VALUE) s_avg FROM humidity GROUP BY S_YEAR, S_MONTH, S_DAY ORDER BY S_YEAR, S_MONTH, S_DAY)")
View(dat)

# Max heatmap
calendarHeat(dates=dat$s_date, values=dat$s_max, color="g2r", varname="Humidity Max Value")

# Min heatmap
calendarHeat(dates=dat$s_date, values=dat$s_min, color="g2r", varname="Humidity Min Value")

# Avg heatmap
calendarHeat(dates=dat$s_date, values=dat$s_avg, color="g2r", varname="Humidity Average")

# time-series chart data for the day of August 28
hourmax <- sqlQuery(conn, "SELECT S_HOUR, S_MINUTE, S_SECOND, S_VALUE FROM humidity WHERE S_MONTH = 8 and S_DAY = 28")
plot(hourmax$S_HOUR, hourmax$S_VALUE, col="blue", main="2016-08-28 humidity per hour", xlab="hour", ylab="value")

# time-series chart data for the day of August 28 from  12 o'clock to 13 o'clock.
minmax <- sqlQuery(conn, "SELECT S_MINUTE, S_SECOND, S_VALUE FROM humidity WHERE S_MONTH = 8 and S_DAY = 28 and S_HOUR = 12")
plot(minmax$S_MINUTE, minmax$S_VALUE, col="#de5347", main="2016-08-28 12 ~ 13 humidity per minute", xlab="minute", ylab="value")

#  time-series chart for 2016
plot(dat$s_date, dat$s_avg, col="#de5347", main="2016", xlab="day", ylab="humidity")

odbcClose(conn)
