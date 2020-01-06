#!/bin/bash

SAMPLE_DB_USER_PWD="$(< "$SAMPLE_DB_USER_PWD_FILE")"

agens --variable=dbname="$SAMPLE_DB_NAME" --variable=dbuser="$SAMPLE_DB_USERNAME" --variable=dbpass="$SAMPLE_DB_USER_PWD" --file="$AGENS_IMPORTDATA_CONTAINER_ROOT/northwind_sql/create_user.sql"
# taken from https://stackoverflow.com/a/18389184/4106215
echo "SELECT 'CREATE DATABASE $SAMPLE_DB_NAME WITH OWNER $SAMPLE_DB_USERNAME' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$SAMPLE_DB_NAME')\gexec" | agens

agens imdb --echo-queries -f "$AGENS_IMPORTDATA_CONTAINER_ROOT/imdb_sql/imdb_load.sql"
printf "Data Preparation Complete"

agens imdb --echo-queries -f "$AGENS_IMPORTDATA_CONTAINER_ROOT/imdb_sql/graph_create.sql"
printf "IMDB Graph Database Ready"
