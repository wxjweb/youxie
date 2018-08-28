-- connect to youxie_db
\c youxie_db;

--for province_data:
DROP TABLE IF EXISTS province_data;
CREATE TABLE province_data(
	auto_id SERIAL PRIMARY KEY ,
	province_name varchar(64),
	month INTEGER,
	price TIMESTAMP
);
