--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: social_account; Type: TABLE; Schema: public; Owner: hendri; Tablespace: 
--

CREATE TABLE social_account (
    id integer NOT NULL,
    user_id integer,
    provider character varying(255) NOT NULL,
    client_id character varying(255) NOT NULL,
    data text,
    code character varying(32),
    created_at integer,
    email character varying(255),
    username character varying(255)
);


ALTER TABLE public.social_account OWNER TO hendri;

--
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: hendri
--

CREATE SEQUENCE account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_id_seq OWNER TO hendri;

--
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hendri
--

ALTER SEQUENCE account_id_seq OWNED BY social_account.id;


--
-- Name: auth_assignment; Type: TABLE; Schema: public; Owner: hendri; Tablespace: 
--

CREATE TABLE auth_assignment (
    item_name character varying(64) NOT NULL,
    user_id character varying(64) NOT NULL,
    created_at integer
);


ALTER TABLE public.auth_assignment OWNER TO hendri;

--
-- Name: auth_item; Type: TABLE; Schema: public; Owner: hendri; Tablespace: 
--

CREATE TABLE auth_item (
    name character varying(64) NOT NULL,
    type integer NOT NULL,
    description text,
    rule_name character varying(64),
    data text,
    created_at integer,
    updated_at integer
);


ALTER TABLE public.auth_item OWNER TO hendri;

--
-- Name: auth_item_child; Type: TABLE; Schema: public; Owner: hendri; Tablespace: 
--

CREATE TABLE auth_item_child (
    parent character varying(64) NOT NULL,
    child character varying(64) NOT NULL
);


ALTER TABLE public.auth_item_child OWNER TO hendri;

--
-- Name: auth_rule; Type: TABLE; Schema: public; Owner: hendri; Tablespace: 
--

CREATE TABLE auth_rule (
    name character varying(64) NOT NULL,
    data text,
    created_at integer,
    updated_at integer
);


ALTER TABLE public.auth_rule OWNER TO hendri;

--
-- Name: migration; Type: TABLE; Schema: public; Owner: hendri; Tablespace: 
--

CREATE TABLE migration (
    version character varying(180) NOT NULL,
    apply_time integer
);


ALTER TABLE public.migration OWNER TO hendri;

--
-- Name: profile; Type: TABLE; Schema: public; Owner: hendri; Tablespace: 
--

CREATE TABLE profile (
    user_id integer NOT NULL,
    name character varying(255),
    public_email character varying(255),
    gravatar_email character varying(255),
    gravatar_id character varying(32),
    location character varying(255),
    website character varying(255),
    bio text
);


ALTER TABLE public.profile OWNER TO hendri;

--
-- Name: token; Type: TABLE; Schema: public; Owner: hendri; Tablespace: 
--

CREATE TABLE token (
    user_id integer NOT NULL,
    code character varying(32) NOT NULL,
    created_at integer NOT NULL,
    type smallint NOT NULL
);


ALTER TABLE public.token OWNER TO hendri;

--
-- Name: user; Type: TABLE; Schema: public; Owner: hendri; Tablespace: 
--

CREATE TABLE "user" (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(60) NOT NULL,
    auth_key character varying(32) NOT NULL,
    confirmed_at integer,
    unconfirmed_email character varying(255),
    blocked_at integer,
    registration_ip character varying(45),
    created_at integer NOT NULL,
    updated_at integer NOT NULL,
    flags integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."user" OWNER TO hendri;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: hendri
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO hendri;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hendri
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hendri
--

ALTER TABLE ONLY social_account ALTER COLUMN id SET DEFAULT nextval('account_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hendri
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Name: account_pkey; Type: CONSTRAINT; Schema: public; Owner: hendri; Tablespace: 
--

ALTER TABLE ONLY social_account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: auth_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: hendri; Tablespace: 
--

ALTER TABLE ONLY auth_assignment
    ADD CONSTRAINT auth_assignment_pkey PRIMARY KEY (item_name, user_id);


--
-- Name: auth_item_child_pkey; Type: CONSTRAINT; Schema: public; Owner: hendri; Tablespace: 
--

ALTER TABLE ONLY auth_item_child
    ADD CONSTRAINT auth_item_child_pkey PRIMARY KEY (parent, child);


--
-- Name: auth_item_pkey; Type: CONSTRAINT; Schema: public; Owner: hendri; Tablespace: 
--

ALTER TABLE ONLY auth_item
    ADD CONSTRAINT auth_item_pkey PRIMARY KEY (name);


--
-- Name: auth_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: hendri; Tablespace: 
--

ALTER TABLE ONLY auth_rule
    ADD CONSTRAINT auth_rule_pkey PRIMARY KEY (name);


--
-- Name: migration_pkey; Type: CONSTRAINT; Schema: public; Owner: hendri; Tablespace: 
--

ALTER TABLE ONLY migration
    ADD CONSTRAINT migration_pkey PRIMARY KEY (version);


--
-- Name: profile_pkey; Type: CONSTRAINT; Schema: public; Owner: hendri; Tablespace: 
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (user_id);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: hendri; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: account_unique; Type: INDEX; Schema: public; Owner: hendri; Tablespace: 
--

CREATE UNIQUE INDEX account_unique ON social_account USING btree (provider, client_id);


--
-- Name: account_unique_code; Type: INDEX; Schema: public; Owner: hendri; Tablespace: 
--

CREATE UNIQUE INDEX account_unique_code ON social_account USING btree (code);


--
-- Name: idx-auth_item-type; Type: INDEX; Schema: public; Owner: hendri; Tablespace: 
--

CREATE INDEX "idx-auth_item-type" ON auth_item USING btree (type);


--
-- Name: token_unique; Type: INDEX; Schema: public; Owner: hendri; Tablespace: 
--

CREATE UNIQUE INDEX token_unique ON token USING btree (user_id, code, type);


--
-- Name: user_unique_email; Type: INDEX; Schema: public; Owner: hendri; Tablespace: 
--

CREATE UNIQUE INDEX user_unique_email ON "user" USING btree (email);


--
-- Name: user_unique_username; Type: INDEX; Schema: public; Owner: hendri; Tablespace: 
--

CREATE UNIQUE INDEX user_unique_username ON "user" USING btree (username);


--
-- Name: auth_assignment_item_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hendri
--

ALTER TABLE ONLY auth_assignment
    ADD CONSTRAINT auth_assignment_item_name_fkey FOREIGN KEY (item_name) REFERENCES auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item_child_child_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hendri
--

ALTER TABLE ONLY auth_item_child
    ADD CONSTRAINT auth_item_child_child_fkey FOREIGN KEY (child) REFERENCES auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item_child_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hendri
--

ALTER TABLE ONLY auth_item_child
    ADD CONSTRAINT auth_item_child_parent_fkey FOREIGN KEY (parent) REFERENCES auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item_rule_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hendri
--

ALTER TABLE ONLY auth_item
    ADD CONSTRAINT auth_item_rule_name_fkey FOREIGN KEY (rule_name) REFERENCES auth_rule(name) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_user_account; Type: FK CONSTRAINT; Schema: public; Owner: hendri
--

ALTER TABLE ONLY social_account
    ADD CONSTRAINT fk_user_account FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: fk_user_profile; Type: FK CONSTRAINT; Schema: public; Owner: hendri
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT fk_user_profile FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: fk_user_token; Type: FK CONSTRAINT; Schema: public; Owner: hendri
--

ALTER TABLE ONLY token
    ADD CONSTRAINT fk_user_token FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

