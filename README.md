# Liquibase Prototype
This prototype project demonstrates performing database migrations using Liquibase. 

## Postgres Setup

### Docker
The Postgres database can be run within a docker container.

This will create a volume under `./data` to hold the database's data. If you would like to clear your database and 
start again delete this directory.

It is important to note that the setup scripts will only run on a clean instance. Therefore, if you need to rerun them
you will first need to delete the `./data` directory and then run `docker-compose up`.

#### Commands
To start the container detached:
`docker-compose up -d`

To stop the container:
`docker-compose down`

Show logs:
`docker logs -f postgres`

Run PSQL:
`docker exec -it postgres psql --username liquibase_migration --dbname liquibase`

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
Changes sets are a set of files that will be executed in a sequence to build the database. With 
liquibase these change sets can be defined as JSON, SQL, XML, or YAML.

### JSON
Example JSON Change Log: `src/main/resources/db/migration/changelog.json`

### SQL
The SQL change logs are pure SQL with liquibase meta data supplied in formatted comments.

Example SQL Change Log: `src/main/resources/db/migration/changelog.sql`

### XML
Example XML Change Log: `src/main/resources/db/migration/changelog.xml`

### YAML
Example YAML Change Log: `src/main/resources/db/migration/changelog.yaml`

## Execution

### Command Line
Can run migrations using the liquibase commandline tool or by running a JAR.

#### Command Line Tool
The Liquibase command line tool can be used to run migrations in environments where Maven is not present.
[Documentation](http://www.liquibase.org/documentation/command_line.html) for Liquibase command line tool can be found 
on their website.

Download the tool from the [Liquibase website](https://download.liquibase.org/).

#### JAR
__TODO__ 
Do we need this?

### Maven
Running via Maven will use the Maven plugin configured in the projects `pom.xml` file. Which uses the configuration
file under `src/main/resources/db/liquibase.properties`.

`mvn clean liquibase:update`

If using IntelliJ IDEA you can also run the plugin via IntelliJ's Maven Plugin. By running `liquibase:update`
