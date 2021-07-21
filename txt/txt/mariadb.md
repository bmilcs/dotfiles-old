# MARIADB

List databases > `SHOW DATABASES;`
Make example the active database > `use example;`
List tables in current database > `SHOW TABLES;`
List columns in mytable table > `SHOW COLUMNS IN mytable;``
Display contents of foo and bar fields from mytable > `SELECT foo,bar FROM mytable;`
+-----+-----+
| foo | bar |
+-----+-----+
| one | baz |
+-----+-----+
Display specified fields in mytable if a field matches a given value 
`SELECT user,host,select_priv FROM mytable WHERE user='tux'; FROM mytable WHERE user='tux';`
