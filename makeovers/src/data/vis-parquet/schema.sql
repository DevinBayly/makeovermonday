CREATE TABLE author(id BIGINT, "name" VARCHAR NOT NULL);;
CREATE TABLE contribution(au_id BIGINT, paper_id BIGINT);;
CREATE TABLE figure(id BIGINT, paper_id BIGINT, local_path VARCHAR, server_path VARCHAR);;
CREATE TABLE figure_property("name" VARCHAR, int_value INTEGER, string_value VARCHAR, figure_id BIGINT);;
CREATE TABLE institution(id BIGINT, ror VARCHAR NOT NULL, "name" VARCHAR NOT NULL);;
CREATE TABLE paper(id BIGINT, title VARCHAR NOT NULL, doi VARCHAR, publication_date DATE, oa_url VARCHAR, pdf_path VARCHAR, inst_id BIGINT);;
CREATE TABLE residence(au_id BIGINT, inst_id BIGINT);;

