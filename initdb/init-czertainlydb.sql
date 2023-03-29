CREATE USER czertainlyuser WITH PASSWORD 'your-strong-password';
CREATE DATABASE czertainlydb ENCODING 'UTF8' LC_COLLATE='en_US.UTF-8' LC_CTYPE='en_US.UTF-8' TEMPLATE=template0;
GRANT ALL PRIVILEGES ON DATABASE czertainlydb to czertainlyuser;