CREATE USER [dab_user]
    WITH PASSWORD = N'Y6@5*9uC*%$C@@xdZ69!x9Mp8n3T%@wU';
GO

ALTER ROLE db_owner ADD MEMBER dab_user;
GO