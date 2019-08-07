--liquibase formatted sql

--preconditions runningAs:"liquibase_migration"

--changeset Thomas Rowe:1
CREATE TABLE "user" (
    uuid UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

--changeset Thomas Rowe:2
CREATE TABLE list (
    uuid UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    created_by UUID REFERENCES "user"(uuid),
    name VARCHAR(256),
    description VARCHAR(256),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

--changeset Thomas Rowe:3
CREATE TABLE user_list_permission (
    user_uuid UUID REFERENCES "user"(uuid) NOT NULL,
    list_uuid UUID REFERENCES list(uuid) NOT NULL,
    can_view BOOLEAN DEFAULT FALSE,
    can_edit BOOLEAN DEFAULT FALSE,
    can_delete BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
