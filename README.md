# Liquibase Prototype
This prototype project demonstrates performing database migrations using Liquibase. 

## Change Sets
Changes sets are a set of files that will be executed in a sequence to build the database. With 
liquibase these change sets can be defined as JSON, SQL, XML, or YAML.

### JSON
Example JSON Change Log: `src/main/resources/liquibase/db.changelog.json`

### SQL
The SQL change logs are pure SQL with liquibase meta data supplied in formatted comments.

Example SQL Change Log: `src/main/resources/liquibase/db.changelog.sql`

### XML
Example XML Change Log: `src/main/resources/liquibase/db.changelog.xml`

### YAML
Example YAML Change Log: `src/main/resources/liquibase/db.changelog.yaml`

## Execution

### Prerequisites
* Localhost instance of Postgres running on port 5432. 
* Create a database named `liquibase`.
* Create a user with username `liquibase_migration` and password `123456` with super user privileges. 
* The `pgcrypto` extension has been installed using `CREATE EXTENSION IF NOT EXISTS "pgcrypto";` This allows
us to use the `gen_random_uuid()` function to generate UUIDs.

### Command Line
Can run migrations using the liquibase commandline tool or by running a JAR.

#### Command Line Tool
__TODO__

#### JAR
__TODO__

### Maven
Running via Maven will use the Maven plugin configured in the projects `pom.xml` file. Which uses the configuration
file under `src/main/resources/liquibase/liquibase.properties`.

`mvn clean liquibase:update`

If using IntelliJ IDEA you can also run the plugin via IntelliJ's Maven Plugin. By running `liquibase:update`

### API
__ TODO __
