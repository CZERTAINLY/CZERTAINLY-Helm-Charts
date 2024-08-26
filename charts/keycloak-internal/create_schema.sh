#/bin/sh

psql -c "DO \$\$
BEGIN
    EXECUTE 'CREATE SCHEMA IF NOT EXISTS {{ .Values.keycloak.dbSchema }}';
EXCEPTION
    WHEN duplicate_schema THEN RAISE NOTICE 'Schema \"{{ .Values.keycloak.dbSchema }}\" already exists';
    WHEN insufficient_privilege THEN RAISE NOTICE 'Permission denied to create schema \"{{ .Values.keycloak.dbSchema }}\"';
END;
\$\$"
