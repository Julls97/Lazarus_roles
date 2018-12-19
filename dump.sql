--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET search_path = public, pg_catalog;

--
-- Name: genders; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE genders AS ENUM (
    'man',
    'woman'
);


ALTER TYPE genders OWNER TO postgres;

--
-- Name: child_ids; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE child_ids
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE child_ids OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: childs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE childs (
    child_id integer DEFAULT nextval('child_ids'::regclass) NOT NULL,
    parent_id integer,
    name character(64) NOT NULL,
    age integer,
    gender genders
);


ALTER TABLE childs OWNER TO postgres;

--
-- Name: group_ids; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE group_ids
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE group_ids OWNER TO postgres;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE groups (
    group_id integer DEFAULT nextval('group_ids'::regclass) NOT NULL,
    name character(64),
    max_count integer DEFAULT 20
);


ALTER TABLE groups OWNER TO postgres;

--
-- Name: kindergartener_ids; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE kindergartener_ids
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE kindergartener_ids OWNER TO postgres;

--
-- Name: kindergarteners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE kindergarteners (
    kindergartener_id integer DEFAULT nextval('kindergartener_ids'::regclass) NOT NULL,
    name character(64) NOT NULL,
    rating integer,
    experience_years integer DEFAULT 0,
    CONSTRAINT kindergarteners_rating_check CHECK (((rating >= 0) AND (rating <= 10)))
);


ALTER TABLE kindergarteners OWNER TO postgres;

--
-- Name: parent_ids; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE parent_ids
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE parent_ids OWNER TO postgres;

--
-- Name: parents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE parents (
    parent_id integer DEFAULT nextval('parent_ids'::regclass) NOT NULL,
    mom_name character(64) NOT NULL,
    dad_name character(64) NOT NULL
);


ALTER TABLE parents OWNER TO postgres;

--
-- Name: records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE records (
    child integer NOT NULL,
    group_ integer NOT NULL,
    kindergartener integer NOT NULL
);


ALTER TABLE records OWNER TO postgres;

--
-- Data for Name: childs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY childs (child_id, parent_id, name, age, gender) FROM stdin;
4	4	Катя                                                            	4	woman
6	6	Костя                                                           	5	man
7	7	Женя                                                            	5	man
8	8	Алла                                                            	6	woman
9	9	Андрей                                                          	6	man
1	1	Саша                                                            	3	man
2	2	Настя                                                           	3	woman
3	3	Олег                                                            	3	man
5	5	Саша                                                            	4	woman
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY groups (group_id, name, max_count) FROM stdin;
1	Утята                                                           	15
2	Ромашка                                                         	18
3	Василек                                                         	15
4	Солнышко                                                        	20
\.


--
-- Data for Name: kindergarteners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY kindergarteners (kindergartener_id, name, rating, experience_years) FROM stdin;
1	Анна Ивановна                                                   	8	10
2	Александра Васильевна                                           	6	2
3	Ольга Константиновна                                            	3	5
4	Надежда Николаевна                                              	9	13
5	Светлана Васильевна                                             	4	7
6	Мария Васильевна                                                	5	9
\.


--
-- Data for Name: parents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY parents (parent_id, mom_name, dad_name) FROM stdin;
1	Мария                                                           	Иван                                                            
2	Олеся                                                           	Петр                                                            
3	Алина                                                           	Евгений                                                         
4	Анна                                                            	Петр                                                            
5	Евгения                                                         	Александр                                                       
6	Анастасия                                                       	Олег                                                            
7	Варвара                                                         	Михаил                                                          
8	Ольга                                                           	Петр                                                            
9	Оксана                                                          	Валерий                                                         
\.


--
-- Data for Name: records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY records (child, group_, kindergartener) FROM stdin;
1	1	1
2	1	1
3	1	1
4	2	2
5	2	2
6	3	4
7	3	4
8	4	6
9	4	6
\.


--
-- Name: child_ids; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('child_ids', 9, true);


--
-- Name: group_ids; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('group_ids', 4, true);


--
-- Name: kindergartener_ids; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('kindergartener_ids', 4, true);


--
-- Name: parent_ids; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('parent_ids', 9, true);


--
-- Name: childs childs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY childs
    ADD CONSTRAINT childs_pkey PRIMARY KEY (child_id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (group_id);


--
-- Name: kindergarteners kindergarteners_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kindergarteners
    ADD CONSTRAINT kindergarteners_pkey PRIMARY KEY (kindergartener_id);


--
-- Name: parents parents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parents
    ADD CONSTRAINT parents_pkey PRIMARY KEY (parent_id);


--
-- Name: childs childs_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY childs
    ADD CONSTRAINT childs_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES parents(parent_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: records records_child_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY records
    ADD CONSTRAINT records_child_id_fkey FOREIGN KEY (child) REFERENCES childs(child_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: records records_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY records
    ADD CONSTRAINT records_group_id_fkey FOREIGN KEY (group_) REFERENCES groups(group_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: records records_kindergartener_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY records
    ADD CONSTRAINT records_kindergartener_id_fkey FOREIGN KEY (kindergartener) REFERENCES kindergarteners(kindergartener_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

