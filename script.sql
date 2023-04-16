CREATE DATABASE wp;
CREATE USER 'wp'@'localhost' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON wp.* TO 'wp'@'localhost';