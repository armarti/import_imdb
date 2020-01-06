\set dbname :dbname
\set dbuser :dbuser
\set dbpass :dbpass

-- taken from here:
-- https://stackoverflow.com/a/8099557/4106215
DO
$do$
BEGIN
    IF NOT EXISTS (
        SELECT  -- SELECT list can stay empty for this
        FROM pg_catalog.pg_roles
        WHERE rolname = :dbuser
    ) THEN
    CREATE ROLE :dbuser WITH LOGIN ENCRYPTED PASSWORD :'dbpass';
    END IF;
END
$do$;
