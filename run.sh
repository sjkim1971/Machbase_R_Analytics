csvimport -d humidity.csv -t humidity_dummy -b bad.log -C

cat bad.log

machsql -f create_table.sql -s 127.0.0.1 -u sys -p manager

machsql -f cleansing.sql -s 127.0.0.1 -u sys -p manager
