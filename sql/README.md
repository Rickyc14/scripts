# SQL


## psql

Meta-Commands (Start with a Backslash `\`):
- `\q`: Quit/Exit the psql shell.
- `\c [database_name]`: Connect to a specific database.
- `\l` or `\list`: List all databases.
- `\dt`: List all tables in the current database.
- `\d [table_name]`: Describe a table, such as showing its columns and their data types.
- `\dn`: List all schemas in the current database.
- `\du`: List all roles/users.
- `\g` or `;`: Execute the query in the buffer (the same as hitting enter after a semicolon).
- `\s`: Display command history.
- `\i [filename]`: Execute commands from a file in SQL format.
- `\e`: Open a text editor with the content of the current query buffer, allowing you to edit a multi-line query more comfortably.
- `\timing`: Toggle the display of execution times for SQL commands.
- `\x`: Toggle expanded output mode. This is useful for viewing large sets of data more clearly.



## References

- [psql — PostgreSQL interactive terminal](https://www.postgresql.org/docs/current/app-psql.html)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/current/index.html)

