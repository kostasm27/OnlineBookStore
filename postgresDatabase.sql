--
-- PostgreSQL database dump
--

-- Dumped from database version 13.6
-- Dumped by pg_dump version 13.6

-- Started on 2022-05-18 19:46:33

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 200 (class 1259 OID 25191)
-- Name: Book_To_Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Book_To_Category" (
    id integer NOT NULL,
    book_name character varying(100) NOT NULL,
    category character varying(100) NOT NULL
);


ALTER TABLE public."Book_To_Category" OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 25194)
-- Name: Books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Books" (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    book_rating real,
    author character varying(50)
);


ALTER TABLE public."Books" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 25197)
-- Name: Book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Book_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Book_id_seq" OWNER TO postgres;

--
-- TOC entry 3047 (class 0 OID 0)
-- Dependencies: 202
-- Name: Book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Book_id_seq" OWNED BY public."Books".id;


--
-- TOC entry 203 (class 1259 OID 25199)
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 25202)
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Category_id_seq" OWNER TO postgres;

--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 204
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- TOC entry 205 (class 1259 OID 25204)
-- Name: Read; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Read" (
    id integer NOT NULL,
    book_id integer NOT NULL,
    user_id integer NOT NULL,
    rent_date date NOT NULL,
    return_date date
);


ALTER TABLE public."Read" OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 25207)
-- Name: Read_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Read_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Read_id_seq" OWNER TO postgres;

--
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 206
-- Name: Read_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Read_id_seq" OWNED BY public."Read".id;


--
-- TOC entry 207 (class 1259 OID 25209)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    email character varying(200) NOT NULL,
    password character varying(600) NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 25215)
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_id_seq" OWNER TO postgres;

--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 208
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- TOC entry 209 (class 1259 OID 25217)
-- Name: movie_to_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movie_to_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movie_to_category_id_seq OWNER TO postgres;

--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 209
-- Name: movie_to_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movie_to_category_id_seq OWNED BY public."Book_To_Category".id;


--
-- TOC entry 2875 (class 2604 OID 25219)
-- Name: Book_To_Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book_To_Category" ALTER COLUMN id SET DEFAULT nextval('public.movie_to_category_id_seq'::regclass);


--
-- TOC entry 2876 (class 2604 OID 25220)
-- Name: Books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Books" ALTER COLUMN id SET DEFAULT nextval('public."Book_id_seq"'::regclass);


--
-- TOC entry 2877 (class 2604 OID 25221)
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- TOC entry 2878 (class 2604 OID 25222)
-- Name: Read id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Read" ALTER COLUMN id SET DEFAULT nextval('public."Read_id_seq"'::regclass);


--
-- TOC entry 2879 (class 2604 OID 25223)
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- TOC entry 3032 (class 0 OID 25191)
-- Dependencies: 200
-- Data for Name: Book_To_Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Book_To_Category" (id, book_name, category) VALUES (21, 'Harry Potter and the Philosopher’s Stone', 'Action');
INSERT INTO public."Book_To_Category" (id, book_name, category) VALUES (22, 'Harry Potter and the Philosopher’s Stone', 'Fantasy');
INSERT INTO public."Book_To_Category" (id, book_name, category) VALUES (23, 'The Lord of the Rings', 'Adventure');
INSERT INTO public."Book_To_Category" (id, book_name, category) VALUES (24, 'The Lord of the Rings', 'Fantasy');
INSERT INTO public."Book_To_Category" (id, book_name, category) VALUES (25, 'The Hobbit', 'Adventure');
INSERT INTO public."Book_To_Category" (id, book_name, category) VALUES (26, 'The Hobbit', 'Fantasy');
INSERT INTO public."Book_To_Category" (id, book_name, category) VALUES (27, 'A Tale of Two Cities', 'Historical novel');
INSERT INTO public."Book_To_Category" (id, book_name, category) VALUES (28, 'Great Expectations', 'Novel');
INSERT INTO public."Book_To_Category" (id, book_name, category) VALUES (29, 'Great Expectations', 'Bildungsroman');
INSERT INTO public."Book_To_Category" (id, book_name, category) VALUES (30, 'The Stories of Anton Chekhov', 'Novel');
INSERT INTO public."Book_To_Category" (id, book_name, category) VALUES (31, 'The Stories of Anton Chekhov', 'Classic Literature');


--
-- TOC entry 3033 (class 0 OID 25194)
-- Dependencies: 201
-- Data for Name: Books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Books" (id, title, book_rating, author) VALUES (1, 'Harry Potter and the Philosopher’s Stone', 8.8, 'J.K. Rowling');
INSERT INTO public."Books" (id, title, book_rating, author) VALUES (2, 'The Lord of the Rings', 8.4, 'John Ronald Reuel Tolkien');
INSERT INTO public."Books" (id, title, book_rating, author) VALUES (3, 'The Hobbit', 8, 'John Ronald Reuel Tolkien');
INSERT INTO public."Books" (id, title, book_rating, author) VALUES (4, 'A Tale of Two Cities', 7.8, 'Charles Dickens');
INSERT INTO public."Books" (id, title, book_rating, author) VALUES (5, 'Great Expectations', 7.5, 'Charles Dickens');
INSERT INTO public."Books" (id, title, book_rating, author) VALUES (6, 'The Stories of Anton Chekhov', 8, 'Anton Chekhov');


