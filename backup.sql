--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: booking_requests; Type: TABLE; Schema: public; Owner: dee
--

CREATE TABLE public.booking_requests (
    id integer NOT NULL,
    space_id integer,
    host_id integer,
    guest_id integer,
    date date NOT NULL
);


ALTER TABLE public.booking_requests OWNER TO dee;

--
-- Name: booking_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: dee
--

CREATE SEQUENCE public.booking_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.booking_requests_id_seq OWNER TO dee;

--
-- Name: booking_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dee
--

ALTER SEQUENCE public.booking_requests_id_seq OWNED BY public.booking_requests.id;


--
-- Name: bookings; Type: TABLE; Schema: public; Owner: dee
--

CREATE TABLE public.bookings (
    id integer NOT NULL,
    host_id integer,
    guest_id integer,
    space_id integer,
    date date,
    total_price money
);


ALTER TABLE public.bookings OWNER TO dee;

--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: dee
--

CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bookings_id_seq OWNER TO dee;

--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dee
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: spaces; Type: TABLE; Schema: public; Owner: dee
--

CREATE TABLE public.spaces (
    id integer NOT NULL,
    description character varying(255),
    location character varying(40),
    price money,
    host_id integer,
    date date,
    guest_id integer
);


ALTER TABLE public.spaces OWNER TO dee;

--
-- Name: spaces_id_seq; Type: SEQUENCE; Schema: public; Owner: dee
--

CREATE SEQUENCE public.spaces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spaces_id_seq OWNER TO dee;

--
-- Name: spaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dee
--

ALTER SEQUENCE public.spaces_id_seq OWNED BY public.spaces.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: dee
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(40),
    email character varying(100),
    password character varying(140)
);


ALTER TABLE public.users OWNER TO dee;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: dee
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO dee;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dee
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: booking_requests id; Type: DEFAULT; Schema: public; Owner: dee
--

ALTER TABLE ONLY public.booking_requests ALTER COLUMN id SET DEFAULT nextval('public.booking_requests_id_seq'::regclass);


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: dee
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: spaces id; Type: DEFAULT; Schema: public; Owner: dee
--

ALTER TABLE ONLY public.spaces ALTER COLUMN id SET DEFAULT nextval('public.spaces_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: dee
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: booking_requests booking_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: dee
--

ALTER TABLE ONLY public.booking_requests
    ADD CONSTRAINT booking_requests_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: dee
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: spaces spaces_pkey; Type: CONSTRAINT; Schema: public; Owner: dee
--

ALTER TABLE ONLY public.spaces
    ADD CONSTRAINT spaces_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: dee
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: booking_requests booking_requests_space_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dee
--

ALTER TABLE ONLY public.booking_requests
    ADD CONSTRAINT booking_requests_space_id_fkey FOREIGN KEY (space_id) REFERENCES public.spaces(id);


--
-- Name: bookings bookings_space_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dee
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_space_id_fkey FOREIGN KEY (space_id) REFERENCES public.spaces(id);


--
-- PostgreSQL database dump complete
--

