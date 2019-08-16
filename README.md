# Liquibase Prototype
This prototype project demonstrates performing database migrations using Liquibase, and documents the features it 
provides. 

## Prerequisites
The following need to be installed on your system to run this project:

- [Java Development Kit 8+](https://www.oracle.com/technetwork/java/javase/downloads/index.html)
- [Maven](https://maven.apache.org/download.cgi)
- [Docker](https://www.docker.com/get-started)

## Quick Setup
Steps to get the project running:

- Download and install everything under prerequisites.
- Run `docker-compose up`
- Run `mvn liquibase:update`

You now have a running Postgres database that has all of the necessary configuration in place. The database migration 
scripts listed in the `scr/main/resources/db/changelog/sql/changelog-1.0_create_initial_tables.sql` file have been run. 

You can now connect to the database using your preferred tool with these details:
```
Host: localhost
Port: 5432
User: liquibase_migration
Password: 123456
Database: liquibase
```

## Postgres Setup

### Docker
The Postgres database can be run within a docker container.

This will create a volume under `./data` to hold the database's data. If you would like to clear your database and 
start again delete this directory.

It is important to note that the setup scripts will only run on a clean instance. Therefore, if you need to rerun them
you will first need to delete the `./data` directory and then run `docker-compose up`.

#### Commands
- To start the container detached: `docker-compose up -d`
- To stop the container: `docker-compose down`
- Show logs: `docker logs -f postgres`
- Run PSQL: `docker exec -it postgres psql --username liquibase_migration --dbname liquibase`

CTRL+D to exit.

Further commands can be found on the [Docker Cheat Sheet](https://www.saltycrane.com/blog/2017/08/docker-cheat-sheet/).

### Manual Setup
Setup instructions for a standalone postgres instance without using Docker.

* Localhost instance of Postgres running on port 5432. 
* Create a database named `liquibase`.
* Create a user with username `liquibase_migration` and password `123456`.
* Make the `liquibase_migration` user the owner of the `liquibase` database.
* Install the `pgcrypto` extension in the `liquibase` database using `CREATE EXTENSION IF NOT EXISTS "pgcrypto";` This 
allows us to use the `gen_random_uuid()` function to generate UUIDs.

## Database
Tools for working with the database. The tools in this section allow you to connect to the database, 
view it's roles and tables, and write SQL queries. This is a short list of tools there are many others 
available.

### PSQL
The [Postgres Command Line Tools](https://www.postgresql.org/docs/9.3/app-psql.html) can be used by 
connecting to the container with `docker exec -it postgres psql --username liquibase_migration --dbname liquibase`

### IntelliJ Database Window
The [IntelliJ Database Window](https://www.jetbrains.com/help/idea/database-tool-window.html) can be 
configured to connect to and view the database.

Open the database window.

General Tab
```
Host: localhost
Port: 5432
User: liquibase_migration
Password: 123456
Database: liquibase
```

Schemas Tab
```
Tick the checkbox next to liquibase.
Expand the liquibase accordion.
Tick the checkbox next to the public.
```

### PG Admin
You can use [PG Admin](https://www.pgadmin.org/download/) by connecting to the database running in the container
with no additional configuration. This is a desktop application for interacting with Postgres databases.

## Change Sets
Files containing change sets are listed in order in a master changelog file. 

Within the files the change sets are run in the order they occur within the file. Liquibase uses four intermediate 
languages that generates SQL; JSON, SQL, XML, or YAML. The change logs can be written in any one or a mixture of these
languages.

It should be noted that Liquibase warns against using incrementing values in filenames to version files as detailed on
their [website](http://www.liquibase.org/2007/06/the-problem-with-rails-active-migrations.html). Liquibase will not 
prevent two change logs with the same version number specified from running. The uniqueness of a change set is defined 
as a combination of it's id, author, and filename.

Within Liquibase change logs we can specify SQL files to execute using 
[sqlFile](https://www.liquibase.org/documentation/changes/sql_file.html). This allows us to specify complex
SQL not supported by Liquibase tags.

Each change set is committed to the database as a transaction and rolled back if any error occurs.

### JSON
Example JSON change logs: `src/main/resources/db/changelog/json/`

### SQL
The SQL change logs are SQL with liquibase meta data supplied in formatted comments.

With SQL change logs it is not possible to reference another file so all changes must be stored in the master file, or 
one of the other intermediate languages must be used to reference the SQL files. 

Example SQL change logs: `src/main/resources/db/changelog/sql/`

### XML
Example XML change logs: `src/main/resources/db/changelog/xml/`

### YAML
Example YAML change logs: `src/main/resources/db/changelog/yaml/`

## Data Inserts
Liquibase is able to insert data into the the database via SQL scripts and CSV files.

Change sets can be made repeatable using the `alwaysRun` or `runOnChange` tags. We can use this to make files
that we edit over time to perform inserts.

### SQL
Example SQL data inserts: `src/main/resources/db/data/sql/`

### CSV
Example CSV data inserts: `src/main/resources/db/data/csv/`

## Liquibase Commands
A list of commands available through Liquibase's Maven plugin and Command Line Tools, and links to there
documentation. 

Run `mvn liquibase:help` for descriptions of each command.

- [changelogSync](https://www.liquibase.org/documentation/maven/maven_changelogsync.html)
- [changelogSyncSQL](https://www.liquibase.org/documentation/maven/maven_changelogsyncsql.html)
- [clearCheckSums](https://www.liquibase.org/documentation/maven/maven_clearchecksums.html)
- [dbDoc](https://www.liquibase.org/documentation/maven/maven_dbDoc.html)
- [diff](https://www.liquibase.org/documentation/maven/maven_diff.html)
- [dropAll](https://www.liquibase.org/documentation/maven/maven_dropall.html)
- [generateChangeLog](https://www.liquibase.org/documentation/maven/maven_generateChangeLog.html)
- [help](https://www.liquibase.org/documentation/maven/maven_help.html)
- [listLocks](https://www.liquibase.org/documentation/maven/maven_listlocks.html)
- [releaseLocks](https://www.liquibase.org/documentation/maven/maven_releaselocks.html)
- [rollback](https://www.liquibase.org/documentation/maven/maven_rollback.html)
- [rollbackSQL](https://www.liquibase.org/documentation/maven/maven_rollbacksql.html)
- [status](https://www.liquibase.org/documentation/maven/maven_status.html)
- [tag](https://www.liquibase.org/documentation/maven/maven_tag.html)
- [update](https://www.liquibase.org/documentation/maven/maven_update.html)
- [updateSQL](https://www.liquibase.org/documentation/maven/maven_updatesql.html)
- [updateTestingRollback](https://www.liquibase.org/documentation/maven/maven_updatetestingrollback.html)
- [futureRollbackSQL](https://www.liquibase.org/documentation/maven/maven_futurerollbacksql.html)

### Deprecated Commands

- migrate
Use `mvn:liquibase update` instead.

- migrateSQL
Use `mvn:liquibase updateSQL` instead.

## Execution

### Command Line
Can run migrations using the liquibase command line tool or via the Maven plugin.

#### Command Line Tool
The [Liquibase command line tool](http://www.liquibase.org/documentation/command_line.html) can be used to run
migrations in environments where Maven is not present.

Download the tool from the [Liquibase website](https://download.liquibase.org/).

### Maven
Running via Maven will use the Maven plugin configured in the projects `pom.xml` file. Which uses the configuration
file under `src/main/resources/db/liquibase.properties`.

Example:
```
mvn clean liquibase:update
```

If using IntelliJ IDEA you can also run the plugin via IntelliJ's Maven Plugin. By running `liquibase:update`
