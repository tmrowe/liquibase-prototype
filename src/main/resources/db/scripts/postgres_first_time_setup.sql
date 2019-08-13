-- Create a user to run the migration scripts.
CREATE USER liquibase_migration WITH
    PASSWORD '123456';

-- Create the database that will hold the application's tables and make the migration user the owner.
CREATE DATABASE liquibase WITH
    OWNER liquibase_migration;