--
-- TOC entry 3035 (class 0 OID 25199)
-- Dependencies: 203
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Category" (id, name) VALUES (1, 'Action');
INSERT INTO public."Category" (id, name) VALUES (2, 'Fantasy');
INSERT INTO public."Category" (id, name) VALUES (3, 'Adventure');
INSERT INTO public."Category" (id, name) VALUES (4, 'Historical novel');
INSERT INTO public."Category" (id, name) VALUES (5, 'Novel');
INSERT INTO public."Category" (id, name) VALUES (6, 'Bildungsroman');
INSERT INTO public."Category" (id, name) VALUES (7, 'Classic Literature');


--
-- TOC entry 3037 (class 0 OID 25204)
-- Dependencies: 205
-- Data for Name: Read; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Read" (id, book_id, user_id, rent_date, return_date) VALUES (7, 5, 3, '2022-05-18', '2022-05-18');


--
-- TOC entry 3039 (class 0 OID 25209)
-- Dependencies: 207
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."User" (id, first_name, email, password) VALUES (2, 'Kostas', 'kostantinosmavros28@.com', 'sha256$VwNNPItiIDNw8Dze$5c80b40051dbc9ce940604eb6d8575de66938f0f93e5483615a0689329bc5954');
INSERT INTO public."User" (id, first_name, email, password) VALUES (3, 'kostas', 'kostantinosmavros28@gmail.com', 'sha256$4US8LC3yWAQTMOcT$ab16e6fe020edd6b7b31e2536920b62ee875ca2a6bccc5e2cd7c5358d1d5253d');
INSERT INTO public."User" (id, first_name, email, password) VALUES (4, 'kostas27', 'kostantinosmavros28new@gmail.com', 'sha256$VBhddt7FCZUrAcVX$67abed7446a2dc1ad485326407e80a6a0822a5ad7ff6fb04c5203a4271aca25b');


--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 202
-- Name: Book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Book_id_seq"', 1, false);


--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 204
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 1, false);


--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 206
-- Name: Read_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Read_id_seq"', 7, true);


--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 208
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 4, true);


--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 209
-- Name: movie_to_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movie_to_category_id_seq', 31, true);


--
-- TOC entry 2883 (class 2606 OID 25225)
-- Name: Books Book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Books"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY (id);


--
-- TOC entry 2887 (class 2606 OID 25227)
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- TOC entry 2889 (class 2606 OID 25229)
-- Name: Category Category_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_unique" UNIQUE (name);


--
-- TOC entry 2891 (class 2606 OID 25231)
-- Name: Read Read_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Read"
    ADD CONSTRAINT "Read_pkey" PRIMARY KEY (id);


--
-- TOC entry 2893 (class 2606 OID 25233)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 2895 (class 2606 OID 25235)
-- Name: User email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT email_unique UNIQUE (email);


--
-- TOC entry 2897 (class 2606 OID 25237)
-- Name: User first_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT first_name_unique UNIQUE (first_name);


--
-- TOC entry 2881 (class 2606 OID 25239)
-- Name: Book_To_Category movie_to_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book_To_Category"
    ADD CONSTRAINT movie_to_category_pkey PRIMARY KEY (id);


--
-- TOC entry 2885 (class 2606 OID 25241)
-- Name: Books name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Books"
    ADD CONSTRAINT name_unique UNIQUE (title);


--
-- TOC entry 2900 (class 2606 OID 25242)
-- Name: Read book_id_foreign_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Read"
    ADD CONSTRAINT book_id_foreign_key FOREIGN KEY (book_id) REFERENCES public."Books"(id) NOT VALID;


--
-- TOC entry 2898 (class 2606 OID 25247)
-- Name: Book_To_Category book_name_foreign_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book_To_Category"
    ADD CONSTRAINT book_name_foreign_key FOREIGN KEY (book_name) REFERENCES public."Books"(title);


--
-- TOC entry 2899 (class 2606 OID 25252)
-- Name: Book_To_Category category_foreign_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book_To_Category"
    ADD CONSTRAINT category_foreign_key FOREIGN KEY (category) REFERENCES public."Category"(name) NOT VALID;


--
-- TOC entry 2901 (class 2606 OID 25257)
-- Name: Read users_id_foreign_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Read"
    ADD CONSTRAINT users_id_foreign_key FOREIGN KEY (user_id) REFERENCES public."User"(id) NOT VALID;


-- Completed on 2022-05-18 19:46:34

--
-- PostgreSQL database dump complete
--

