--
-- PostgreSQL database dump
--

\restrict yhxbPC6uQ9ylBiNFnxb1PqDpYOZa7ZT0AjPc3xZfWz0yOl4bJACPXNyD8GcYUOD

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

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
-- Name: account_assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_assets (
    id integer NOT NULL,
    rep_username text NOT NULL,
    account text NOT NULL,
    item_type text NOT NULL,
    brand text NOT NULL,
    count integer DEFAULT 0 NOT NULL,
    last_date text,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.account_assets OWNER TO postgres;

--
-- Name: account_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.account_assets_id_seq OWNER TO postgres;

--
-- Name: account_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_assets_id_seq OWNED BY public.account_assets.id;


--
-- Name: brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brands (
    id integer NOT NULL,
    catalog_item_id integer NOT NULL,
    name text NOT NULL,
    is_default boolean DEFAULT false NOT NULL
);


ALTER TABLE public.brands OWNER TO postgres;

--
-- Name: brands_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.brands_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.brands_id_seq OWNER TO postgres;

--
-- Name: brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.brands_id_seq OWNED BY public.brands.id;


--
-- Name: catalog_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalog_items (
    id integer NOT NULL,
    name text NOT NULL,
    icon text,
    color text,
    is_default boolean DEFAULT false NOT NULL
);


ALTER TABLE public.catalog_items OWNER TO postgres;

--
-- Name: catalog_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catalog_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.catalog_items_id_seq OWNER TO postgres;

--
-- Name: catalog_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catalog_items_id_seq OWNED BY public.catalog_items.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    name text NOT NULL,
    rep_username text NOT NULL,
    chain text,
    customer_type text,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: event_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_reports (
    id integer NOT NULL,
    event_id integer NOT NULL,
    staff_name text NOT NULL,
    attendee_count integer,
    served_count integer,
    brand_comments text,
    total_spend text,
    image_urls text DEFAULT '[]'::text NOT NULL,
    submitted_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.event_reports OWNER TO postgres;

--
-- Name: event_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_reports_id_seq OWNER TO postgres;

--
-- Name: event_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_reports_id_seq OWNED BY public.event_reports.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id integer NOT NULL,
    title text NOT NULL,
    account text NOT NULL,
    brand text,
    date text NOT NULL,
    start_time text NOT NULL,
    end_time text NOT NULL,
    notes text,
    pos_items text DEFAULT '[]'::text NOT NULL,
    staff_requested integer DEFAULT 1 NOT NULL,
    rep_username text NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    staff_assigned text DEFAULT '[]'::text NOT NULL,
    pos_approved boolean DEFAULT false NOT NULL,
    pos_requested boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    approved_at timestamp without time zone,
    approved_by text,
    rep_or_supplier_present boolean DEFAULT false NOT NULL
);


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.events_id_seq OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    id integer NOT NULL,
    catalog_item_id integer NOT NULL,
    brand_id integer NOT NULL,
    item_type text NOT NULL,
    brand text NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- Name: inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventory_id_seq OWNER TO postgres;

--
-- Name: inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventory_id_seq OWNED BY public.inventory.id;


--
-- Name: pos_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pos_requests (
    id integer NOT NULL,
    rep_username text NOT NULL,
    customer text NOT NULL,
    item_type text NOT NULL,
    brand text NOT NULL,
    quantity integer NOT NULL,
    status text DEFAULT 'Pending'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    fulfilled_at timestamp without time zone
);


ALTER TABLE public.pos_requests OWNER TO postgres;

--
-- Name: pos_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pos_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pos_requests_id_seq OWNER TO postgres;

--
-- Name: pos_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pos_requests_id_seq OWNED BY public.pos_requests.id;


--
-- Name: promo_staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promo_staff (
    id integer NOT NULL,
    name text NOT NULL,
    phone text,
    email text,
    notes text,
    password_hash text
);


ALTER TABLE public.promo_staff OWNER TO postgres;

--
-- Name: promo_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promo_staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promo_staff_id_seq OWNER TO postgres;

--
-- Name: promo_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promo_staff_id_seq OWNED BY public.promo_staff.id;


--
-- Name: receive_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.receive_history (
    id integer NOT NULL,
    item_type text NOT NULL,
    brand text NOT NULL,
    quantity integer NOT NULL,
    note text,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.receive_history OWNER TO postgres;

--
-- Name: receive_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.receive_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.receive_history_id_seq OWNER TO postgres;

--
-- Name: receive_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.receive_history_id_seq OWNED BY public.receive_history.id;


--
-- Name: transfers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transfers (
    id integer NOT NULL,
    rep_username text NOT NULL,
    item_type text NOT NULL,
    brand text NOT NULL,
    quantity integer NOT NULL,
    from_account text NOT NULL,
    to_account text NOT NULL,
    is_return boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.transfers OWNER TO postgres;

--
-- Name: transfers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transfers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transfers_id_seq OWNER TO postgres;

--
-- Name: transfers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transfers_id_seq OWNED BY public.transfers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    password_hash text NOT NULL,
    role text NOT NULL,
    display_name text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: account_assets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_assets ALTER COLUMN id SET DEFAULT nextval('public.account_assets_id_seq'::regclass);


--
-- Name: brands id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands ALTER COLUMN id SET DEFAULT nextval('public.brands_id_seq'::regclass);


--
-- Name: catalog_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog_items ALTER COLUMN id SET DEFAULT nextval('public.catalog_items_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: event_reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_reports ALTER COLUMN id SET DEFAULT nextval('public.event_reports_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: inventory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory ALTER COLUMN id SET DEFAULT nextval('public.inventory_id_seq'::regclass);


--
-- Name: pos_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos_requests ALTER COLUMN id SET DEFAULT nextval('public.pos_requests_id_seq'::regclass);


--
-- Name: promo_staff id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_staff ALTER COLUMN id SET DEFAULT nextval('public.promo_staff_id_seq'::regclass);


--
-- Name: receive_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receive_history ALTER COLUMN id SET DEFAULT nextval('public.receive_history_id_seq'::regclass);


--
-- Name: transfers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers ALTER COLUMN id SET DEFAULT nextval('public.transfers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: account_assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_assets (id, rep_username, account, item_type, brand, count, last_date, updated_at) FROM stdin;
5562	amartin	AMERICAN LEGION POST 48 - HUDSON	Coaster	Gold Road Mango Cart	1	3/20/2026 5:43 PM	2026-03-20 17:43:22.234352
5563	amartin	CODEX B.A.R	Large Tap Marker	Bud Light	1	3/20/2026 6:18 PM	2026-03-20 18:18:07.80323
811	maanderson	PEDDLER'S DAUGHTER	Coaster	Bud Light	15	3/12/2026 1:42 PM	2026-03-17 19:05:54.369475
812	rconstant	99 REST - LONDONDERRY	Coaster	Nutrl	3	3/12/2026 12:43 PM	2026-03-17 19:05:54.66115
813	rconstant	PROFESSOR SPORTS PUB	Coaster	Nutrl	5	3/12/2026 12:43 PM	2026-03-17 19:05:54.664938
814	rconstant	HUDSONS NORTH SIDE GRILLE	Coaster	Bud Light	9	3/12/2026 12:43 PM	2026-03-17 19:05:54.668747
815	lnorton	T-BONES - BEDFORD	Coaster	Bud Light	82	3/12/2026 12:39 PM	2026-03-17 19:05:54.672131
816	scamuso	NATIONAL CLUB (THE)	Coaster	Bud Light	4	3/12/2026 8:26 AM	2026-03-17 19:05:54.675323
817	ddooling	MICHAELS FLATBREAD PIZZA CO.	Coaster	Bud Light	6	3/11/2026 4:24 PM	2026-03-17 19:05:54.67824
818	jaustin	TEMPESTA'S	Coaster	Mich Ultra	7	3/11/2026 2:11 PM	2026-03-17 19:05:54.68173
819	maanderson	FRIENDLY RED'S - HUDSON	Coaster	Mich Ultra	3	3/11/2026 2:05 PM	2026-03-17 19:05:54.684808
820	maanderson	AMERICAN LEGION POST 100 - PELHAM	Coaster	Mich Ultra	2	3/10/2026 2:27 PM	2026-03-17 19:05:54.753811
821	ggage	CHRYSANTHI'S	Coaster	Mich Ultra	17	3/10/2026 2:08 PM	2026-03-17 19:05:54.757065
824	rconstant	STUMBLE INN BAR & GRILL	Coaster	Nutrl	5	3/9/2026 3:34 PM	2026-03-17 19:05:54.914492
827	rconstant	99 REST - LONDONDERRY	Coaster	Bud Light	3	3/9/2026 9:49 AM	2026-03-17 19:05:54.919367
828	jmeharg	TAVERN ON THE GREENS	Coaster	Bud Light	2	3/9/2026 4:15 AM	2026-03-17 19:05:54.923124
829	eleahy	T-BONES - DERRY	Coaster	Bud Light	9	3/5/2026 1:51 PM	2026-03-17 19:05:54.927546
830	ddooling	PEPPERS PUB (NEW)	Coaster	Bud Light	6	3/5/2026 11:34 AM	2026-03-17 19:05:54.930864
831	scamuso	KINSLEY HOUSE OF PIZZA	Coaster	Bud Light	2	3/4/2026 1:55 PM	2026-03-17 19:05:54.934643
835	lnorton	LA VAKA MEXICAN RESTAURANT	Coaster	Bud Light	2	3/3/2026 2:56 PM	2026-03-17 19:05:54.937561
836	lnorton	VILLAGE TRESTLE (THE)	Coaster	Bud Light	6	3/3/2026 2:56 PM	2026-03-17 19:05:54.940464
838	tchagnon	THIRSTY MOOSE	Coaster	Mich Ultra	6	3/3/2026 8:08 AM	2026-03-17 19:05:54.945059
839	jjohnson	ZIGGY'S PIZZA - W. LEB	Coaster	Bud Light	3	3/2/2026 3:07 PM	2026-03-17 19:05:54.948277
840	lortiz	CHILI'S - NASHUA - DW HWY	Coaster	Bud Light	21	3/2/2026 2:23 PM	2026-03-17 19:05:54.95178
841	eleahy	APPLEBEES - DERRY	Coaster	Bud Light	9	3/2/2026 2:02 PM	2026-03-17 19:05:54.954339
822	ddooling	DERRY SALEM ELKS 2226	Coaster	Budweiser	1	3/10/2026 2:03 PM	2026-03-17 14:10:29.726499
823	maanderson	PINE VALLEY GOLF COURSE	Coaster	Bud Light	1	3/10/2026 11:15 AM	2026-03-17 14:10:29.729905
825	lortiz	RED ROBIN BURGERS #515 NASHUA	Coaster	Bud Light	1	3/9/2026 2:24 PM	2026-03-17 14:10:29.737091
826	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Coaster	Mich Ultra	1	3/9/2026 1:17 PM	2026-03-17 14:10:29.740213
832	ggage	STONECUTTERS PUB	Coaster	Heineken	1	3/4/2026 12:48 PM	2026-03-17 14:10:29.755712
833	eleahy	50 EAST DERRY RD CONVENIENCE - REST	Coaster	Bud Light	1	3/4/2026 10:38 AM	2026-03-17 14:10:29.758011
843	ddooling	T-BONES - SALEM	Coaster	Bud Light	37	3/2/2026 12:28 PM	2026-03-17 19:05:55.010947
837	pwollert	ITALIAN CLUB	Coaster	Mich Ultra	1	3/3/2026 2:04 PM	2026-03-17 14:10:29.770246
842	sshaunessy	LAFAYETTE CLUB A.C.	Coaster	Nutrl	1	3/2/2026 1:07 PM	2026-03-17 14:10:29.783811
850	amartin	PANDA GOURMET	Coaster	Mich Ultra	1	2/26/2026 1:46 PM	2026-03-17 14:10:29.807019
851	amartin	LYNN'S 102 TAVERN	Coaster	Mich Ultra	1	2/26/2026 1:46 PM	2026-03-17 14:10:29.809542
852	amartin	BACKSTREET BAR & GRILL LLC	Coaster	Mich Ultra	1	2/26/2026 1:46 PM	2026-03-17 14:10:29.812891
855	amartin	ODD FELLOWS BREWING COMPANY	Coaster	Bud Light	1	2/25/2026 7:25 AM	2026-03-17 14:10:29.820777
856	jgrumblatt	SALT HILL PUB - NEWBURY	Coaster	Bud Light	1	2/24/2026 3:51 PM	2026-03-17 14:10:29.824222
857	ddooling	DERRY SALEM ELKS 2226	Coaster	Bud Light	1	2/24/2026 3:30 PM	2026-03-17 14:10:29.826694
844	jcaron	AMIGOS MEXICAN CANTINA	Coaster	Bud Light	2	3/2/2026 12:16 PM	2026-03-17 19:05:55.014533
845	jmeharg	HILLSBORO HOUSE OF PIZZA	Coaster	Bud Light	5	3/2/2026 11:26 AM	2026-03-17 19:05:55.018226
846	jaustin	CHILI'S - KEENE	Coaster	Mich Ultra	7	3/2/2026 11:18 AM	2026-03-17 19:05:55.021541
847	jmorse	RAMUNTOS - CLAREMONT	Coaster	Bud Light	17	3/2/2026 10:39 AM	2026-03-17 19:05:55.024514
848	jgrumblatt	BUBBA'S BAR AND GRILLE	Coaster	Bud Light	6	2/26/2026 3:09 PM	2026-03-17 19:05:55.027874
849	maanderson	PEDDLER'S DAUGHTER	Coaster	Mich Ultra	3	2/26/2026 3:07 PM	2026-03-17 19:05:55.030641
853	maanderson	LUK'S BAR & GRILL	Coaster	Nutrl	3	2/25/2026 1:20 PM	2026-03-17 19:05:55.033832
854	eleahy	FANG CHEN'S RESTAURANT	Coaster	Bud Light	2	2/25/2026 12:52 PM	2026-03-17 19:05:55.037733
864	tchagnon	DON RAMON	Coaster	Dos Equis	1	2/20/2026 3:13 PM	2026-03-17 14:10:29.846312
866	jjohnson	JESSE'S STEAKHOUSE	Coaster	Mich Ultra	1	2/19/2026 3:44 PM	2026-03-17 14:10:29.85145
867	ddooling	NEW CHIEF WOK	Coaster	Budweiser	1	2/19/2026 1:00 PM	2026-03-17 14:10:29.853771
858	ddooling	ON THE CORNER GRILL	Coaster	Bud Light	2	2/24/2026 3:29 PM	2026-03-17 19:05:55.040975
859	jmorse	TREMONT HOUSE OF PIZZA	Coaster	Bud Light	8	2/24/2026 2:38 PM	2026-03-17 19:05:55.044677
872	eleahy	HARE OF THE DAWG BAR & GRILL	Coaster	Bud Light Seltzer Sangria Splash Variety	1	2/18/2026 11:33 AM	2026-03-17 14:10:29.867579
860	ggage	CHRYSANTHI'S	Coaster	Bud Light	11	2/24/2026 1:23 PM	2026-03-17 19:05:55.047405
861	lnorton	PINARDVILLE ATHLETIC CLUB	Coaster	Bud Light	3	2/24/2026 1:10 PM	2026-03-17 19:05:55.050772
862	pbelanger	BRADYS BAR AND GRILL	Coaster	Bud Light	2	2/24/2026 10:30 AM	2026-03-17 19:05:55.053947
863	tchagnon	LOBSTER BOAT RESTAURANT	Coaster	Mich Ultra	2	2/20/2026 3:13 PM	2026-03-17 19:05:55.056532
886	jgrumblatt	JALISCO MEXICAN BAR & GRILL	Coaster	Nutrl	1	2/3/2026 12:06 PM	2026-03-17 14:10:29.906782
887	jjohnson	ZIGGY'S PIZZA - W. LEB	Coaster	Nutrl	1	2/2/2026 3:05 PM	2026-03-17 14:10:29.909997
865	ddooling	T-BONES - SALEM	Coaster	Budweiser	31	2/19/2026 3:50 PM	2026-03-17 19:05:55.058959
891	sshaunessy	HALUWA	Coaster	Nutrl	1	1/29/2026 4:03 PM	2026-03-17 14:10:29.922641
868	rconstant	LA CARRETA - LONDONDERRY	Coaster	Nutrl	2	2/18/2026 4:23 PM	2026-03-17 19:05:55.062115
901	lnorton	T-BONES - BEDFORD	Coaster	Nutrl	1	1/22/2026 1:56 PM	2026-03-17 14:10:29.95123
906	jaustin	MAIN CRUST CO.	Coaster	Mich Ultra	1	1/21/2026 3:27 PM	2026-03-17 14:10:29.966122
908	eleahy	HARE OF THE DAWG BAR & GRILL	Coaster	Bud Light	1	1/21/2026 10:12 AM	2026-03-17 14:10:29.972148
911	jaustin	CLIFFY'S PUB	Coaster	Mich Ultra	1	1/15/2026 3:54 PM	2026-03-17 14:10:29.980173
913	maanderson	FRIENDLY RED'S - HUDSON	Coaster	Nutrl	1	1/14/2026 3:23 PM	2026-03-17 14:10:29.985839
915	tchagnon	PIZZICO - MERRIMACK	Coaster	Mich Ultra	1	1/14/2026 1:52 PM	2026-03-17 14:10:29.990377
916	jaustin	A-1 PIZZA & GRILL HINSDALE	Coaster	Mich Ultra	1	1/13/2026 3:55 PM	2026-03-17 14:10:29.993144
869	jaustin	APPLEBEES - KEENE #6714	Coaster	Mich Ultra	7	2/18/2026 3:51 PM	2026-03-17 19:05:55.064923
920	eleahy	T-BONES - DERRY	Coaster	Mich Ultra	1	1/12/2026 1:26 PM	2026-03-17 14:10:30.012042
921	jsewall	MOLLYS RESTAURANT	Coaster	Bud Light	1	1/12/2026 12:23 PM	2026-03-17 14:10:30.014659
923	tchagnon	LOS PRIMOS MEXICAN RESTAURANT	Coaster	Mich Ultra	1	1/7/2026 3:41 PM	2026-03-17 14:10:30.019029
926	jaustin	VFW #799 - KEENE	Coaster	Mich Ultra	1	1/7/2026 12:59 PM	2026-03-17 14:10:30.028549
873	pbelanger	EMMAS 321	Coaster	Bud Light	13	2/18/2026 11:33 AM	2026-03-17 19:05:55.067483
874	pbelanger	MI JALISCO - PETERBORO	Coaster	Bud Light	2	2/17/2026 11:53 AM	2026-03-17 19:05:55.070471
876	pbelanger	MEXICA MEXICAN RESTAURANT	Coaster	Dos Equis	3	2/16/2026 2:25 PM	2026-03-17 19:05:55.07347
878	sshaunessy	HALUWA	Coaster	Bud Light	5	2/12/2026 2:29 PM	2026-03-17 19:05:55.076509
879	maanderson	MARGARITAS MEXICAN RESTAURANT-NASHUA	Coaster	Bud Light	2	2/12/2026 2:26 PM	2026-03-17 19:05:55.079442
880	eleahy	FRIENDLY REDS - DERRY	Coaster	Bud Light	6	2/12/2026 11:07 AM	2026-03-17 19:05:55.082033
881	eplatt	PPC KITCHEN & BAR	Coaster	Bud Light	3	2/11/2026 12:50 PM	2026-03-17 19:05:55.086067
883	jmeharg	TOOKY MILLS PUB	Coaster	Bud Light	36	2/9/2026 12:42 PM	2026-03-17 19:05:55.088992
885	jmorse	DADDY'S PIZZA	Coaster	Bud Light	27	2/3/2026 1:24 PM	2026-03-17 19:05:55.09174
889	jaustin	LAB'N LAGER KEENE	Coaster	Nutrl	2	2/2/2026 1:19 PM	2026-03-17 19:05:55.095955
890	jsewall	SALT HILL PUB - LEBANON	Coaster	Bud Light	4	2/2/2026 10:57 AM	2026-03-17 19:05:55.10036
892	amartin	LYNN'S 102 TAVERN	Coaster	Nutrl	2	1/29/2026 2:46 PM	2026-03-17 19:05:55.1035
893	maanderson	MARGARITAS MEXICAN RESTAURANT-NASHUA	Coaster	Mich Ultra	2	1/29/2026 2:07 PM	2026-03-17 19:05:55.107179
894	jaustin	GUERRILLA GRILL	Coaster	Nutrl	2	1/29/2026 12:47 PM	2026-03-17 19:05:55.193526
895	maanderson	CALI B HUDSON	Coaster	Nutrl	2	1/28/2026 2:18 PM	2026-03-17 19:05:55.196297
896	bgermano	STAGE HANDS RESTAURANT	Coaster	Bud Light	9	1/27/2026 2:32 PM	2026-03-17 19:05:55.198742
897	pbelanger	COOPER'S HILL	Coaster	Bud Light	2	1/27/2026 12:46 PM	2026-03-17 19:05:55.201321
899	jgrumblatt	SALT HILL PUB - NEWPORT	Coaster	Budweiser	2	1/22/2026 3:50 PM	2026-03-17 19:05:55.204057
900	rconstant	AJ'S SPORTS BAR & GRILL	Coaster	Nutrl	7	1/22/2026 3:32 PM	2026-03-17 19:05:55.20642
902	jaustin	KILKENNY PUB - KEENE	Coaster	Mich Ultra	2	1/22/2026 1:16 PM	2026-03-17 19:05:55.209478
903	pwollert	HUNGRY DINER (THE)	Coaster	Zero Gravity - Cone Head	2	1/22/2026 12:07 PM	2026-03-17 19:05:55.212654
904	rconstant	GAME CHANGER SPORTS BAR & GRILL	Coaster	Nutrl	4	1/21/2026 5:26 PM	2026-03-17 19:05:55.217125
905	jaustin	MI JALISCO - KEENE	Coaster	Mich Ultra	4	1/21/2026 3:28 PM	2026-03-17 19:05:55.22062
907	rconstant	HUDSONS NORTH SIDE GRILLE	Coaster	Nutrl	5	1/21/2026 3:14 PM	2026-03-17 19:05:55.223474
909	jgrumblatt	FORESTERS OF AMERICA	Coaster	Budweiser	4	1/20/2026 4:22 PM	2026-03-17 19:05:55.228865
910	amartin	BAR	Coaster	Bud Light	7	1/19/2026 11:32 AM	2026-03-17 19:05:55.232745
912	rconstant	GAME CHANGER SPORTS BAR & GRILL	Coaster	Bud Light	3	1/14/2026 4:04 PM	2026-03-17 19:05:55.235242
914	eplatt	PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD	Coaster	Bud Light	4	1/14/2026 2:53 PM	2026-03-17 19:05:55.238156
917	rconstant	LA CARRETA - LONDONDERRY	Coaster	Bud Light	4	1/13/2026 1:28 PM	2026-03-17 19:05:55.240943
918	tchagnon	THIRSTY MOOSE	Coaster	Bud Light	5	1/13/2026 12:58 PM	2026-03-17 19:05:55.24456
922	jgiuffrida	RED ROBIN GOURMET BURGERS - SALEM	Coaster	Bud Light	2	1/8/2026 2:24 PM	2026-03-17 19:05:55.247108
924	maanderson	FRIENDLY RED'S - HUDSON	Coaster	Bud Light	17	1/7/2026 2:03 PM	2026-03-17 19:05:55.249544
925	maanderson	LUK'S BAR & GRILL	Coaster	Bud Light	6	1/7/2026 1:38 PM	2026-03-17 19:05:55.252088
927	eplatt	PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD	Coaster	Mich Ultra	2	1/7/2026 11:52 AM	2026-03-17 19:05:55.25514
929	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Coaster	Bud Light	3	1/5/2026 2:16 PM	2026-03-17 19:05:55.257862
930	sshaunessy	LAFAYETTE CLUB A.C.	Coaster	Bud Light	1	1/5/2026 1:46 PM	2026-03-17 14:10:30.050314
932	rconstant	ROCCO'S PIZZA	Coaster	Bud Light	7	1/5/2026 11:59 AM	2026-03-17 19:05:55.260775
934	scamuso	FAMILY PIZZA AND ROAST BEEF OF NASHUA	Coaster	Bud Light	1	12/28/2025 12:54 PM	2026-03-17 14:10:30.070837
935	jmeharg	CROTCHED MOUNTAIN SKI AREA	Coaster	Fiddlehead - IPA	1	12/23/2025 11:08 AM	2026-03-17 14:10:30.074224
938	scamuso	EL TAPATIO RESTAURANTE MEXICANO LLC	Coaster	Bud Light	1	12/18/2025 2:21 PM	2026-03-17 14:10:30.083147
939	rconstant	COACH STOP	Coaster	Bud Light	1	12/17/2025 11:01 AM	2026-03-17 14:10:30.085945
940	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Coaster	Budweiser	1	12/15/2025 1:09 PM	2026-03-17 14:10:30.089271
942	tchagnon	AMERICAN LEGION POST 98 - MERRIMACK	Coaster	Budweiser	1	12/10/2025 4:00 PM	2026-03-17 14:10:30.095095
933	jaustin	MI JALISCO - KEENE	Coaster	Bud Light	5	12/30/2025 12:38 PM	2026-03-17 19:05:55.263724
945	amartin	NEW NAN KING RESTAURANT	Coaster	Bud Light	1	12/10/2025 12:12 PM	2026-03-17 14:10:30.105838
946	tchagnon	JADE DRAGON-MERRIMACK	Coaster	Bud Light	1	12/9/2025 2:28 PM	2026-03-17 14:10:30.108994
936	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Coaster	Nutrl	3	12/22/2025 2:36 PM	2026-03-17 19:05:55.266496
937	rconstant	RENEGADES PUB	Coaster	Nutrl	7	12/22/2025 12:46 PM	2026-03-17 19:05:55.269487
951	eleahy	T-BONES - DERRY	Coaster	Budweiser	1	12/8/2025 10:13 AM	2026-03-17 14:10:30.124245
955	scamuso	KSONES THAI DINING	Coaster	Bud Light	1	12/3/2025 1:13 PM	2026-03-17 14:10:30.135294
956	jaustin	VFW #3968 - WINCHESTER	Coaster	Mich Ultra	1	12/3/2025 6:07 AM	2026-03-17 14:10:30.138144
957	eleahy	FODY'S TAVERN (DERRY)	Coaster	Bud Light	1	12/2/2025 12:34 PM	2026-03-17 14:10:30.140141
958	jgiuffrida	99 REST - SALEM	Coaster	Bud Light	1	12/1/2025 3:49 PM	2026-03-17 14:10:30.142097
959	scamuso	PIZZERIA ZACHARIA	Coaster	Bud Light	1	12/1/2025 12:52 PM	2026-03-17 14:10:30.144589
964	eplatt	PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD	Coaster	Fiddlehead - IPA	1	11/25/2025 12:06 PM	2026-03-17 14:10:30.157552
966	jaustin	RUSTIC TABLE (THE)	Coaster	Bud Light	1	11/24/2025 12:31 PM	2026-03-17 14:10:30.162204
967	pbelanger	COOPER'S HILL	Coaster	Fiddlehead - IPA	1	11/24/2025 12:02 PM	2026-03-17 14:10:30.164404
968	jaustin	LAB'N LAGER KEENE	Coaster	Mich Ultra	1	11/23/2025 1:20 PM	2026-03-17 14:10:30.167775
969	tchagnon	RIVER ROAD TAVERN	Coaster	Bud Light	1	11/21/2025 9:52 AM	2026-03-17 14:10:30.170065
970	ddooling	OLD SCHOOL BAR AND GRILL	Coaster	Bud Light	1	11/20/2025 2:25 PM	2026-03-17 14:10:30.17234
971	eleahy	LA CARRETA - DERRY	Coaster	Bud Light	1	11/19/2025 11:22 AM	2026-03-17 14:10:30.174801
976	tchagnon	DON RAMON	Coaster	Mich Ultra	1	11/17/2025 3:38 PM	2026-03-17 14:10:30.190287
979	jaustin	YANKEE LANES / KEENE BOWL	Coaster	Bud Light	1	11/17/2025 11:41 AM	2026-03-17 14:10:30.209277
981	ddooling	NEW CHIEF WOK	Coaster	Bud Ice	1	11/13/2025 1:01 PM	2026-03-17 14:10:30.216223
982	scamuso	GIORGIO'S TRATTORIA - MERRIMACK	Coaster	Bud Light	1	11/13/2025 12:51 PM	2026-03-17 14:10:30.218949
983	maanderson	CALI B HUDSON	Coaster	Heineken	1	11/12/2025 2:21 PM	2026-03-17 14:10:30.221844
985	pwollert	AMERICAN LEGION POST 4 - KEENE	Coaster	Bud Light	1	11/11/2025 1:38 PM	2026-03-17 14:10:30.228181
986	rconstant	GAME CHANGER SPORTS BAR & GRILL	Coaster	Mich Ultra	1	11/5/2025 4:24 PM	2026-03-17 14:10:30.231233
941	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Coaster	Bud Light	4	12/15/2025 11:16 AM	2026-03-17 19:05:55.272235
943	jaustin	TEMPESTA'S	Coaster	Bud Light	5	12/10/2025 2:27 PM	2026-03-17 19:05:55.275748
949	rconstant	STUMBLE INN BAR & GRILL	Coaster	Bud Light	4	12/9/2025 12:36 PM	2026-03-17 19:05:55.279312
993	jjohnson	JESSE'S STEAKHOUSE	Coaster	Nutrl	1	10/30/2025 3:30 PM	2026-03-17 14:10:30.249519
994	eleahy	AMPHORA RESTAURANT	Coaster	Mich Ultra	1	10/30/2025 11:49 AM	2026-03-17 14:10:30.252046
950	jaustin	LAB'N LAGER KEENE	Coaster	Bud Light	7	12/8/2025 1:11 PM	2026-03-17 19:05:55.282233
952	amartin	ROYAL PIZZA	Coaster	Bud Light	2	12/5/2025 3:51 PM	2026-03-17 19:05:55.285
953	rconstant	PROFESSOR SPORTS PUB	Coaster	Bud Light	5	12/3/2025 3:37 PM	2026-03-17 19:05:55.2875
954	amartin	FODY'S TAVERN (NASHUA)	Coaster	Bud Light	3	12/3/2025 1:30 PM	2026-03-17 19:05:55.290694
960	jaustin	CLIFFY'S PUB	Coaster	Bud Light	5	12/1/2025 11:59 AM	2026-03-17 19:05:55.29369
961	rconstant	ROCCO'S PIZZA	Coaster	Nutrl	3	12/1/2025 11:28 AM	2026-03-17 19:05:55.296637
962	amartin	LA HACIENDA DEL RIO	Coaster	Bud Light	10	11/26/2025 3:11 PM	2026-03-17 19:05:55.299007
963	maanderson	CALI B HUDSON	Coaster	Mich Ultra	2	11/25/2025 12:34 PM	2026-03-17 19:05:55.301843
965	rconstant	STUMBLE INN BAR & GRILL	Coaster	Mich Ultra	3	11/24/2025 4:30 PM	2026-03-17 19:05:55.305122
972	maanderson	AMERICAN LEGION POST 100 - PELHAM	Coaster	Bud Light	2	11/18/2025 2:09 PM	2026-03-17 19:05:55.307913
973	ggage	AMERICAN LEGION POST 23 - MILFORD	Coaster	Mich Ultra	3	11/18/2025 12:52 PM	2026-03-17 19:05:55.310648
974	jmorse	CASA JALISCO BAR & GRILL	Coaster	Bud Light	4	11/18/2025 10:11 AM	2026-03-17 19:05:55.313567
975	amartin	SAKURA	Coaster	Bud Light	4	11/17/2025 4:12 PM	2026-03-17 19:05:55.316094
977	jaustin	KILKENNY PUB - KEENE	Coaster	Bud Light	5	11/17/2025 3:36 PM	2026-03-17 19:05:55.318576
978	maanderson	ZO'S PLACE	Coaster	Bud Light	3	11/17/2025 2:39 PM	2026-03-17 19:05:55.321367
980	rconstant	AJ'S SPORTS BAR & GRILL	Coaster	Mich Ultra	3	11/13/2025 2:52 PM	2026-03-17 19:05:55.324855
984	jmorse	HELEN'S PLACE	Coaster	Bud Light	15	11/12/2025 12:22 PM	2026-03-17 19:05:55.327361
987	jaustin	A-1 PIZZA & GRILL HINSDALE	Coaster	Bud Light	2	11/4/2025 3:09 PM	2026-03-17 19:05:55.330686
990	pbelanger	MEXICA MEXICAN RESTAURANT	Coaster	Bud Light	2	11/3/2025 4:25 PM	2026-03-17 19:05:55.344875
992	jaustin	CHILI'S - KEENE	Coaster	Bud Light	12	11/3/2025 11:23 AM	2026-03-17 19:05:55.347799
996	jmeharg	VILLAGE TRESTLE (THE)	Coaster	Bud Light	35	10/28/2025 2:15 PM	2026-03-17 19:05:55.351113
998	maanderson	PINE VALLEY GOLF COURSE	Coaster	Mich Ultra	3	10/28/2025 1:04 PM	2026-03-17 19:05:55.353875
1003	tchagnon	AMERICAN LEGION POST 100 - PELHAM	Coaster	Nutrl	1	10/24/2025 1:33 PM	2026-03-17 14:10:30.275012
1006	eleahy	SUMO SUSHI	Coaster	Bud Light	1	10/23/2025 11:17 AM	2026-03-17 14:10:30.282161
999	pbelanger	RUSTIC TABLE (THE)	Coaster	Bud Light	13	10/28/2025 9:42 AM	2026-03-17 19:05:55.363359
1000	sshaunessy	AMIGOS MEXICAN CANTINA	Coaster	Bud Light	2	10/27/2025 3:23 PM	2026-03-17 19:05:55.366739
1015	jaustin	GUERRILLA GRILL	Coaster	Mich Ultra	1	10/16/2025 2:46 PM	2026-03-17 14:10:30.305595
1017	eplatt	PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD	Coaster	Budweiser	1	10/16/2025 6:35 AM	2026-03-17 14:10:30.310923
1018	eplatt	PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD	Coaster	Mich Ultra Org	1	10/16/2025 6:35 AM	2026-03-17 14:10:30.313414
1020	ggage	CHRYSANTHI'S	Coaster	Fiddlehead - IPA	1	10/14/2025 3:00 PM	2026-03-17 14:10:30.318405
1021	jaustin	MARGARITA'S - KEENE	Coaster	Dos Equis	1	10/8/2025 2:45 PM	2026-03-17 14:10:30.32124
1001	jjohnson	GUSANOZ MEXICAN REST	Coaster	Nutrl	3	10/27/2025 1:04 PM	2026-03-17 19:05:55.371029
1002	ddooling	CHILI'S - SALEM	Coaster	Budweiser	6	10/27/2025 12:02 PM	2026-03-17 19:05:55.373813
1024	jgrumblatt	JALISCO MEXICAN BAR & GRILL	Coaster	Budweiser	1	10/7/2025 1:45 PM	2026-03-17 14:10:30.329042
1004	amartin	PANDA GOURMET	Coaster	Bud Light	16	10/23/2025 2:38 PM	2026-03-17 19:05:55.376502
1005	jaustin	BRICKHOUSE PIZZA & WINGS	Coaster	Bud Light	2	10/23/2025 12:13 PM	2026-03-17 19:05:55.381629
1007	scamuso	HALUWA	Coaster	Bud Light	15	10/23/2025 11:14 AM	2026-03-17 19:05:55.384292
1034	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Coaster	Mich Ultra	1	9/25/2025 10:30 AM	2026-03-17 14:10:30.353281
1009	jsewall	LUI LUI - WEST LEBANON	Coaster	Bud Light	5	10/22/2025 3:48 PM	2026-03-17 19:05:55.387553
1010	sshaunessy	MI JALISCO - PETERBORO	Coaster	Bud Light	7	10/22/2025 2:58 PM	2026-03-17 19:05:55.390276
1040	lnorton	T-BONES - BEDFORD	Coaster	Budweiser	1	9/22/2025 10:01 AM	2026-03-17 14:10:30.367804
1044	eleahy	SUN ASIAN BISTRO	Coaster	Bud Light	1	9/18/2025 12:03 PM	2026-03-17 14:10:30.377489
1011	jaustin	AMERICAN LEGION POST 4 - KEENE	Coaster	Bud Light	15	10/21/2025 3:07 PM	2026-03-17 19:05:55.393704
1012	tchagnon	AMERICAN LEGION POST 100 - PELHAM	Coaster	Bud Light	16	10/21/2025 1:52 PM	2026-03-17 19:05:55.39625
1013	pwollert	KEENE LODGE OF ELKS	Coaster	Bud Light	2	10/21/2025 1:22 PM	2026-03-17 19:05:55.399075
1059	ddooling	OLD SCHOOL BAR AND GRILL	Coaster	Mich Ultra	1	9/4/2025 3:41 PM	2026-03-17 14:10:30.417993
1060	jaustin	BRICKHOUSE PIZZA & WINGS	Coaster	Mich Ultra	1	9/4/2025 1:17 PM	2026-03-17 14:10:30.420853
1016	ddooling	NEW CHIEF WOK	Coaster	Bud Light	3	10/16/2025 12:51 PM	2026-03-17 19:05:55.401862
1064	maanderson	SOHO RESTAURANT	Coaster	Mich Ultra	1	9/3/2025 2:29 PM	2026-03-17 14:10:30.432651
1065	maanderson	GOLDEN DRAGON RESTAURANT	Coaster	Bud Light	1	9/3/2025 1:43 PM	2026-03-17 14:10:30.435142
1019	sshaunessy	SUN BAR & GRILL	Coaster	Bud Light	3	10/14/2025 4:32 PM	2026-03-17 19:05:55.405118
1026	ggage	OLDE TOWNE TAVERN	Coaster	Mich Ultra	3	10/7/2025 11:02 AM	2026-03-17 19:05:55.41059
1027	jmorse	CLAREMONT COUNTRY CLUB	Coaster	Bud Light	2	10/6/2025 3:41 PM	2026-03-17 19:05:55.413666
1028	pbelanger	VFW SOCIAL CLUB	Coaster	Bud Light	14	10/6/2025 1:16 PM	2026-03-17 19:05:55.417069
1030	jgrumblatt	JALISCO MEXICAN BAR & GRILL	Coaster	Bud Light	3	9/30/2025 3:27 PM	2026-03-17 19:05:55.420819
1032	jjohnson	ZIGGY'S PIZZA - W. LEB	Coaster	Mich Ultra	2	9/29/2025 11:42 AM	2026-03-17 19:05:55.425036
1033	pbelanger	PAPAGALLOS RESTAURANT	Coaster	Bud Light	18	9/25/2025 12:43 PM	2026-03-17 19:05:55.430286
1036	jmorse	FORBES TAVERN AND EVENTS	Coaster	Bud Light	7	9/24/2025 3:19 PM	2026-03-17 19:05:55.434253
1038	sshaunessy	BRADYS BAR AND GRILL	Coaster	Bud Light	5	9/24/2025 11:29 AM	2026-03-17 19:05:55.437404
1039	rconstant	RENEGADES PUB	Coaster	Bud Light	6	9/23/2025 12:47 PM	2026-03-17 19:05:55.439839
1041	lnorton	RIVER ROAD TAVERN	Coaster	Bud Light	2	9/18/2025 2:38 PM	2026-03-17 19:05:55.442322
1042	jjohnson	ZIGGY'S PIZZA - W. LEB	Coaster	Budweiser	4	9/18/2025 2:37 PM	2026-03-17 19:05:55.44487
1043	maanderson	NATIONAL CLUB (THE)	Coaster	Bud Light	16	9/18/2025 1:22 PM	2026-03-17 19:05:55.448517
1045	jsewall	APPLEBEES - W.LEB #6732	Coaster	Bud Light	4	9/18/2025 6:05 AM	2026-03-17 19:05:55.451043
1046	amartin	PHO TAI LOC	Coaster	Bud Light	3	9/17/2025 1:20 PM	2026-03-17 19:05:55.453743
1047	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Coaster	Mich Ultra	2	9/17/2025 9:46 AM	2026-03-17 19:05:55.456222
1048	jaustin	AMERICAN LEGION POST 4 - KEENE	Coaster	Mich Ultra	6	9/16/2025 4:05 PM	2026-03-17 19:05:55.459294
1049	jmorse	IMPERIAL BUFFET & LOUNGE	Coaster	Bud Light	2	9/16/2025 11:34 AM	2026-03-17 19:05:55.46201
1050	jgiuffrida	PAR28	Coaster	Bud Light	2	9/15/2025 3:23 PM	2026-03-17 19:05:55.464435
1051	ddooling	MICHAELS FLATBREAD PIZZA CO.	Coaster	Budweiser	5	9/15/2025 1:37 PM	2026-03-17 19:05:55.466802
1052	jjohnson	GUSANOZ MEXICAN REST	Coaster	Bud Light	6	9/15/2025 12:15 PM	2026-03-17 19:05:55.46975
1053	pbelanger	WOODBOUND INN	Coaster	Bud Light	2	9/9/2025 11:48 AM	2026-03-17 19:05:55.472121
1057	sshaunessy	AMERICAN LEGION POST 10 - WILTON	Coaster	Bud Light	2	9/7/2025 11:29 AM	2026-03-17 19:05:55.475503
1058	jmorse	TAVERNE ON THE SQUARE LLC	Coaster	Bud Light	13	9/5/2025 12:47 PM	2026-03-17 19:05:55.479937
1062	jsewall	LEBANON VILLAGE PIZZA	Coaster	Bud Light	17	9/4/2025 1:01 PM	2026-03-17 19:05:55.484005
1063	pbelanger	MAMA MCDONOUGH'S IRISH PUB	Coaster	Bud Light	8	9/4/2025 11:34 AM	2026-03-17 19:05:55.486402
1066	sshaunessy	COOPER'S HILL	Coaster	Bud Light	1	9/3/2025 11:31 AM	2026-03-17 14:10:30.437997
1067	jaustin	MI JALISCO - KEENE	Coaster	Dos Equis	2	9/3/2025 11:21 AM	2026-03-17 19:05:55.488587
1068	amartin	SLADES FOOD & SPIRITS	Coaster	Bud Light	4	8/28/2025 3:10 PM	2026-03-17 19:05:55.491451
1072	ddooling	CHILI'S - SALEM	Coaster	Bud Light	4	8/25/2025 1:06 PM	2026-03-17 19:05:55.494672
1073	eleahy	HALCYON CLUB	Coaster	Bud Light	1	8/22/2025 10:56 AM	2026-03-17 14:10:30.454806
1074	jgiuffrida	LIM'S SPORTS BAR & CAFE	Coaster	Bud Light	1	8/21/2025 1:54 PM	2026-03-17 14:10:30.457257
1075	maanderson	CALI B HUDSON	Coaster	Bud Light	5	8/20/2025 1:33 PM	2026-03-17 19:05:55.49706
1076	jsewall	LEBANON LODGE OF ELKS	Coaster	Bud Light	4	8/19/2025 1:46 PM	2026-03-17 19:05:55.49949
1081	ggage	THE BRICKHOUSE RESTAURANT AND BREWERY	Coaster	Bud Light	5	8/12/2025 10:33 AM	2026-03-17 19:05:55.504449
1082	jmeharg	TOOKY MILLS PUB	Coaster	Mich Ultra	5	8/11/2025 12:00 PM	2026-03-17 19:05:55.5068
1087	scamuso	MILANO HOUSE OF PIZZA-NASHUA	Coaster	Bud Light	3	7/28/2025 12:20 PM	2026-03-17 19:05:55.510921
1093	jaustin	APPLEBEES - KEENE #6714	Coaster	Bud Light	8	7/22/2025 1:46 PM	2026-03-17 19:05:55.515688
1095	ggage	AMERICAN LEGION POST 23 - MILFORD	Coaster	Bud Light	2	7/22/2025 12:59 PM	2026-03-17 19:05:55.519915
1097	jmeharg	AMERICAN LEGION POST 59 - HILLSBORO	Coaster	Bud Light	2	7/21/2025 12:33 PM	2026-03-17 19:05:55.524962
1088	ddooling	T-BONES - SALEM	Coaster	Mich Ultra	1	7/24/2025 12:53 PM	2026-03-17 14:10:30.493571
1089	ggage	OLDE TOWNE TAVERN	Coaster	Nutrl	1	7/22/2025 3:08 PM	2026-03-17 14:10:30.495696
1090	ggage	OLDE TOWNE TAVERN	Coaster	Kona - Big Wave	1	7/22/2025 3:08 PM	2026-03-17 14:10:30.498289
1099	lortiz	LUI LUI - NASHUA	Coaster	Bud Light	3	7/17/2025 2:59 PM	2026-03-17 19:05:55.528358
1100	amartin	BACKSTREET BAR & GRILL LLC	Coaster	Bud Light	4	7/17/2025 2:08 PM	2026-03-17 19:05:55.531448
1094	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Coaster	Fiddlehead - IPA	1	7/22/2025 1:11 PM	2026-03-17 14:10:30.5093
1111	ggage	THE BRICKHOUSE RESTAURANT AND BREWERY	Coaster	Mich Ultra	7	7/1/2025 9:10 AM	2026-03-17 19:05:55.535102
1116	sshaunessy	MI JALISCO - PETERBORO	Coaster	Budweiser	4	6/25/2025 3:34 PM	2026-03-17 19:05:55.539088
1119	tchagnon	KELARI TAVERNA & BAR	Coaster	Bud Light	6	6/24/2025 11:27 AM	2026-03-17 19:05:55.541599
1120	ggage	VFW #4368 - MILFORD	Coaster	Mich Ultra	3	6/24/2025 9:37 AM	2026-03-17 19:05:55.544364
1122	jmeharg	SAMPAN CHINESE RESTAURANT	Coaster	Bud Light	4	6/23/2025 12:53 PM	2026-03-17 19:05:55.547109
1104	jmorse	AMERICAN LEGION POST 29 - CLAREMONT	Coaster	Nutrl	1	7/14/2025 1:08 PM	2026-03-17 14:10:30.536581
1105	ddooling	COPPER DOOR - SALEM	Coaster	Stella Artois	1	7/14/2025 10:49 AM	2026-03-17 14:10:30.539003
1106	ggage	AMERICAN LEGION POST 13 - GREENVILLE	Coaster	Budweiser	1	7/13/2025 11:39 AM	2026-03-17 14:10:30.54144
1107	ddooling	COPPER DOOR - SALEM	Coaster	Budweiser	1	7/10/2025 11:17 AM	2026-03-17 14:10:30.543603
1123	lortiz	PIZZICO - ITALIAN RESTAURANT - NASHUA	Coaster	Bud Light	2	6/23/2025 12:02 PM	2026-03-17 19:05:55.549701
1124	scamuso	POLISH AMERICAN CLUB-NASHUA	Coaster	Bud Light	6	6/23/2025 8:46 AM	2026-03-17 19:05:55.552238
1125	amartin	LYNN'S 102 TAVERN	Coaster	Bud Light	2	6/19/2025 1:15 PM	2026-03-17 19:05:55.556077
1112	jsewall	ORE MILL BAR & GRILLE	Coaster	Bud Light	1	6/30/2025 1:17 PM	2026-03-17 14:10:30.555612
1129	ggage	PIZZERIA ZACHARIA	Coaster	Mich Ultra	2	6/16/2025 10:21 AM	2026-03-17 19:05:55.559519
1114	ggage	AMERICAN LEGION POST 13 - GREENVILLE	Coaster	Bud Light	1	6/29/2025 10:46 AM	2026-03-17 14:10:30.560875
1131	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Coaster	Bud Light	5	6/12/2025 10:31 AM	2026-03-17 19:05:55.561957
1117	lnorton	EVVIVA TRATTORIA - BEDFORD	Coaster	Bud Light	1	6/25/2025 1:22 PM	2026-03-17 14:10:30.568789
1118	jgrumblatt	APPLESEED LAKESIDE REST	Coaster	Mich Ultra	1	6/25/2025 9:44 AM	2026-03-17 14:10:30.571622
1126	maanderson	THE SPICE	Coaster	Mich Ultra	1	6/18/2025 1:52 PM	2026-03-17 14:10:30.601654
1134	maanderson	NEW NAN KING RESTAURANT	Coaster	Mich Ultra	1	6/11/2025 11:26 AM	2026-03-17 14:10:30.624819
1135	jjohnson	ZIGGY'S PIZZA - W. LEB	Coaster	Kona - Big Wave	1	6/9/2025 3:41 PM	2026-03-17 14:10:30.62767
1138	scamuso	LAFAYETTE CLUB A.C.	Coaster	Bud Light	7	6/9/2025 9:53 AM	2026-03-17 19:05:55.566133
1143	jjohnson	GUSANOZ MEXICAN REST	Coaster	Budweiser	2	6/2/2025 1:13 PM	2026-03-17 19:05:55.569318
1146	ddooling	T-BONES - SALEM	Coaster	Nutrl	2	5/29/2025 12:33 PM	2026-03-17 19:05:55.572023
1140	eleahy	PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD	Coaster	Mich Ultra	1	6/4/2025 1:54 PM	2026-03-17 14:10:30.640137
1147	jaustin	TEMPESTA'S	Coaster	Nutrl	3	5/28/2025 3:04 PM	2026-03-17 19:05:55.574372
1149	sshaunessy	BRADYS BAR AND GRILL	Coaster	Budweiser	2	5/28/2025 12:33 PM	2026-03-17 19:05:55.576982
1152	jgrumblatt	THE REFINERY	Coaster	Bud Light	2	5/28/2025 11:13 AM	2026-03-17 19:05:55.579664
1167	eleahy	PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD	Coaster	Bud Light	8	5/7/2025 1:06 PM	2026-03-17 19:05:55.587812
1173	scamuso	LAFAYETTE CLUB A.C.	Coaster	Budweiser	2	5/5/2025 9:44 AM	2026-03-17 19:05:55.590244
1150	jgrumblatt	PETER CHRISTIANS TAVERN	Coaster	Mich Ultra	1	5/28/2025 11:57 AM	2026-03-17 14:10:30.666484
1151	lnorton	MARKET BASKET #71 BEDFORD	Coaster	Bud Light	1	5/28/2025 11:45 AM	2026-03-17 14:10:30.668961
1182	jmeharg	VILLAGE TRESTLE (THE)	Coaster	Mich Ultra	2	4/22/2025 12:24 PM	2026-03-17 19:05:55.594242
1188	ggage	OLDE TOWNE TAVERN	Coaster	Bud Light	3	4/15/2025 1:37 PM	2026-03-17 19:05:55.598732
1190	jmorse	RANCHO VIEJO MEXICAN FOOD AND CANTINA	Coaster	Bud Light	3	4/15/2025 12:59 PM	2026-03-17 19:05:55.601514
1200	jgrumblatt	NEWPORT VETERAN'S CLUB	Coaster	Bud Light	5	4/8/2025 3:40 PM	2026-03-17 19:05:55.605825
1160	ggage	THE BRICKHOUSE RESTAURANT AND BREWERY	Coaster	Nutrl	1	5/13/2025 9:26 AM	2026-03-17 14:10:30.702239
1163	jsewall	LEBANON VILLAGE PIZZA	Coaster	Stoneface - IPA	1	5/12/2025 1:37 PM	2026-03-17 14:10:30.710025
1165	scamuso	POLISH AMERICAN CLUB-NASHUA	Coaster	Budweiser	1	5/12/2025 9:53 AM	2026-03-17 14:10:30.7208
1168	pbelanger	VFW #3968 - WINCHESTER	Coaster	Bud Light	1	5/6/2025 4:37 PM	2026-03-17 14:10:30.729364
1171	ddooling	CHILI'S - SALEM	Coaster	Dos Equis	1	5/5/2025 12:28 PM	2026-03-17 14:10:30.737704
1172	ddooling	T-BONES - SALEM	Coaster	Good Boy Vodka	1	5/5/2025 12:12 PM	2026-03-17 14:10:30.740178
1178	jgrumblatt	WILDWOOD SMOKEHOUSE	Coaster	Bud Light	1	4/23/2025 3:40 PM	2026-03-17 14:10:30.756104
1181	tchagnon	AMERICAN LEGION POST 100 - PELHAM	Coaster	Mich Ultra	1	4/22/2025 2:24 PM	2026-03-17 14:10:30.763991
1183	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Coaster	Nutrl	1	4/21/2025 2:39 PM	2026-03-17 14:10:30.769389
1185	jgiuffrida	SHAKING SEAFOOD	Coaster	Bud Light	1	4/17/2025 1:56 PM	2026-03-17 14:10:30.774751
1186	jgrumblatt	BUBBA'S BAR AND GRILLE	Coaster	Mich Ultra	1	4/17/2025 10:28 AM	2026-03-17 14:10:30.77684
1191	ddooling	SAYDES RESTAURANT INC.	Coaster	Bud Light	1	4/15/2025 11:57 AM	2026-03-17 14:10:30.788844
1192	sshaunessy	AMHERST COUNTRY CLUB	Coaster	Mich Ultra	1	4/14/2025 3:49 PM	2026-03-17 14:10:30.791239
1194	jmeharg	HILLSBORO HOUSE OF PIZZA	Coaster	Mich Ultra	1	4/14/2025 12:21 PM	2026-03-17 14:10:30.796407
1198	scamuso	PINE STREET EATERY	Coaster	Budweiser	1	4/10/2025 12:13 PM	2026-03-17 14:10:30.806867
1199	jgrumblatt	FORESTERS OF AMERICA	Coaster	Bud Light	1	4/8/2025 4:16 PM	2026-03-17 14:10:30.809085
1201	amartin	LA HACIENDA DEL RIO	Coaster	Mich Ultra	1	4/3/2025 3:58 PM	2026-03-17 14:10:30.8151
1202	eleahy	PLAISTOW CIGAR COMPANY	Coaster	Stoneface - IPA	1	4/3/2025 11:13 AM	2026-03-17 14:10:30.818413
1204	lnorton	NEW WA TOY	Coaster	Bud Light	15	4/1/2025 12:05 PM	2026-03-17 19:05:55.608379
1205	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Coaster	Bud Light	15	3/31/2025 2:43 PM	2026-03-17 19:05:55.611051
1208	rconstant	PASSACONAWAY COUNTRY CLUB	Coaster	Nutrl	1	3/26/2025 1:20 PM	2026-03-17 14:10:30.837331
1209	rconstant	HIDDEN CREEK COUNTRY CLUB	Coaster	Nutrl	1	3/26/2025 1:18 PM	2026-03-17 14:10:30.839925
1207	maanderson	LUK'S BAR & GRILL	Coaster	Nutrl Pineapple	2	3/26/2025 1:26 PM	2026-03-17 19:05:55.614348
1215	rconstant	AJ'S SPORTS BAR & GRILL	Coaster	Bud Light	3	3/6/2025 12:54 PM	2026-03-17 19:05:55.618724
1216	jaustin	VFW #799 - KEENE	Coaster	Bud Light	2	3/4/2025 1:46 PM	2026-03-17 19:05:55.621666
1213	rconstant	ROMANO'S PIZZA LLC	Coaster	Bud Light	1	3/6/2025 12:55 PM	2026-03-17 14:10:30.850826
1214	rconstant	LI'L LOBSTER BOAT	Coaster	Bud Light	1	3/6/2025 12:55 PM	2026-03-17 14:10:30.853097
1218	jgrumblatt	PETER CHRISTIANS TAVERN	Coaster	Bud Light	1	2/26/2025 2:42 PM	2026-03-17 14:10:30.863263
1219	pbelanger	ARLINGTON INN & TAVERN (THE)	Coaster	Bud Light	1	2/25/2025 2:43 PM	2026-03-17 14:10:30.866007
1221	jmorse	FORBES TAVERN AND EVENTS	Coaster	Mich Ultra	1	2/19/2025 10:35 AM	2026-03-17 14:10:30.870972
1222	sshaunessy	AMERICAN LEGION POST 11 - JAFFREY	Coaster	Budweiser	1	2/19/2025 9:05 AM	2026-03-17 14:10:30.874312
1217	maanderson	SOHO RESTAURANT	Coaster	Bud Light	2	3/3/2025 11:43 AM	2026-03-17 19:05:55.624605
1226	jmorse	AMERICAN LEGION POST 29 - CLAREMONT	Coaster	Bud Light	1	2/15/2025 10:48 AM	2026-03-17 14:10:30.8869
1220	jsewall	CHILI'S - W.LEB	Coaster	Bud Light	6	2/20/2025 11:39 AM	2026-03-17 19:05:55.627997
1228	maanderson	THE SPICE	Coaster	Bud Light	1	2/12/2025 1:20 PM	2026-03-17 14:10:30.892514
1224	jmorse	CLAREMONT LODGE OF ELKS	Coaster	Bud Light	2	2/15/2025 2:33 PM	2026-03-17 19:05:55.630847
1225	jmorse	VFW #808 - CLAREMONT	Coaster	Bud Light	2	2/15/2025 12:43 PM	2026-03-17 19:05:55.633672
1229	rconstant	RENEGADES PUB	Coaster	Budweiser	3	2/11/2025 12:03 PM	2026-03-17 19:05:55.636715
1235	ddooling	PEPPERS PUB (NEW)	Coaster	Bud Ice	1	1/30/2025 10:07 AM	2026-03-17 14:10:30.91086
1237	pwollert	ITALIAN CLUB	Coaster	Bud Light	1	1/28/2025 2:09 PM	2026-03-17 14:10:30.916357
1238	jgrumblatt	NEWBURY PALACE PIZZA	Coaster	Bud Light	1	1/28/2025 1:15 PM	2026-03-17 14:10:30.918928
1232	maanderson	T-BONES - HUDSON	Coaster	Bud Light	6	2/5/2025 11:44 AM	2026-03-17 19:05:55.63985
1234	pwollert	FRATERNAL ORDER OF EAGLES	Coaster	Bud Light	6	2/4/2025 1:36 PM	2026-03-17 19:05:55.642404
1241	rconstant	PROFESSOR SPORTS PUB	Coaster	Budweiser	1	1/23/2025 3:04 PM	2026-03-17 14:10:30.926822
1244	jmorse	HELEN'S PLACE	Coaster	Budweiser	1	1/22/2025 12:14 PM	2026-03-17 14:10:30.935201
1245	rconstant	LA CARRETA - LONDONDERRY	Coaster	Budweiser	1	1/22/2025 11:32 AM	2026-03-17 14:10:30.946237
1246	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Coaster	Budweiser	1	1/21/2025 3:14 PM	2026-03-17 14:10:30.948406
1236	rconstant	STUMBLE INN BAR & GRILL	Coaster	Budweiser	3	1/28/2025 3:45 PM	2026-03-17 19:05:55.644804
1242	maanderson	NATIONAL CLUB (THE)	Coaster	Nutrl	4	1/23/2025 2:16 PM	2026-03-17 19:05:55.647988
1249	maanderson	NATIONAL CLUB (THE)	Coaster	Budweiser	1	1/16/2025 12:47 PM	2026-03-17 14:10:30.957496
1243	jaustin	KILKENNY PUB - KEENE	Coaster	Nutrl	4	1/23/2025 5:57 AM	2026-03-17 19:05:55.650775
1250	jaustin	MAIN CRUST CO.	Coaster	Bud Light	3	1/15/2025 3:08 PM	2026-03-17 19:05:55.653153
1254	lnorton	CHEN YANG LI RESTAURANT BY KFZ	Coaster	Bud Light	2	1/7/2025 1:59 PM	2026-03-17 19:05:55.656267
1255	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Coaster	Nutrl	1	1/7/2025 1:38 PM	2026-03-17 14:10:30.977914
1256	maanderson	NATIONAL CLUB (THE)	Coaster	Mich Ultra Zero	1	1/6/2025 2:08 PM	2026-03-17 14:10:30.980515
1257	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Coaster	Mich Ultra	1	1/6/2025 12:22 PM	2026-03-17 14:10:30.983144
1260	amartin	SAN FRANCISCO KITCHEN INC	Coaster	Bud Light	4	12/19/2024 2:45 PM	2026-03-17 19:05:55.658518
1263	jsewall	TARGET # 3401 - W. LEBANON	Coaster	Bud Light	2	12/18/2024 11:37 AM	2026-03-17 19:05:55.662107
1261	jsewall	LEBANON VILLAGE PIZZA	Coaster	Budweiser	1	12/19/2024 11:34 AM	2026-03-17 14:10:30.994038
1265	ggage	PIZZERIA ZACHARIA	Coaster	Bud Light	2	12/16/2024 12:14 PM	2026-03-17 19:05:55.664494
1271	jaustin	MARGARITA'S - KEENE	Coaster	Bud Light	4	12/4/2024 1:25 PM	2026-03-17 19:05:55.668386
1266	sshaunessy	HARLOWS PUBLIC HOUSE	Coaster	Budweiser	1	12/11/2024 1:31 PM	2026-03-17 14:10:31.00824
1283	sshaunessy	HARLOWS PUBLIC HOUSE	Coaster	Bud Light	2	11/6/2024 2:09 PM	2026-03-17 19:05:55.675031
1273	eleahy	SUSHI TIME RESTAURANT	Coaster	Bud Light	1	11/29/2024 12:18 PM	2026-03-17 14:10:31.029438
1274	jmorse	TAVERNE ON THE SQUARE LLC	Coaster	Budweiser	1	11/25/2024 11:57 AM	2026-03-17 14:10:31.031776
1290	amartin	AMERICAN LEGION POST 3 - NASHUA	Coaster	Bud Light	3	10/31/2024 12:15 PM	2026-03-17 19:05:55.679183
1276	maanderson	CALI B HUDSON	Coaster	Dos Equis	1	11/20/2024 12:26 PM	2026-03-17 14:10:31.03806
1293	ggage	VFW #4368 - MILFORD	Coaster	Bud Light	3	10/29/2024 9:21 AM	2026-03-17 19:05:55.681476
1278	eleahy	PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD	Coaster	Stella Artois	1	11/13/2024 2:24 PM	2026-03-17 14:10:31.043829
1299	pwollert	KEENE LODGE OF ELKS	Coaster	Nutrl	2	10/22/2024 12:52 PM	2026-03-17 19:05:55.684247
1306	sshaunessy	AMERICAN LEGION POST 11 - JAFFREY	Coaster	Bud Light	2	10/15/2024 1:05 PM	2026-03-17 19:05:55.687139
1281	jmorse	WAL-MART #1975 - CLAREMONT	Coaster	Athletic - Lite	1	11/7/2024 10:10 AM	2026-03-17 14:10:31.051087
1309	eleahy	PPC KITCHEN & BAR	Coaster	Bud Light	3	10/14/2024 3:24 PM	2026-03-17 19:05:55.689832
1284	sshaunessy	SUN BAR & GRILL	Coaster	Budweiser	1	11/5/2024 4:14 PM	2026-03-17 14:10:31.058858
1329	maanderson	NEW NAN KING RESTAURANT	Coaster	Bud Light	2	9/18/2024 12:44 PM	2026-03-17 19:05:55.693374
1331	pwollert	21 ROXBURY BAR & GRILL	Coaster	Bud Light	4	9/11/2024 3:50 PM	2026-03-17 19:05:55.696255
1287	ddooling	NEW CHIEF WOK	Coaster	Nutrl Orange	1	10/31/2024 3:11 PM	2026-03-17 14:10:31.066551
1332	jaustin	GUERRILLA GRILL	Coaster	Bud Light	2	9/11/2024 2:39 PM	2026-03-17 19:05:55.699388
1291	jmeharg	DANIEL'S PUB INC	Coaster	Stella Artois	1	10/30/2024 1:58 PM	2026-03-17 14:10:31.076455
1292	pwollert	POUR HOUSE (THE)	Coaster	Bud Light	1	10/29/2024 4:27 PM	2026-03-17 14:10:31.079161
1294	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Coaster	Wicked Weed	1	10/28/2024 10:26 AM	2026-03-17 14:10:31.083792
1295	jsewall	SAWTOOTH KITCHEN LLC	Coaster	Bud Light	1	10/24/2024 2:54 PM	2026-03-17 14:10:31.085974
1296	jaustin	CHILI'S - KEENE	Coaster	Budweiser	1	10/24/2024 2:39 PM	2026-03-17 14:10:31.088319
1297	jjohnson	ZIGGY'S PIZZA - W. LEB	Coaster	Wicked Weed	1	10/24/2024 10:29 AM	2026-03-17 14:10:31.090398
1308	jmorse	TAVERNE ON THE SQUARE LLC	Coaster	Mich Ultra	1	10/15/2024 6:18 AM	2026-03-17 14:10:31.117261
1314	jgrumblatt	CIRCLE K #7247 - ANDOVER	Coaster	Bud Light	1	10/9/2024 11:49 AM	2026-03-17 14:10:31.133721
1315	jgrumblatt	LITTLE BROTHERS BURGERS	Coaster	Bud Light	1	10/7/2024 2:22 PM	2026-03-17 14:10:31.135926
1316	tchagnon	HANNAFORD #8015 - PELHAM	Coaster	Bud Light	1	10/3/2024 3:47 PM	2026-03-17 14:10:31.138705
1317	ddooling	TIO JUAN'S MARGARITAS MEXICAN REST-SALEM	Coaster	Bud Light	1	10/3/2024 3:18 PM	2026-03-17 14:10:31.142464
1321	lnorton	SUNSHUI ASIAN CUISINE	Coaster	Bud Light	1	9/30/2024 1:36 PM	2026-03-17 14:10:31.158357
1326	bgermano	STAGE HANDS RESTAURANT	Coaster	Mich Ultra	1	9/24/2024 1:35 PM	2026-03-17 14:10:31.170952
1337	maanderson	NEW NAN KING RESTAURANT	Coaster	Heineken	1	9/4/2024 12:25 PM	2026-03-17 14:10:31.198928
1338	lnorton	NEW WA TOY	Coaster	Nutrl	1	9/3/2024 1:34 PM	2026-03-17 14:10:31.201024
1339	pwollert	ITALIAN CLUB	Coaster	Nutrl	1	8/27/2024 2:12 PM	2026-03-17 14:10:31.203155
1340	jmorse	CASA JALISCO BAR & GRILL	Coaster	Dos Equis	1	8/27/2024 11:32 AM	2026-03-17 14:10:31.20575
1359	lnorton	OLD SCHOOL BAR AND GRILL	Coaster	Bud Light	8	8/1/2024 2:25 PM	2026-03-17 19:05:55.705411
1360	lnorton	FRIENDLY RED'S - WINDHAM	Coaster	Bud Light	8	8/1/2024 2:24 PM	2026-03-17 19:05:55.708485
1368	maanderson	LUK'S BAR & GRILL	Coaster	Mich Ultra	2	7/30/2024 12:39 PM	2026-03-17 19:05:55.711284
1384	jmorse	POLISH AMER CITIZENS CLUB-CLAREMONT	Coaster	Bud Light	3	7/16/2024 5:41 AM	2026-03-17 19:05:55.715137
1403	maanderson	STROKERS	Coaster	Bud Light	2	7/2/2024 3:18 PM	2026-03-17 19:05:55.718873
1348	maanderson	ZO'S PLACE	Coaster	Nutrl	1	8/19/2024 1:54 PM	2026-03-17 14:10:31.227329
1358	ddooling	PEPPERS PUB (NEW)	Coaster	Budweiser	1	8/1/2024 3:37 PM	2026-03-17 14:10:31.252038
1361	scamuso	PINE STREET EATERY	Coaster	Bud Light	1	8/1/2024 2:09 PM	2026-03-17 14:10:31.260744
1362	rconstant	HUDSONS NORTH SIDE GRILLE	Coaster	Mich Ultra	1	8/1/2024 1:08 PM	2026-03-17 14:10:31.263524
1363	rconstant	PROFESSOR SPORTS PUB	Coaster	Mich Ultra	1	8/1/2024 1:08 PM	2026-03-17 14:10:31.26577
1365	amartin	CHICKEN N CHIP'S	Coaster	Bud Light	1	7/31/2024 1:19 PM	2026-03-17 14:10:31.271759
1366	lnorton	SHAW'S #0686 - WINDHAM	Coaster	Bud Light	1	7/31/2024 1:17 PM	2026-03-17 14:10:31.274203
1377	pbelanger	WAL-MART #2057 - RINDGE	Coaster	Bud Light	1	7/24/2024 12:11 PM	2026-03-17 14:10:31.304559
1380	amartin	WHOLE FOODS MARKET - NASHUA - BAR	Coaster	Bud Light	1	7/18/2024 9:44 AM	2026-03-17 14:10:31.315204
1385	lortiz	THE FRIENDLY TOAST - NASHUA	Coaster	Mich Ultra	1	7/15/2024 2:40 PM	2026-03-17 14:10:31.333848
1386	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Coaster	Mich Ultra	1	7/15/2024 2:07 PM	2026-03-17 14:10:31.336631
1394	jgrumblatt	NEWPORT VETERAN'S CLUB	Coaster	Nutrl	1	7/9/2024 4:35 PM	2026-03-17 14:10:31.357616
1395	jgrumblatt	LITTLE BROTHERS BURGERS	Coaster	Hoop Tea	1	7/8/2024 3:47 PM	2026-03-17 14:10:31.360404
1399	maanderson	NATIONAL CLUB (THE)	Coaster	Heineken	1	7/4/2024 1:56 PM	2026-03-17 14:10:31.371144
1400	ddooling	TIO JUAN'S MARGARITAS MEXICAN REST-SALEM	Coaster	Kona - Big Wave	1	7/3/2024 2:02 PM	2026-03-17 14:10:31.373824
1407	pbelanger	SHATTUCK GOLF AND DUBLIN ROAD TAPROOM	Coaster	Bud Light	1	6/24/2024 3:08 PM	2026-03-17 14:10:31.393273
1408	amartin	LA CARRETA - NASHUA	Coaster	Bud Light	1	6/24/2024 1:52 PM	2026-03-17 14:10:31.395784
1423	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Budweiser	2	3/11/2026 8:15 AM	2026-03-17 19:05:55.721263
1425	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Sparkling Ice	3	3/11/2026 8:15 AM	2026-03-17 19:05:55.723977
1428	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	Bud Light	7	3/10/2026 8:43 AM	2026-03-17 19:05:55.727052
1429	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	Budweiser	2	3/10/2026 8:43 AM	2026-03-17 19:05:55.729942
1430	jgiuffrida	MARKET BASKET #06 SALEM	Display/ Display Enhancer	Stella Artois	2	3/9/2026 12:28 PM	2026-03-17 19:05:55.732641
1431	rconstant	MARKET BASKET #42 LONDERRY	Display/ Display Enhancer	Super Coffee	2	3/5/2026 2:48 PM	2026-03-17 19:05:55.735006
1436	jaustin	BIG DEAL - KEENE	Display/ Display Enhancer	Mich Ultra	2	3/2/2026 3:54 PM	2026-03-17 19:05:55.737896
1418	sshaunessy	POLISH AMERICAN CLUB-NASHUA	Coaster	Budweiser	1	6/17/2024 10:38 AM	2026-03-17 14:10:31.420705
1443	pwollert	SHAW'S #3533 - WALPOLE	Display/ Display Enhancer	Mich Ultra	3	2/26/2026 12:25 PM	2026-03-17 19:05:55.741359
1420	sshaunessy	HALUWA	Coaster	Budweiser	1	6/13/2024 12:31 PM	2026-03-17 14:10:31.425813
1445	lnorton	MARKET BASKET #71 BEDFORD	Display/ Display Enhancer	Sparkling Ice	3	2/25/2026 9:27 AM	2026-03-17 19:05:55.744232
1447	bgermano	WAL-MART #3549 - KEENE	Display/ Display Enhancer	Bud Light	2	2/19/2026 8:18 AM	2026-03-17 19:05:55.746968
1424	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Ryse Energy + Protein	1	3/11/2026 8:15 AM	2026-03-17 14:10:31.436893
1426	jgrumblatt	HANNAFORD #8246 - NEW LONDON	Display/ Display Enhancer	Bud Light	1	3/11/2026 6:49 AM	2026-03-17 14:10:31.442132
1427	jgrumblatt	HANNAFORD #8246 - NEW LONDON	Display/ Display Enhancer	Budweiser	1	3/11/2026 6:49 AM	2026-03-17 14:10:31.444548
1432	lnorton	MARKET BASKET #71 BEDFORD	Display/ Display Enhancer	Super Coffee	1	3/5/2026 2:24 PM	2026-03-17 14:10:31.457725
1433	pwollert	T-BIRD MINI MART - SWANZEY MONADNOCK HIGHWAY #676	Display/ Display Enhancer	Nutrl	1	3/5/2026 1:28 PM	2026-03-17 14:10:31.460279
1434	pbelanger	SHAW'S #4694 - PETERBORO	Display/ Display Enhancer	Sparkling Ice	1	3/5/2026 11:58 AM	2026-03-17 14:10:31.462441
1435	bgermano	T-BIRD MINI MART - W. SWANZEY	Display/ Display Enhancer	Mich Ultra	1	3/5/2026 8:28 AM	2026-03-17 14:10:31.465268
1437	rconstant	SHAW'S #0484 - LONDERRY	Display/ Display Enhancer	Ryse Fuel	1	3/2/2026 11:36 AM	2026-03-17 14:10:31.47124
1438	jcaron	MARKET BASKET #39 NASHUA - NORTHWEST BLVD	Display/ Display Enhancer	Wormtown - Irish Red	1	3/1/2026 3:52 PM	2026-03-17 14:10:31.473775
1439	jcaron	MARKET BASKET #39 NASHUA - NORTHWEST BLVD	Display/ Display Enhancer	Nutrl Lime	1	3/1/2026 3:52 PM	2026-03-17 14:10:31.476259
1440	jcaron	MARKET BASKET #39 NASHUA - NORTHWEST BLVD	Display/ Display Enhancer	Murphy's Irish	1	3/1/2026 3:52 PM	2026-03-17 14:10:31.479193
1441	tchagnon	RIVER ROAD TAVERN	Display/ Display Enhancer	Able - Auburn	1	2/26/2026 2:15 PM	2026-03-17 14:10:31.481589
1442	pwollert	T-BIRD MINI MART - SWANZEY MONADNOCK HIGHWAY #676	Display/ Display Enhancer	Devils BB - Vrty	1	2/26/2026 12:28 PM	2026-03-17 14:10:31.484287
1444	pwollert	SHAW'S #3533 - WALPOLE	Display/ Display Enhancer	Busch Light	1	2/26/2026 12:25 PM	2026-03-17 14:10:31.489892
1446	jmeharg	SHAW'S #4514 - HILLSBORO	Display/ Display Enhancer	Ryse Fuel	1	2/19/2026 10:27 AM	2026-03-17 14:10:31.495498
1448	eplatt	MARKET BASKET #25 PLAISTOW	Display/ Display Enhancer	Popwell	1	2/12/2026 1:21 PM	2026-03-17 14:10:31.500925
1451	tchagnon	SHAW'S #0678 - MERRIMACK - CONTINENTAL	Display/ Display Enhancer	Bud Light	1	2/11/2026 2:18 PM	2026-03-17 14:10:31.50991
1452	jcaron	SHAW'S #2492 - MILFORD	Display/ Display Enhancer	Budweiser	1	2/11/2026 2:00 PM	2026-03-17 14:10:31.513227
1453	tchagnon	SHAW'S #3505 - MERRIMACK - DWH	Display/ Display Enhancer	Bud Light	1	2/11/2026 1:38 PM	2026-03-17 14:10:31.516148
1455	jcaron	SHAW'S #2492 - MILFORD	Display/ Display Enhancer	Athletic - All Out	1	2/11/2026 10:12 AM	2026-03-17 14:10:31.521401
1456	jcaron	MARKET BASKET #39 NASHUA - NORTHWEST BLVD	Display/ Display Enhancer	Athletic - All Out	1	2/11/2026 10:12 AM	2026-03-17 14:10:31.523986
1457	jcaron	MARKET BASKET #39 NASHUA - NORTHWEST BLVD	Display/ Display Enhancer	Bud Light	1	2/11/2026 10:12 AM	2026-03-17 14:10:31.52682
1458	jcaron	SHAW'S #2492 - MILFORD	Display/ Display Enhancer	Bud Light	2	2/11/2026 10:12 AM	2026-03-17 14:10:31.52957
1463	jaustin	BIG DEAL - KEENE	Display/ Display Enhancer	Bud Light	1	2/9/2026 2:37 PM	2026-03-17 14:10:31.541865
1464	rconstant	CIRCLE K #7261 - HUDSON	Display/ Display Enhancer	Bud Light	1	2/9/2026 12:40 PM	2026-03-17 14:10:31.544244
1469	bgermano	CRAFT MARKET AT RIVERSIDE	Display/ Display Enhancer	Johny Bootlegger	1	2/5/2026 8:42 AM	2026-03-17 14:10:31.557338
1470	jgiuffrida	MARKET BASKET #06 SALEM	Display/ Display Enhancer	Budweiser	1	2/4/2026 3:21 PM	2026-03-17 14:10:31.560034
1449	jmeharg	SHAW'S #4514 - HILLSBORO	Display/ Display Enhancer	Bud Light	4	2/12/2026 10:44 AM	2026-03-17 19:05:55.749876
1450	bgermano	PRICE CHOPPER #208 - KEENE	Display/ Display Enhancer	Bud Light	14	2/12/2026 9:49 AM	2026-03-17 19:05:55.753109
1454	jaustin	TROY DELI & MARKET PLACE	Display/ Display Enhancer	Bud Light	2	2/11/2026 11:50 AM	2026-03-17 19:05:55.756157
1459	pwollert	KEENE DISCOUNT MART	Display/ Display Enhancer	Bud Light	3	2/10/2026 3:36 PM	2026-03-17 19:05:55.75901
1460	jaustin	GET-N-GO	Display/ Display Enhancer	Bud Light	2	2/10/2026 11:10 AM	2026-03-17 19:05:55.761693
1461	jaustin	RIVERSIDE GROCERY	Display/ Display Enhancer	Bud Light	5	2/10/2026 11:10 AM	2026-03-17 19:05:55.764892
1462	bgermano	PRICE CHOPPER #208 - KEENE	Display/ Display Enhancer	Budweiser	2	2/9/2026 3:10 PM	2026-03-17 19:05:55.767626
1465	jaustin	T-BIRD MINI MART - HINSDALE	Display/ Display Enhancer	Bud Light	5	2/9/2026 11:42 AM	2026-03-17 19:05:55.770083
1466	pwollert	SHAW'S #3533 - WALPOLE	Display/ Display Enhancer	Bud Light	11	2/9/2026 11:40 AM	2026-03-17 19:05:55.773076
1467	rconstant	SHAW'S #0484 - LONDERRY	Display/ Display Enhancer	Bud Light	3	2/9/2026 10:48 AM	2026-03-17 19:05:55.775869
1468	pwollert	SHAW'S #3533 - WALPOLE	Display/ Display Enhancer	Budweiser	5	2/5/2026 10:20 AM	2026-03-17 19:05:55.778304
1474	eplatt	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Super Coffee	1	1/29/2026 1:43 PM	2026-03-17 14:10:31.570959
1475	bgermano	WAL-MART #3549 - KEENE	Display/ Display Enhancer	Mich Ultra	1	1/29/2026 12:50 PM	2026-03-17 14:10:31.573679
1484	eplatt	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Good 2 grow	1	1/19/2026 9:48 AM	2026-03-17 14:10:31.610984
1485	bgermano	MARKET BASKET #64 SWANZEY	Display/ Display Enhancer	Sparkling Ice	1	1/19/2026 9:40 AM	2026-03-17 14:10:31.614938
1486	pbelanger	SHAW'S #4694 - PETERBORO	Display/ Display Enhancer	Budweiser	1	1/15/2026 1:03 PM	2026-03-17 14:10:31.617783
1471	rconstant	SHAW'S #0484 - LONDERRY	Display/ Display Enhancer	Mich Ultra	2	2/2/2026 11:51 AM	2026-03-17 19:05:55.780888
1491	sshaunessy	HANNAFORD #8186 - NASHUA	Display/ Display Enhancer	Sparkling Ice	1	1/8/2026 11:34 AM	2026-03-17 14:10:31.633958
1492	sshaunessy	SUNNYSIDE STOP	Display/ Display Enhancer	BeatBox Vrty	1	1/8/2026 8:46 AM	2026-03-17 14:10:31.636807
1493	jgrumblatt	SHAW'S #4534 - NEWPORT	Display/ Display Enhancer	Bud Light	1	1/8/2026 7:55 AM	2026-03-17 14:10:31.639114
1497	tchagnon	SHAW'S #0678 - MERRIMACK - CONTINENTAL	Display/ Display Enhancer	Sparkling Ice	1	1/7/2026 8:54 AM	2026-03-17 14:10:31.650273
1498	pbelanger	MR MIKE'S - FITZWILLIAM	Display/ Display Enhancer	Johny Bootlegger	1	1/6/2026 4:18 PM	2026-03-17 14:10:31.652888
1499	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	Mich Ultra	1	1/6/2026 3:50 PM	2026-03-17 14:10:31.655314
1500	pbelanger	ALLTOWN MARKET #200311- PETERBOROUGH	Display/ Display Enhancer	Johny Bootlegger	1	1/6/2026 3:05 PM	2026-03-17 14:10:31.657872
1501	pbelanger	MR MIKE'S - JAFFREY	Display/ Display Enhancer	Johny Bootlegger	1	1/6/2026 3:05 PM	2026-03-17 14:10:31.660664
1502	jaustin	ALLTOWN MARKET 202767- WINCHESTER	Display/ Display Enhancer	Johny Bootlegger	1	1/6/2026 1:33 PM	2026-03-17 14:10:31.66333
1503	jaustin	T-BIRD MINI MART - HINSDALE	Display/ Display Enhancer	Mich Ultra	1	1/5/2026 9:38 AM	2026-03-17 14:10:31.666064
1504	pbelanger	SHAW'S #4694 - PETERBORO	Display/ Display Enhancer	Bud Light	1	12/31/2025 1:21 PM	2026-03-17 14:10:31.669081
1505	bgermano	WAL-MART #3549 - KEENE	Display/ Display Enhancer	Sparkling Ice	1	12/31/2025 8:32 AM	2026-03-17 14:10:31.671256
1506	lortiz	SHAW'S #3510 - NASHUA - ROYAL RIDGE	Display/ Display Enhancer	Super Coffee	1	12/30/2025 3:50 PM	2026-03-17 14:10:31.673832
1507	maanderson	JUKK INC	Display/ Display Enhancer	Johny Bootlegger	1	12/29/2025 9:13 AM	2026-03-17 14:10:31.676089
1508	maanderson	JUKK INC	Display/ Display Enhancer	BeatBox Vrty	1	12/29/2025 9:13 AM	2026-03-17 14:10:31.678671
1510	pwollert	T-BIRD MINI MART - SWANZEY MONADNOCK HIGHWAY #676	Display/ Display Enhancer	Bud Light	1	12/23/2025 1:46 PM	2026-03-17 14:10:31.683907
1511	eplatt	PLAISTOW MINI EXPRESS	Display/ Display Enhancer	Good 2 grow	1	12/21/2025 1:48 PM	2026-03-17 14:10:31.687012
1513	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Display/ Display Enhancer	Bud Light	1	12/18/2025 10:18 AM	2026-03-17 14:10:31.692432
1514	eleahy	50 EAST DERRY ROAD CONVENIENCE	Display/ Display Enhancer	Good 2 grow	1	12/17/2025 4:02 PM	2026-03-17 14:10:31.695141
1516	jmeharg	ZOOMIES CORNER MARKET	Display/ Display Enhancer	Good 2 grow	1	12/16/2025 12:18 PM	2026-03-17 14:10:31.70001
1518	sshaunessy	SUPER SHELL FOOD MART #1128 - HARRIS RD - NASHUA	Display/ Display Enhancer	Good 2 grow	1	12/11/2025 11:15 AM	2026-03-17 14:10:31.705781
1519	sshaunessy	MAIN DUNSTABLE SHELL #1124	Display/ Display Enhancer	Good 2 grow	1	12/11/2025 8:44 AM	2026-03-17 14:10:31.707942
1520	sshaunessy	A & P CORNER MARKET LLC	Display/ Display Enhancer	Good 2 grow	1	12/10/2025 4:08 PM	2026-03-17 14:10:31.710751
1521	sshaunessy	DIYA MART	Display/ Display Enhancer	Good 2 grow	1	12/10/2025 10:28 AM	2026-03-17 14:10:31.712997
1522	sshaunessy	AMHERST STREET SHELL #1123 - 190 AMHERST - NASHUA	Display/ Display Enhancer	Good 2 grow	1	12/10/2025 9:45 AM	2026-03-17 14:10:31.715855
1523	pbelanger	ALLTOWN MARKET #200311- PETERBOROUGH	Display/ Display Enhancer	Good 2 grow	1	12/9/2025 3:36 PM	2026-03-17 14:10:31.718973
1525	jgrumblatt	JAKES MARKET AND DELI - GEORGES MILLS	Display/ Display Enhancer	Good 2 grow	1	12/9/2025 10:41 AM	2026-03-17 14:10:31.724465
1526	sshaunessy	BROAD ST. PETROLEUM LLC	Display/ Display Enhancer	Good 2 grow	1	12/9/2025 9:43 AM	2026-03-17 14:10:31.727101
1527	jgrumblatt	JAKES MARKET AND DELI- NEW LONDON	Display/ Display Enhancer	Good 2 grow	1	12/9/2025 8:53 AM	2026-03-17 14:10:31.729451
1472	jsewall	DISCOUNT BEVERAGE KING W. LEB	Display/ Display Enhancer	Mich Ultra	2	2/2/2026 10:35 AM	2026-03-17 19:05:55.783544
1473	jgiuffrida	MARKET BASKET #06 SALEM	Display/ Display Enhancer	Mich Ultra	3	1/29/2026 2:11 PM	2026-03-17 19:05:55.786413
1476	bgermano	MARKET BASKET #64 SWANZEY	Display/ Display Enhancer	Bud Light	13	1/29/2026 12:50 PM	2026-03-17 19:05:55.789282
1477	pwollert	STATELINE GROCERY	Display/ Display Enhancer	Mich Ultra	2	1/29/2026 11:02 AM	2026-03-17 19:05:55.791731
1478	pwollert	STATELINE GROCERY	Display/ Display Enhancer	Bud Light	5	1/29/2026 11:02 AM	2026-03-17 19:05:55.794529
1479	jaustin	WEST CHESTERFIELD SHELL #200643	Display/ Display Enhancer	Bud Light	4	1/27/2026 9:16 AM	2026-03-17 19:05:55.798249
1480	jmeharg	MOBIL ON THE RUN #200626 - HENNIKER	Display/ Display Enhancer	Good 2 grow	3	1/25/2026 8:41 AM	2026-03-17 19:05:55.800857
1481	lnorton	MARKET BASKET #71 BEDFORD	Display/ Display Enhancer	Bud Light	4	1/22/2026 12:53 PM	2026-03-17 19:05:55.804066
1482	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Bud Light	7	1/21/2026 7:20 AM	2026-03-17 19:05:55.806585
1483	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Athletic - Run Wild	3	1/21/2026 7:20 AM	2026-03-17 19:05:55.809636
1487	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Display/ Display Enhancer	Sparkling Ice	2	1/15/2026 12:04 PM	2026-03-17 19:05:55.812152
1488	jgrumblatt	SHAW'S #4534 - NEWPORT	Display/ Display Enhancer	Sparkling Ice	2	1/15/2026 11:43 AM	2026-03-17 19:05:55.814867
1489	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Athletic - Free Wave	2	1/14/2026 3:04 PM	2026-03-17 19:05:55.817637
1494	jgiuffrida	MARKET BASKET #31 SALEM	Display/ Display Enhancer	Bud Light	4	1/7/2026 1:51 PM	2026-03-17 19:05:55.821058
1495	jaustin	MINUTE MART	Display/ Display Enhancer	Bud Light	3	1/7/2026 12:16 PM	2026-03-17 19:05:55.823654
1496	jaustin	TROY DELI & MARKET PLACE	Display/ Display Enhancer	Mich Ultra	3	1/7/2026 11:42 AM	2026-03-17 19:05:55.826462
1509	bgermano	MARKET BASKET #64 SWANZEY	Display/ Display Enhancer	Budweiser	7	12/24/2025 1:10 PM	2026-03-17 19:05:55.829319
1512	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Display/ Display Enhancer	Good 2 grow	3	12/18/2025 10:22 AM	2026-03-17 19:05:55.832959
1515	jaustin	ALLTOWN MARKET 202767- WINCHESTER	Display/ Display Enhancer	Good 2 grow	2	12/16/2025 3:00 PM	2026-03-17 19:05:55.835737
1517	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	Heineken	2	12/16/2025 9:26 AM	2026-03-17 19:05:55.838716
1524	bgermano	BEAVER STREET MARKET	Display/ Display Enhancer	Good 2 grow	2	12/9/2025 1:55 PM	2026-03-17 19:05:55.842803
1528	sshaunessy	NASHUA SHELL #1127 - 620 AMHERST ST	Display/ Display Enhancer	Good 2 grow	1	12/8/2025 4:10 PM	2026-03-17 14:10:31.732863
1529	sshaunessy	WEST HOLLIS STREET SHELL #1126	Display/ Display Enhancer	Good 2 grow	1	12/8/2025 1:54 PM	2026-03-17 14:10:31.735606
1530	eleahy	SPEEDWAY #46190 - DERRY	Display/ Display Enhancer	Good 2 grow	1	12/8/2025 9:33 AM	2026-03-17 14:10:31.737753
1531	jgrumblatt	CIRCLE K #7247 - ANDOVER	Display/ Display Enhancer	Mich Ultra	1	12/7/2025 10:47 AM	2026-03-17 14:10:31.74003
1533	jaustin	SANDRI STOP MART - KEENE	Display/ Display Enhancer	Good 2 grow	1	12/3/2025 1:52 PM	2026-03-17 14:10:31.744965
1534	jgiuffrida	MARKET BASKET #31 SALEM	Display/ Display Enhancer	Budweiser	1	12/3/2025 1:33 PM	2026-03-17 14:10:31.747714
1535	jaustin	MAIN STREET MINI MART	Display/ Display Enhancer	Good 2 grow	1	12/2/2025 1:31 PM	2026-03-17 14:10:31.750507
1536	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	Ryse Protein	1	12/2/2025 10:15 AM	2026-03-17 14:10:31.752889
1532	ddooling	STATELINE PAYSAVER	Display/ Display Enhancer	Good 2 grow	3	12/4/2025 10:39 AM	2026-03-17 19:05:55.846132
1538	pwollert	JIFFY MART #200691 - WESTMORELAND	Display/ Display Enhancer	Good 2 grow	1	12/1/2025 9:50 AM	2026-03-17 14:10:31.772942
1539	pwollert	JIFFY MART #200459 - WALPOLE	Display/ Display Enhancer	Good 2 grow	1	12/1/2025 9:50 AM	2026-03-17 14:10:31.777295
1540	eleahy	DERRY QUICK MART	Display/ Display Enhancer	Good 2 grow	1	12/1/2025 9:45 AM	2026-03-17 14:10:31.779819
1541	jsewall	HANNAFORD #8266 - W.LEB	Display/ Display Enhancer	Good 2 grow	1	11/26/2025 3:14 PM	2026-03-17 14:10:31.782325
1543	pwollert	STATELINE GROCERY	Display/ Display Enhancer	Good 2 grow	1	11/26/2025 11:17 AM	2026-03-17 14:10:31.78825
1544	pwollert	ALSTEAD GENERAL STORE	Display/ Display Enhancer	Good 2 grow	1	11/25/2025 11:53 AM	2026-03-17 14:10:31.790918
1545	jsewall	TARGET # 3401 - W. LEBANON	Display/ Display Enhancer	Good 2 grow	1	11/25/2025 7:55 AM	2026-03-17 14:10:31.794155
1548	jsewall	DISCOUNT BEVERAGE KING W. LEB	Display/ Display Enhancer	Budweiser	1	11/20/2025 2:10 PM	2026-03-17 14:10:31.803307
1549	jsewall	DISCOUNT BEVERAGE KING W. LEB	Display/ Display Enhancer	Heineken	1	11/20/2025 2:10 PM	2026-03-17 14:10:31.806073
1551	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Display/ Display Enhancer	Stella Artois	1	11/20/2025 10:04 AM	2026-03-17 14:10:31.812258
1552	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Display/ Display Enhancer	Mich Ultra	1	11/20/2025 10:04 AM	2026-03-17 14:10:31.814864
1553	pwollert	T-BIRD MINI MART - SWANZEY MONADNOCK HIGHWAY #676	Display/ Display Enhancer	Budweiser	1	11/20/2025 9:46 AM	2026-03-17 14:10:31.817683
1554	lnorton	MARKET BASKET #71 BEDFORD	Display/ Display Enhancer	Good 2 grow	1	11/19/2025 2:46 PM	2026-03-17 14:10:31.820467
1555	jsewall	MERIDEN DELI MART	Display/ Display Enhancer	Good 2 grow	1	11/19/2025 11:28 AM	2026-03-17 14:10:31.823423
1556	jaustin	MARLBOROUGH FOOD MART	Display/ Display Enhancer	Good 2 grow	1	11/19/2025 11:10 AM	2026-03-17 14:10:31.826315
1542	bgermano	MARKET BASKET #64 SWANZEY	Display/ Display Enhancer	Heineken	2	11/26/2025 1:18 PM	2026-03-17 19:05:55.849367
1561	rconstant	A AND S FOODMART	Display/ Display Enhancer	Good 2 grow	1	11/18/2025 11:00 AM	2026-03-17 14:10:31.840613
1562	eleahy	HOWIE GLYNN & SONS CONVENIENCE	Display/ Display Enhancer	Good 2 grow	1	11/18/2025 10:51 AM	2026-03-17 14:10:31.844001
1564	ddooling	TAVERN IN THE SQUARE SALEM LLC	Display/ Display Enhancer	Gold Road Mango Cart	1	11/17/2025 1:39 PM	2026-03-17 14:10:31.849811
1565	jsewall	NH-VT SMOKE & BEVERAGE OUTLET INC	Display/ Display Enhancer	Downeast - Original	1	11/17/2025 9:23 AM	2026-03-17 14:10:31.851989
1566	lnorton	HANNAFORD #8311 - GOFFSTOWN	Display/ Display Enhancer	Mich Ultra	1	11/13/2025 3:02 PM	2026-03-17 14:10:31.854271
1546	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Good 2 grow	2	11/25/2025 7:22 AM	2026-03-17 19:05:55.852615
1568	jaustin	TROY DELI & MARKET PLACE	Display/ Display Enhancer	Good 2 grow	1	11/12/2025 12:00 PM	2026-03-17 14:10:31.860089
1570	jaustin	RIVERSIDE GROCERY	Display/ Display Enhancer	Good 2 grow	1	11/11/2025 12:34 PM	2026-03-17 14:10:31.86547
1571	jaustin	SANDRI STOP - HINSDALE	Display/ Display Enhancer	Good 2 grow	1	11/10/2025 11:01 AM	2026-03-17 14:10:31.868607
1573	pwollert	SHAW'S #3533 - WALPOLE	Display/ Display Enhancer	Heineken	1	11/6/2025 1:16 PM	2026-03-17 14:10:31.874771
1574	ddooling	BEER STORE LLC (THE) - SALEM	Display/ Display Enhancer	Good 2 grow	1	11/6/2025 12:55 PM	2026-03-17 14:10:31.877072
1575	jaustin	RTE. 63 COUNTRY STORE	Display/ Display Enhancer	Good 2 grow	1	11/6/2025 11:32 AM	2026-03-17 14:10:31.880026
1576	ddooling	CITY LINE MARKET (NEW)	Display/ Display Enhancer	Good 2 grow	1	11/6/2025 11:13 AM	2026-03-17 14:10:31.882643
1578	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Natural Light	1	11/6/2025 8:22 AM	2026-03-17 14:10:31.889125
1581	ddooling	HOWIE GLYNN - DERRY	Display/ Display Enhancer	Good 2 grow	1	11/5/2025 2:52 PM	2026-03-17 14:10:31.898756
1582	ddooling	HOWIE GLYNN - SALEM	Display/ Display Enhancer	Good 2 grow	1	11/5/2025 2:52 PM	2026-03-17 14:10:31.901405
1583	ddooling	SMOKE N BARLEY - SALEM	Display/ Display Enhancer	Good 2 grow	1	11/5/2025 11:48 AM	2026-03-17 14:10:31.90422
1584	ddooling	KEV'S COUNTRY STORE	Display/ Display Enhancer	Good 2 grow	1	11/5/2025 10:38 AM	2026-03-17 14:10:31.906719
1585	ddooling	SALEM CONVENIENCE STORE	Display/ Display Enhancer	Good 2 grow	1	11/5/2025 9:10 AM	2026-03-17 14:10:31.909501
1547	ddooling	SALEM CONVENIENCE STORE	Display/ Display Enhancer	Budweiser	2	11/24/2025 9:58 AM	2026-03-17 19:05:55.85611
1550	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Display/ Display Enhancer	Heineken	2	11/20/2025 10:04 AM	2026-03-17 19:05:55.859334
1557	pwollert	MR MIKE'S - STODDARD	Display/ Display Enhancer	Good 2 grow	2	11/19/2025 10:36 AM	2026-03-17 19:05:55.863054
1559	bgermano	SEVEN ELEV #32504 B- KEENE	Display/ Display Enhancer	Bud Light	2	11/18/2025 11:57 AM	2026-03-17 19:05:55.865725
1560	jaustin	WEST CHESTERFIELD SHELL #200643	Display/ Display Enhancer	Good 2 grow	2	11/18/2025 11:42 AM	2026-03-17 19:05:55.86858
1563	jsewall	FOUR CORNERS GENERAL STORE	Display/ Display Enhancer	Budweiser	2	11/18/2025 10:48 AM	2026-03-17 19:05:55.871906
1569	jmorse	NEWPORT MEAT MARKET	Display/ Display Enhancer	Good 2 grow	5	11/12/2025 8:41 AM	2026-03-17 19:05:55.874706
1572	jaustin	T-BIRD MINI MART - HINSDALE	Display/ Display Enhancer	Good 2 grow	3	11/10/2025 11:01 AM	2026-03-17 19:05:55.877336
1577	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Heineken	2	11/6/2025 8:22 AM	2026-03-17 19:05:55.879882
1579	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Budweiser	2	11/6/2025 8:22 AM	2026-03-17 19:05:55.882872
1580	ddooling	ISLAND POND CONVENIENCE	Display/ Display Enhancer	Good 2 grow	3	11/5/2025 2:53 PM	2026-03-17 19:05:55.885297
1586	jaustin	CARRS STORE (TBIRD DUBLIN)	Display/ Display Enhancer	Good 2 grow	1	11/5/2025 8:26 AM	2026-03-17 14:10:31.912419
1588	jmorse	CIRCLE K #7204 - NEWPORT	Display/ Display Enhancer	Good 2 grow	1	11/5/2025 6:24 AM	2026-03-17 14:10:31.917111
1589	jsewall	SHAWNEE GENERAL STORE	Display/ Display Enhancer	Good 2 grow	1	11/4/2025 2:16 PM	2026-03-17 14:10:31.919258
1590	jsewall	LYME COUNTRY STORE	Display/ Display Enhancer	Good 2 grow	1	11/4/2025 2:16 PM	2026-03-17 14:10:31.921965
1591	jsewall	APPLEKNOCKERS STORE	Display/ Display Enhancer	Good 2 grow	1	11/4/2025 2:14 PM	2026-03-17 14:10:31.924707
1592	rconstant	NUTFIELD COUNTRY STORE	Display/ Display Enhancer	Good 2 grow	1	11/4/2025 11:42 AM	2026-03-17 14:10:31.926944
1593	tchagnon	DW HIGHWAY MOBIL INC	Display/ Display Enhancer	Good 2 grow	1	11/4/2025 11:26 AM	2026-03-17 14:10:31.929661
1596	eleahy	LA CARRETA - DERRY	Display/ Display Enhancer	Bud Light	1	10/29/2025 1:38 PM	2026-03-17 14:10:31.937952
1598	pbelanger	CHA'S GEM SHOP AND CONV	Display/ Display Enhancer	Bud Light	1	10/23/2025 9:41 AM	2026-03-17 14:10:31.944065
1599	jgiuffrida	MARKET BASKET #31 SALEM	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	10/15/2025 12:43 PM	2026-03-17 14:10:31.94648
1600	jgiuffrida	MARKET BASKET #06 SALEM	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	10/15/2025 9:09 AM	2026-03-17 14:10:31.948875
1603	rconstant	SEVEN ELEV #37392 - LONDONDERY - ROCKINGHAM RD	Display/ Display Enhancer	Phorm Energy Blue Blitz	1	10/7/2025 8:37 AM	2026-03-17 14:10:31.957167
1604	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Display/ Display Enhancer	Super Coffee	1	10/2/2025 11:31 AM	2026-03-17 14:10:31.960059
1587	jmorse	SHOP EXPRESS	Display/ Display Enhancer	Good 2 grow	3	11/5/2025 8:03 AM	2026-03-17 19:05:55.887924
1607	rconstant	ALLTOWN #202152 - LONDONDERRY	Display/ Display Enhancer	Good 2 grow	1	9/29/2025 10:05 AM	2026-03-17 14:10:31.967472
1594	jsewall	FOUR CORNERS GENERAL STORE	Display/ Display Enhancer	Good 2 grow	3	11/4/2025 10:33 AM	2026-03-17 19:05:55.890624
1595	jmorse	BIRNEY'S MINI MART	Display/ Display Enhancer	Good 2 grow	2	11/4/2025 10:29 AM	2026-03-17 19:05:55.894078
1597	pbelanger	T-BIRD MINI MART - SWANZEY MONADNOCK HIGHWAY #676	Display/ Display Enhancer	Good 2 grow	2	10/27/2025 2:42 PM	2026-03-17 19:05:55.896749
1611	bgermano	MARKET BASKET #64 SWANZEY	Display/ Display Enhancer	New Belgium - Fat Tire	1	9/25/2025 1:57 PM	2026-03-17 14:10:31.979029
1615	bgermano	PRICE CHOPPER #208 - KEENE	Display/ Display Enhancer	Sparkling Ice	1	9/18/2025 2:07 PM	2026-03-17 14:10:31.990078
1617	jmeharg	SHAW'S #4514 - HILLSBORO	Display/ Display Enhancer	Daily's Cocktails	1	9/10/2025 3:41 PM	2026-03-17 14:10:31.994958
1618	jsewall	TARGET # 3401 - W. LEBANON	Display/ Display Enhancer	Mich Ultra	1	9/9/2025 8:54 AM	2026-03-17 14:10:31.998073
1619	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	9/9/2025 7:57 AM	2026-03-17 14:10:32.000448
1601	jmorse	T-BIRD MINI MART - CLAREMONT-WASHINGTON ST	Display/ Display Enhancer	Good 2 grow	2	10/13/2025 7:34 AM	2026-03-17 19:05:55.899183
1621	eleahy	SHAW'S #3483- DERRY	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	9/4/2025 11:34 AM	2026-03-17 14:10:32.005357
1622	jaustin	DOLLAR GENER #17668 - TROY	Display/ Display Enhancer	Bud Light	1	9/3/2025 10:00 AM	2026-03-17 14:10:32.007816
1623	tchagnon	HAFFNERS- ENERGY NORTH	Display/ Display Enhancer	Ryse Fuel	1	8/29/2025 1:57 PM	2026-03-17 14:10:32.010733
1624	jgrumblatt	MARKET BASKET #53 CLAREMNT	Display/ Display Enhancer	Sparkling Ice	1	8/28/2025 12:50 PM	2026-03-17 14:10:32.012768
1625	jmeharg	U.S. 202 EXPRESS MINI MART INC	Display/ Display Enhancer	Bud Light	1	8/27/2025 9:35 AM	2026-03-17 14:10:32.015085
1626	jmeharg	SHAW'S #4514 - HILLSBORO	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	8/21/2025 1:33 PM	2026-03-17 14:10:32.01773
1628	rconstant	MARKET BASKET #42 LONDERRY	Display/ Display Enhancer	Popwell	1	8/20/2025 10:04 AM	2026-03-17 14:10:32.022707
1602	jmeharg	HANNAFORD #8311 - GOFFSTOWN	Display/ Display Enhancer	Shipyard - Pumpkin Head	2	10/9/2025 11:59 AM	2026-03-17 19:05:55.901426
1606	jmorse	T-BIRD MINI MART - CLAREMONT-CHARLESTOWN RD	Display/ Display Enhancer	Good 2 grow	3	9/30/2025 7:45 AM	2026-03-17 19:05:55.904524
1612	bgermano	MARKET BASKET #64 SWANZEY	Display/ Display Enhancer	Mich Ultra	4	9/25/2025 1:30 PM	2026-03-17 19:05:55.907544
1632	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Bud Light	1	8/13/2025 2:25 PM	2026-03-17 14:10:32.033391
1633	pwollert	MILL VILLAGE CTRY STORE	Display/ Display Enhancer	Cabot	1	8/13/2025 1:41 PM	2026-03-17 14:10:32.035964
1636	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Super Coffee	1	8/13/2025 7:27 AM	2026-03-17 14:10:32.043992
1613	pwollert	RALPH'S SUPERMARKET	Display/ Display Enhancer	Good 2 grow	2	9/24/2025 12:09 PM	2026-03-17 19:05:55.910103
1638	pbelanger	ALLTOWN MARKET 202767- WINCHESTER	Display/ Display Enhancer	Good 2 grow	1	8/12/2025 10:53 AM	2026-03-17 14:10:32.057838
1640	jsewall	STINSON'S VILLAGE STORE	Display/ Display Enhancer	Daily's Cocktails	1	8/11/2025 11:53 AM	2026-03-17 14:10:32.063128
1641	pbelanger	CHA'S GEM SHOP AND CONV	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	8/7/2025 12:18 PM	2026-03-17 14:10:32.0662
1614	jgiuffrida	MARKET BASKET #31 SALEM	Display/ Display Enhancer	Mich Ultra	2	9/23/2025 2:01 PM	2026-03-17 19:05:55.912476
1616	jmeharg	SHAW'S #4514 - HILLSBORO	Display/ Display Enhancer	Popwell	3	9/18/2025 4:36 AM	2026-03-17 19:05:55.915547
1627	jmorse	WAL-MART #1975 - CLAREMONT	Display/ Display Enhancer	Bud Light	2	8/21/2025 10:35 AM	2026-03-17 19:05:55.918347
1634	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Shipyard - Pumpkin Head	3	8/13/2025 10:28 AM	2026-03-17 19:05:55.921491
1635	pbelanger	HANNAFORD #8180 - RINDGE	Display/ Display Enhancer	Super Coffee	2	8/13/2025 9:35 AM	2026-03-17 19:05:55.923728
1639	bgermano	PRICE CHOPPER #208 - KEENE	Display/ Display Enhancer	Shipyard - Pumpkin Head	2	8/11/2025 3:54 PM	2026-03-17 19:05:55.927128
1642	lnorton	MARKET BASKET #71 BEDFORD	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	8/6/2025 12:30 PM	2026-03-17 14:10:32.068679
1644	bgermano	BEAVER STREET MARKET	Display/ Display Enhancer	Natty Daddy	1	8/5/2025 2:06 PM	2026-03-17 14:10:32.082009
1645	pbelanger	MARKET BASKET #47 RINDGE	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	8/1/2025 1:35 PM	2026-03-17 14:10:32.084963
1646	bgermano	MARKET BASKET #64 SWANZEY	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	7/31/2025 3:14 PM	2026-03-17 14:10:32.087406
1643	pbelanger	CHA'S GEM SHOP AND CONV	Display/ Display Enhancer	Good 2 grow	2	8/5/2025 3:51 PM	2026-03-17 19:05:55.929608
1648	jmorse	JIFFY MART #200431 - CLAREMONT	Display/ Display Enhancer	Good 2 grow	1	7/31/2025 6:42 AM	2026-03-17 14:10:32.094399
1649	maanderson	RUSTY LANTER MARKET #0004	Display/ Display Enhancer	Ryse Fuel	1	7/30/2025 10:11 AM	2026-03-17 14:10:32.096606
1654	bgermano	MARKET BASKET #64 SWANZEY	Display/ Display Enhancer	Busch Light	2	7/17/2025 1:15 PM	2026-03-17 19:05:55.931852
1665	ddooling	SALEM CONVENIENCE STORE	Display/ Display Enhancer	Bud Light	3	7/15/2025 11:30 AM	2026-03-17 19:05:55.934501
1652	amartin	HANNAFORD #8183 - HUDSON	Display/ Display Enhancer	Sparkling Ice	1	7/21/2025 12:34 PM	2026-03-17 14:10:32.104115
1653	jmeharg	SHAW'S #4514 - HILLSBORO	Display/ Display Enhancer	NOCA	1	7/21/2025 12:33 PM	2026-03-17 14:10:32.106618
1670	pbelanger	NEW WORLD GAS - RINDGE	Display/ Display Enhancer	Daily's Cocktails	2	7/9/2025 4:43 PM	2026-03-17 19:05:55.937473
1656	jaustin	WAL-MART #1907 - HINSDALE	Display/ Display Enhancer	NOCA	1	7/17/2025 10:20 AM	2026-03-17 14:10:32.114639
1671	sshaunessy	SHAW'S #4694 - PETERBORO	Display/ Display Enhancer	Sparkling Ice	2	7/9/2025 1:54 PM	2026-03-17 19:05:55.940261
1658	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Kona - Big Wave	1	7/16/2025 12:22 PM	2026-03-17 14:10:32.119151
1659	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Nutrl Lemonade Vrty	1	7/16/2025 12:22 PM	2026-03-17 14:10:32.121643
1660	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Mich Ultra	1	7/16/2025 12:22 PM	2026-03-17 14:10:32.124124
1661	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Bud Lt Lime-A-Rita	1	7/16/2025 9:20 AM	2026-03-17 14:10:32.12682
1662	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	NOCA	1	7/16/2025 9:20 AM	2026-03-17 14:10:32.129197
1663	jaustin	SUMMIT STORES - KEENE	Display/ Display Enhancer	NOCA	1	7/15/2025 3:34 PM	2026-03-17 14:10:32.131825
1664	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	NOCA	1	7/15/2025 2:46 PM	2026-03-17 14:10:32.133931
1676	jsewall	APPLEKNOCKERS STORE	Display/ Display Enhancer	Beatbox Hard T	2	7/1/2025 9:15 AM	2026-03-17 19:05:55.942652
1667	rconstant	ALLTOWN #202152 - LONDONDERRY	Display/ Display Enhancer	Beatbox Hard T	1	7/14/2025 12:10 PM	2026-03-17 14:10:32.141761
1680	jmorse	HANNAFORD #8119 - CLAREMNT	Display/ Display Enhancer	Daily's Cocktails	2	6/26/2025 2:29 PM	2026-03-17 19:05:55.945203
1669	bgermano	T-BIRD MINI MART - KEENE	Display/ Display Enhancer	Beatbox Hard T	1	7/10/2025 10:37 AM	2026-03-17 14:10:32.146809
1672	maanderson	R & B SUPERETTE	Display/ Display Enhancer	Johny Bootlegger	1	7/8/2025 11:30 AM	2026-03-17 14:10:32.162442
1673	jsewall	HANNAFORD #8266 - W.LEB	Display/ Display Enhancer	Super Coffee	1	7/3/2025 9:37 AM	2026-03-17 14:10:32.165424
1674	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Nutrl	1	7/2/2025 8:07 AM	2026-03-17 14:10:32.168156
1675	jaustin	SUMMIT STORES - KEENE	Display/ Display Enhancer	Good 2 grow	1	7/1/2025 10:30 AM	2026-03-17 14:10:32.170735
1677	jmeharg	BLACK BIRD MARKET AND DELI	Display/ Display Enhancer	Bud Light	1	7/1/2025 5:50 AM	2026-03-17 14:10:32.175383
1678	jmeharg	HANNAFORD #8311 - GOFFSTOWN	Display/ Display Enhancer	Daily's Cocktails	1	6/30/2025 4:31 AM	2026-03-17 14:10:32.177912
1679	bgermano	T-BIRD MINI MART - KEENE	Display/ Display Enhancer	Good 2 grow	1	6/26/2025 3:11 PM	2026-03-17 14:10:32.18101
1681	amartin	HANNAFORD #8183 - HUDSON	Display/ Display Enhancer	Daily's Cocktails	1	6/26/2025 2:05 PM	2026-03-17 14:10:32.187046
1682	jaustin	WAL-MART #1907 - HINSDALE	Display/ Display Enhancer	Devils BB - Orng Smash	1	6/26/2025 10:13 AM	2026-03-17 14:10:32.189944
1683	jaustin	RTE. 63 COUNTRY STORE	Display/ Display Enhancer	Mas+ by Messi	1	6/26/2025 10:13 AM	2026-03-17 14:10:32.192199
1684	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Stella Artois	1	6/25/2025 3:43 PM	2026-03-17 14:10:32.194369
1685	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	603 Brew - Winni	1	6/25/2025 3:43 PM	2026-03-17 14:10:32.197822
1686	sshaunessy	SHAW'S #4694 - PETERBORO	Display/ Display Enhancer	Mas+ by Messi	1	6/25/2025 12:57 PM	2026-03-17 14:10:32.200441
1687	pwollert	JIFFY MART #200692 - KEENE	Display/ Display Enhancer	Good 2 grow	1	6/24/2025 1:33 PM	2026-03-17 14:10:32.2031
1689	rconstant	SHAW'S #0484 - LONDERRY	Display/ Display Enhancer	Tivoli - Outlaw	1	6/23/2025 10:54 AM	2026-03-17 14:10:32.208045
1690	lortiz	QUICK MART - NASHUA	Display/ Display Enhancer	Good 2 grow	1	6/19/2025 2:56 PM	2026-03-17 14:10:32.210662
1692	pbelanger	CHA'S GEM SHOP AND CONV	Display/ Display Enhancer	Mas+ by Messi	1	6/19/2025 9:54 AM	2026-03-17 14:10:32.216117
1693	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Display/ Display Enhancer	Tivoli - Outlaw	1	6/19/2025 9:46 AM	2026-03-17 14:10:32.218391
1694	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Display/ Display Enhancer	Bud Lt Lime-A-Rita	1	6/19/2025 9:46 AM	2026-03-17 14:10:32.220594
1695	jgrumblatt	BRADFORD MARKET	Display/ Display Enhancer	Mas+ by Messi	1	6/17/2025 3:14 PM	2026-03-17 14:10:32.482441
1696	jsewall	APPLEKNOCKERS STORE	Display/ Display Enhancer	Poland Spring	1	6/17/2025 10:46 AM	2026-03-17 14:10:32.485015
1697	jgrumblatt	SHAW'S #4534 - NEWPORT	Display/ Display Enhancer	Tivoli - Outlaw	1	6/16/2025 10:40 AM	2026-03-17 14:10:32.487921
1698	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Display/ Display Enhancer	Bud Lt Lemon-Ade-Rita	1	6/12/2025 2:32 PM	2026-03-17 14:10:32.49028
1688	rconstant	SHAW'S #0484 - LONDERRY	Display/ Display Enhancer	Bud Lt Lime-A-Rita	2	6/23/2025 10:54 AM	2026-03-17 19:05:55.948311
1691	bgermano	PRICE CHOPPER #208 - KEENE	Display/ Display Enhancer	Mich Ultra	2	6/19/2025 11:01 AM	2026-03-17 19:05:55.950964
1699	pwollert	SHAW'S #3533 - WALPOLE	Display/ Display Enhancer	Tivoli - Outlaw	1	6/12/2025 1:23 PM	2026-03-17 14:10:32.493
1713	ddooling	ISLAND POND CONVENIENCE	Display/ Display Enhancer	Beatbox Hard T	2	5/28/2025 3:34 PM	2026-03-17 19:05:55.953397
1742	jsewall	LYME COUNTRY STORE	Display/ Display Enhancer	Mas+ by Messi	2	4/29/2025 1:46 PM	2026-03-17 19:05:55.957255
1702	lortiz	SHAW'S #3510 - NASHUA - ROYAL RIDGE	Display/ Display Enhancer	Bud Lt Summer Rita	1	6/11/2025 3:21 PM	2026-03-17 14:10:32.500424
1744	pbelanger	T-BIRD MINI MART - SWANZEY MONADNOCK HIGHWAY #676	Display/ Display Enhancer	Mich Ultra	2	4/28/2025 12:26 PM	2026-03-17 19:05:55.96002
1704	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Bud Lt Straw-Ber-Rita	1	6/11/2025 8:15 AM	2026-03-17 14:10:32.505776
1705	pwollert	KEENE DISCOUNT MART	Display/ Display Enhancer	Mas+ by Messi	1	6/10/2025 2:41 PM	2026-03-17 14:10:32.508061
1706	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	Phorm Energy Blue Blitz	1	6/10/2025 12:54 PM	2026-03-17 14:10:32.510386
1707	pwollert	SHAW'S #3533 - WALPOLE	Display/ Display Enhancer	Bud Lt Straw-Ber-Rita	1	6/9/2025 2:33 PM	2026-03-17 14:10:32.513221
1708	rconstant	SHAW'S #0484 - LONDERRY	Display/ Display Enhancer	Nutrl	1	6/9/2025 10:27 AM	2026-03-17 14:10:32.515934
1709	pbelanger	T-BIRD MINI MART - SWANZEY MONADNOCK HIGHWAY #676	Display/ Display Enhancer	Devils BB - Orng Smash	1	6/5/2025 2:45 PM	2026-03-17 14:10:32.51862
1710	jmeharg	NEW HARVESTER MARKET INC	Display/ Display Enhancer	Mas+ by Messi	1	6/4/2025 2:45 PM	2026-03-17 14:10:32.521253
1711	jmeharg	DELAY'S HARVESTER MARKET	Display/ Display Enhancer	Mas+ by Messi	1	6/4/2025 1:01 PM	2026-03-17 14:10:32.524095
1712	sshaunessy	SHAW'S #4694 - PETERBORO	Display/ Display Enhancer	Popwell	1	6/4/2025 10:01 AM	2026-03-17 14:10:32.526169
1714	ddooling	HOWIE GLYNN - DERRY	Display/ Display Enhancer	Beatbox Hard T	1	5/28/2025 3:34 PM	2026-03-17 14:10:32.532659
1754	jmeharg	ANTRIM MARKET	Display/ Display Enhancer	Budweiser	2	4/16/2025 11:40 AM	2026-03-17 19:05:55.962689
1716	jmorse	T-BIRD MINI MART - CLAREMONT-CHARLESTOWN RD	Display/ Display Enhancer	Devils BB - Orng Smash	1	5/27/2025 6:51 AM	2026-03-17 14:10:32.540965
1717	jmorse	T-BIRD MINI MART - CLAREMONT-CHARLESTOWN RD	Display/ Display Enhancer	Beatbox Hard T	1	5/27/2025 6:51 AM	2026-03-17 14:10:32.54484
1718	jmeharg	NEW HARVESTER MARKET INC	Display/ Display Enhancer	Athletic - Free Wave	1	5/22/2025 12:21 PM	2026-03-17 14:10:32.547834
1720	jmorse	JIFFY MART #200431 - CLAREMONT	Display/ Display Enhancer	Devils BB - Orng Smash	1	5/22/2025 9:05 AM	2026-03-17 14:10:32.553672
1721	jmeharg	SHAW'S #4514 - HILLSBORO	Display/ Display Enhancer	Mas+ by Messi	1	5/22/2025 4:58 AM	2026-03-17 14:10:32.556447
1722	jmorse	PLEASANT ST SMOKE & BEER	Display/ Display Enhancer	Links Drinks	1	5/20/2025 1:03 PM	2026-03-17 14:10:32.558982
1723	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	Good Boy J Daly	1	5/20/2025 1:00 PM	2026-03-17 14:10:32.561973
1724	maanderson	R & B SUPERETTE	Display/ Display Enhancer	Beatbox Hard T	1	5/20/2025 11:54 AM	2026-03-17 14:10:32.564462
1725	maanderson	SPIT BROOK MARKET	Display/ Display Enhancer	Beatbox Hard T	1	5/19/2025 12:23 PM	2026-03-17 14:10:32.566942
1726	jgiuffrida	MARKET BASKET #06 SALEM	Display/ Display Enhancer	Bud Light	1	5/18/2025 2:43 PM	2026-03-17 14:10:32.569511
1727	jgrumblatt	CIRCLE K #7247 - ANDOVER	Display/ Display Enhancer	Nutrl	1	5/14/2025 2:10 PM	2026-03-17 14:10:32.572091
1729	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Happy Dad Variety	1	5/14/2025 10:42 AM	2026-03-17 14:10:32.577833
1730	bgermano	BEAVER STREET MARKET	Display/ Display Enhancer	Natural Ice	1	5/13/2025 12:58 PM	2026-03-17 14:10:32.580189
1731	jsewall	LYME COUNTRY STORE	Display/ Display Enhancer	Beatbox Hard T	1	5/13/2025 12:55 PM	2026-03-17 14:10:32.58258
1732	eleahy	PPC KITCHEN & BAR	Display/ Display Enhancer	Budweiser	1	5/7/2025 3:16 PM	2026-03-17 14:10:32.585389
1733	eleahy	PPC KITCHEN & BAR	Display/ Display Enhancer	Bud Light	2	5/7/2025 3:16 PM	2026-03-17 14:10:32.587687
1734	eleahy	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Popwell	1	5/7/2025 2:03 PM	2026-03-17 14:10:32.590028
1735	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Sparkling Ice	1	5/7/2025 12:35 PM	2026-03-17 14:10:32.592813
1737	ddooling	MCKINNON'S MARKET PLACE	Display/ Display Enhancer	Jack's Abby - Banner	1	5/6/2025 2:46 PM	2026-03-17 14:10:32.598088
1738	jgiuffrida	MARKET BASKET #06 SALEM	Display/ Display Enhancer	Dos Equis	2	5/1/2025 1:33 PM	2026-03-17 14:10:32.600595
1739	sshaunessy	COOPER'S HILL	Display/ Display Enhancer	Fiddlehead - IPA	1	4/30/2025 1:52 PM	2026-03-17 14:10:32.603118
1740	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	New Belgium - Juice Force	1	4/30/2025 8:32 AM	2026-03-17 14:10:32.605681
1741	jmorse	CIRCLE K #7204 - NEWPORT	Display/ Display Enhancer	Poland Spring	1	4/30/2025 6:51 AM	2026-03-17 14:10:32.608197
1743	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	Ryse Fuel	1	4/29/2025 12:28 PM	2026-03-17 14:10:32.613213
1745	jmorse	PLEASANT ST MOBIL	Display/ Display Enhancer	Ryse Fuel	1	4/28/2025 5:39 AM	2026-03-17 14:10:32.618037
1746	eleahy	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Bud Lt Straw-Ber-Rita	1	4/25/2025 12:39 PM	2026-03-17 14:10:32.62033
1747	sshaunessy	MARKET BASKET #57 MILFORD	Display/ Display Enhancer	Dos Equis	1	4/24/2025 11:54 AM	2026-03-17 14:10:32.623114
1748	jmorse	JIFFY MART #200431 - CLAREMONT	Display/ Display Enhancer	Deep River	1	4/24/2025 6:29 AM	2026-03-17 14:10:32.625404
1749	pwollert	DREWSVILLE GENERAL STORE	Display/ Display Enhancer	Cabot	1	4/23/2025 1:29 PM	2026-03-17 14:10:32.627953
1750	jmeharg	ANTRIM MARKET	Display/ Display Enhancer	Bud Light	1	4/23/2025 7:44 AM	2026-03-17 14:10:32.630981
1751	jgrumblatt	CIRCLE K #7247 - ANDOVER	Display/ Display Enhancer	Dos Equis	1	4/23/2025 6:51 AM	2026-03-17 14:10:32.633521
1752	jaustin	BIG DEAL - KEENE	Display/ Display Enhancer	Ryse Fuel	1	4/21/2025 6:01 AM	2026-03-17 14:10:32.636446
1753	jgrumblatt	SHAW'S #4534 - NEWPORT	Display/ Display Enhancer	Popwell	1	4/17/2025 1:10 PM	2026-03-17 14:10:32.638923
1755	lnorton	LA VAKA MEXICAN RESTAURANT	Display/ Display Enhancer	Dos Equis	1	4/16/2025 10:49 AM	2026-03-17 14:10:32.644728
1756	jsewall	TARGET # 3401 - W. LEBANON	Display/ Display Enhancer	Mas+ by Messi	1	4/16/2025 8:45 AM	2026-03-17 14:10:32.647078
1758	jmorse	CLAREMONT MOBIL	Display/ Display Enhancer	Ryse Fuel	2	4/10/2025 1:39 PM	2026-03-17 19:05:55.9652
1759	jmorse	HANNAFORD #8119 - CLAREMNT	Display/ Display Enhancer	Ryse Fuel	1	4/10/2025 12:20 PM	2026-03-17 14:10:32.666929
1761	jgiuffrida	MARKET BASKET #06 SALEM	Display/ Display Enhancer	Nutrl	2	4/9/2025 2:39 PM	2026-03-17 14:10:32.672207
1762	jmeharg	SHAW'S #4514 - HILLSBORO	Display/ Display Enhancer	Bud Lt Lime-A-Rita	1	4/7/2025 12:15 PM	2026-03-17 14:10:32.675001
1764	jmorse	WAL-MART #1975 - CLAREMONT	Display/ Display Enhancer	Ryse Fuel	1	4/3/2025 9:25 AM	2026-03-17 14:10:32.681751
1765	pbelanger	CHA'S GEM SHOP AND CONV	Display/ Display Enhancer	Nutrl	1	4/3/2025 9:21 AM	2026-03-17 14:10:32.844103
1766	jmorse	LEO'S ONE STOP	Display/ Display Enhancer	Ryse Fuel	1	4/3/2025 7:06 AM	2026-03-17 14:10:32.846771
1760	jgrumblatt	MARKET BASKET #53 CLAREMNT	Display/ Display Enhancer	Mich Ultra	3	4/10/2025 8:31 AM	2026-03-17 19:05:55.968416
1768	jaustin	MINUTE MART	Display/ Display Enhancer	Mich Ultra	1	4/2/2025 10:38 AM	2026-03-17 14:10:32.854175
1770	jmorse	NEWPORT MEAT MARKET	Display/ Display Enhancer	Ryse Fuel	1	4/2/2025 9:33 AM	2026-03-17 14:10:32.861353
1771	jaustin	MARLBOROUGH CTRY CONVENIENCE	Display/ Display Enhancer	Kona - Big Wave	1	4/2/2025 8:45 AM	2026-03-17 14:10:32.865062
1772	jmorse	SHOP EXPRESS	Display/ Display Enhancer	Ryse Fuel	1	4/2/2025 8:14 AM	2026-03-17 14:10:32.868091
1773	jmorse	PLEASANT ST SMOKE & BEER	Display/ Display Enhancer	Ryse Fuel	1	4/1/2025 1:19 PM	2026-03-17 14:10:32.871791
1774	jmorse	BIRNEY'S MINI MART	Display/ Display Enhancer	Ryse Fuel	1	4/1/2025 9:53 AM	2026-03-17 14:10:32.874949
1775	pwollert	SHAW'S #3533 - WALPOLE	Display/ Display Enhancer	Athletic - Run Wild	1	3/27/2025 1:11 PM	2026-03-17 14:10:32.878708
1776	rconstant	SHAW'S #0484 - LONDERRY	Display/ Display Enhancer	Budweiser	1	3/24/2025 10:36 AM	2026-03-17 14:10:32.881798
1763	jaustin	RTE. 63 COUNTRY STORE	Display/ Display Enhancer	Mich Ultra	2	4/3/2025 3:41 PM	2026-03-17 19:05:55.971926
1769	jaustin	TROY DELI & MARKET PLACE	Display/ Display Enhancer	Budweiser	2	4/2/2025 9:53 AM	2026-03-17 19:05:55.974879
1779	ddooling	MCKINNON'S MARKET PLACE	Display/ Display Enhancer	Sparkling Ice	1	3/18/2025 7:58 AM	2026-03-17 14:10:32.892424
1781	jgrumblatt	MARKET BASKET #53 CLAREMNT	Display/ Display Enhancer	Budweiser	1	3/6/2025 7:01 AM	2026-03-17 14:10:32.898627
1782	jmorse	SUGAR RIVER MARKET & DELI	Display/ Display Enhancer	Bud Light	1	3/5/2025 7:44 AM	2026-03-17 14:10:32.901654
1784	jmorse	PLEASANT ST SMOKE & BEER	Display/ Display Enhancer	Cabot	1	2/18/2025 12:26 PM	2026-03-17 14:10:32.907688
1785	jsewall	SHAWNEE GENERAL STORE	Display/ Display Enhancer	Bud Light	1	2/18/2025 9:14 AM	2026-03-17 14:10:32.91089
1787	jmeharg	T-BIRD MINI MART - ANTRIM	Display/ Display Enhancer	Cabot	1	2/12/2025 4:30 AM	2026-03-17 14:10:32.917791
1788	pwollert	TARGET #2120 - KEENE	Display/ Display Enhancer	Bud Light	1	2/10/2025 1:09 PM	2026-03-17 14:10:32.920761
1780	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	Athletic - Free Wave	2	3/17/2025 9:00 PM	2026-03-17 19:05:55.977813
1790	jmeharg	SHAW'S #4514 - HILLSBORO	Display/ Display Enhancer	Sparkling Ice	1	2/6/2025 4:30 AM	2026-03-17 14:10:32.92952
1791	lortiz	TARGET #1228 - NASHUA - DWH	Display/ Display Enhancer	Sparkling Ice	1	2/5/2025 2:28 PM	2026-03-17 14:10:32.932765
1793	rconstant	HANNAFORD #8185 - LONDERY	Display/ Display Enhancer	Bud Light	1	2/3/2025 9:31 AM	2026-03-17 14:10:32.939494
1794	jmeharg	HANNAFORD #8311 - GOFFSTOWN	Display/ Display Enhancer	Bud Light	1	1/30/2025 11:22 AM	2026-03-17 14:10:32.942912
1783	jgrumblatt	MARKET BASKET #53 CLAREMNT	Display/ Display Enhancer	Bud Light	3	2/20/2025 7:43 AM	2026-03-17 19:05:55.980881
1796	lnorton	MARKET BASKET #71 BEDFORD	Display/ Display Enhancer	Sparkling Ice Caf	1	1/23/2025 12:02 PM	2026-03-17 14:10:32.949451
1786	jgrumblatt	CIRCLE K #7247 - ANDOVER	Display/ Display Enhancer	Bud Light	5	2/12/2025 3:12 PM	2026-03-17 19:05:55.984749
1798	jmorse	NEWPORT MEAT MARKET	Display/ Display Enhancer	Guinness Pretzel Pieces	1	1/22/2025 9:18 AM	2026-03-17 14:10:32.955726
1799	jmorse	PLEASANT ST SMOKE & BEER	Display/ Display Enhancer	Guinness Pretzel Pieces	1	1/21/2025 2:34 PM	2026-03-17 14:10:32.95904
1800	bgermano	CUMBERLAND FM #5425 - KEENE	Display/ Display Enhancer	Bud Light	1	1/21/2025 11:40 AM	2026-03-17 14:10:32.961824
1801	jsewall	APPLEKNOCKERS STORE	Display/ Display Enhancer	Johny Bootlegger	1	1/21/2025 11:28 AM	2026-03-17 14:10:32.96536
1792	lnorton	CIRCLE K #7263 - BEDFORD - WHITE AVE	Display/ Display Enhancer	Tivoli - Outlaw	2	2/3/2025 10:04 AM	2026-03-17 19:05:55.987654
1803	jsewall	HANNAFORD #8266 - W.LEB	Display/ Display Enhancer	Bud Light	1	1/16/2025 9:03 AM	2026-03-17 14:10:32.97192
1804	jmorse	LEO'S ONE STOP	Display/ Display Enhancer	Deep River	1	1/16/2025 7:20 AM	2026-03-17 14:10:32.97419
1805	lortiz	SHAW'S #3510 - NASHUA - ROYAL RIDGE	Display/ Display Enhancer	Sparkling Ice	1	1/15/2025 12:53 PM	2026-03-17 14:10:32.976912
1809	rconstant	SEVEN ELEV #37392 - LONDONDERY - ROCKINGHAM RD	Display/ Display Enhancer	Bud Light	2	1/7/2025 11:32 AM	2026-03-17 19:05:55.990666
1814	jmorse	AR VILLAGE STORE	Display/ Display Enhancer	Good 2 grow	2	12/28/2024 8:55 AM	2026-03-17 19:05:55.993623
1808	lnorton	X-GOLF BEDFORD	Display/ Display Enhancer	Bud Light	1	1/9/2025 2:01 PM	2026-03-17 14:10:32.985412
1810	pwollert	STATELINE GROCERY	Display/ Display Enhancer	Mich Ultra Zero	1	1/6/2025 11:04 AM	2026-03-17 14:10:32.991963
1811	jmeharg	SHAW'S #4514 - HILLSBORO	Display/ Display Enhancer	Deep River	1	1/2/2025 10:16 AM	2026-03-17 14:10:32.995414
1812	lnorton	MARKET BASKET #71 BEDFORD	Display/ Display Enhancer	Mich Ultra	1	12/31/2024 9:38 AM	2026-03-17 14:10:32.998085
1813	lnorton	MARKET BASKET #71 BEDFORD	Display/ Display Enhancer	Athletic - Run Wild	1	12/31/2024 9:38 AM	2026-03-17 14:10:33.001674
1821	jsewall	DISCOUNT BEVERAGE KING W. LEB	Display/ Display Enhancer	Stella Artois	2	12/16/2024 9:26 AM	2026-03-17 19:05:55.998698
1823	jaustin	RIVERSIDE GROCERY	Display/ Display Enhancer	Johny Bootlegger	2	12/10/2024 10:38 AM	2026-03-17 19:05:56.001073
1818	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Display/ Display Enhancer	Good 2 grow	1	12/19/2024 1:19 PM	2026-03-17 14:10:33.018839
1819	sshaunessy	BRADYS BAR AND GRILL	Display/ Display Enhancer	Mich Ultra	1	12/18/2024 3:00 PM	2026-03-17 14:10:33.022413
1820	rconstant	CIRCLE K #7261 - HUDSON	Display/ Display Enhancer	Good 2 grow	1	12/16/2024 10:49 AM	2026-03-17 14:10:33.025907
1822	rconstant	HANNAFORD #8185 - LONDERY	Display/ Display Enhancer	Sparkling Ice	1	12/12/2024 10:41 AM	2026-03-17 14:10:33.032942
1824	bgermano	MARKET BASKET #64 SWANZEY	Display/ Display Enhancer	Downeast - Original	1	12/5/2024 1:27 PM	2026-03-17 14:10:33.039601
1826	bgermano	PRICE CHOPPER #208 - KEENE	Display/ Display Enhancer	Heineken	1	11/27/2024 11:41 AM	2026-03-17 14:10:33.04518
1827	jaustin	WAL-MART #1907 - HINSDALE	Display/ Display Enhancer	Good 2 grow	1	11/21/2024 9:01 AM	2026-03-17 14:10:33.047971
1829	jgrumblatt	CIRCLE K #7247 - ANDOVER	Display/ Display Enhancer	Tivoli - Outlaw	1	11/20/2024 1:54 PM	2026-03-17 14:10:33.05418
1830	pwollert	KEENE DISCOUNT MART	Display/ Display Enhancer	Johny Bootlegger	1	11/19/2024 3:25 PM	2026-03-17 14:10:33.057209
1831	sshaunessy	HAR HAR MAHADEV INC	Display/ Display Enhancer	Athletic - Free Wave	1	11/19/2024 12:13 PM	2026-03-17 14:10:33.060182
1832	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	Good 2 grow	1	11/19/2024 12:09 PM	2026-03-17 14:10:33.062939
1833	lnorton	CIRCLE K #7233 - GOFFSTOWN	Display/ Display Enhancer	Tivoli - Outlaw	1	11/19/2024 9:43 AM	2026-03-17 14:10:33.065668
1834	jaustin	T-BIRD MINI MART - HINSDALE	Display/ Display Enhancer	Heineken	1	11/18/2024 2:53 PM	2026-03-17 14:10:33.06798
1835	jaustin	BIG DEAL - KEENE	Display/ Display Enhancer	Good 2 grow	1	11/18/2024 2:36 PM	2026-03-17 14:10:33.070897
1836	sshaunessy	CIRCLE K #7236 - MILFORD	Display/ Display Enhancer	Tivoli - Outlaw	1	11/18/2024 1:59 PM	2026-03-17 14:10:33.073145
1837	eleahy	SUSHI TIME RESTAURANT	Display/ Display Enhancer	Bud Light	1	11/15/2024 1:36 PM	2026-03-17 14:10:33.076254
1838	pwollert	STATELINE GROCERY	Display/ Display Enhancer	Budweiser	1	11/14/2024 12:19 PM	2026-03-17 14:10:33.078873
1839	pwollert	STATELINE GROCERY	Display/ Display Enhancer	Heineken	1	11/14/2024 12:19 PM	2026-03-17 14:10:33.082131
1840	pwollert	STATELINE GROCERY	Display/ Display Enhancer	Johny Bootlegger	1	11/14/2024 12:08 PM	2026-03-17 14:10:33.08547
1841	lnorton	MARKET BASKET #71 BEDFORD	Display/ Display Enhancer	Heineken	1	11/13/2024 3:23 PM	2026-03-17 14:10:33.088315
1842	ddooling	SALEM CONVENIENCE STORE	Display/ Display Enhancer	Mich Ultra	1	11/13/2024 7:38 AM	2026-03-17 14:10:33.090617
1843	jmorse	CIRCLE K #7204 - NEWPORT	Display/ Display Enhancer	Tivoli - Outlaw	1	11/13/2024 7:05 AM	2026-03-17 14:10:33.093608
1825	lnorton	CIRCLE K #7259 - BEDFORD - TECHNOLOGY DR	Display/ Display Enhancer	Tivoli - Outlaw	2	12/2/2024 10:25 AM	2026-03-17 19:05:56.003531
1846	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	Stella Artois	1	11/12/2024 2:14 PM	2026-03-17 14:10:33.101224
1847	pwollert	CIRCLE K # 7257 - KEENE	Display/ Display Enhancer	Tivoli - Outlaw	1	11/12/2024 12:27 PM	2026-03-17 14:10:33.104002
1828	jgrumblatt	CIRCLE K #7247 - ANDOVER	Display/ Display Enhancer	Budweiser	2	11/20/2024 1:56 PM	2026-03-17 19:05:56.006094
1844	jsewall	PATTERSON GROCERY & DELI	Display/ Display Enhancer	Good 2 grow	4	11/12/2024 3:19 PM	2026-03-17 19:05:56.00947
1850	pbelanger	NEW WORLD GAS - RINDGE	Display/ Display Enhancer	BeatBox Vrty	1	11/6/2024 12:35 PM	2026-03-17 14:10:33.111904
1852	eleahy	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	NOCA - Alcolo	1	11/6/2024 11:25 AM	2026-03-17 14:10:33.117257
1851	eleahy	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Mich Ultra	2	11/6/2024 11:25 AM	2026-03-17 19:05:56.014479
1854	jsewall	CIRCLE K #7246 - W.LEB	Display/ Display Enhancer	Tivoli - Outlaw	2	11/4/2024 11:41 AM	2026-03-17 14:10:33.122363
1855	jsewall	CIRCLE K #7245 - HANOVER	Display/ Display Enhancer	Tivoli - Outlaw	1	11/4/2024 11:40 AM	2026-03-17 14:10:33.125014
1856	rconstant	SHAW'S #0484 - LONDERRY	Display/ Display Enhancer	Heineken	1	11/4/2024 9:33 AM	2026-03-17 14:10:33.136973
1857	jmeharg	CIRCLE K #7230 - HILLSBORO	Display/ Display Enhancer	Tivoli - Outlaw	1	11/4/2024 4:15 AM	2026-03-17 14:10:33.139879
1864	jgiuffrida	AR SMOKE BEER & CIGAR	Display/ Display Enhancer	Super Coffee	2	10/16/2024 1:58 PM	2026-03-17 19:05:56.019702
1867	jaustin	BIG DEAL - KEENE	Display/ Display Enhancer	Johny Bootlegger	2	10/7/2024 3:36 PM	2026-03-17 19:05:56.023632
1860	eleahy	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Athletic - Free Wave	1	10/28/2024 9:00 AM	2026-03-17 14:10:33.151018
1861	pbelanger	NEW WORLD GAS - RINDGE	Display/ Display Enhancer	Johny Bootlegger	1	10/23/2024 12:01 PM	2026-03-17 14:10:33.154456
1862	jaustin	SANDRI STOP - HINSDALE	Display/ Display Enhancer	Johny Bootlegger	1	10/21/2024 1:51 PM	2026-03-17 14:10:33.157704
1873	jaustin	BIG DEAL - SPOFFORD	Display/ Display Enhancer	Johny Bootlegger	4	10/1/2024 1:29 PM	2026-03-17 19:05:56.02865
1866	jaustin	SUMMIT STORES - KEENE	Display/ Display Enhancer	Bud Light	1	10/8/2024 9:43 AM	2026-03-17 14:10:33.180086
1868	rconstant	MARKET BASKET #42 LONDERRY	Display/ Display Enhancer	Nutrl	1	10/3/2024 12:28 PM	2026-03-17 14:10:33.187644
1869	rconstant	MARKET BASKET #42 LONDERRY	Display/ Display Enhancer	Cutwater Variety	1	10/3/2024 12:28 PM	2026-03-17 14:10:33.192465
1870	jgiuffrida	AR SMOKE BEER & CIGAR	Display/ Display Enhancer	Revitalyte	1	10/2/2024 2:10 PM	2026-03-17 14:10:33.646768
1871	sshaunessy	BOWLING ACRES	Display/ Display Enhancer	Bud Light	1	10/2/2024 11:28 AM	2026-03-17 14:10:33.650905
1888	eleahy	MARKET BASKET #25 PLAISTOW	Display/ Display Enhancer	Shipyard - Pumpkin Head	2	9/9/2024 9:01 AM	2026-03-17 19:05:56.031255
1876	lnorton	HANNAFORD #8436 - BEDFORD - KILTON RD	Display/ Display Enhancer	Sparkling Ice	1	9/23/2024 1:26 PM	2026-03-17 14:10:33.665119
1877	jsewall	HANNAFORD #8266 - W.LEB	Display/ Display Enhancer	NOCA - Alcolo	1	9/19/2024 4:19 PM	2026-03-17 14:10:33.667983
1878	eleahy	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Sparkling Ice Energy	1	9/19/2024 12:20 PM	2026-03-17 14:10:33.672704
1879	jgrumblatt	SHAW'S #4534 - NEWPORT	Display/ Display Enhancer	Sparkling Ice Caf	1	9/19/2024 12:09 PM	2026-03-17 14:10:33.67578
1880	pwollert	SHAW'S #3533 - WALPOLE	Display/ Display Enhancer	Sparkling Ice Energy	1	9/19/2024 10:29 AM	2026-03-17 14:10:33.678044
1882	sshaunessy	SHAW'S #4694 - PETERBORO	Display/ Display Enhancer	Sparkling Ice Energy	1	9/18/2024 12:03 PM	2026-03-17 14:10:33.683857
1884	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Sparkling Ice Energy	1	9/18/2024 8:59 AM	2026-03-17 14:10:33.691106
1885	ddooling	HOWIE GLYNN - WINDHAM - COBBETS RD.	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	9/17/2024 11:10 AM	2026-03-17 14:10:33.694648
1886	eleahy	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Downeast - Original	1	9/11/2024 9:06 AM	2026-03-17 14:10:33.697267
1887	maanderson	TOBACCO JUNCTION - HUDSON	Display/ Display Enhancer	Daily's Cocktails	1	9/10/2024 12:42 PM	2026-03-17 14:10:33.701216
1889	bgermano	HANNAFORD #8163 - KEENE	Display/ Display Enhancer	Downeast - Original	1	9/5/2024 10:44 AM	2026-03-17 14:10:33.706974
1891	jmeharg	SULLY'S SUPERETTE	Display/ Display Enhancer	Johny Bootlegger	1	9/3/2024 7:49 AM	2026-03-17 14:10:33.712551
1892	rconstant	MARKET BASKET #42 LONDERRY	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	8/29/2024 10:34 AM	2026-03-17 14:10:33.715065
1893	rconstant	MARKET BASKET #42 LONDERRY	Display/ Display Enhancer	Bud Light	1	8/29/2024 10:30 AM	2026-03-17 14:10:33.718058
1894	eleahy	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Bud Light	1	8/28/2024 8:40 AM	2026-03-17 14:10:33.720878
1895	jaustin	MARLBOROUGH FOOD MART	Display/ Display Enhancer	Johny Bootlegger	1	8/28/2024 8:36 AM	2026-03-17 14:10:33.723876
1896	jgrumblatt	CIRCLE K #7247 - ANDOVER	Display/ Display Enhancer	Shipyard - Pumpkin Head	2	8/28/2024 7:46 AM	2026-03-17 14:10:33.726305
1897	jgrumblatt	SHAW'S #4534 - NEWPORT	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	8/28/2024 7:36 AM	2026-03-17 14:10:33.729269
1898	jmorse	BIRNEY'S MINI MART	Display/ Display Enhancer	Johny Bootlegger	1	8/27/2024 10:47 AM	2026-03-17 14:10:33.735258
1902	jmorse	CIRCLE K #7240 - GRANTHAM	Display/ Display Enhancer	Good 2 grow	1	8/21/2024 12:53 PM	2026-03-17 14:10:33.748882
1903	jsewall	SHAW'S #4555 - W.LEB	Display/ Display Enhancer	Cutwater Tequila Paloma	1	8/21/2024 8:44 AM	2026-03-17 14:10:33.752209
1907	eleahy	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	8/14/2024 8:18 AM	2026-03-17 14:10:33.763201
1908	eleahy	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Downeast - Overboard	1	8/14/2024 8:18 AM	2026-03-17 14:10:33.769904
1909	jaustin	RIVERSIDE GROCERY	Display/ Display Enhancer	Devils BB - Vrty	1	8/13/2024 12:34 PM	2026-03-17 14:10:33.773403
1911	pwollert	SHAW'S #3533 - WALPOLE	Display/ Display Enhancer	Cutwater Vodka Mule	1	8/12/2024 1:10 PM	2026-03-17 14:10:33.779141
1912	jmorse	MERIDEN DELI MART	Display/ Display Enhancer	Johny Bootlegger	1	8/12/2024 12:09 PM	2026-03-17 14:10:33.781424
1913	jmorse	THE 12% SOLUTION	Display/ Display Enhancer	Johny Bootlegger	1	8/12/2024 10:15 AM	2026-03-17 14:10:33.784726
1914	rconstant	SHAW'S #0484 - LONDERRY	Display/ Display Enhancer	Cutwater Variety	1	8/12/2024 9:51 AM	2026-03-17 14:10:33.787825
1915	jaustin	MAIN STREET MARKETPLACE	Display/ Display Enhancer	Johny Bootlegger	1	8/12/2024 7:31 AM	2026-03-17 14:10:33.790836
1916	jmorse	CLAREMONT MOBIL	Display/ Display Enhancer	Johny Bootlegger	1	8/8/2024 2:26 PM	2026-03-17 14:10:33.793642
1918	jaustin	RTE. 63 COUNTRY STORE	Display/ Display Enhancer	Johny Bootlegger	1	8/8/2024 10:34 AM	2026-03-17 14:10:33.800911
1919	jmorse	HANNAFORD #8119 - CLAREMNT	Display/ Display Enhancer	Stella Artois	1	8/8/2024 10:12 AM	2026-03-17 14:10:33.804753
1920	jmorse	NEWPORT MEAT MARKET	Display/ Display Enhancer	Johny Bootlegger	1	8/7/2024 8:43 AM	2026-03-17 14:10:33.807741
1921	jmorse	SHOP EXPRESS	Display/ Display Enhancer	Johny Bootlegger	1	8/7/2024 8:17 AM	2026-03-17 14:10:33.811143
1922	pwollert	KEENE DISCOUNT MART	Display/ Display Enhancer	Heineken	1	8/6/2024 3:16 PM	2026-03-17 14:10:33.813789
1923	lnorton	SHAW'S #0686 - WINDHAM	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	8/6/2024 11:39 AM	2026-03-17 14:10:33.817682
1924	rconstant	HANNAFORD #8185 - LONDERY	Display/ Display Enhancer	Shipyard - Pumpkin Head	1	7/31/2024 9:41 AM	2026-03-17 14:10:33.820137
1925	pwollert	STATELINE GROCERY	Display/ Display Enhancer	Heineken Silver	1	7/25/2024 11:21 AM	2026-03-17 14:10:33.823248
1926	jsewall	FOUR CORNERS GENERAL STORE	Display/ Display Enhancer	Clubtails	1	7/23/2024 10:48 AM	2026-03-17 14:10:33.825655
1927	jgrumblatt	SHAW'S #4534 - NEWPORT	Display/ Display Enhancer	Deep River	1	7/18/2024 11:36 AM	2026-03-17 14:10:33.828775
1928	rconstant	HANNAFORD #8185 - LONDERY	Display/ Display Enhancer	Ghost Energy	1	7/18/2024 9:22 AM	2026-03-17 14:10:33.831165
1929	sshaunessy	CUMBERLAND FARMS #5450 -NASHUA - AMHERST ST	Display/ Display Enhancer	Beatbox Hard T	1	7/16/2024 2:51 PM	2026-03-17 14:10:33.834246
1931	jmorse	HANNAFORD #8119 - CLAREMNT	Display/ Display Enhancer	Heineken	1	7/11/2024 1:28 PM	2026-03-17 14:10:33.840934
1932	maanderson	R & B SUPERETTE	Display/ Display Enhancer	Daily's Cocktails	1	7/9/2024 10:34 AM	2026-03-17 14:10:33.844
1933	eleahy	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Daily's Cocktails	1	7/3/2024 12:11 PM	2026-03-17 14:10:33.848465
1934	jmeharg	DELAY'S HARVESTER MARKET	Display/ Display Enhancer	Daily's Cocktails	1	7/3/2024 8:23 AM	2026-03-17 14:10:33.851005
1935	lnorton	ENERGY NORTH #2219 - SALEM - N.BROADWAY	Display/ Display Enhancer	Ryse Fuel	1	7/2/2024 1:25 PM	2026-03-17 14:10:33.854234
1936	rconstant	HANNAFORD #8185 - LONDERY	Display/ Display Enhancer	Mich Ultra	1	6/27/2024 9:04 AM	2026-03-17 14:10:33.85711
1939	rconstant	MARKET BASKET #42 LONDERRY	Display/ Display Enhancer	Daily's Cocktails	2	6/26/2024 12:58 PM	2026-03-17 19:05:56.033597
1938	rconstant	HANNAFORD #8185 - LONDERY	Display/ Display Enhancer	Daily's Cocktails	1	6/26/2024 1:25 PM	2026-03-17 14:10:33.862461
1940	jmorse	SHOP EXPRESS	Display/ Display Enhancer	Daily's Cocktails	1	6/26/2024 10:30 AM	2026-03-17 14:10:33.8679
1941	lnorton	SHAW'S #0686 - WINDHAM	Display/ Display Enhancer	Bud Light	1	6/25/2024 4:08 PM	2026-03-17 14:10:33.870943
1942	lnorton	SHAW'S #0686 - WINDHAM	Display/ Display Enhancer	Mich Ultra	1	6/25/2024 4:08 PM	2026-03-17 14:10:33.873599
1963	jmeharg	KAT'S COUNTRY CORNER	Illuminated Sign	Budweiser	2	2/25/2026 2:48 PM	2026-03-17 19:05:56.036454
1944	pbelanger	CHA'S GEM SHOP AND CONV	Display/ Display Enhancer	The Beast - Mean Green	1	6/25/2024 12:43 PM	2026-03-17 14:10:33.87913
1945	jaustin	RIVERSIDE GROCERY	Display/ Display Enhancer	Daily's Cocktails	1	6/25/2024 10:25 AM	2026-03-17 14:10:33.882779
1948	jmeharg	SHAW'S #4514 - HILLSBORO	Display/ Display Enhancer	Kona - Big Wave	1	6/20/2024 7:49 AM	2026-03-17 14:10:33.890817
1949	jaustin	WAL-MART #1907 - HINSDALE	Display/ Display Enhancer	Bud Light	1	6/13/2024 9:26 AM	2026-03-17 14:10:33.894313
1950	eleahy	SHAW'S #3669 - PLAISTOW	Display/ Display Enhancer	Cutwater Mojito	1	6/12/2024 11:14 AM	2026-03-17 14:10:33.896939
1951	tchagnon	MARKET BASKET #33 HUDSON	Glass	Busch Light	1	10/28/2025 2:42 PM	2026-03-17 14:10:33.899723
1952	jsewall	SHAWNEE GENERAL STORE	Glass	Bud Light	1	8/12/2025 2:53 PM	2026-03-17 14:10:33.902123
1953	amartin	BAR	Glass	Bud Light	1	2/17/2025 12:01 PM	2026-03-17 14:10:33.905308
1954	jsewall	LEBANON VILLAGE PIZZA	Glass	Fiddlehead - IPA	1	12/29/2024 1:23 PM	2026-03-17 14:10:33.908379
1958	tchagnon	AMERICAN LEGION POST 100 - PELHAM	Glass	Bud Light	1	6/18/2024 1:42 PM	2026-03-17 14:10:33.920654
1959	bgermano	CRAFT MARKET AT RIVERSIDE	Illuminated Sign	Stella Artois	1	3/12/2026 2:20 PM	2026-03-17 14:10:33.924136
1960	bgermano	CRAFT MARKET AT RIVERSIDE	Illuminated Sign	Kona - Big Wave	1	3/12/2026 2:20 PM	2026-03-17 14:10:33.927964
1961	bgermano	CRAFT MARKET AT RIVERSIDE	Illuminated Sign	Busch Light	1	3/12/2026 2:20 PM	2026-03-17 14:10:33.931912
1962	jmorse	CASA JALISCO BAR & GRILL	Illuminated Sign	Bud Light	1	3/3/2026 1:30 PM	2026-03-17 14:10:33.935258
1964	jsewall	CHILI'S - W.LEB	Illuminated Sign	Bud Light	1	2/19/2026 10:13 AM	2026-03-17 14:10:33.943161
1965	jmorse	MARKET BASKET #53 CLAREMNT	Illuminated Sign	Bud Light	2	2/12/2026 9:44 AM	2026-03-17 14:10:33.946957
1966	bgermano	CRAFT MARKET AT RIVERSIDE	Illuminated Sign	Fiddlehead - IPA	1	2/3/2026 3:00 PM	2026-03-17 14:10:33.9498
1967	bgermano	CRAFT MARKET AT RIVERSIDE	Illuminated Sign	BL Seltzer Variety	1	2/3/2026 3:00 PM	2026-03-17 14:10:33.954146
1968	bgermano	CRAFT MARKET AT RIVERSIDE	Illuminated Sign	Bud Light	1	2/3/2026 3:00 PM	2026-03-17 14:10:33.957794
1969	jmorse	MARKET BASKET #53 CLAREMNT	Illuminated Sign	Fiddlehead - IPA	1	1/29/2026 9:04 AM	2026-03-17 14:10:33.961511
1970	amartin	BACKSTREET BAR & GRILL LLC	Illuminated Sign	Bud Light	1	1/15/2026 2:06 PM	2026-03-17 14:10:33.964495
1971	ddooling	SALEM CONVENIENCE STORE	Illuminated Sign	Budweiser	1	1/7/2026 9:26 AM	2026-03-17 14:10:33.970057
1972	jmeharg	BUFFALO BO'S	Illuminated Sign	Dos Equis	1	12/31/2025 11:37 AM	2026-03-17 14:10:33.973467
1973	sshaunessy	NOURIA ENERGY #1122 - NASH - BROAD ST	Illuminated Sign	Good 2 grow	1	12/8/2025 10:04 AM	2026-03-17 14:10:33.97754
1974	jmorse	CROYDON GENERAL STORE	Illuminated Sign	Bud Light	1	12/3/2025 9:50 AM	2026-03-17 14:10:33.98151
1975	pbelanger	WEST OF THE BORDER	Illuminated Sign	Mich Ultra	1	11/25/2025 12:07 PM	2026-03-17 14:10:33.9842
1976	pbelanger	WEST OF THE BORDER	Illuminated Sign	Bud Light	1	11/25/2025 12:07 PM	2026-03-17 14:10:33.987256
1977	tchagnon	REED'S FERRY MARKET	Illuminated Sign	Mich Ultra	1	11/21/2025 9:52 AM	2026-03-17 14:10:33.99012
1978	pbelanger	NEW WORLD GAS - RINDGE	Illuminated Sign	Bud Light	1	11/19/2025 1:08 PM	2026-03-17 14:10:33.993116
1979	pbelanger	NEW WORLD GAS - RINDGE	Illuminated Sign	Mich Ultra	1	11/19/2025 1:08 PM	2026-03-17 14:10:33.997085
1980	bgermano	SWANZEY NEIGHBOR	Illuminated Sign	Mich Ultra	1	11/18/2025 2:10 PM	2026-03-17 14:10:34.007818
1981	sshaunessy	TJ'S DELI AND CATERING	Illuminated Sign	Mich Ultra	1	11/13/2025 2:02 PM	2026-03-17 14:10:34.01202
1982	tchagnon	REED'S FERRY MARKET	Illuminated Sign	Nutrl	1	11/12/2025 9:02 AM	2026-03-17 14:10:34.014556
1983	tchagnon	BUDGET LUCKY MART	Illuminated Sign	Nutrl	1	11/12/2025 7:01 AM	2026-03-17 14:10:34.017252
1984	jsewall	99 REST - W.LEB	Illuminated Sign	Fiddlehead - IPA	1	10/30/2025 9:17 AM	2026-03-17 14:10:34.019734
1985	tchagnon	MARKET BASKET #33 HUDSON	Illuminated Sign	Nutrl	1	10/24/2025 1:33 PM	2026-03-17 14:10:34.022737
1986	maanderson	AXE PLAY	Illuminated Sign	Nutrl	1	10/22/2025 11:51 AM	2026-03-17 14:10:34.0251
1987	jmorse	IMPERIAL BUFFET & LOUNGE	Illuminated Sign	Mich Ultra	1	10/14/2025 11:23 AM	2026-03-17 14:10:34.027377
1991	maanderson	GOLDEN DRAGON RESTAURANT	Illuminated Sign	Budweiser	1	9/3/2025 1:43 PM	2026-03-17 14:10:34.03729
1992	pwollert	STATELINE GROCERY	Illuminated Sign	Fiddlehead - IPA	1	8/28/2025 2:40 PM	2026-03-17 14:10:34.039485
1993	jgiuffrida	PENALTY BOX BAR & GRILL	Illuminated Sign	Bud Light	1	8/18/2025 12:33 PM	2026-03-17 14:10:34.041734
2002	jmorse	RANCHO VIEJO MEXICAN FOOD AND CANTINA	Illuminated Sign	Dos Equis	2	5/13/2025 1:31 PM	2026-03-17 19:05:56.040025
1995	jgiuffrida	PAR28	Illuminated Sign	Bud Light	1	8/7/2025 4:00 PM	2026-03-17 14:10:34.047278
1996	pbelanger	STATELINE GROCERY'S	Illuminated Sign	Fiddlehead - IPA	1	7/21/2025 1:19 PM	2026-03-17 14:10:34.049798
1997	jgiuffrida	PAR28	Illuminated Sign	Stella Artois	1	6/26/2025 3:13 PM	2026-03-17 14:10:34.052625
1998	pbelanger	MARKET BASKET #47 RINDGE	Illuminated Sign	Fiddlehead - IPA	1	6/25/2025 2:13 PM	2026-03-17 14:10:34.055093
1999	pbelanger	JM NORTH OF THE BORDER	Illuminated Sign	Fiddlehead - IPA	1	6/25/2025 12:19 PM	2026-03-17 14:10:34.057605
2000	pbelanger	VFW SOCIAL CLUB	Illuminated Sign	Budweiser	1	6/9/2025 1:46 PM	2026-03-17 14:10:34.060111
2001	tchagnon	AMERICAN LEGION POST 100 - PELHAM	Illuminated Sign	Nutrl	1	5/14/2025 2:51 PM	2026-03-17 14:10:34.062419
2003	jmorse	CASA JALISCO BAR & GRILL	Illuminated Sign	Dos Equis	1	5/13/2025 11:21 AM	2026-03-17 14:10:34.067377
2004	pbelanger	JM NORTH OF THE BORDER	Illuminated Sign	Mich Ultra	1	5/7/2025 11:29 AM	2026-03-17 14:10:34.070005
2006	jmeharg	KAT'S COUNTRY CORNER	Illuminated Sign	Hoop Tea	1	4/22/2025 4:55 AM	2026-03-17 14:10:34.075439
2007	jmeharg	KAT'S COUNTRY CORNER	Illuminated Sign	Dos Equis	1	4/22/2025 4:55 AM	2026-03-17 14:10:34.078162
2008	jmeharg	KAT'S COUNTRY CORNER	Illuminated Sign	Mich Ultra	1	4/16/2025 1:23 PM	2026-03-17 14:10:34.080734
2009	jmeharg	KAT'S COUNTRY CORNER	Illuminated Sign	Nutrl	1	4/16/2025 1:23 PM	2026-03-17 14:10:34.08322
2010	jmeharg	KAT'S COUNTRY CORNER	Illuminated Sign	Busch Light	1	4/16/2025 1:23 PM	2026-03-17 14:10:34.086343
2011	jsewall	APPLEBEES - W.LEB #6732	Illuminated Sign	Mich Ultra	1	4/16/2025 10:32 AM	2026-03-17 14:10:34.090077
2012	rconstant	99 REST - LONDONDERRY	Illuminated Sign	Budweiser	1	4/7/2025 12:32 PM	2026-03-17 14:10:34.092662
2013	jmorse	PLEASANT ST SMOKE & BEER	Illuminated Sign	Mich Ultra	1	3/10/2025 11:42 AM	2026-03-17 14:10:34.095328
2014	jmorse	KJ'S PIZZA & SUBS	Illuminated Sign	Bud Light	1	3/7/2025 12:44 PM	2026-03-17 14:10:34.097765
2016	rconstant	PROFESSOR SPORTS PUB	Illuminated Sign	Mich Ultra	1	2/27/2025 2:06 PM	2026-03-17 14:10:34.103241
2017	jmorse	SUGAR RIVER MARKET & DELI	Illuminated Sign	Mich Ultra	1	2/19/2025 8:35 AM	2026-03-17 14:10:34.10592
2018	bgermano	CHESHIRE VILLAGE PIZZA	Illuminated Sign	Bud Light	1	1/20/2025 3:58 PM	2026-03-17 14:10:34.108351
2019	jsewall	LEBANON VILLAGE PIZZA	Illuminated Sign	Fiddlehead - IPA	1	1/2/2025 12:41 PM	2026-03-17 14:10:34.11066
2020	tchagnon	AMERICAN LEGION POST 100 - PELHAM	Illuminated Sign	Budweiser	1	12/5/2024 4:11 PM	2026-03-17 14:10:34.112938
2021	tchagnon	KELARI TAVERNA & BAR	Illuminated Sign	Bud Light	1	12/5/2024 1:53 PM	2026-03-17 14:10:34.115425
2022	jgrumblatt	MARKET BASKET #53 CLAREMNT	Illuminated Sign	Mich Ultra	1	11/27/2024 11:23 AM	2026-03-17 14:10:34.117979
2023	jaustin	BRICKHOUSE PIZZA & WINGS	Illuminated Sign	Bud Light	1	10/31/2024 3:41 PM	2026-03-17 14:10:34.120374
2005	jsewall	APPLEBEES - W.LEB #6732	Illuminated Sign	Fiddlehead - IPA	2	5/1/2025 2:06 PM	2026-03-17 19:05:56.043776
2025	jgrumblatt	SALT HILL PUB - NEWPORT	Illuminated Sign	Fiddlehead - IPA	1	10/17/2024 1:43 PM	2026-03-17 14:10:34.125283
2027	rconstant	HUDSONS NORTH SIDE GRILLE	Illuminated Sign	Budweiser	1	10/3/2024 12:55 PM	2026-03-17 14:10:34.131268
2015	jmorse	RANCHO VIEJO MEXICAN FOOD AND CANTINA	Illuminated Sign	Bud Light	2	3/4/2025 12:52 PM	2026-03-17 19:05:56.046505
2029	ggage	OLDE TOWNE TAVERN	Illuminated Sign	Bud Light	1	10/1/2024 2:45 PM	2026-03-17 14:10:34.136947
2030	tchagnon	KELARI TAVERNA & BAR	Illuminated Sign	Heineken	1	9/3/2024 3:51 PM	2026-03-17 14:10:34.139292
2031	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Illuminated Sign	Bud Light	1	9/3/2024 12:56 PM	2026-03-17 14:10:34.141827
2032	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Illuminated Sign	Budweiser	1	9/3/2024 12:56 PM	2026-03-17 14:10:34.144229
2026	jmorse	CLAREMONT LODGE OF ELKS	Illuminated Sign	Budweiser	3	10/15/2024 1:59 PM	2026-03-17 19:05:56.04888
2035	maanderson	PINE VALLEY GOLF COURSE	Illuminated Sign	Budweiser	1	8/13/2024 9:53 AM	2026-03-17 14:10:34.151816
2033	jmorse	CLAREMONT LODGE OF ELKS	Illuminated Sign	Bud Light	2	8/27/2024 2:24 PM	2026-03-17 19:05:56.052036
2050	jaustin	GUERRILLA GRILL	Large Tap Marker	Concord Craft - White Mtn White	2	3/11/2026 12:48 PM	2026-03-17 19:05:56.054606
2041	jaustin	AMERICAN LEGION POST 4 - KEENE	Illuminated Sign	Budweiser	1	7/16/2024 3:55 PM	2026-03-17 14:10:34.16835
2043	ddooling	GRANFANALLYS PIZZA PUB	Large Tap Marker	Concord Craft - Safe Space	1	3/12/2026 2:44 PM	2026-03-17 14:10:34.173224
2044	jgiuffrida	RED ROBIN GOURMET BURGERS - SALEM	Large Tap Marker	Gold Road Mango Cart	1	3/12/2026 12:56 PM	2026-03-17 14:10:34.175349
2045	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Henniker - First One Today	1	3/12/2026 11:23 AM	2026-03-17 14:10:34.177704
2046	ddooling	T-BONES - SALEM	Large Tap Marker	Stoneface - IPA	1	3/12/2026 10:26 AM	2026-03-17 14:10:34.180104
2047	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	Henniker - First One Today	1	3/12/2026 9:56 AM	2026-03-17 14:10:34.183286
2048	maanderson	LUK'S BAR & GRILL	Large Tap Marker	Kona - Big Wave	1	3/11/2026 1:52 PM	2026-03-17 14:10:34.18581
2049	scamuso	EVVIVA TRATTORIA - NASHUA	Large Tap Marker	Gold Road Mango Cart	1	3/11/2026 12:55 PM	2026-03-17 14:10:34.188326
2051	rconstant	LA CARRETA - LONDONDERRY	Large Tap Marker	Gold Road Mango Cart	1	3/11/2026 12:27 PM	2026-03-17 14:10:34.193733
2052	sshaunessy	99 REST - NASHUA	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	3/11/2026 11:51 AM	2026-03-17 14:10:34.196324
2053	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Henniker - First One Today	1	3/11/2026 11:23 AM	2026-03-17 14:10:34.200299
2061	ddooling	DERRY SALEM ELKS 2226	Large Tap Marker	New Belgium - Juicy Haze	2	3/10/2026 11:16 AM	2026-03-17 19:05:56.0573
2064	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Kona - Big Wave	2	3/10/2026 7:22 AM	2026-03-17 19:05:56.059927
2076	jaustin	GUERRILLA GRILL	Large Tap Marker	603 Brew - IPA	2	3/5/2026 3:51 PM	2026-03-17 19:05:56.0628
2105	jmeharg	SNACKSHOT CATERING	Large Tap Marker	Kona - Big Wave	2	3/3/2026 11:09 AM	2026-03-17 19:05:56.065261
2059	jmeharg	APPLESEED LAKESIDE REST	Large Tap Marker	Henniker - First One Today	1	3/10/2026 1:39 PM	2026-03-17 14:10:34.216798
2060	tchagnon	THIRSTY MOOSE	Large Tap Marker	Jack's Abby - Porch Fest	1	3/10/2026 12:02 PM	2026-03-17 14:10:34.219218
2062	tchagnon	THIRSTY MOOSE	Large Tap Marker	Downeast - Black Cherry	1	3/10/2026 7:36 AM	2026-03-17 14:10:34.224736
2063	tchagnon	THIRSTY MOOSE	Large Tap Marker	BBCO - Lighthouse	1	3/10/2026 7:36 AM	2026-03-17 14:10:34.227478
2065	sshaunessy	SHORTY'S MEXICAN ROADHOUSE	Large Tap Marker	BBCO - Wizard	1	3/9/2026 4:44 PM	2026-03-17 14:10:34.233011
2066	jsewall	MOLLYS RESTAURANT	Large Tap Marker	Kelsen - Paradigm	1	3/9/2026 3:30 PM	2026-03-17 14:10:34.235804
2067	jsewall	UPPER VALLEY EVENT CENTER	Large Tap Marker	Kona - Big Wave	1	3/9/2026 2:43 PM	2026-03-17 14:10:34.238259
2068	scamuso	NATIONAL CLUB (THE)	Large Tap Marker	Kona - Big Wave	1	3/9/2026 2:22 PM	2026-03-17 14:10:34.240769
2069	jjohnson	JESSE'S STEAKHOUSE	Large Tap Marker	Bells - Two Hearted	1	3/9/2026 2:14 PM	2026-03-17 14:10:34.24395
2070	jgiuffrida	99 REST - SALEM	Large Tap Marker	Kona - Big Wave	1	3/9/2026 9:18 AM	2026-03-17 14:10:34.246245
2071	tchagnon	RIVER ROAD TAVERN	Large Tap Marker	Fiddlehead - White	1	3/5/2026 4:33 PM	2026-03-17 14:10:34.24861
2072	tchagnon	RIVER ROAD TAVERN	Large Tap Marker	Able - Fighting 69th	1	3/5/2026 4:33 PM	2026-03-17 14:10:34.251864
2073	tchagnon	RIVER ROAD TAVERN	Large Tap Marker	Downeast - Apple Pie	1	3/5/2026 4:33 PM	2026-03-17 14:10:34.254275
2074	tchagnon	OTTO PORTLAND	Large Tap Marker	Sea Dog - Blueberry	1	3/5/2026 4:17 PM	2026-03-17 14:10:34.256889
2075	jaustin	KILKENNY PUB - KEENE	Large Tap Marker	Fiddlehead - White	1	3/5/2026 3:51 PM	2026-03-17 14:10:34.259509
2077	jaustin	CLIFFY'S PUB	Large Tap Marker	603 Brew - Irish Hello	1	3/5/2026 3:35 PM	2026-03-17 14:10:34.264994
2078	amartin	LYNN'S 102 TAVERN	Large Tap Marker	Gold Road Mango Cart	1	3/5/2026 3:09 PM	2026-03-17 14:10:34.267754
2079	jaustin	NOBLE RAMEN HOUSE	Large Tap Marker	Fiddlehead - IPA	1	3/5/2026 2:53 PM	2026-03-17 14:10:34.270604
2080	jsewall	MOLLYS RESTAURANT	Large Tap Marker	Jack's Abby - Citrus Wave	1	3/5/2026 2:05 PM	2026-03-17 14:10:34.273275
2081	jgiuffrida	RED ROBIN GOURMET BURGERS - SALEM	Large Tap Marker	Downeast - Prickly Pear	1	3/5/2026 1:57 PM	2026-03-17 14:10:34.275683
2082	jgiuffrida	RED ROBIN GOURMET BURGERS - SALEM	Large Tap Marker	Kona - Big Wave	1	3/5/2026 1:57 PM	2026-03-17 14:10:34.278233
2083	jgiuffrida	SHAKING SEAFOOD	Large Tap Marker	Kona - Big Wave	1	3/5/2026 12:38 PM	2026-03-17 14:10:34.281153
2084	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Bells - Kalamazo	1	3/5/2026 12:05 PM	2026-03-17 14:10:34.283567
2085	ggage	ALAMO TEXAS BAR-B-QUE & TEQUILA BAR	Large Tap Marker	Able - Auburn	1	3/5/2026 10:14 AM	2026-03-17 14:10:34.286423
2086	lnorton	MURPHY'S TAPROOM AND CARRIAGE HOUSE	Large Tap Marker	Founders - Breakfast Stout	1	3/4/2026 4:20 PM	2026-03-17 14:10:34.288758
2087	jcannamucio	JAMISON'S	Large Tap Marker	603 Brew - Pipes & Drums	1	3/4/2026 4:17 PM	2026-03-17 14:10:34.292683
2088	ggage	OLDE TOWNE TAVERN	Large Tap Marker	Mich Ultra	1	3/4/2026 3:50 PM	2026-03-17 14:10:34.295897
2089	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Able - Burn the Ships	1	3/4/2026 3:12 PM	2026-03-17 14:10:34.298289
2090	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Able - Fighting 69th	1	3/4/2026 2:56 PM	2026-03-17 14:10:34.300657
2091	tchagnon	PRESSED CAFE - BEDFORD	Large Tap Marker	Concord Craft - White Mtn White	1	3/4/2026 1:26 PM	2026-03-17 14:10:34.303151
2092	eplatt	PPC KITCHEN & BAR	Large Tap Marker	Epigram - Temptation	1	3/4/2026 12:37 PM	2026-03-17 14:10:34.305953
2093	ddooling	PELHAM STREET BLACK WATER GRILL	Large Tap Marker	Mich Ultra	1	3/4/2026 12:21 PM	2026-03-17 14:10:34.309147
2094	rconstant	COACH STOP	Large Tap Marker	Gold Road Mango Cart	1	3/4/2026 12:01 PM	2026-03-17 14:10:34.311872
2095	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Kona - Big Wave	1	3/4/2026 11:32 AM	2026-03-17 14:10:34.314453
2096	scamuso	TEXAS ROADHOUSE	Large Tap Marker	Kona - Big Wave	1	3/4/2026 11:27 AM	2026-03-17 14:10:34.317082
2097	sshaunessy	99 REST - NASHUA	Large Tap Marker	Kona - Big Wave	1	3/4/2026 9:41 AM	2026-03-17 14:10:34.319466
2115	jsewall	99 REST - W.LEB	Large Tap Marker	Kona - Big Wave	2	3/2/2026 10:31 AM	2026-03-17 19:05:56.067468
2100	jmorse	CASA JALISCO BAR & GRILL	Large Tap Marker	Bud Light	1	3/3/2026 1:30 PM	2026-03-17 14:10:34.327918
2101	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Kona - Big Wave	1	3/3/2026 1:28 PM	2026-03-17 14:10:34.330576
2102	jmorse	RANCHO VIEJO MEXICAN FOOD AND CANTINA	Large Tap Marker	Bud Light	1	3/3/2026 1:18 PM	2026-03-17 14:10:34.333359
2103	ggage	CHRYSANTHI'S	Large Tap Marker	Founders - All Day IPA	1	3/3/2026 12:46 PM	2026-03-17 14:10:34.336743
2104	eleahy	HYLA BROOK ESTATE	Large Tap Marker	603 Brew - Beer Hall	1	3/3/2026 12:32 PM	2026-03-17 14:10:34.339137
2107	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Kona - Big Wave	1	3/3/2026 9:10 AM	2026-03-17 14:10:34.346349
2108	jmorse	AMERICAN LEGION POST 29 - CLAREMONT	Large Tap Marker	Kona - Big Wave	1	3/3/2026 8:37 AM	2026-03-17 14:10:34.349089
2109	tchagnon	THIRSTY MOOSE	Large Tap Marker	Downeast - Apple Pie	1	3/3/2026 8:08 AM	2026-03-17 14:10:34.35171
2110	jcannamucio	ATKINSON RESORT AND COUNTRY CLUB	Large Tap Marker	Stella Artois	1	3/2/2026 4:09 PM	2026-03-17 14:10:34.354357
2111	jjohnson	JESSE'S STEAKHOUSE	Large Tap Marker	Fiddlehead - Hodad	1	3/2/2026 2:13 PM	2026-03-17 14:10:34.357226
2112	jjohnson	SNAX	Large Tap Marker	Elysian Space Dust	1	3/2/2026 1:56 PM	2026-03-17 14:10:34.359604
2113	ddooling	RALPHIE'S CAFE ITALIANO	Large Tap Marker	Gold Road Mango Cart	1	3/2/2026 1:00 PM	2026-03-17 14:10:34.362001
2114	jmeharg	AMERICAN LEGION POST 59 - HILLSBORO	Large Tap Marker	Fiddlehead - IPA	1	3/2/2026 12:16 PM	2026-03-17 14:10:34.364402
2116	ggage	AMERICAN LEGION POST 10 - WILTON	Large Tap Marker	BBCO - Little Wizard	1	3/1/2026 12:47 PM	2026-03-17 14:10:34.369379
2117	rconstant	PROFESSOR SPORTS PUB	Large Tap Marker	Bud Light	1	2/26/2026 4:17 PM	2026-03-17 14:10:34.372294
2118	rconstant	AJ'S SPORTS BAR & GRILL	Large Tap Marker	Budweiser	1	2/26/2026 2:27 PM	2026-03-17 14:10:34.374672
2143	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Downeast - Black Cherry	2	2/23/2026 9:51 AM	2026-03-17 19:05:56.070918
2120	pwollert	DIAMOND PIZZA	Large Tap Marker	Stella Artois	1	2/26/2026 12:35 PM	2026-03-17 14:10:34.380005
2121	jgrumblatt	RAGGED MOUNTAIN	Large Tap Marker	Left Hand - Coconut Milk Stout	1	2/25/2026 2:30 PM	2026-03-17 14:10:34.383075
2122	jsewall	WEATHERVANE - W.LEB	Large Tap Marker	BBCO - Lunar Wizard	1	2/25/2026 2:24 PM	2026-03-17 14:10:34.385826
2167	ddooling	T-BONES - SALEM	Large Tap Marker	von Trapp - Dunkel	2	2/12/2026 11:23 AM	2026-03-17 19:05:56.074749
2124	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Downeast - Apple Pie	1	2/25/2026 1:21 PM	2026-03-17 14:10:34.391466
2171	jaustin	MAIN CRUST CO.	Large Tap Marker	Concord Craft - Safe Space	3	2/11/2026 4:04 PM	2026-03-17 19:05:56.077792
2127	jsewall	POOR THOMS TAVERN	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	2/25/2026 11:59 AM	2026-03-17 14:10:34.400301
2128	sshaunessy	99 REST - NASHUA	Large Tap Marker	Downeast - Pomegranate	1	2/25/2026 11:38 AM	2026-03-17 14:10:34.403007
2129	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	Downeast - Apple Pie	1	2/25/2026 10:13 AM	2026-03-17 14:10:34.40582
2130	maanderson	STROKERS	Large Tap Marker	Shocktop	1	2/24/2026 3:05 PM	2026-03-17 14:10:34.408323
2131	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	Bud Light	1	2/24/2026 2:45 PM	2026-03-17 14:10:34.410964
2132	pwollert	ITALIAN CLUB	Large Tap Marker	Mich Ultra	1	2/24/2026 2:18 PM	2026-03-17 14:10:34.413805
2133	tchagnon	THIRSTY MOOSE	Large Tap Marker	Wormtown - Irish Red	1	2/24/2026 1:30 PM	2026-03-17 14:10:34.416688
2134	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Downeast - Apple Pie	1	2/24/2026 1:12 PM	2026-03-17 14:10:34.419931
2136	jsewall	PEYTON PLACE RESTAURANT	Large Tap Marker	Deciduous - Easier Operator	1	2/24/2026 11:25 AM	2026-03-17 14:10:34.424696
2137	jcannamucio	JAMISON'S	Large Tap Marker	Founders - KBS	1	2/24/2026 10:44 AM	2026-03-17 14:10:34.427392
2138	jcannamucio	JAMISON'S	Large Tap Marker	Lord Hobo - Boomsauce	1	2/24/2026 10:44 AM	2026-03-17 14:10:34.429804
2139	rconstant	TWINS SMOKE SHOP	Large Tap Marker	603 Brew - Mitz RIS	1	2/24/2026 8:43 AM	2026-03-17 14:10:34.432615
2140	jmeharg	PATS PEAK	Large Tap Marker	Henniker - Miles & Miles	1	2/23/2026 4:16 PM	2026-03-17 14:10:34.43531
2141	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Maine Beer Co - Peeper	1	2/23/2026 9:51 AM	2026-03-17 14:10:34.437811
2142	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Maine Beer Co - Another One	1	2/23/2026 9:51 AM	2026-03-17 14:10:34.44038
2144	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	Stoneface - Sunday Sauce	1	2/19/2026 3:33 PM	2026-03-17 14:10:34.446277
2145	ddooling	FIGARO'S MARTINI BAR + KITCHEN	Large Tap Marker	Deciduous - Easier Operator	1	2/19/2026 3:16 PM	2026-03-17 14:10:34.44889
2146	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	Sea Dog - Blueberry	1	2/19/2026 2:59 PM	2026-03-17 14:10:34.451521
2147	tchagnon	RIVER ROAD TAVERN	Large Tap Marker	Epigram - Rowdy House	1	2/19/2026 2:31 PM	2026-03-17 14:10:34.454144
2148	rconstant	PROFESSOR SPORTS PUB	Large Tap Marker	Elysian Space Dust	1	2/19/2026 1:21 PM	2026-03-17 14:10:34.457166
2149	lnorton	MURPHY'S TAPROOM AND CARRIAGE HOUSE	Large Tap Marker	Able - Burn the Ships	1	2/19/2026 1:17 PM	2026-03-17 14:10:34.459668
2150	tchagnon	PRESSED CAFE - BEDFORD	Large Tap Marker	Jack's Abby - House Lager	1	2/18/2026 4:03 PM	2026-03-17 14:10:34.462496
2151	tchagnon	TAVERN IN THE SQUARE BEDFORD LLC	Large Tap Marker	Stoneface - Sunday Sauce	1	2/18/2026 3:52 PM	2026-03-17 14:10:34.464987
2152	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Widowmaker - Return to Dust	1	2/18/2026 2:18 PM	2026-03-17 14:10:34.467605
2153	jcannamucio	KINGSTON VETS CLUB INC	Large Tap Marker	Elysian Space Dust	1	2/18/2026 12:54 PM	2026-03-17 14:10:34.470088
2154	jjohnson	BARK & BEVY CO.	Large Tap Marker	Maine Beer Co - Lunch	1	2/18/2026 11:49 AM	2026-03-17 14:10:34.472549
2155	amartin	SPECTACLE MANAGEMENT INC	Large Tap Marker	New Belgium - Fat Tire	1	2/18/2026 10:43 AM	2026-03-17 14:10:34.475186
2156	rconstant	SMOKE SHACK CAFE	Large Tap Marker	603 Brew - Winni	1	2/17/2026 4:22 PM	2026-03-17 14:10:34.477791
2158	tchagnon	MANCHESTER COUNTRY CLUB	Large Tap Marker	Epigram - Temptation	1	2/17/2026 2:14 PM	2026-03-17 14:10:34.48322
2159	jmeharg	SNACKSHOT CATERING	Large Tap Marker	Able - Burn the Ships	1	2/17/2026 1:35 PM	2026-03-17 14:10:34.485939
2160	tchagnon	THIRSTY MOOSE	Large Tap Marker	BBCO - Little Wizard	1	2/17/2026 12:08 PM	2026-03-17 14:10:34.488917
2161	tchagnon	THIRSTY MOOSE	Large Tap Marker	Concord Craft - Pond Hockey	1	2/17/2026 7:35 AM	2026-03-17 14:10:34.491984
2162	tchagnon	THIRSTY MOOSE	Large Tap Marker	Left Hand - Candy Cane Nitro	1	2/17/2026 7:35 AM	2026-03-17 14:10:34.49447
2163	ddooling	CHILI'S - SALEM	Large Tap Marker	Fiddlehead - IPA	1	2/16/2026 12:09 PM	2026-03-17 14:10:34.500839
2165	jjohnson	JESSE'S STEAKHOUSE	Large Tap Marker	von Trapp - Schwarz	1	2/12/2026 3:12 PM	2026-03-17 14:10:34.506413
2166	scamuso	EL TAPATIO RESTAURANTE MEXICANO LLC	Large Tap Marker	Mich Ultra	1	2/12/2026 2:12 PM	2026-03-17 14:10:34.509804
2168	tchagnon	THIRSTY MOOSE	Large Tap Marker	603 Brew - Irish Hello	1	2/12/2026 11:16 AM	2026-03-17 14:10:34.514667
2169	jmeharg	TOLL BOOTH TAVERN (THE)	Large Tap Marker	603 Brew - Hard Seltzer	1	2/11/2026 4:46 PM	2026-03-17 14:10:34.517493
2170	jmeharg	TOLL BOOTH TAVERN (THE)	Large Tap Marker	Kona - Big Wave	1	2/11/2026 4:43 PM	2026-03-17 14:10:34.519903
2172	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	2/11/2026 4:00 PM	2026-03-17 14:10:34.524718
2173	pwollert	MAMA MCDONOUGH'S IRISH PUB	Large Tap Marker	Downeast - Black Cherry	1	2/11/2026 3:33 PM	2026-03-17 14:10:34.527765
2174	pwollert	MAMA MCDONOUGH'S IRISH PUB	Large Tap Marker	Downeast - Pomegranate	1	2/11/2026 2:06 PM	2026-03-17 14:10:34.530113
2175	pwollert	POUR HOUSE (THE)	Large Tap Marker	Throwback - Cheek Squeezer	1	2/10/2026 3:11 PM	2026-03-17 14:10:34.532474
2176	pwollert	POUR HOUSE (THE)	Large Tap Marker	603 Brew - Winni	1	2/10/2026 3:11 PM	2026-03-17 14:10:34.534855
2194	jsewall	99 REST - W.LEB	Large Tap Marker	Downeast - Blackberry	2	2/5/2026 10:20 AM	2026-03-17 19:05:56.080852
2178	pbelanger	BOWLING ACRES	Large Tap Marker	Henniker - Wrking Man Porter	1	2/10/2026 10:30 AM	2026-03-17 14:10:34.542026
2179	maanderson	PINE VALLEY GOLF COURSE	Large Tap Marker	Downeast - Blackberry	1	2/10/2026 10:03 AM	2026-03-17 14:10:34.544853
2180	jgiuffrida	DREO FOOD AND DRINK	Large Tap Marker	Downeast - Prickly Pear	1	2/9/2026 4:02 PM	2026-03-17 14:10:34.547461
2181	tchagnon	RIVER ROAD TAVERN	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	2/5/2026 4:28 PM	2026-03-17 14:10:34.55145
2182	tchagnon	RIVER ROAD TAVERN	Large Tap Marker	603 Brew - Winni	1	2/5/2026 4:28 PM	2026-03-17 14:10:34.553807
2183	tchagnon	RIVER ROAD TAVERN	Large Tap Marker	von Trapp - Pilsner	1	2/5/2026 4:24 PM	2026-03-17 14:10:34.556211
2184	jaustin	LOCAL BURGER OF KEENE	Large Tap Marker	Gold Road Mango Cart	1	2/5/2026 3:57 PM	2026-03-17 14:10:34.558675
2185	jsewall	MOLLYS RESTAURANT	Large Tap Marker	Concord Craft - Kapital Kolsch	1	2/5/2026 3:39 PM	2026-03-17 14:10:34.561089
2186	jaustin	THE PERCH	Large Tap Marker	BBCO - Lighthouse	1	2/5/2026 3:07 PM	2026-03-17 14:10:34.563348
2187	amartin	LYNN'S 102 TAVERN	Large Tap Marker	Stoneface - IPA	1	2/5/2026 2:46 PM	2026-03-17 14:10:34.566327
2188	amartin	LYNN'S 102 TAVERN	Large Tap Marker	Able - Lady of the Lake	1	2/5/2026 2:46 PM	2026-03-17 14:10:34.571841
2189	jaustin	GUERRILLA GRILL	Large Tap Marker	Elysian Space Dust	1	2/5/2026 1:37 PM	2026-03-17 14:10:34.576025
2190	jaustin	GUERRILLA GRILL	Large Tap Marker	Founders - All Day IPA	1	2/5/2026 1:37 PM	2026-03-17 14:10:34.579049
2191	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Berkshire - Coffehouse Porter	1	2/5/2026 12:50 PM	2026-03-17 14:10:34.58232
2192	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Breck Vanilla Porter	1	2/5/2026 12:50 PM	2026-03-17 14:10:34.585818
2193	rconstant	AJ'S SPORTS BAR & GRILL	Large Tap Marker	Gold Road Mango Cart	1	2/5/2026 12:44 PM	2026-03-17 14:10:34.588154
2196	jaustin	MAIN CRUST CO.	Large Tap Marker	Berkshire - Coffehouse Porter	1	2/4/2026 3:48 PM	2026-03-17 14:10:34.596169
2197	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Zero Gravity - Green State	1	2/4/2026 3:20 PM	2026-03-17 14:10:34.598462
2198	jaustin	BRICKHOUSE PIZZA & WINGS	Large Tap Marker	Mich Ultra	1	2/4/2026 1:49 PM	2026-03-17 14:10:34.601004
2199	ggage	STONECUTTERS PUB	Large Tap Marker	603 Brew - Winni	1	2/4/2026 1:26 PM	2026-03-17 14:10:34.603622
2201	pbelanger	BANTAM GRILL	Large Tap Marker	Tuckerman - Pale Ale	1	2/3/2026 4:27 PM	2026-03-17 14:10:34.608575
2202	jmeharg	APPLESEED LAKESIDE REST	Large Tap Marker	Downeast - Blackberry	1	2/3/2026 3:32 PM	2026-03-17 14:10:34.611381
2203	ddooling	DERRY SALEM ELKS 2226	Large Tap Marker	Fiddlehead - IPA	1	2/3/2026 2:56 PM	2026-03-17 14:10:34.613799
2204	jsewall	WICKED TASTY (CATERING)	Large Tap Marker	Wormtown - Be Hoppy	1	2/3/2026 1:10 PM	2026-03-17 14:10:34.616742
2206	tchagnon	THIRSTY MOOSE	Large Tap Marker	Cigar City - Jai Alai	1	2/3/2026 9:26 AM	2026-03-17 14:10:34.621433
2207	tchagnon	THIRSTY MOOSE	Large Tap Marker	Oskar Blues - Dbl Dales Pale	1	2/3/2026 9:26 AM	2026-03-17 14:10:34.62379
2208	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Henniker - King Misanthrope	1	2/2/2026 4:30 PM	2026-03-17 14:10:34.626274
2210	jmeharg	CHARTWELL'S DINING SERVICES	Large Tap Marker	Captain Eli's	1	2/2/2026 3:48 PM	2026-03-17 14:10:34.631238
2211	jgiuffrida	PAR28	Large Tap Marker	Mich Ultra	1	2/2/2026 1:43 PM	2026-03-17 14:10:34.633392
2212	tchagnon	OTTO PORTLAND	Large Tap Marker	Fiddlehead - IPA	1	2/2/2026 1:31 PM	2026-03-17 14:10:34.636348
2213	tchagnon	OTTO PORTLAND	Large Tap Marker	Deciduous - Easy Operator	1	2/2/2026 1:31 PM	2026-03-17 14:10:34.63862
2214	tchagnon	OTTO PORTLAND	Large Tap Marker	Orono - Tubular	1	2/2/2026 1:31 PM	2026-03-17 14:10:34.641003
2215	tchagnon	OTTO PORTLAND	Large Tap Marker	Able - Lady of the Lake	1	2/2/2026 1:31 PM	2026-03-17 14:10:34.643571
2216	tchagnon	OTTO PORTLAND	Large Tap Marker	603 Brew - Winni	1	2/2/2026 1:31 PM	2026-03-17 14:10:34.646571
2217	jsewall	MOLLYS RESTAURANT	Large Tap Marker	von Trapp - Dunkel	1	2/2/2026 1:17 PM	2026-03-17 14:10:34.649338
2218	jjohnson	SNAX	Large Tap Marker	von Trapp - Schwarz	1	2/2/2026 1:17 PM	2026-03-17 14:10:34.652143
2220	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Large Tap Marker	Mich Ultra	1	2/2/2026 12:08 PM	2026-03-17 14:10:34.657536
2221	tchagnon	TOMAHAWK BUTCHERY & TAVERN (REST)	Large Tap Marker	603 Brew - Winni	1	2/2/2026 11:43 AM	2026-03-17 14:10:34.66001
2222	amartin	SURF RESTAURANT INC	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	1/29/2026 3:06 PM	2026-03-17 14:10:34.662907
2223	amartin	BACKSTREET BAR & GRILL LLC	Large Tap Marker	Able - Burn the Ships	1	1/29/2026 2:06 PM	2026-03-17 14:10:34.665729
2224	ddooling	GRANFANALLYS PIZZA PUB	Large Tap Marker	Henniker - Wrking Man Porter	1	1/29/2026 2:05 PM	2026-03-17 14:10:34.668074
2225	ddooling	GRANFANALLYS PIZZA PUB	Large Tap Marker	Elysian Space Dust	1	1/29/2026 2:05 PM	2026-03-17 14:10:34.670554
2226	jjohnson	HANOVER INN	Large Tap Marker	Athletic - Run Wild	1	1/29/2026 2:04 PM	2026-03-17 14:10:34.672921
2227	jaustin	GUERRILLA GRILL	Large Tap Marker	Concord Craft - Irish Stout	1	1/29/2026 12:47 PM	2026-03-17 14:10:34.675599
2229	jmeharg	PATS PEAK	Large Tap Marker	Concord Craft - White Mtn White	1	1/29/2026 12:00 PM	2026-03-17 14:10:34.681169
2230	pbelanger	WOODBOUND INN	Large Tap Marker	Fiddlehead - IPA	1	1/28/2026 4:23 PM	2026-03-17 14:10:34.683706
2195	pbelanger	PHOENIX SMOKEHOUSE AND TAQUERIA	Large Tap Marker	Fiddlehead - IPA	2	2/4/2026 3:53 PM	2026-03-17 19:05:56.083459
2232	jcannamucio	HENHOUSE BAR & GRILL	Large Tap Marker	Concord Craft - Conquered	1	1/28/2026 3:38 PM	2026-03-17 14:10:34.688772
2233	jcannamucio	JAMISON'S	Large Tap Marker	Citizen Cider - Mimosa Crush	1	1/28/2026 3:06 PM	2026-03-17 14:10:34.691218
2234	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Elysian Space Dust	1	1/28/2026 2:46 PM	2026-03-17 14:10:34.693722
2200	jmeharg	CROTCHED MOUNTAIN SKI AREA	Large Tap Marker	Fiddlehead - Hodad	2	2/4/2026 8:37 AM	2026-03-17 19:05:56.087117
2205	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Downeast - Pomegranate	3	2/3/2026 11:01 AM	2026-03-17 19:05:56.089862
2209	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Mich Ultra	4	2/2/2026 4:28 PM	2026-03-17 19:05:56.093214
2219	jmorse	RAMUNTOS - CLAREMONT	Large Tap Marker	von Trapp - Helles	2	2/2/2026 12:14 PM	2026-03-17 19:05:56.096411
2228	jaustin	GUERRILLA GRILL	Large Tap Marker	Henniker - Flap Jack	3	1/29/2026 12:47 PM	2026-03-17 19:05:56.099595
2235	jaustin	TEMPESTA'S	Large Tap Marker	Maine Beer Co - Lunch	2	1/28/2026 2:42 PM	2026-03-17 19:05:56.102447
2236	jmeharg	CROTCHED MOUNTAIN SKI AREA	Large Tap Marker	Downeast - Prickly Pear	1	1/28/2026 1:15 PM	2026-03-17 14:10:34.698553
2237	jmeharg	DANIEL'S PUB INC	Large Tap Marker	Henniker - King Misanthrope	1	1/28/2026 12:25 PM	2026-03-17 14:10:34.701082
2238	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Citizen Cider - Mimosa Crush	1	1/28/2026 12:02 PM	2026-03-17 14:10:34.70361
2239	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Stoneface - Sunday Sauce	1	1/28/2026 11:24 AM	2026-03-17 14:10:34.706433
2240	ggage	GIORGIO'S RISTORANTE - MILFORD	Large Tap Marker	Mich Ultra	1	1/27/2026 4:30 PM	2026-03-17 14:10:34.709287
2241	pwollert	POUR HOUSE (THE)	Large Tap Marker	Frost - Little Lush	1	1/27/2026 1:50 PM	2026-03-17 14:10:34.71189
2242	pbelanger	WATERHOUSE BISTRO	Large Tap Marker	Founders - Porter	1	1/27/2026 12:46 PM	2026-03-17 14:10:34.714684
2243	ggage	OLDE TOWNE TAVERN	Large Tap Marker	Downeast - Pomegranate	1	1/27/2026 10:58 AM	2026-03-17 14:10:34.718294
2245	pwollert	MADAME SHERRI'S	Large Tap Marker	Sea Dog - Blueberry	1	1/27/2026 9:05 AM	2026-03-17 14:10:34.723721
2246	tchagnon	COMMON MAN - MERRIMACK	Large Tap Marker	Stella Artois	1	1/27/2026 7:53 AM	2026-03-17 14:10:34.727189
2248	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	603 Brew - Winni	1	1/26/2026 2:50 PM	2026-03-17 14:10:34.732577
2249	amartin	SURF RESTAURANT INC	Large Tap Marker	603 Brew - Winni	1	1/22/2026 3:46 PM	2026-03-17 14:10:34.744639
2250	jsewall	MOLLYS RESTAURANT	Large Tap Marker	Kelsen - Battle Axe	1	1/22/2026 2:36 PM	2026-03-17 14:10:34.747828
2252	tchagnon	TAVERN IN THE SQUARE BEDFORD LLC	Large Tap Marker	Concord Craft - Four Rivers	1	1/22/2026 12:47 PM	2026-03-17 14:10:34.752787
2253	sshaunessy	RIVIERA NAYARITA MEXICAN-STYLE SEAFOOD	Large Tap Marker	Dos Equis Amber	1	1/21/2026 3:13 PM	2026-03-17 14:10:34.7551
2254	jgrumblatt	PETER CHRISTIANS TAVERN	Large Tap Marker	Zero Gravity - Extra Stout	1	1/21/2026 1:59 PM	2026-03-17 14:10:34.75768
2244	pwollert	MADAME SHERRI'S	Large Tap Marker	Maine Beer Co - Lunch	2	1/27/2026 9:05 AM	2026-03-17 19:05:56.105419
2257	scamuso	FRONTERA GRILL OF NASHUA	Large Tap Marker	Downeast - Original	1	1/21/2026 12:54 PM	2026-03-17 14:10:34.940047
2259	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Shipyard - Boatload Berry	1	1/21/2026 12:36 PM	2026-03-17 14:10:34.946539
2260	eleahy	FODY'S TAVERN (DERRY)	Large Tap Marker	603 Brew - Seltzer Black Cherry	1	1/20/2026 4:28 PM	2026-03-17 14:10:34.949364
2261	jsewall	WICKED TASTY (CATERING)	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	1/20/2026 1:49 PM	2026-03-17 14:10:34.954068
2262	jsewall	WICKED TASTY (CATERING)	Large Tap Marker	Mich Ultra	1	1/20/2026 1:49 PM	2026-03-17 14:10:34.958438
2263	pbelanger	HARLOWS PUBLIC HOUSE	Large Tap Marker	Maine Beer Co - N Mean Tom	1	1/20/2026 12:26 PM	2026-03-17 14:10:34.961146
2264	jcannamucio	JAMISON'S	Large Tap Marker	Downeast - Winter	1	1/20/2026 11:43 AM	2026-03-17 14:10:34.964149
2265	pbelanger	BRADYS BAR AND GRILL	Large Tap Marker	Concord Craft - Four Rivers	1	1/20/2026 10:01 AM	2026-03-17 14:10:34.967489
2266	jmeharg	TAVERN ON THE GREENS	Large Tap Marker	Tuckerman - Pale Ale	1	1/19/2026 4:12 PM	2026-03-17 14:10:34.970708
2267	tchagnon	TAVERN IN THE SQUARE BEDFORD LLC	Large Tap Marker	Fiddlehead - Mastermind	1	1/19/2026 12:05 PM	2026-03-17 14:10:34.973155
2268	jaustin	CLIFFY'S PUB	Large Tap Marker	Concord Craft - Safe Space	1	1/15/2026 3:54 PM	2026-03-17 14:10:34.975918
2270	amartin	BACKSTREET BAR & GRILL LLC	Large Tap Marker	603 Brew - Winni	1	1/15/2026 2:06 PM	2026-03-17 14:10:34.980871
2271	jgiuffrida	LIM'S SPORTS BAR & CAFE	Large Tap Marker	603 Brew - Winni	1	1/15/2026 1:54 PM	2026-03-17 14:10:34.983113
2272	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Jack's Abby - Framinghammer	1	1/15/2026 12:31 PM	2026-03-17 14:10:34.986139
2247	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Downeast - Prickly Pear	2	1/26/2026 2:51 PM	2026-03-17 19:05:56.108252
2274	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Large Tap Marker	Maine Beer Co - Lunch	1	1/15/2026 9:40 AM	2026-03-17 14:10:34.991854
2275	jcannamucio	SADDLE UP SALOON	Large Tap Marker	Able - Burn the Ships	1	1/14/2026 4:24 PM	2026-03-17 14:10:34.994649
2276	jcannamucio	JAMISON'S	Large Tap Marker	New Belgium - Juicy Haze	1	1/14/2026 3:13 PM	2026-03-17 14:10:34.9973
2251	jjohnson	JESSE'S STEAKHOUSE	Large Tap Marker	Von Trapp - West Coast	2	1/22/2026 1:31 PM	2026-03-17 19:05:56.111839
2278	rconstant	O'NEIL CINEMAS	Large Tap Marker	Mich Ultra	1	1/14/2026 12:56 PM	2026-03-17 14:10:35.004482
2279	rconstant	O'NEIL CINEMAS	Large Tap Marker	Stoneface - IPA	1	1/14/2026 12:56 PM	2026-03-17 14:10:35.006934
2280	rconstant	O'NEIL CINEMAS	Large Tap Marker	603 Brew - Winni	1	1/14/2026 12:56 PM	2026-03-17 14:10:35.00977
2281	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Fiddlehead - Hodad	1	1/14/2026 11:07 AM	2026-03-17 14:10:35.011999
2283	maanderson	STROKERS	Large Tap Marker	Wormtown - Be Hoppy	1	1/13/2026 3:12 PM	2026-03-17 14:10:35.016774
2284	tchagnon	VFW #8641 - MERRIMACK	Large Tap Marker	Jack's Abby - House Lager	1	1/13/2026 2:11 PM	2026-03-17 14:10:35.019516
2256	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Zero Gravity - Powder Jones	2	1/21/2026 1:36 PM	2026-03-17 19:05:56.114562
2258	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Able - Burn the Ships	2	1/21/2026 12:36 PM	2026-03-17 19:05:56.118665
2269	maanderson	PENUCHE'S ALE HOUSE-NASHUA	Large Tap Marker	603 Brew - Winni	2	1/15/2026 3:00 PM	2026-03-17 19:05:56.123242
2282	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	603 Brew - Winni	2	1/14/2026 11:07 AM	2026-03-17 19:05:56.126904
2290	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	1/13/2026 1:36 PM	2026-03-17 14:10:35.037969
2291	tchagnon	THIRSTY MOOSE	Large Tap Marker	Wormtown - Be Hoppy	1	1/13/2026 12:58 PM	2026-03-17 14:10:35.040476
2292	tchagnon	THIRSTY MOOSE	Large Tap Marker	Fiddlehead - Mastermind	1	1/13/2026 12:58 PM	2026-03-17 14:10:35.043013
2293	tchagnon	THIRSTY MOOSE	Large Tap Marker	Bitburger - Premium Pils	1	1/13/2026 12:58 PM	2026-03-17 14:10:35.045436
2294	amartin	SPECTACLE MANAGEMENT INC	Large Tap Marker	603 Brew - Winni	1	1/13/2026 12:19 PM	2026-03-17 14:10:35.048026
2289	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	Deciduous - Easy Operator	2	1/13/2026 1:36 PM	2026-03-17 19:05:56.129853
2296	pbelanger	BOWLING ACRES	Large Tap Marker	603 Brew - Winni	1	1/13/2026 10:08 AM	2026-03-17 14:10:35.053037
2297	tchagnon	THIRSTY MOOSE	Large Tap Marker	Banded - Charm	1	1/13/2026 9:33 AM	2026-03-17 14:10:35.055347
2298	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Southern - Chestnut Praline	1	1/12/2026 5:04 PM	2026-03-17 14:10:35.05823
2299	jcannamucio	CARRIAGE TOWN BAR & GRILL	Large Tap Marker	Downeast - Winter	1	1/12/2026 4:20 PM	2026-03-17 14:10:35.060758
2300	jjohnson	BARK & BEVY CO.	Large Tap Marker	Downeast - Blackberry	1	1/12/2026 3:47 PM	2026-03-17 14:10:35.063712
2301	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	603 Brew - Winni	1	1/12/2026 2:33 PM	2026-03-17 14:10:35.066852
2295	ggage	HAMPSHIRE DOME (THE)	Large Tap Marker	Concord Craft - Squirrel Fights	2	1/13/2026 11:52 AM	2026-03-17 19:05:56.133061
2303	jsewall	MOLLYS RESTAURANT	Large Tap Marker	Zero Gravity - Cone Head	1	1/12/2026 2:29 PM	2026-03-17 14:10:35.072446
2304	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Fiddlehead - Hodad	1	1/12/2026 12:36 PM	2026-03-17 14:10:35.075709
2305	jsewall	99 REST - W.LEB	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	1/12/2026 8:43 AM	2026-03-17 14:10:35.078634
2307	jsewall	WEATHERVANE - W.LEB	Large Tap Marker	Concord Craft - Irish Stout	1	1/12/2026 8:43 AM	2026-03-17 14:10:35.083794
2308	jsewall	WEATHERVANE - W.LEB	Large Tap Marker	Bells - Two Hearted	1	1/12/2026 8:43 AM	2026-03-17 14:10:35.086608
2309	jsewall	BUDDY T'S	Large Tap Marker	Tuckerman - Pale Ale	1	1/8/2026 2:34 PM	2026-03-17 14:10:35.089864
2310	jsewall	BUDDY T'S	Large Tap Marker	Maine Beer Co - Lunch	1	1/8/2026 2:34 PM	2026-03-17 14:10:35.092387
2312	jaustin	KILKENNY PUB - KEENE	Large Tap Marker	603 Brew - Winni	1	1/8/2026 1:49 PM	2026-03-17 14:10:35.098373
2313	pwollert	RESTAURANT AT BURDICKS	Large Tap Marker	Able - Burn the Ships	1	1/8/2026 12:56 PM	2026-03-17 14:10:35.100892
2314	pwollert	RESTAURANT AT BURDICKS	Large Tap Marker	603 Brew - Winni	1	1/8/2026 12:56 PM	2026-03-17 14:10:35.103769
2315	pwollert	RESTAURANT AT BURDICKS	Large Tap Marker	BBCO - Wizard	1	1/8/2026 12:56 PM	2026-03-17 14:10:35.106863
2316	tchagnon	RIVER ROAD TAVERN	Large Tap Marker	Concord Craft - Pond Hockey	1	1/8/2026 12:50 PM	2026-03-17 14:10:35.109475
2317	tchagnon	RIVER ROAD TAVERN	Large Tap Marker	Widowmaker - Blue Comet	1	1/8/2026 12:50 PM	2026-03-17 14:10:35.111882
2318	tchagnon	RIVER ROAD TAVERN	Large Tap Marker	Epigram - Temptation	1	1/8/2026 12:50 PM	2026-03-17 14:10:35.11445
2319	tchagnon	NH SPORTSPLEX	Large Tap Marker	Deciduous - Easy Operator	1	1/8/2026 11:41 AM	2026-03-17 14:10:35.117104
2322	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	Busch Light	1	1/7/2026 1:33 PM	2026-03-17 14:10:35.126264
2324	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	603 Brew - Winni	1	1/7/2026 12:01 PM	2026-03-17 14:10:35.131298
2325	jsewall	POOR THOMS TAVERN	Large Tap Marker	Tuckerman - Pale Ale	1	1/7/2026 11:25 AM	2026-03-17 14:10:35.13359
2326	jsewall	POOR THOMS TAVERN	Large Tap Marker	Fiddlehead - White	1	1/7/2026 11:25 AM	2026-03-17 14:10:35.136762
2328	pwollert	POUR HOUSE (THE)	Large Tap Marker	Athletic - Run Wild	1	1/6/2026 2:36 PM	2026-03-17 14:10:35.142321
2329	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	603 Brew - Winni	1	1/6/2026 12:32 PM	2026-03-17 14:10:35.145246
2330	maanderson	PINE VALLEY GOLF COURSE	Large Tap Marker	Downeast - Winter	1	1/6/2026 11:45 AM	2026-03-17 14:10:35.148051
2331	ggage	OLDE TOWNE TAVERN	Large Tap Marker	Downeast - Blackberry	1	1/6/2026 11:03 AM	2026-03-17 14:10:35.150798
2332	tchagnon	THIRSTY MOOSE	Large Tap Marker	Carlsberg - Lager	1	1/6/2026 7:35 AM	2026-03-17 14:10:35.1536
2333	tchagnon	THIRSTY MOOSE	Large Tap Marker	Maine Beer Co - Red IPA	1	1/6/2026 7:35 AM	2026-03-17 14:10:35.156277
2335	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Deciduous - Easy Operator	1	1/5/2026 3:32 PM	2026-03-17 14:10:35.16214
2306	jsewall	WEATHERVANE - W.LEB	Large Tap Marker	Downeast - Winter	2	1/12/2026 8:43 AM	2026-03-17 19:05:56.136162
2338	jsewall	SAWTOOTH KITCHEN LLC	Large Tap Marker	Concord Craft - Squirrel Fights	1	1/5/2026 2:51 PM	2026-03-17 14:10:35.17085
2339	jgiuffrida	PAR28	Large Tap Marker	Deciduous - Easy Operator	1	1/5/2026 2:14 PM	2026-03-17 14:10:35.173172
2311	jaustin	GUERRILLA GRILL	Large Tap Marker	Fiddlehead - Mastermind	2	1/8/2026 1:53 PM	2026-03-17 19:05:56.139938
2341	tchagnon	RIVER ROAD TAVERN	Large Tap Marker	Athletic - Run Wild	1	1/2/2026 2:01 PM	2026-03-17 14:10:35.179103
2342	jgiuffrida	RED ROBIN GOURMET BURGERS - SALEM	Large Tap Marker	603 Brew - Winni	1	12/31/2025 1:29 PM	2026-03-17 14:10:35.181882
2344	jgrumblatt	SALT HILL PUB - NEWPORT	Large Tap Marker	603 Brew - Winni	1	12/31/2025 11:40 AM	2026-03-17 14:10:35.187027
2346	pbelanger	EMMAS 321	Large Tap Marker	Concord Craft - Irish Stout	1	12/30/2025 4:29 PM	2026-03-17 14:10:35.191965
2347	lnorton	MARKET BASKET #71 BEDFORD	Large Tap Marker	Bud Light	1	12/30/2025 1:45 PM	2026-03-17 14:10:35.194359
2348	jgrumblatt	RAGGED MOUNTAIN	Large Tap Marker	Henniker - Wrking Man Porter	1	12/30/2025 12:30 PM	2026-03-17 14:10:35.1976
2349	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Concord Craft - Pond Hockey	1	12/30/2025 12:30 PM	2026-03-17 14:10:35.200019
2350	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Founders - Porter	1	12/30/2025 12:30 PM	2026-03-17 14:10:35.203175
2351	pwollert	MADAME SHERRI'S	Large Tap Marker	Shipyard - Boatload Berry	1	12/29/2025 1:04 PM	2026-03-17 14:10:35.205684
2352	pwollert	MADAME SHERRI'S	Large Tap Marker	Berkshire - Coffehouse Porter	1	12/29/2025 1:04 PM	2026-03-17 14:10:35.20924
2353	tchagnon	THIRSTY MOOSE	Large Tap Marker	Citizen Cider - BD Apple Pie	1	12/29/2025 11:45 AM	2026-03-17 14:10:35.211775
2320	jaustin	MAIN CRUST CO.	Large Tap Marker	603 Brew - Winni	2	1/7/2026 3:54 PM	2026-03-17 19:05:56.142503
2321	jmeharg	CROTCHED MOUNTAIN SKI AREA	Large Tap Marker	Henniker - Flap Jack	2	1/7/2026 1:44 PM	2026-03-17 19:05:56.145712
2323	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Concord Craft - Pond Hockey	2	1/7/2026 12:01 PM	2026-03-17 19:05:56.150799
2327	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Citizen Cider - BD Apple Pie	2	1/6/2026 3:15 PM	2026-03-17 19:05:56.15576
2334	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	von Trapp - Vienna	2	1/5/2026 3:32 PM	2026-03-17 19:05:56.158442
2336	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Mich Ultra	2	1/5/2026 3:32 PM	2026-03-17 19:05:56.161233
2343	tchagnon	TAVERN IN THE SQUARE BEDFORD LLC	Large Tap Marker	Henniker - Flap Jack	2	12/31/2025 12:49 PM	2026-03-17 19:05:56.163759
2345	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Lord Hobo - Boomsauce	2	12/31/2025 11:37 AM	2026-03-17 19:05:56.167104
2354	tchagnon	THIRSTY MOOSE	Large Tap Marker	New Belgium - Fat Tire	1	12/29/2025 11:45 AM	2026-03-17 14:10:35.214621
2356	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	BBCO - Lighthouse	1	12/29/2025 10:53 AM	2026-03-17 14:10:35.220899
2357	jmeharg	TAVERN ON THE GREENS	Large Tap Marker	Lord Hobo - Boomsauce	1	12/28/2025 3:35 PM	2026-03-17 14:10:35.223937
2358	jsewall	MOLLYS RESTAURANT	Large Tap Marker	Stoneface - Imaginary Cartwheel	1	12/28/2025 11:40 AM	2026-03-17 14:10:35.226952
2360	jaustin	MAIN CRUST CO.	Large Tap Marker	Zero Gravity - Cone Head	1	12/23/2025 3:43 PM	2026-03-17 14:10:35.242831
2361	jmeharg	PATS PEAK	Large Tap Marker	Fiddlehead - White	1	12/23/2025 3:39 PM	2026-03-17 14:10:35.245154
2362	jmeharg	PATS PEAK	Large Tap Marker	Fiddlehead - IPA	1	12/23/2025 3:39 PM	2026-03-17 14:10:35.248467
2363	tchagnon	THIRSTY MOOSE	Large Tap Marker	Concord Craft - White Mtn White	1	12/23/2025 2:36 PM	2026-03-17 14:10:35.25093
2364	tchagnon	THIRSTY MOOSE	Large Tap Marker	603 Brew - Winni	1	12/22/2025 2:38 PM	2026-03-17 14:10:35.253732
2365	ggage	CHRYSANTHI'S	Large Tap Marker	Henniker - Flap Jack	1	12/22/2025 2:14 PM	2026-03-17 14:10:35.256847
2355	ggage	ALAMO TEXAS BAR-B-QUE & TEQUILA BAR	Large Tap Marker	Mich Ultra	2	12/29/2025 11:11 AM	2026-03-17 19:05:56.170133
2359	jaustin	MAIN CRUST CO.	Large Tap Marker	Mighty Squirrel - Cloud Candy	2	12/23/2025 3:43 PM	2026-03-17 19:05:56.172572
2368	jgiuffrida	DREO FOOD AND DRINK	Large Tap Marker	603 Brew - Coffee Cake Porter	2	12/18/2025 3:12 PM	2026-03-17 19:05:56.174997
2374	jaustin	MAIN CRUST CO.	Large Tap Marker	Upper Pass - First Drop	2	12/17/2025 3:53 PM	2026-03-17 19:05:56.178195
2377	jaustin	MAIN CRUST CO.	Large Tap Marker	Stella Artois	2	12/17/2025 3:53 PM	2026-03-17 19:05:56.180641
2383	jaustin	MAIN CRUST CO.	Large Tap Marker	Paulaner	2	12/17/2025 11:04 AM	2026-03-17 19:05:56.183368
2373	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	Fiddlehead - White	1	12/18/2025 11:48 AM	2026-03-17 14:10:35.278838
2375	jaustin	MAIN CRUST CO.	Large Tap Marker	Throwback - Rule Roost	1	12/17/2025 3:53 PM	2026-03-17 14:10:35.2837
2376	jaustin	MAIN CRUST CO.	Large Tap Marker	Jack's Abby - Extra Layer	1	12/17/2025 3:53 PM	2026-03-17 14:10:35.287007
2378	pwollert	MAMA MCDONOUGH'S IRISH PUB	Large Tap Marker	Stella Artois	1	12/17/2025 1:45 PM	2026-03-17 14:10:35.292885
2379	jmeharg	CROTCHED MOUNTAIN SKI AREA	Large Tap Marker	Wormtown - Blizzard	1	12/17/2025 1:04 PM	2026-03-17 14:10:35.29522
2380	lnorton	COPPER DOOR - BEDFORD	Large Tap Marker	Wormtown - Blizzard	1	12/17/2025 12:27 PM	2026-03-17 14:10:35.298246
2381	jcannamucio	JAMISON'S	Large Tap Marker	Weihenstephaner - Kristalweiss	1	12/17/2025 12:14 PM	2026-03-17 14:10:35.301108
2382	jaustin	MAIN CRUST CO.	Large Tap Marker	Champlain Orch - Kingston Dry	1	12/17/2025 11:04 AM	2026-03-17 14:10:35.304392
2384	jsewall	POOR THOMS TAVERN	Large Tap Marker	Lord Hobo - Boomsauce	1	12/17/2025 10:41 AM	2026-03-17 14:10:35.311587
2386	tchagnon	VFW #8641 - MERRIMACK	Large Tap Marker	603 Brew - Seltzer Black Cherry	1	12/16/2025 2:18 PM	2026-03-17 14:10:35.316691
2387	ggage	VFW #4368 - MILFORD	Large Tap Marker	New Belgium - Fat Tire	1	12/16/2025 10:33 AM	2026-03-17 14:10:35.319225
2388	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Shocktop	1	12/15/2025 4:11 PM	2026-03-17 14:10:35.322162
2389	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Wormtown - Blizzard	1	12/15/2025 2:49 PM	2026-03-17 14:10:35.324679
2390	ddooling	GRANFANALLYS PIZZA PUB	Large Tap Marker	Founders - Mortal Bloom	1	12/15/2025 2:35 PM	2026-03-17 14:10:35.327946
2391	jjohnson	JESSE'S STEAKHOUSE	Large Tap Marker	Wormtown - Blizzard	1	12/15/2025 2:10 PM	2026-03-17 14:10:35.330629
2392	lortiz	RED ROBIN BURGERS #515 NASHUA	Large Tap Marker	Downeast - Winter	1	12/15/2025 2:10 PM	2026-03-17 14:10:35.333613
2393	jjohnson	SNAX	Large Tap Marker	603 Brew - APL	1	12/15/2025 1:53 PM	2026-03-17 14:10:35.336042
2394	jjohnson	SNAX	Large Tap Marker	Wormtown - Be Hoppy	1	12/15/2025 1:53 PM	2026-03-17 14:10:35.33855
2395	eleahy	T-BONES - DERRY	Large Tap Marker	603 Brew - Winni	1	12/15/2025 9:57 AM	2026-03-17 14:10:35.340882
2385	jgrumblatt	SUNA RESTAURANT	Large Tap Marker	von Trapp - Pilsner	2	12/16/2025 4:26 PM	2026-03-17 19:05:56.186094
2398	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Fiddlehead - Mastermind	1	12/11/2025 1:36 PM	2026-03-17 14:10:35.349313
2399	lnorton	EVVIVA TRATTORIA - BEDFORD	Large Tap Marker	Wormtown - Blizzard	1	12/11/2025 1:25 PM	2026-03-17 14:10:35.35184
2400	jaustin	GUERRILLA GRILL	Large Tap Marker	Bells - Big hearted	1	12/11/2025 12:56 PM	2026-03-17 14:10:35.354508
2397	amartin	SURF RESTAURANT INC	Large Tap Marker	Breck Christmas	2	12/11/2025 3:00 PM	2026-03-17 19:05:56.189129
2412	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Shipyard - Prelude	3	12/11/2025 4:48 AM	2026-03-17 19:05:56.19198
2405	sshaunessy	TJ'S DELI AND CATERING	Large Tap Marker	Wormtown - Blizzard	1	12/11/2025 9:54 AM	2026-03-17 14:10:35.367271
2406	jmeharg	BUFFALO BO'S	Large Tap Marker	Downeast - Original	1	12/11/2025 7:24 AM	2026-03-17 14:10:35.370493
2407	jmeharg	BUFFALO BO'S	Large Tap Marker	Maine Beer Co - Lunch	1	12/11/2025 7:24 AM	2026-03-17 14:10:35.372789
2408	jmeharg	BUFFALO BO'S	Large Tap Marker	603 Brew - Seltzer Black Cherry	1	12/11/2025 7:24 AM	2026-03-17 14:10:35.376134
2409	jmeharg	BUFFALO BO'S	Large Tap Marker	Henniker - Hop Slinger IPA	1	12/11/2025 7:24 AM	2026-03-17 14:10:35.378449
2410	jmeharg	BUFFALO BO'S	Large Tap Marker	Henniker - Henni Light	1	12/11/2025 7:24 AM	2026-03-17 14:10:35.381423
2411	jmeharg	BUFFALO BO'S	Large Tap Marker	Dos Equis	1	12/11/2025 7:24 AM	2026-03-17 14:10:35.383702
2413	jgrumblatt	WILDWOOD SMOKEHOUSE	Large Tap Marker	von Trapp - Dunkel	1	12/10/2025 4:17 PM	2026-03-17 14:10:35.389266
2414	jmeharg	CROTCHED MOUNTAIN SKI AREA	Large Tap Marker	Zero Gravity - Cone Head	1	12/10/2025 3:34 PM	2026-03-17 14:10:35.392424
2415	jmeharg	CROTCHED MOUNTAIN SKI AREA	Large Tap Marker	Fiddlehead - White	1	12/10/2025 3:34 PM	2026-03-17 14:10:35.395524
2416	jmeharg	CROTCHED MOUNTAIN SKI AREA	Large Tap Marker	Mich Ultra	1	12/10/2025 3:34 PM	2026-03-17 14:10:35.398265
2417	jaustin	TEMPESTA'S	Large Tap Marker	Henniker - Wrking Man Porter	1	12/10/2025 2:27 PM	2026-03-17 14:10:35.400826
2418	lnorton	VILLAGE TRESTLE (THE)	Large Tap Marker	Downeast - Winter	1	12/9/2025 2:27 PM	2026-03-17 14:10:35.403614
2420	rconstant	SMOKE SHACK CAFE	Large Tap Marker	Jack's Abby - Extra Layer	2	12/9/2025 1:17 PM	2026-03-17 19:05:56.194692
2421	tchagnon	THIRSTY MOOSE	Large Tap Marker	Maine Beer Co - MO	1	12/9/2025 8:12 AM	2026-03-17 14:10:35.411958
2422	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Tuckerman - Pale Ale	1	12/8/2025 4:07 PM	2026-03-17 14:10:35.414852
2423	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Breck Christmas	1	12/8/2025 4:07 PM	2026-03-17 14:10:35.417344
2424	jaustin	CLIFFY'S PUB	Large Tap Marker	Stella Artois	1	12/8/2025 3:59 PM	2026-03-17 14:10:35.420474
2425	jaustin	CLIFFY'S PUB	Large Tap Marker	Maine Beer Co - Lunch	1	12/8/2025 3:59 PM	2026-03-17 14:10:35.432456
2427	pbelanger	EMMAS 321	Large Tap Marker	Zero Gravity - Evergreen	1	12/4/2025 3:17 PM	2026-03-17 14:10:35.438086
2426	pwollert	21 ROXBURY BAR & GRILL	Large Tap Marker	Mighty Squirrel - Cloud Candy	2	12/4/2025 3:32 PM	2026-03-17 19:05:56.197247
2429	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	Jack's Abby - Extra Layer	1	12/4/2025 1:21 PM	2026-03-17 14:10:35.444311
2430	jgrumblatt	SALT HILL PUB - NEWPORT	Large Tap Marker	Concord Craft - Four Rivers	1	12/4/2025 1:09 PM	2026-03-17 14:10:35.446812
2431	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Maine Beer Co - Lunch	1	12/4/2025 11:50 AM	2026-03-17 14:10:35.449917
2434	scamuso	TEXAS ROADHOUSE	Large Tap Marker	Wormtown - Blizzard	1	12/3/2025 1:13 PM	2026-03-17 14:10:35.466036
2435	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Zero Gravity - Evergreen	1	12/3/2025 1:05 PM	2026-03-17 14:10:35.468606
2436	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Upper Pass - First Drop	1	12/3/2025 1:05 PM	2026-03-17 14:10:35.470783
2437	eplatt	PPC KITCHEN & BAR	Large Tap Marker	Mighty Squirrel - Heart	1	12/3/2025 11:51 AM	2026-03-17 14:10:35.473501
2438	eplatt	PPC KITCHEN & BAR	Large Tap Marker	BBCO - Phantom Glow	1	12/3/2025 11:51 AM	2026-03-17 14:10:35.47591
2439	rconstant	LA CARRETA - LONDONDERRY	Large Tap Marker	Mich Ultra	1	12/3/2025 11:05 AM	2026-03-17 14:10:35.480149
2440	jsewall	POOR THOMS TAVERN	Large Tap Marker	Zero Gravity - Green State	1	12/3/2025 10:56 AM	2026-03-17 14:10:35.482592
2441	rconstant	SUPPAS PIZZA LONDONDERRY	Large Tap Marker	Stella Artois	1	12/2/2025 12:42 PM	2026-03-17 14:10:35.485492
2442	pwollert	FRATERNAL ORDER OF EAGLES	Large Tap Marker	Fiddlehead - IPA	1	12/2/2025 9:57 AM	2026-03-17 14:10:35.488633
2443	tchagnon	THIRSTY MOOSE	Large Tap Marker	Shipyard - Prelude	1	12/2/2025 6:34 AM	2026-03-17 14:10:35.491499
2445	rconstant	TWINS SMOKE SHOP	Large Tap Marker	14th Star - Maple Br	1	12/1/2025 4:01 PM	2026-03-17 14:10:35.497918
2446	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Frost - Lush	1	12/1/2025 3:09 PM	2026-03-17 14:10:35.500287
2447	jaustin	KILKENNY PUB - KEENE	Large Tap Marker	Henniker - Wrking Man Porter	1	12/1/2025 2:54 PM	2026-03-17 14:10:35.503067
2448	scamuso	BISTRO 603	Large Tap Marker	Wormtown - Blizzard	1	12/1/2025 2:20 PM	2026-03-17 14:10:35.505182
2449	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Concord Craft - Safe Space	1	12/1/2025 12:47 PM	2026-03-17 14:10:35.507761
2450	ggage	OLDE TOWNE TAVERN	Large Tap Marker	Downeast - Caramel Apple	1	12/1/2025 12:20 PM	2026-03-17 14:10:35.510048
2451	jmeharg	TOOKY MILLS PUB	Large Tap Marker	Jack's Abby - Extra Layer	1	12/1/2025 10:30 AM	2026-03-17 14:10:35.512972
2452	maanderson	PEDDLER'S DAUGHTER	Large Tap Marker	Tuckerman - Pale Ale	1	11/26/2025 3:16 PM	2026-03-17 14:10:35.515228
2432	pwollert	21 ROXBURY BAR & GRILL	Large Tap Marker	603 Brew - Coffee Cake Porter	2	12/3/2025 2:12 PM	2026-03-17 19:05:56.200958
2456	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Mighty Squirrel - Heart	1	11/25/2025 3:30 PM	2026-03-17 14:10:35.525229
2457	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	603 Brew - APL	1	11/25/2025 3:10 PM	2026-03-17 14:10:35.528325
2433	pwollert	21 ROXBURY BAR & GRILL	Large Tap Marker	Wormtown - Blizzard	2	12/3/2025 2:12 PM	2026-03-17 19:05:56.203725
2444	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Mighty Squirrel - Heart	3	12/2/2025 4:30 AM	2026-03-17 19:05:56.206128
2453	maanderson	PEDDLER'S DAUGHTER	Large Tap Marker	Stoneface - IPA	2	11/26/2025 3:16 PM	2026-03-17 19:05:56.208671
2463	pbelanger	EMMAS 321	Large Tap Marker	Widowmaker - Green Wizard	1	11/25/2025 10:47 AM	2026-03-17 14:10:35.544705
2464	ddooling	PELHAM STREET BLACK WATER GRILL	Large Tap Marker	Bud Light	1	11/24/2025 4:02 PM	2026-03-17 14:10:35.54713
2465	tchagnon	THIRSTY MOOSE	Large Tap Marker	Tuckerman - Rock Pile IPA	1	11/24/2025 3:47 PM	2026-03-17 14:10:35.549903
2466	tchagnon	THIRSTY MOOSE	Large Tap Marker	von Trapp - Helles	1	11/24/2025 3:47 PM	2026-03-17 14:10:35.552229
2467	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Upper Pass - Cloud Drop	1	11/24/2025 3:45 PM	2026-03-17 14:10:35.555023
2470	pbelanger	BOWLING ACRES	Large Tap Marker	Widowmaker - Green Wizard	1	11/24/2025 2:44 PM	2026-03-17 14:10:35.562687
2472	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	Stoneface - IPA	1	11/24/2025 1:40 PM	2026-03-17 14:10:35.568078
2473	jaustin	RUSTIC TABLE (THE)	Large Tap Marker	Concord Craft - Four Rivers	1	11/24/2025 12:31 PM	2026-03-17 14:10:35.570562
2455	rconstant	AJ'S SPORTS BAR & GRILL	Large Tap Marker	Stella Artois	2	11/26/2025 12:35 PM	2026-03-17 19:05:56.21145
2458	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Wormtown - Blizzard	2	11/25/2025 3:10 PM	2026-03-17 19:05:56.21387
2460	eplatt	PPC KITCHEN & BAR	Large Tap Marker	Foundation - Epiphany	2	11/25/2025 12:10 PM	2026-03-17 19:05:56.216369
2468	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Goose - Bourb County	2	11/24/2025 3:26 PM	2026-03-17 19:05:56.219626
2469	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Zero Gravity - Green State	2	11/24/2025 3:26 PM	2026-03-17 19:05:56.222537
2471	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	Downeast - Winter	2	11/24/2025 1:56 PM	2026-03-17 19:05:56.225087
2474	ggage	ALAMO TEXAS BAR-B-QUE & TEQUILA BAR	Large Tap Marker	Bud Select	1	11/24/2025 11:54 AM	2026-03-17 14:10:35.572975
2475	ggage	ALAMO TEXAS BAR-B-QUE & TEQUILA BAR	Large Tap Marker	Downeast - Cranberry	1	11/24/2025 11:54 AM	2026-03-17 14:10:35.575773
2476	pbelanger	BOWLING ACRES	Large Tap Marker	Goose - Bourb County	1	11/24/2025 9:02 AM	2026-03-17 14:10:35.57889
2477	pbelanger	HARLOWS PUBLIC HOUSE	Large Tap Marker	Goose - Bourb County	1	11/24/2025 9:02 AM	2026-03-17 14:10:35.581799
2478	tchagnon	THIRSTY MOOSE	Large Tap Marker	Founders - Mortal Bloom	1	11/24/2025 7:36 AM	2026-03-17 14:10:35.584373
2479	tchagnon	THIRSTY MOOSE	Large Tap Marker	Shipyard - Boatload Berry	1	11/24/2025 7:36 AM	2026-03-17 14:10:35.58761
2488	jgiuffrida	RED ROBIN GOURMET BURGERS - SALEM	Large Tap Marker	Wormtown - Blizzard	2	11/20/2025 2:03 PM	2026-03-17 19:05:56.227503
2481	ggage	STONECUTTERS PUB	Large Tap Marker	Wormtown - Blizzard	1	11/23/2025 12:30 PM	2026-03-17 14:10:35.592364
2482	jgrumblatt	VAIL RESORT/ MOUNT SUNAPEE	Large Tap Marker	Zero Gravity - Green State	1	11/22/2025 10:31 AM	2026-03-17 14:10:35.594731
2483	jgrumblatt	VAIL RESORT/ MOUNT SUNAPEE	Large Tap Marker	Henniker - Flyway	1	11/22/2025 10:31 AM	2026-03-17 14:10:35.599031
2484	jgrumblatt	VAIL RESORT/ MOUNT SUNAPEE	Large Tap Marker	Henniker - Miles & Miles	1	11/22/2025 10:31 AM	2026-03-17 14:10:35.602031
2485	jgrumblatt	VAIL RESORT/ MOUNT SUNAPEE	Large Tap Marker	Zero Gravity - Green State Light	1	11/22/2025 10:31 AM	2026-03-17 14:10:35.605999
2486	jgrumblatt	VAIL RESORT/ MOUNT SUNAPEE	Large Tap Marker	von Trapp - Dunkel	1	11/22/2025 10:31 AM	2026-03-17 14:10:35.608431
2487	jjohnson	ENTERTAINMENT CINEMAS - LEBANON	Large Tap Marker	Mich Ultra	1	11/20/2025 3:24 PM	2026-03-17 14:10:35.610875
2489	amartin	LYNN'S 102 TAVERN	Large Tap Marker	Downeast - Caramel Apple	1	11/20/2025 1:16 PM	2026-03-17 14:10:35.616622
2490	jaustin	THE PERCH	Large Tap Marker	Maine Beer Co - Lunch	1	11/20/2025 1:16 PM	2026-03-17 14:10:35.61921
2491	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Able - Broad Arrow	1	11/20/2025 1:13 PM	2026-03-17 14:10:35.622899
2493	jaustin	GUERRILLA GRILL	Large Tap Marker	Stella Artois	1	11/20/2025 12:23 PM	2026-03-17 14:10:35.627836
2495	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Frost - Lush	1	11/20/2025 11:11 AM	2026-03-17 14:10:35.633239
2492	jaustin	GUERRILLA GRILL	Large Tap Marker	von Trapp - Dunkel	3	11/20/2025 12:23 PM	2026-03-17 19:05:56.230387
2497	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Downeast - Winter	1	11/19/2025 3:53 PM	2026-03-17 14:10:35.638195
2498	rconstant	PROFESSOR SPORTS PUB	Large Tap Marker	Stella Artois	1	11/19/2025 3:32 PM	2026-03-17 14:10:35.640419
2499	pwollert	MAMA MCDONOUGH'S IRISH PUB	Large Tap Marker	Downeast - Blackberry	1	11/19/2025 2:00 PM	2026-03-17 14:10:35.642654
2500	pwollert	MAMA MCDONOUGH'S IRISH PUB	Large Tap Marker	Wormtown - Blizzard	1	11/19/2025 2:00 PM	2026-03-17 14:10:35.64492
2501	jmeharg	BLUE BEAR HOSPITALITY LLC	Large Tap Marker	von Trapp - Pilsner	1	11/19/2025 1:33 PM	2026-03-17 14:10:35.647232
2502	maanderson	LUK'S BAR & GRILL	Large Tap Marker	Wormtown - Blizzard	1	11/19/2025 12:57 PM	2026-03-17 14:10:35.649387
2503	jgrumblatt	THE REFINERY	Large Tap Marker	BBCO - Lighthouse	1	11/19/2025 11:49 AM	2026-03-17 14:10:35.651785
2504	jsewall	PEYTON PLACE RESTAURANT	Large Tap Marker	Frost - Little Lush	1	11/18/2025 12:27 PM	2026-03-17 14:10:35.654031
2505	jsewall	PEYTON PLACE RESTAURANT	Large Tap Marker	Able - Burn the Ships	1	11/18/2025 12:27 PM	2026-03-17 14:10:35.656855
2506	jsewall	PEYTON PLACE RESTAURANT	Large Tap Marker	Jack's Abby - Extra Layer	1	11/18/2025 12:27 PM	2026-03-17 14:10:35.65906
2508	pbelanger	BRADYS BAR AND GRILL	Large Tap Marker	Wormtown - Blizzard	1	11/18/2025 10:12 AM	2026-03-17 14:10:35.664463
2509	pbelanger	BOWLING ACRES	Large Tap Marker	Wormtown - Blizzard	1	11/18/2025 10:01 AM	2026-03-17 14:10:35.666926
2510	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Stoneface - Berliner Weisse	1	11/17/2025 6:08 PM	2026-03-17 14:10:35.669821
2511	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Henniker - Wrking Man Porter	1	11/17/2025 6:08 PM	2026-03-17 14:10:35.672631
2512	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Bud Light	1	11/17/2025 6:08 PM	2026-03-17 14:10:35.674787
2513	pbelanger	MEXICA MEXICAN RESTAURANT	Large Tap Marker	BBCO - Little Wizard	1	11/17/2025 4:24 PM	2026-03-17 14:10:35.677153
2514	scamuso	DOUBLETREE BY HILTON NASHUA	Large Tap Marker	Berkshire - Coffehouse Porter	1	11/17/2025 3:45 PM	2026-03-17 14:10:35.679793
2515	jmeharg	TAVERN ON THE GREENS	Large Tap Marker	Maine Beer Co - Lunch	1	11/17/2025 3:14 PM	2026-03-17 14:10:35.682286
2516	ggage	ALAMO TEXAS BAR-B-QUE & TEQUILA BAR	Large Tap Marker	Carlson - Berry	1	11/17/2025 12:43 PM	2026-03-17 14:10:35.68456
2517	scamuso	BISTRO 603	Large Tap Marker	Berkshire - Coffehouse Porter	1	11/17/2025 12:29 PM	2026-03-17 14:10:35.687516
2518	ddooling	COPPER DOOR - SALEM	Large Tap Marker	Lord Hobo - Boomsauce	1	11/17/2025 12:20 PM	2026-03-17 14:10:35.689951
2519	tchagnon	COMMON MAN - MERRIMACK	Large Tap Marker	603 Brew - Winni	1	11/17/2025 11:47 AM	2026-03-17 14:10:35.70072
2520	jaustin	YANKEE LANES / KEENE BOWL	Large Tap Marker	Dos Equis Amber	1	11/17/2025 11:41 AM	2026-03-17 14:10:35.703284
2494	jaustin	GUERRILLA GRILL	Large Tap Marker	Concord Craft - Squirrel Fights	3	11/20/2025 12:23 PM	2026-03-17 19:05:56.233474
2507	maanderson	PINE VALLEY GOLF COURSE	Large Tap Marker	603 Brew - APL	2	11/18/2025 11:01 AM	2026-03-17 19:05:56.23606
2521	jmorse	RAMUNTOS - CLAREMONT	Large Tap Marker	von Trapp - Dunkel	3	11/17/2025 11:10 AM	2026-03-17 19:05:56.238563
2525	jgiuffrida	MARKET BASKET #06 SALEM	Large Tap Marker	Stoneface - IPA	1	11/16/2025 3:18 PM	2026-03-17 14:10:35.716661
2526	ggage	AMERICAN LEGION POST 10 - WILTON	Large Tap Marker	Henniker - Picnic	1	11/16/2025 3:14 PM	2026-03-17 14:10:35.719918
2527	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	603 Brew - APL	1	11/16/2025 3:12 PM	2026-03-17 14:10:35.723363
2532	jaustin	LOCAL BURGER OF KEENE	Large Tap Marker	von Trapp - Helles	2	11/13/2025 1:13 PM	2026-03-17 19:05:56.241698
2529	jgrumblatt	SALT HILL PUB - NEWPORT	Large Tap Marker	Able - Burn the Ships	1	11/13/2025 2:52 PM	2026-03-17 14:10:35.728611
2530	jaustin	KEENE COUNTRY CLUB INC	Large Tap Marker	Henniker - Flap Jack	1	11/13/2025 2:29 PM	2026-03-17 14:10:35.731148
2531	jsewall	SAWTOOTH KITCHEN LLC	Large Tap Marker	Fiddlehead - IPA	1	11/13/2025 1:51 PM	2026-03-17 14:10:35.734074
2533	maanderson	NASH CASINO	Large Tap Marker	Mich Ultra	1	11/13/2025 1:03 PM	2026-03-17 14:10:35.739864
2535	jaustin	GUERRILLA GRILL	Large Tap Marker	Downeast - Cranberry	1	11/13/2025 12:53 PM	2026-03-17 14:10:35.746212
2536	pwollert	21 ROXBURY BAR & GRILL	Large Tap Marker	Deciduous - Easy Operator	1	11/13/2025 12:46 PM	2026-03-17 14:10:35.748837
2537	ddooling	T-BONES - SALEM	Large Tap Marker	Mich Ultra	1	11/13/2025 12:46 PM	2026-03-17 14:10:35.75174
2538	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Wormtown - Blizzard	1	11/13/2025 11:57 AM	2026-03-17 14:10:35.755356
2539	jaustin	MAIN CRUST CO.	Large Tap Marker	Stoneface - Full Clip	1	11/12/2025 4:24 PM	2026-03-17 14:10:35.758628
2540	jaustin	MI JALISCO - KEENE	Large Tap Marker	Fiddlehead - IPA	1	11/12/2025 4:16 PM	2026-03-17 14:10:35.761411
2541	ddooling	SEVMAR MEDITERRANEAN BISTRO	Large Tap Marker	Fiddlehead - White	1	11/12/2025 3:02 PM	2026-03-17 14:10:35.764076
2542	amartin	SPECTACLE MANAGEMENT INC	Large Tap Marker	Jack's Abby - Extra Layer	1	11/12/2025 2:51 PM	2026-03-17 14:10:35.766506
2543	jaustin	MAIN CRUST CO.	Large Tap Marker	Hacker-Pschorr	1	11/12/2025 1:57 PM	2026-03-17 14:10:35.768935
2534	jaustin	GUERRILLA GRILL	Large Tap Marker	Fiddlehead - White	2	11/13/2025 12:56 PM	2026-03-17 19:05:56.244766
2547	lnorton	X-GOLF BEDFORD	Large Tap Marker	Fiddlehead - IPA	2	11/12/2025 1:12 PM	2026-03-17 19:05:56.247434
2546	lortiz	BURTON'S GRILL	Large Tap Marker	Able - Burn the Ships	1	11/12/2025 1:18 PM	2026-03-17 14:10:35.777459
2548	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Tuckerman - Pale Ale	1	11/12/2025 1:11 PM	2026-03-17 14:10:35.782644
2549	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	14th Star - Remix	1	11/12/2025 1:11 PM	2026-03-17 14:10:35.785886
2550	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Concord Craft - White Mtn White	1	11/12/2025 1:11 PM	2026-03-17 14:10:35.788323
2554	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Bells - Christmas Ale	1	11/12/2025 11:53 AM	2026-03-17 14:10:35.799108
2555	scamuso	TEXAS ROADHOUSE	Large Tap Marker	Sea Dog - Blueberry	1	11/12/2025 10:40 AM	2026-03-17 14:10:35.801741
2556	tchagnon	HOMESTEAD RESTAURANT & TAVERN	Large Tap Marker	Able - Lady of the Lake	1	11/12/2025 7:01 AM	2026-03-17 14:10:35.804072
2557	tchagnon	HOMESTEAD RESTAURANT & TAVERN	Large Tap Marker	Concord Craft - Safe Space	1	11/12/2025 7:01 AM	2026-03-17 14:10:35.806891
2558	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Large Tap Marker	Fiddlehead - IPA	1	11/11/2025 3:28 PM	2026-03-17 14:10:35.809455
2559	bgermano	ATHEN'S PIZZA	Large Tap Marker	Downeast - Cranberry	1	11/11/2025 2:31 PM	2026-03-17 14:10:35.811919
2560	lnorton	LA VAKA MEXICAN RESTAURANT	Large Tap Marker	603 Brew - Winni	1	11/11/2025 1:38 PM	2026-03-17 14:10:35.814264
2551	jmorse	HELEN'S PLACE	Large Tap Marker	von Trapp - Dunkel	3	11/12/2025 12:16 PM	2026-03-17 19:05:56.249752
2565	jmorse	POLISH AMER CITIZENS CLUB-CLAREMONT	Large Tap Marker	Tuckerman - Pale Ale	1	11/10/2025 3:18 PM	2026-03-17 14:10:35.827357
2567	ggage	HAMPSHIRE DOME (THE)	Large Tap Marker	Able - Lady of the Lake	1	11/10/2025 2:21 PM	2026-03-17 14:10:35.832478
2552	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Zero Gravity - Cone Head	2	11/12/2025 11:53 AM	2026-03-17 19:05:56.252944
2569	rconstant	ROCCO'S PIZZA	Large Tap Marker	Berkshire - Coffehouse Porter	1	11/10/2025 11:47 AM	2026-03-17 14:10:35.837749
2570	ddooling	COPPER DOOR - SALEM	Large Tap Marker	Mich Ultra	1	11/10/2025 11:41 AM	2026-03-17 14:10:35.839992
2571	jgiuffrida	MARKET BASKET #06 SALEM	Large Tap Marker	Able - Burn the Ships	1	11/10/2025 10:33 AM	2026-03-17 14:10:35.842516
2553	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Widowmaker - Blue Comet	2	11/12/2025 11:53 AM	2026-03-17 19:05:56.255563
2561	pwollert	MADAME SHERRI'S	Large Tap Marker	603 Brew - Coffee Cake Porter	2	11/11/2025 1:22 PM	2026-03-17 19:05:56.257864
2563	rconstant	TWINS SMOKE SHOP	Large Tap Marker	603 Brew - Mitz BA RIS	2	11/10/2025 4:51 PM	2026-03-17 19:05:56.260101
2564	rconstant	TWINS SMOKE SHOP	Large Tap Marker	603 Brew - APL	2	11/10/2025 4:51 PM	2026-03-17 19:05:56.263409
2576	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	BBCO - Doom Wizard	1	11/6/2025 12:58 PM	2026-03-17 14:10:35.855915
2577	sshaunessy	PINE STREET EATERY	Large Tap Marker	Downeast - Cranberry	1	11/6/2025 12:41 PM	2026-03-17 14:10:35.858507
2578	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Jack's Abby - Extra Layer	1	11/6/2025 12:23 PM	2026-03-17 14:10:35.86106
2579	jsewall	SAWTOOTH KITCHEN LLC	Large Tap Marker	Wormtown - Blizzard	1	11/6/2025 12:16 PM	2026-03-17 14:10:35.86361
2581	pbelanger	WOODBOUND INN	Large Tap Marker	Stella Artois	1	11/5/2025 4:32 PM	2026-03-17 14:10:35.868794
2582	ddooling	ON THE CORNER GRILL	Large Tap Marker	Stoneface - Sunday Sauce	1	11/5/2025 4:13 PM	2026-03-17 14:10:35.871113
2583	ggage	OLDE KILKENNY PUB	Large Tap Marker	Wormtown - Blizzard	1	11/5/2025 3:39 PM	2026-03-17 14:10:35.874018
2584	jaustin	MAIN CRUST CO.	Large Tap Marker	Spaten	1	11/5/2025 1:54 PM	2026-03-17 14:10:35.876569
2585	ddooling	SEVMAR MEDITERRANEAN BISTRO	Large Tap Marker	603 Brew - Coffee Cake Porter	1	11/5/2025 1:12 PM	2026-03-17 14:10:35.879074
2587	rconstant	COACH STOP	Large Tap Marker	Maine Beer Co - Lunch	1	11/5/2025 12:30 PM	2026-03-17 14:10:35.884453
2588	rconstant	COACH STOP	Large Tap Marker	603 Brew - Winni	1	11/5/2025 12:30 PM	2026-03-17 14:10:35.886897
2589	eplatt	PPC KITCHEN & BAR	Large Tap Marker	Downeast - Cranberry	1	11/5/2025 11:52 AM	2026-03-17 14:10:35.88949
2590	eplatt	PPC KITCHEN & BAR	Large Tap Marker	Wormtown - Blizzard	1	11/5/2025 11:52 AM	2026-03-17 14:10:35.891937
2591	pbelanger	EMMAS 321	Large Tap Marker	Jack's Abby - Extra Layer	1	11/5/2025 11:30 AM	2026-03-17 14:10:35.894834
2566	jmorse	POLISH AMER CITIZENS CLUB-CLAREMONT	Large Tap Marker	Downeast - Original	2	11/10/2025 3:18 PM	2026-03-17 19:05:56.265686
2580	jsewall	APPLEBEES - W.LEB #6732	Large Tap Marker	Stella Artois	2	11/6/2025 12:16 PM	2026-03-17 19:05:56.268004
2586	lnorton	COPPER DOOR - BEDFORD	Large Tap Marker	Jack's Abby - Extra Layer	2	11/5/2025 1:06 PM	2026-03-17 19:05:56.270295
2592	eleahy	HARE OF THE DAWG BAR & GRILL	Large Tap Marker	Mich Ultra	1	11/5/2025 11:07 AM	2026-03-17 14:10:35.89741
2593	rconstant	PASQUALE'S RISTORANTE	Large Tap Marker	Tuckerman - Pale Ale	1	11/5/2025 11:03 AM	2026-03-17 14:10:35.900151
2594	sshaunessy	99 REST - NASHUA	Large Tap Marker	Wormtown - Be Hoppy	1	11/5/2025 9:45 AM	2026-03-17 14:10:35.902737
2595	ggage	GIORGIO'S RISTORANTE - MILFORD	Large Tap Marker	Concord Craft - Squirrel Fights	1	11/4/2025 4:38 PM	2026-03-17 14:10:35.905327
2596	pbelanger	BOWLING ACRES	Large Tap Marker	Able - Victory Nor Defeat	1	11/4/2025 12:37 PM	2026-03-17 14:10:35.908278
2597	pbelanger	BOWLING ACRES	Large Tap Marker	Widowmaker - Blue Comet	1	11/4/2025 12:37 PM	2026-03-17 14:10:35.910769
2605	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Concord Craft - Blue Coggler	2	11/3/2025 1:05 PM	2026-03-17 19:05:56.273462
2622	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Throwback - Cheek Squeezer	2	10/30/2025 11:37 AM	2026-03-17 19:05:56.276542
2600	eleahy	FODY'S TAVERN (DERRY)	Large Tap Marker	Wormtown - Blizzard	1	11/4/2025 9:54 AM	2026-03-17 14:10:35.919414
2601	jcannamucio	DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)	Large Tap Marker	Downeast - Caramel Apple	1	11/3/2025 4:03 PM	2026-03-17 14:10:35.921863
2643	sshaunessy	AMERICAN LEGION POST 11 - JAFFREY	Large Tap Marker	Mich Ultra	2	10/28/2025 1:02 PM	2026-03-17 19:05:56.279679
2604	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	603 Brew - APL	1	11/3/2025 1:41 PM	2026-03-17 14:10:35.929246
2606	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Left Hand - Mexican Hot Choc Milk Stout	1	11/3/2025 1:05 PM	2026-03-17 14:10:35.934237
2607	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Lord Hobo - Boomsauce	1	11/3/2025 1:05 PM	2026-03-17 14:10:35.936767
2608	ggage	AMERICAN LEGION POST 10 - WILTON	Large Tap Marker	1911 - Cider Donut	1	11/2/2025 12:30 PM	2026-03-17 14:10:35.939151
2609	amartin	LA HACIENDA DEL RIO	Large Tap Marker	Fiddlehead - IPA	1	10/30/2025 3:57 PM	2026-03-17 14:10:35.941758
2612	jjohnson	JESSE'S STEAKHOUSE	Large Tap Marker	603 Brew - APL	1	10/30/2025 3:24 PM	2026-03-17 14:10:35.949116
2613	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Able - Gemultich German Lager	1	10/30/2025 3:15 PM	2026-03-17 14:10:35.951443
2614	lnorton	RIVER ROAD TAVERN	Large Tap Marker	1911 - Maple Bourbon Cider	1	10/30/2025 3:15 PM	2026-03-17 14:10:35.953776
2615	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	603 Brew - APL	1	10/30/2025 2:45 PM	2026-03-17 14:10:35.956278
2616	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Henniker - West Coast Colab	1	10/30/2025 2:32 PM	2026-03-17 14:10:35.958814
2617	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	603 Brew - APL	1	10/30/2025 2:32 PM	2026-03-17 14:10:35.961367
2618	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Downeast - Original	1	10/30/2025 2:32 PM	2026-03-17 14:10:35.963885
2619	maanderson	PENUCHE'S ALE HOUSE-NASHUA	Large Tap Marker	603 Brew - APL	1	10/30/2025 2:29 PM	2026-03-17 14:10:35.966336
2620	jgiuffrida	TOMO STEAKHOUSE	Large Tap Marker	Mich Ultra	1	10/30/2025 12:57 PM	2026-03-17 14:10:35.968634
2621	jaustin	CLIFFY'S PUB	Large Tap Marker	Deciduous - Easy Operator	1	10/30/2025 12:18 PM	2026-03-17 14:10:35.970955
2624	sshaunessy	SUN BAR & GRILL	Large Tap Marker	Concord Craft - Squirrel Fights	1	10/29/2025 5:05 PM	2026-03-17 14:10:35.979197
2625	scamuso	EVVIVA TRATTORIA - NASHUA	Large Tap Marker	Jack's Abby - House Lager	1	10/29/2025 3:32 PM	2026-03-17 14:10:35.9817
2627	amartin	FODY'S TAVERN (NASHUA)	Large Tap Marker	Tuckerman - Pale Ale	1	10/29/2025 3:15 PM	2026-03-17 14:10:35.986811
2628	jmeharg	BLUE BEAR HOSPITALITY LLC	Large Tap Marker	von Trapp - Vienna	1	10/29/2025 3:10 PM	2026-03-17 14:10:35.989627
2630	pbelanger	EMMAS 321	Large Tap Marker	603 Brew - APL	1	10/29/2025 1:49 PM	2026-03-17 14:10:35.99451
2631	eplatt	PPC KITCHEN & BAR	Large Tap Marker	603 Brew - APL	1	10/29/2025 1:44 PM	2026-03-17 14:10:35.997324
2632	eplatt	PPC KITCHEN & BAR	Large Tap Marker	Concord Craft - White Mtn White	1	10/29/2025 1:44 PM	2026-03-17 14:10:35.999758
2633	eplatt	PPC KITCHEN & BAR	Large Tap Marker	Deciduous - Easier Operator	1	10/29/2025 1:44 PM	2026-03-17 14:10:36.002178
2635	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	von Trapp - Dunkel	1	10/29/2025 1:11 PM	2026-03-17 14:10:36.006988
2636	lnorton	NH SPORTSPLEX	Large Tap Marker	Sea Dog - Blueberry	1	10/29/2025 12:59 PM	2026-03-17 14:10:36.00945
2637	sshaunessy	BOWLING ACRES	Large Tap Marker	Mich Ultra	1	10/29/2025 11:36 AM	2026-03-17 14:10:36.011951
2638	sshaunessy	BOWLING ACRES	Large Tap Marker	Kelsen - Paradigm	1	10/29/2025 11:36 AM	2026-03-17 14:10:36.014245
2639	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Fiddlehead - IPA	1	10/29/2025 11:14 AM	2026-03-17 14:10:36.016971
2642	jcannamucio	GRUMPY'S BAR & GRILL	Large Tap Marker	603 Brew - APL	1	10/28/2025 2:34 PM	2026-03-17 14:10:36.02408
2645	jcannamucio	CARRIAGE TOWN BAR & GRILL	Large Tap Marker	603 Brew - APL	1	10/27/2025 4:04 PM	2026-03-17 14:10:36.031421
2646	sshaunessy	RILEY'S PLACE	Large Tap Marker	Deciduous - Easy Operator	1	10/27/2025 3:28 PM	2026-03-17 14:10:36.034268
2647	jmeharg	TAVERN ON THE GREENS	Large Tap Marker	Concord Craft - Squirrel Fights	1	10/27/2025 3:08 PM	2026-03-17 14:10:36.036591
2648	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Cigar City - Maduro	1	10/27/2025 2:57 PM	2026-03-17 14:10:36.038947
2649	maanderson	NATIONAL CLUB (THE)	Large Tap Marker	Hacker-Pschorr	1	10/27/2025 2:41 PM	2026-03-17 14:10:36.041233
2650	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Able - Victory Nor Defeat	1	10/27/2025 2:16 PM	2026-03-17 14:10:36.043996
2651	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Zero Gravity - Pisolino	1	10/27/2025 2:16 PM	2026-03-17 14:10:36.046656
2652	jjohnson	SNAX	Large Tap Marker	Tuckerman - Pale Ale	1	10/27/2025 1:36 PM	2026-03-17 14:10:36.048988
2653	jjohnson	SNAX	Large Tap Marker	Downeast - Caramel Apple	1	10/27/2025 1:15 PM	2026-03-17 14:10:36.051307
2654	jmeharg	AMERICAN LEGION POST 59 - HILLSBORO	Large Tap Marker	Henniker - Flap Jack	1	10/27/2025 12:15 PM	2026-03-17 14:10:36.0535
2655	jsewall	LEBANON LODGE OF ELKS	Large Tap Marker	Tuckerman - Pale Ale	1	10/27/2025 12:10 PM	2026-03-17 14:10:36.056845
2656	ddooling	TIO JUAN'S MARGARITAS MEXICAN REST-SALEM	Large Tap Marker	603 Brew - APL	1	10/23/2025 4:58 PM	2026-03-17 14:10:36.059978
2657	ddooling	PEPPERS PUB (NEW)	Large Tap Marker	Shipyard - Smashed Pumpkin	1	10/23/2025 4:38 PM	2026-03-17 14:10:36.063765
2658	lortiz	LUI LUI - NASHUA	Large Tap Marker	Kona - Big Wave	1	10/23/2025 4:02 PM	2026-03-17 14:10:36.066396
2659	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	603 Brew - APL	1	10/23/2025 3:57 PM	2026-03-17 14:10:36.069408
2660	jaustin	GUERRILLA GRILL	Large Tap Marker	603 Brew - Coffee Cake Porter	1	10/23/2025 3:07 PM	2026-03-17 14:10:36.071719
2663	jgiuffrida	RED ROBIN GOURMET BURGERS - SALEM	Large Tap Marker	603 Brew - Wood Devil IPA	2	10/23/2025 1:48 PM	2026-03-17 19:05:56.281919
2662	jgiuffrida	DREO FOOD AND DRINK	Large Tap Marker	Deciduous - Easy Operator	1	10/23/2025 2:08 PM	2026-03-17 14:10:36.07649
2664	jmeharg	DANIEL'S PUB INC	Large Tap Marker	Henniker - West Coast Colab	1	10/23/2025 1:20 PM	2026-03-17 14:10:36.081632
2665	pbelanger	MEXICA MEXICAN RESTAURANT	Large Tap Marker	Deciduous - Easy Operator	1	10/22/2025 4:11 PM	2026-03-17 14:10:36.084684
2666	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Henniker - Flap Jack	1	10/22/2025 3:54 PM	2026-03-17 14:10:36.087597
2677	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Downeast - Caramel Apple	2	10/22/2025 1:14 PM	2026-03-17 19:05:56.28723
2678	lnorton	COPPER DOOR - BEDFORD	Large Tap Marker	603 Brew - Slightly Tstd	2	10/22/2025 12:53 PM	2026-03-17 19:05:56.289562
2683	ddooling	PRESSED CAFE - SALEM	Large Tap Marker	603 Brew - Winni	2	10/22/2025 11:35 AM	2026-03-17 19:05:56.292045
2670	scamuso	BOBOLA RESTAURANT	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	10/22/2025 3:21 PM	2026-03-17 14:10:36.098116
2671	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Austin Street - Patina	1	10/22/2025 3:04 PM	2026-03-17 14:10:36.100647
2672	sshaunessy	MI JALISCO - PETERBORO	Large Tap Marker	Fiddlehead - IPA	1	10/22/2025 2:58 PM	2026-03-17 14:10:36.103322
2673	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Lord Hobo - Boomsauce	1	10/22/2025 2:55 PM	2026-03-17 14:10:36.106423
2676	jgrumblatt	PETER CHRISTIANS TAVERN	Large Tap Marker	14th Star - Maple Br	1	10/22/2025 1:20 PM	2026-03-17 14:10:36.113995
2679	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	New Belgium - Juicy Haze	1	10/22/2025 11:45 AM	2026-03-17 14:10:36.12167
2680	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Founders - CBS	1	10/22/2025 11:45 AM	2026-03-17 14:10:36.124045
2681	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Wormtown - Fresh Patch	1	10/22/2025 11:45 AM	2026-03-17 14:10:36.126288
2682	jsewall	WEATHERVANE - W.LEB	Large Tap Marker	Downeast - Caramel Apple	1	10/22/2025 11:36 AM	2026-03-17 14:10:36.128591
2686	sshaunessy	DEL ROSSI'S TRATTORIA OF DUBLIN	Large Tap Marker	Stoneface - Duderino	1	10/21/2025 2:32 PM	2026-03-17 14:10:36.142066
2687	sshaunessy	DEL ROSSI'S TRATTORIA OF DUBLIN	Large Tap Marker	Maine Beer Co - Lunch	1	10/21/2025 2:32 PM	2026-03-17 14:10:36.144418
2688	sshaunessy	DEL ROSSI'S TRATTORIA OF DUBLIN	Large Tap Marker	Citizen Cider - Unified Press	1	10/21/2025 2:32 PM	2026-03-17 14:10:36.146911
2689	ggage	AMERICAN LEGION POST 23 - MILFORD	Large Tap Marker	von Trapp - Oktober	1	10/21/2025 2:12 PM	2026-03-17 14:10:36.149371
2695	maanderson	PINE VALLEY GOLF COURSE	Large Tap Marker	603 Brew - Coffee Cake Porter	1	10/21/2025 12:49 PM	2026-03-17 14:10:36.164119
2697	jgrumblatt	SALT HILL PUB - NEWBURY	Large Tap Marker	Maine Beer Co - Lunch	1	10/21/2025 12:09 PM	2026-03-17 14:10:36.169196
2698	rconstant	SUPPAS PIZZA LONDONDERRY	Large Tap Marker	Downeast - Cider Donut	1	10/21/2025 10:59 AM	2026-03-17 14:10:36.171557
2699	ggage	VFW #4368 - MILFORD	Large Tap Marker	Henniker - Flap Jack	1	10/21/2025 10:33 AM	2026-03-17 14:10:36.174202
2700	lortiz	LONGHORN STEAK #5457 - NASHUA	Large Tap Marker	Bud Light	1	10/20/2025 4:54 PM	2026-03-17 14:10:36.176584
2701	lortiz	RED ROBIN BURGERS #515 NASHUA	Large Tap Marker	Downeast - Caramel Apple	1	10/20/2025 4:16 PM	2026-03-17 14:10:36.179043
2703	jmeharg	HILLSBORO HOUSE OF PIZZA	Large Tap Marker	Henniker - Flap Jack	1	10/20/2025 3:43 PM	2026-03-17 14:10:36.184006
2706	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Shipyard - Smashed Pumpkin	1	10/20/2025 2:42 PM	2026-03-17 14:10:36.19169
2717	scamuso	COURTYARD BY MARRIOTT - NASHUA	Large Tap Marker	603 Brew - Wood Devil IPA	2	10/16/2025 1:55 PM	2026-03-17 19:05:56.294545
2711	jaustin	GUERRILLA GRILL	Large Tap Marker	Southern - Caramel Pumking	1	10/16/2025 2:46 PM	2026-03-17 14:10:36.205608
2712	jaustin	GUERRILLA GRILL	Large Tap Marker	Wormtown - Be Hoppy	1	10/16/2025 2:46 PM	2026-03-17 14:10:36.208653
2722	jaustin	CHILI'S - KEENE	Large Tap Marker	Downeast - Pumpkin	2	10/16/2025 11:18 AM	2026-03-17 19:05:56.297475
2730	pbelanger	EMMAS 321	Large Tap Marker	Citizen Cider - BD Donut	2	10/15/2025 3:24 PM	2026-03-17 19:05:56.299878
2746	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Downeast - Caramel Apple	2	10/14/2025 10:52 AM	2026-03-17 19:05:56.303212
2751	pwollert	21 ROXBURY BAR & GRILL	Large Tap Marker	Maine Beer Co - Lunch	2	10/9/2025 3:36 PM	2026-03-17 19:05:56.30576
2718	jaustin	LOCAL BURGER OF KEENE	Large Tap Marker	Henniker - Flap Jack	1	10/16/2025 1:52 PM	2026-03-17 14:10:36.223779
2753	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Other Half - Ticker Shock	2	10/9/2025 2:54 PM	2026-03-17 19:05:56.30901
2720	jaustin	NOBLE RAMEN HOUSE	Large Tap Marker	Deciduous - Lollipop Rasp	1	10/16/2025 12:38 PM	2026-03-17 14:10:36.228993
2721	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	14th Star - Mexican Lager	1	10/16/2025 11:58 AM	2026-03-17 14:10:36.231428
2723	jmorse	WAL-MART #1975 - CLAREMONT	Large Tap Marker	Mich Ultra	1	10/16/2025 10:14 AM	2026-03-17 14:10:36.23674
2724	jmorse	WAL-MART #1975 - CLAREMONT	Large Tap Marker	Shocktop	1	10/16/2025 10:14 AM	2026-03-17 14:10:36.239709
2725	jmorse	WAL-MART #1975 - CLAREMONT	Large Tap Marker	Maine Beer Co - Lunch	1	10/16/2025 10:14 AM	2026-03-17 14:10:36.242665
2726	rconstant	GIABELLA'S	Large Tap Marker	Stoneface - IPA	1	10/15/2025 4:25 PM	2026-03-17 14:10:36.245005
2727	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	603 Brew - IPA	1	10/15/2025 4:19 PM	2026-03-17 14:10:36.247767
2728	amartin	SPECTACLE MANAGEMENT INC	Large Tap Marker	Wormtown - Fresh Patch	1	10/15/2025 3:49 PM	2026-03-17 14:10:36.250165
2729	amartin	SPECTACLE MANAGEMENT INC	Large Tap Marker	14th Star - Maple Br	1	10/15/2025 3:49 PM	2026-03-17 14:10:36.252487
2731	pbelanger	EMMAS 321	Large Tap Marker	Citizen Cider - B Cider	1	10/15/2025 3:24 PM	2026-03-17 14:10:36.257519
2732	eplatt	PPC KITCHEN & BAR	Large Tap Marker	Southern - Caramel Pumking	1	10/15/2025 3:01 PM	2026-03-17 14:10:36.260138
2733	pwollert	THE CLUBHOUSE BAR AND GRILLE	Large Tap Marker	Bud Light	1	10/15/2025 1:36 PM	2026-03-17 14:10:36.262657
2734	pwollert	THE CLUBHOUSE BAR AND GRILLE	Large Tap Marker	Fiddlehead - IPA	1	10/15/2025 1:36 PM	2026-03-17 14:10:36.265323
2760	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Shipyard - Smashed Pumpkin	2	10/9/2025 11:53 AM	2026-03-17 19:05:56.311864
2738	jsewall	THREE TOMATOES TRATTORIA	Large Tap Marker	Wormtown - Fresh Patch	1	10/15/2025 6:58 AM	2026-03-17 14:10:36.275509
2739	pbelanger	RUSTIC TABLE (THE)	Large Tap Marker	Jack's Abby - House Lager	1	10/14/2025 4:30 PM	2026-03-17 14:10:36.278543
2741	jmeharg	STONEBRIDGE COUNTRY CLUB	Large Tap Marker	Henniker - Wrking Man Porter	1	10/14/2025 12:52 PM	2026-03-17 14:10:36.283773
2742	maanderson	PINE VALLEY GOLF COURSE	Large Tap Marker	603 Brew - Slightly Tstd	1	10/14/2025 12:02 PM	2026-03-17 14:10:36.286579
2743	jsewall	THREE TOMATOES TRATTORIA	Large Tap Marker	603 Brew - Slightly Tstd	1	10/14/2025 11:47 AM	2026-03-17 14:10:36.289411
2744	jsewall	UPPER VALLEY EVENT CENTER	Large Tap Marker	Concord Craft - Squirrel Fights	1	10/14/2025 11:42 AM	2026-03-17 14:10:36.29206
2745	jmorse	IMPERIAL BUFFET & LOUNGE	Large Tap Marker	Mich Ultra	1	10/14/2025 11:15 AM	2026-03-17 14:10:36.296047
2749	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Shocktop	1	10/13/2025 11:03 AM	2026-03-17 14:10:36.306112
2750	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Maine Beer Co - Lunch	1	10/13/2025 11:03 AM	2026-03-17 14:10:36.308521
2752	jjohnson	JESSE'S STEAKHOUSE	Large Tap Marker	603 Brew - Winni	1	10/9/2025 3:24 PM	2026-03-17 14:10:36.313351
2754	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Other Half - LACEd in Space	1	10/9/2025 2:54 PM	2026-03-17 14:10:36.318386
2755	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Able - Burn the Ships	1	10/9/2025 2:51 PM	2026-03-17 14:10:36.320941
2756	jmorse	WAL-MART #1975 - CLAREMONT	Large Tap Marker	Frost - Lush	1	10/9/2025 1:58 PM	2026-03-17 14:10:36.323481
2757	amartin	LYNN'S 102 TAVERN	Large Tap Marker	Concord Craft - Four Rivers	1	10/9/2025 1:49 PM	2026-03-17 14:10:36.328142
2758	ggage	ROUTE 13 STATELINE CONV MART	Large Tap Marker	Bells - Two Hearted	1	10/9/2025 12:11 PM	2026-03-17 14:10:36.330724
2759	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Epigram - Temptation	1	10/9/2025 11:54 AM	2026-03-17 14:10:36.333458
2762	jmeharg	BLUE BEAR HOSPITALITY LLC	Large Tap Marker	Able - Homecoming Pumpkin Ale	1	10/8/2025 3:56 PM	2026-03-17 14:10:36.341223
2763	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Able - Lady of the Lake	1	10/8/2025 3:50 PM	2026-03-17 14:10:36.343799
2766	amartin	SURF RESTAURANT INC	Large Tap Marker	Concord Craft - Squirrel Fights	1	10/8/2025 3:01 PM	2026-03-17 14:10:36.354487
2767	jsewall	SAWTOOTH KITCHEN LLC	Large Tap Marker	Throwback - Rule Roost	1	10/8/2025 1:10 PM	2026-03-17 14:10:36.35703
2768	jaustin	GUERRILLA GRILL	Large Tap Marker	Zero Gravity - Woodchuck	1	10/8/2025 12:53 PM	2026-03-17 14:10:36.359368
2771	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	von Trapp - Dunkel	2	10/8/2025 12:20 PM	2026-03-17 19:05:56.314646
2782	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	Concord Craft - Four Rivers	3	10/6/2025 2:03 PM	2026-03-17 19:05:56.317552
2772	pbelanger	EMMAS 321	Large Tap Marker	Deciduous - Easy Operator	1	10/8/2025 11:40 AM	2026-03-17 14:10:36.369625
2773	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Maine Beer Co - Waters	1	10/8/2025 11:02 AM	2026-03-17 14:10:36.484178
2774	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Maine Beer Co - Tiny	1	10/8/2025 11:02 AM	2026-03-17 14:10:36.486723
2787	lnorton	X-GOLF BEDFORD	Large Tap Marker	Shipyard - Pumpkin Head	2	10/2/2025 2:18 PM	2026-03-17 19:05:56.32074
2788	jmeharg	DANIEL'S PUB INC	Large Tap Marker	Henniker - Henni Light	4	10/2/2025 1:49 PM	2026-03-17 19:05:56.324259
2798	pbelanger	MEXICA MEXICAN RESTAURANT	Large Tap Marker	Shipyard - Pumpkin Head	2	10/1/2025 2:19 PM	2026-03-17 19:05:56.327544
2778	jaustin	NOBLE RAMEN HOUSE	Large Tap Marker	Other Half - Broccoli	1	10/7/2025 12:53 PM	2026-03-17 14:10:36.496752
2779	jaustin	NOBLE RAMEN HOUSE	Large Tap Marker	Bud Light	1	10/7/2025 12:53 PM	2026-03-17 14:10:36.499501
2780	ggage	THE BRICKHOUSE RESTAURANT AND BREWERY	Large Tap Marker	Downeast - Original	1	10/7/2025 9:59 AM	2026-03-17 14:10:36.502187
2781	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Fiddlehead - Mastermind	1	10/6/2025 2:07 PM	2026-03-17 14:10:36.504714
2783	maanderson	NATIONAL CLUB (THE)	Large Tap Marker	Tuckerman - Pale Ale	1	10/6/2025 1:25 PM	2026-03-17 14:10:36.509822
2784	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Deciduous - Lollipop Rasp	2	10/6/2025 12:24 PM	2026-03-17 14:10:36.512146
2785	jaustin	GUERRILLA GRILL	Large Tap Marker	BBCO - Barista	1	10/2/2025 3:51 PM	2026-03-17 14:10:36.514636
2786	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Wormtown - Fresh Patch	1	10/2/2025 3:23 PM	2026-03-17 14:10:36.517575
2789	jjohnson	JESSE'S STEAKHOUSE	Large Tap Marker	Mich Ultra	1	10/2/2025 1:14 PM	2026-03-17 14:10:36.525408
2790	jjohnson	JESSE'S STEAKHOUSE	Large Tap Marker	Von Trapp - Polotmavy	1	10/2/2025 1:14 PM	2026-03-17 14:10:36.52837
2805	jgrumblatt	THE REFINERY	Large Tap Marker	Berkshire - Coffehouse Porter	2	10/1/2025 12:54 PM	2026-03-17 19:05:56.330373
2792	jsewall	99 REST - W.LEB	Large Tap Marker	Stella Artois	1	10/2/2025 7:59 AM	2026-03-17 14:10:36.533427
2793	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Shipyard - Pumpkin Head	1	10/2/2025 5:30 AM	2026-03-17 14:10:36.535927
2794	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	603 Brew - Coffee Cake Porter	1	10/1/2025 2:58 PM	2026-03-17 14:10:36.538252
2795	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Deciduous - NH Lager	1	10/1/2025 2:58 PM	2026-03-17 14:10:36.540973
2807	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Concord Craft - Squirrel Fights	2	10/1/2025 11:55 AM	2026-03-17 19:05:56.333662
2813	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Henniker - Flap Jack	2	9/29/2025 3:37 PM	2026-03-17 19:05:56.337351
2799	pbelanger	EMMAS 321	Large Tap Marker	Kelsen - Gallowglass	1	10/1/2025 2:19 PM	2026-03-17 14:10:36.552596
2814	jaustin	CLIFFY'S PUB	Large Tap Marker	Downeast - Cider Donut	2	9/29/2025 1:27 PM	2026-03-17 19:05:56.340484
2824	scamuso	BISTRO 603	Large Tap Marker	Southern - Pumking	2	9/25/2025 9:24 AM	2026-03-17 19:05:56.344411
2802	jgrumblatt	PETER CHRISTIANS TAVERN	Large Tap Marker	Concord Craft - Squirrel Fights	1	10/1/2025 1:51 PM	2026-03-17 14:10:36.560719
2803	jgrumblatt	PETER CHRISTIANS TAVERN	Large Tap Marker	Concord Craft - Four Rivers	1	10/1/2025 1:51 PM	2026-03-17 14:10:36.563242
2804	jgrumblatt	VAIL RESORT/ MOUNT SUNAPEE	Large Tap Marker	Maine Beer Co - Lunch	1	10/1/2025 12:54 PM	2026-03-17 14:10:36.56622
2808	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Epigram - Temptation	1	10/1/2025 11:55 AM	2026-03-17 14:10:36.57881
2810	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	Concord Craft - Squirrel Fights	1	9/30/2025 2:08 PM	2026-03-17 14:10:36.584351
2811	lnorton	LA VAKA MEXICAN RESTAURANT	Large Tap Marker	Shipyard - Pumpkin Head	1	9/30/2025 12:19 PM	2026-03-17 14:10:36.587303
2812	jgiuffrida	LIM'S SPORTS BAR & CAFE	Large Tap Marker	Busch Light	1	9/29/2025 4:48 PM	2026-03-17 14:10:36.58993
2816	jmeharg	CHARTWELL'S DINING SERVICES	Large Tap Marker	Shipyard - Pumpkin Head	1	9/29/2025 12:09 PM	2026-03-17 14:10:36.602066
2817	jaustin	GUERRILLA GRILL	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	9/25/2025 3:34 PM	2026-03-17 14:10:36.607099
2818	maanderson	PENUCHE'S ALE HOUSE-NASHUA	Large Tap Marker	Shocktop - Pretzel	1	9/25/2025 3:02 PM	2026-03-17 14:10:36.610076
2819	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	14th Star - Mexican Lager	1	9/25/2025 3:00 PM	2026-03-17 14:10:36.613073
2820	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	Zero Gravity - Cone Head	1	9/25/2025 2:21 PM	2026-03-17 14:10:36.616032
2821	jsewall	SAWTOOTH KITCHEN LLC	Large Tap Marker	Deciduous - Easy Operator	1	9/25/2025 1:52 PM	2026-03-17 14:10:36.621358
2823	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	Concord Craft - Safe Space	1	9/25/2025 11:52 AM	2026-03-17 14:10:36.627635
2826	lnorton	EVVIVA TRATTORIA - BEDFORD	Large Tap Marker	Shipyard - Pumpkin Head	1	9/24/2025 4:16 PM	2026-03-17 14:10:36.636616
2867	jaustin	A-1 PIZZA & GRILL HINSDALE	Large Tap Marker	Shipyard - Pumpkin Head	2	9/16/2025 4:05 PM	2026-03-17 19:05:56.35074
2828	jgrumblatt	STOCKWELL RESTAURANT	Large Tap Marker	Maine Beer Co - Lunch	1	9/24/2025 1:35 PM	2026-03-17 14:10:36.643096
2829	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	14th Star - Oktoberfest	1	9/24/2025 1:34 PM	2026-03-17 14:10:36.646203
2830	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	14th Star - N Maple Br	1	9/24/2025 12:44 PM	2026-03-17 14:10:36.648891
2831	sshaunessy	POST & BEAM	Large Tap Marker	603 Brew - Smoketoberfest	1	9/24/2025 12:44 PM	2026-03-17 14:10:36.651882
2832	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Founders - Imperial Thorn	1	9/24/2025 11:48 AM	2026-03-17 14:10:36.654286
2833	sshaunessy	BOWLING ACRES	Large Tap Marker	Deciduous - Easy Operator	1	9/24/2025 11:47 AM	2026-03-17 14:10:36.657744
2834	jgrumblatt	RAGGED MOUNTAIN	Large Tap Marker	Shipyard - Pumpkin Head	1	9/24/2025 11:30 AM	2026-03-17 14:10:36.660246
2835	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	Able - Lady of the Lake	1	9/24/2025 9:28 AM	2026-03-17 14:10:36.662839
2836	pwollert	FRATERNAL ORDER OF EAGLES	Large Tap Marker	Mich Ultra	1	9/23/2025 2:36 PM	2026-03-17 14:10:36.665433
2837	jsewall	WICKED TASTY (CATERING)	Large Tap Marker	Fiddlehead - IPA	1	9/23/2025 2:33 PM	2026-03-17 14:10:36.667983
2838	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	14th Star - Maple Br	1	9/23/2025 2:33 PM	2026-03-17 14:10:36.670478
2839	ggage	OLDE KILKENNY PUB	Large Tap Marker	Concord Craft - Squirrel Fights	1	9/23/2025 2:04 PM	2026-03-17 14:10:36.673011
2879	ddooling	MICHAELS FLATBREAD PIZZA CO.	Large Tap Marker	New Belgium - Fat Tire	2	9/15/2025 1:34 PM	2026-03-17 19:05:56.354103
2843	sshaunessy	UNION COFFEE COMPANY	Large Tap Marker	Wormtown - Fresh Patch	1	9/22/2025 2:26 PM	2026-03-17 14:10:36.683554
2844	jmeharg	CHARTWELL'S DINING SERVICES	Large Tap Marker	Henniker - Seltzer Baboosic	1	9/22/2025 1:58 PM	2026-03-17 14:10:36.686028
2845	jaustin	CLIFFY'S PUB	Large Tap Marker	Upper Pass - First Drop	1	9/22/2025 1:32 PM	2026-03-17 14:10:36.689015
2846	jjohnson	SNAX	Large Tap Marker	Equilibrium - MC2	1	9/22/2025 1:23 PM	2026-03-17 14:10:36.691546
2847	jjohnson	SNAX	Large Tap Marker	Shipyard - Pumpkin Head	1	9/22/2025 1:23 PM	2026-03-17 14:10:36.69429
2848	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Stoneface - Sunday Sauce	1	9/22/2025 11:57 AM	2026-03-17 14:10:36.697423
2849	jgiuffrida	99 REST - SALEM	Large Tap Marker	Stella Artois	1	9/22/2025 9:39 AM	2026-03-17 14:10:36.700125
2850	amartin	SURF RESTAURANT INC	Large Tap Marker	Jack's Abby - Copper Legend	1	9/18/2025 3:26 PM	2026-03-17 14:10:36.702706
2851	jgiuffrida	SHAKING SEAFOOD	Large Tap Marker	Shipyard - Pumpkin Head	1	9/18/2025 3:01 PM	2026-03-17 14:10:36.705602
2852	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Southern - Pumking	1	9/18/2025 2:56 PM	2026-03-17 14:10:36.708092
2853	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Founders - Imperial Thorn	1	9/18/2025 2:56 PM	2026-03-17 14:10:36.710603
2854	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	Downeast - Cider Donut	1	9/18/2025 1:16 PM	2026-03-17 14:10:36.713065
2856	jaustin	LOCAL BURGER OF KEENE	Large Tap Marker	Widowmaker - Blue Comet	1	9/17/2025 3:34 PM	2026-03-17 14:10:36.72057
2857	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	True North - Witch	1	9/17/2025 3:06 PM	2026-03-17 14:10:36.72397
2858	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Henniker - Flap Jack	1	9/17/2025 3:06 PM	2026-03-17 14:10:36.726455
2859	amartin	RIVERWALK BAKERY & CAFE	Large Tap Marker	1911 - Cider Donut	1	9/17/2025 1:20 PM	2026-03-17 14:10:36.729435
2860	amartin	RIVERWALK BAKERY & CAFE	Large Tap Marker	Shipyard - Pumpkin Head	1	9/17/2025 1:20 PM	2026-03-17 14:10:36.734024
2861	sshaunessy	COOPER'S HILL	Large Tap Marker	Shipyard - Pumpkin Head	1	9/17/2025 1:19 PM	2026-03-17 14:10:36.73669
2862	sshaunessy	BOWLING ACRES	Large Tap Marker	Mighty Squirrel - Oktoberfest	1	9/17/2025 1:13 PM	2026-03-17 14:10:36.739817
2863	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	603 Brew - Octoberfest	1	9/17/2025 12:30 PM	2026-03-17 14:10:36.742981
2866	sshaunessy	HAMPSHIRE HILLS S&F CLUB	Large Tap Marker	Concord Craft - Squirrel Fights	1	9/16/2025 4:16 PM	2026-03-17 14:10:36.752201
2868	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Henniker - Oktoberfest	1	9/16/2025 3:39 PM	2026-03-17 14:10:36.757809
2870	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Fiddlehead - IPA	1	9/16/2025 12:10 PM	2026-03-17 14:10:36.763741
2871	eleahy	FODY'S TAVERN (DERRY)	Large Tap Marker	Tuckerman - Pale Ale	1	9/16/2025 11:25 AM	2026-03-17 14:10:36.766863
2872	ggage	VFW #4368 - MILFORD	Large Tap Marker	Able - Burn the Ships	1	9/16/2025 10:57 AM	2026-03-17 14:10:36.769363
2873	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	Shipyard - Pumpkin Head	1	9/15/2025 2:46 PM	2026-03-17 14:10:36.771833
2874	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	von Trapp - Oktober	1	9/15/2025 2:11 PM	2026-03-17 14:10:36.774368
2875	jsewall	WICKED TASTY (CATERING)	Large Tap Marker	Zero Gravity - Cone Head	1	9/15/2025 1:51 PM	2026-03-17 14:10:36.777212
2876	jsewall	WICKED TASTY (CATERING)	Large Tap Marker	Shipyard - Pumpkin Head	1	9/15/2025 1:51 PM	2026-03-17 14:10:36.779822
2877	jsewall	WICKED TASTY (CATERING)	Large Tap Marker	Jack's Abby - Copper Legend	1	9/15/2025 1:51 PM	2026-03-17 14:10:36.78234
2878	jsewall	WICKED TASTY (CATERING)	Large Tap Marker	von Trapp - Oktober	1	9/15/2025 1:51 PM	2026-03-17 14:10:36.78476
2882	jsewall	LEBANON LODGE OF ELKS	Large Tap Marker	Shipyard - Pumpkin Head	1	9/15/2025 11:15 AM	2026-03-17 14:10:36.796576
2883	scamuso	BOBOLA RESTAURANT	Large Tap Marker	Shipyard - Pumpkin Head	1	9/11/2025 3:45 PM	2026-03-17 14:10:36.799543
2884	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	603 Brew - Slightly Tstd	1	9/10/2025 4:37 PM	2026-03-17 14:10:36.802334
2885	jaustin	GUERRILLA GRILL	Large Tap Marker	603 Brew - Slightly Tstd	1	9/10/2025 3:55 PM	2026-03-17 14:10:36.804951
2886	jaustin	THE PERCH	Large Tap Marker	Fiddlehead - IPA	1	9/10/2025 3:54 PM	2026-03-17 14:10:36.807467
2888	jaustin	THE PERCH	Large Tap Marker	Shipyard - Pumpkin Head	1	9/10/2025 3:54 PM	2026-03-17 14:10:36.812393
2889	jaustin	THE PERCH	Large Tap Marker	Carlson - Oak Hill	1	9/10/2025 3:54 PM	2026-03-17 14:10:36.815191
2890	jaustin	THE PERCH	Large Tap Marker	Dos Equis Amber	1	9/10/2025 3:54 PM	2026-03-17 14:10:36.817752
2891	jaustin	THE PERCH	Large Tap Marker	Founders - All Day IPA	1	9/10/2025 3:54 PM	2026-03-17 14:10:36.820282
2892	jaustin	THE PERCH	Large Tap Marker	Bud Light	1	9/10/2025 3:54 PM	2026-03-17 14:10:36.823047
2894	lnorton	RIVER ROAD TAVERN	Large Tap Marker	14th Star - Remix	1	9/10/2025 3:42 PM	2026-03-17 14:10:36.828189
2897	pwollert	ALYSONS ORCHARD	Large Tap Marker	Shipyard - Pumpkin Head	1	9/10/2025 3:38 PM	2026-03-17 14:10:36.836489
2887	jaustin	GUERRILLA GRILL	Large Tap Marker	True North - Witch	2	9/10/2025 3:54 PM	2026-03-17 19:05:56.356811
2893	rconstant	GIABELLA'S	Large Tap Marker	Shipyard - Pumpkin Head	2	9/10/2025 3:51 PM	2026-03-17 19:05:56.36013
2901	scamuso	EVVIVA TRATTORIA - NASHUA	Large Tap Marker	Shipyard - Pumpkin Head	1	9/10/2025 2:00 PM	2026-03-17 14:10:36.847137
2902	jaustin	KILKENNY PUB - KEENE	Large Tap Marker	14th Star - Remix	1	9/10/2025 1:38 PM	2026-03-17 14:10:36.850257
2903	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Equilibrium - Mmm...Osa	1	9/10/2025 1:01 PM	2026-03-17 14:10:36.853019
2906	jgrumblatt	SUNA RESTAURANT	Large Tap Marker	Henniker - Wrking Man Porter	1	9/10/2025 9:38 AM	2026-03-17 14:10:36.861482
2907	jgrumblatt	SUNA RESTAURANT	Large Tap Marker	Jack's Abby - Copper Legend	1	9/10/2025 9:38 AM	2026-03-17 14:10:36.864795
2895	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Foundation - Fetch	2	9/10/2025 3:42 PM	2026-03-17 19:05:56.36414
2896	lnorton	RIVER ROAD TAVERN	Large Tap Marker	BBCO - Good Company	2	9/10/2025 3:42 PM	2026-03-17 19:05:56.367711
2904	rconstant	AJ'S SPORTS BAR & GRILL	Large Tap Marker	Shipyard - Pumpkin Head	2	9/10/2025 12:00 PM	2026-03-17 19:05:56.371888
2913	jaustin	MI JALISCO - KEENE	Large Tap Marker	Bud Light	1	9/9/2025 11:32 AM	2026-03-17 14:10:36.881896
2905	jaustin	TEMPESTA'S	Large Tap Marker	Shipyard - Pumpkin Head	2	9/10/2025 11:28 AM	2026-03-17 19:05:56.374706
2916	jjohnson	SNAX	Large Tap Marker	Epigram - Liam's Lager	1	9/8/2025 1:56 PM	2026-03-17 14:10:36.890456
2917	eleahy	T-BONES - DERRY	Large Tap Marker	Citizen Cider - Unified Press	1	9/8/2025 1:26 PM	2026-03-17 14:10:36.892854
2918	ddooling	COPPER DOOR - SALEM	Large Tap Marker	Shipyard - Pumpkin Head	1	9/8/2025 1:02 PM	2026-03-17 14:10:36.895143
2919	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Maine Beer Co - Dinner	1	9/8/2025 11:45 AM	2026-03-17 14:10:36.897689
2920	pwollert	MADAME SHERRI'S	Large Tap Marker	Downeast - Cider Donut	1	9/8/2025 8:43 AM	2026-03-17 14:10:36.900162
2921	jmorse	POOR THOMS TAVERN	Large Tap Marker	Von Trapp - Polotmavy	1	9/6/2025 9:52 AM	2026-03-17 14:10:36.902772
2922	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	Able - Victory Nor Defeat	1	9/4/2025 3:26 PM	2026-03-17 14:10:36.905164
2923	lnorton	PRESSED CAFE - BEDFORD	Large Tap Marker	Downeast - Cider Donut	1	9/4/2025 3:16 PM	2026-03-17 14:10:36.907978
2924	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Able - Lady of the Lake	1	9/4/2025 2:51 PM	2026-03-17 14:10:36.910461
2927	jgiuffrida	RED ROBIN GOURMET BURGERS - SALEM	Large Tap Marker	Shipyard - Pumpkin Head	1	9/4/2025 1:51 PM	2026-03-17 14:10:36.918269
2910	pbelanger	MAMA MCDONOUGH'S IRISH PUB	Large Tap Marker	Downeast - Blackberry	3	9/9/2025 2:56 PM	2026-03-17 19:05:56.378566
2912	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Shipyard - Pumpkin Head	2	9/9/2025 12:46 PM	2026-03-17 19:05:56.381572
2930	jmeharg	DANIEL'S PUB INC	Large Tap Marker	Henniker - Oktoberfest	1	9/4/2025 12:52 PM	2026-03-17 14:10:36.925703
2931	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Shipyard - Pumpkin Head	1	9/4/2025 12:43 PM	2026-03-17 14:10:36.929592
2933	pbelanger	MAMA MCDONOUGH'S IRISH PUB	Large Tap Marker	Shipyard - Pumpkin Head	1	9/4/2025 11:34 AM	2026-03-17 14:10:36.936925
2914	amartin	SAKURA	Large Tap Marker	Shipyard - Pumpkin Head	2	9/8/2025 3:24 PM	2026-03-17 19:05:56.38425
2925	jgiuffrida	DREO FOOD AND DRINK	Large Tap Marker	Shipyard - Pumpkin Head	2	9/4/2025 2:36 PM	2026-03-17 19:05:56.386751
2936	amartin	FODY'S TAVERN (NASHUA)	Large Tap Marker	Shipyard - Pumpkin Head	1	9/3/2025 3:55 PM	2026-03-17 14:10:36.94575
2937	jaustin	TEMPESTA'S	Large Tap Marker	Downeast - Cider Donut	1	9/3/2025 2:42 PM	2026-03-17 14:10:36.948472
2926	lnorton	T-BONES - BEDFORD	Large Tap Marker	Shipyard - Pumpkin Head	2	9/4/2025 1:55 PM	2026-03-17 19:05:56.39041
2932	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	Shipyard - Pumpkin Head	2	9/4/2025 11:59 AM	2026-03-17 19:05:56.393489
2943	jgrumblatt	PETER CHRISTIANS TAVERN	Large Tap Marker	Shipyard - Pumpkin Head	2	9/3/2025 1:29 PM	2026-03-17 19:05:56.404262
2942	jmeharg	BLUE BEAR HOSPITALITY LLC	Large Tap Marker	Shipyard - Pumpkin Head	1	9/3/2025 1:51 PM	2026-03-17 14:10:36.968066
2944	pbelanger	WOODBOUND INN	Large Tap Marker	Shipyard - Pumpkin Head	1	9/3/2025 11:27 AM	2026-03-17 14:10:36.973171
2945	jsewall	TARGET # 3401 - W. LEBANON	Large Tap Marker	Shipyard - Pumpkin Head	1	9/3/2025 10:35 AM	2026-03-17 14:10:36.97599
2946	jcannamucio	JAMISON'S	Large Tap Marker	Weihenstephaner - Hefe Dunkel	1	9/2/2025 3:53 PM	2026-03-17 14:10:36.978451
2950	pwollert	POUR HOUSE (THE)	Large Tap Marker	Fiddlehead - White	2	9/2/2025 1:53 PM	2026-03-17 19:05:56.40946
2956	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Shipyard - Pumpkin Head	3	9/1/2025 12:01 PM	2026-03-17 19:05:56.412682
2949	lnorton	MANCHESTER COUNTRY CLUB	Large Tap Marker	Henniker - Oktoberfest	1	9/2/2025 2:43 PM	2026-03-17 14:10:36.986691
2951	sshaunessy	RILEY'S PLACE	Large Tap Marker	Shipyard - Pumpkin Head	1	9/2/2025 12:22 PM	2026-03-17 14:10:36.992548
2952	pwollert	MADAME SHERRI'S	Large Tap Marker	Carlson - Oak Hill	1	9/2/2025 9:31 AM	2026-03-17 14:10:36.995735
2953	amartin	LA CARRETA - NASHUA	Large Tap Marker	Shipyard - Pumpkin Head	1	9/1/2025 4:25 PM	2026-03-17 14:10:36.998367
2960	lnorton	RIVER ROAD TAVERN	Large Tap Marker	603 Brew - Slightly Tstd	2	8/28/2025 4:09 PM	2026-03-17 19:05:56.41567
2955	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Citizen Cider - Unified Press	1	9/1/2025 12:01 PM	2026-03-17 14:10:37.00346
2957	jmorse	AMERICAN LEGION POST 29 - CLAREMONT	Large Tap Marker	Shipyard - Pumpkin Head	1	9/1/2025 11:46 AM	2026-03-17 14:10:37.008901
2958	jgiuffrida	99 REST - SALEM	Large Tap Marker	Shipyard - Pumpkin Head	1	9/1/2025 10:31 AM	2026-03-17 14:10:37.011597
2961	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Carlson - Oak Hill	2	8/28/2025 4:09 PM	2026-03-17 19:05:56.418284
2962	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Downeast - Cider Donut	1	8/28/2025 4:09 PM	2026-03-17 14:10:37.023907
2963	lnorton	PRESSED CAFE - BEDFORD	Large Tap Marker	603 Brew - Slightly Tstd	1	8/28/2025 3:55 PM	2026-03-17 14:10:37.026758
2964	amartin	SURF RESTAURANT INC	Large Tap Marker	von Trapp - Oktober	1	8/28/2025 3:29 PM	2026-03-17 14:10:37.029577
2968	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	Shipyard - Pumpkin Head	2	8/28/2025 2:25 PM	2026-03-17 19:05:56.420635
2975	jaustin	MAIN CRUST CO.	Large Tap Marker	True North - Witch	2	8/27/2025 4:26 PM	2026-03-17 19:05:56.423729
2967	pwollert	21 ROXBURY BAR & GRILL	Large Tap Marker	Shipyard - Pumpkin Head	1	8/28/2025 2:38 PM	2026-03-17 14:10:37.038992
2969	jaustin	GUERRILLA GRILL	Large Tap Marker	Widowmaker - Blue Comet	1	8/28/2025 2:22 PM	2026-03-17 14:10:37.044885
2970	pwollert	WATKINS INN & TAVERN	Large Tap Marker	Shipyard - Pumpkin Head	1	8/28/2025 11:49 AM	2026-03-17 14:10:37.048192
2971	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Hacker-Pschorr	1	8/28/2025 11:36 AM	2026-03-17 14:10:37.05132
2980	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Shipyard - Pumpkin Head	2	8/27/2025 11:31 AM	2026-03-17 19:05:56.426431
2973	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Henniker - Flap Jack	1	8/27/2025 6:32 PM	2026-03-17 14:10:37.062152
2974	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	1911 - Cider Donut	1	8/27/2025 4:53 PM	2026-03-17 14:10:37.064986
2976	sshaunessy	WATERHOUSE BISTRO	Large Tap Marker	Downeast - Blackberry	1	8/27/2025 2:55 PM	2026-03-17 14:10:37.071062
2977	sshaunessy	WATERHOUSE BISTRO	Large Tap Marker	603 Brew - Slightly Tstd	1	8/27/2025 2:55 PM	2026-03-17 14:10:37.074152
2982	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	von Trapp - Oktober	2	8/27/2025 10:05 AM	2026-03-17 19:05:56.42937
2979	sshaunessy	BOWLING ACRES	Large Tap Marker	Shipyard - Pumpkin Head	1	8/27/2025 11:51 AM	2026-03-17 14:10:37.085984
2981	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	Downeast - Cider Donut	1	8/27/2025 10:05 AM	2026-03-17 14:10:37.092176
2983	jgrumblatt	NEWPORT VETERAN'S CLUB	Large Tap Marker	Fiddlehead - White	1	8/27/2025 7:13 AM	2026-03-17 14:10:37.097714
2984	jaustin	LONGHORN STEAK #0003 - KEENE	Large Tap Marker	Shipyard - Pumpkin Head	1	8/26/2025 6:34 PM	2026-03-17 14:10:37.100916
2994	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Shipyard - Pumpkin Head	2	8/25/2025 2:37 PM	2026-03-17 19:05:56.431672
2986	ggage	AMERICAN LEGION POST 23 - MILFORD	Large Tap Marker	Shipyard - Pumpkin Head	1	8/26/2025 12:54 PM	2026-03-17 14:10:37.106198
3000	amartin	LA HACIENDA DEL RIO	Large Tap Marker	Shipyard - Pumpkin Head	2	8/21/2025 3:19 PM	2026-03-17 19:05:56.435014
2989	ggage	VFW #4368 - MILFORD	Large Tap Marker	Shipyard - Pumpkin Head	1	8/26/2025 10:10 AM	2026-03-17 14:10:37.114576
2992	jsewall	ARIANA'S RESTAURANT	Large Tap Marker	603 Brew - Winni	1	8/25/2025 3:03 PM	2026-03-17 14:10:37.122473
2993	jsewall	ARIANA'S RESTAURANT	Large Tap Marker	Jack's Abby - Copper Legend	1	8/25/2025 3:03 PM	2026-03-17 14:10:37.125341
2995	jmeharg	TOOKY MILLS PUB	Large Tap Marker	Downeast - Original	1	8/25/2025 12:17 PM	2026-03-17 14:10:37.13266
2996	jgiuffrida	PAR28	Large Tap Marker	Shipyard - Pumpkin Head	1	8/25/2025 10:41 AM	2026-03-17 14:10:37.135671
2997	sshaunessy	AMERICAN LEGION POST 10 - WILTON	Large Tap Marker	Shipyard - Pumpkin Head	1	8/24/2025 5:18 PM	2026-03-17 14:10:37.139312
2998	jaustin	GUERRILLA GRILL	Large Tap Marker	True North - Violet	1	8/21/2025 4:06 PM	2026-03-17 14:10:37.142222
2999	ddooling	FIGARO'S MARTINI BAR + KITCHEN	Large Tap Marker	Shipyard - Pumpkin Head	1	8/21/2025 4:00 PM	2026-03-17 14:10:37.145912
3003	jgiuffrida	DREO FOOD AND DRINK	Large Tap Marker	Downeast - Cider Donut	1	8/21/2025 3:05 PM	2026-03-17 14:10:37.158711
3005	jgiuffrida	RED ROBIN GOURMET BURGERS - SALEM	Large Tap Marker	Epigram - Temptation	1	8/21/2025 2:17 PM	2026-03-17 14:10:37.164218
3006	jgiuffrida	LIM'S SPORTS BAR & CAFE	Large Tap Marker	Maine Beer Co - Lunch	1	8/21/2025 1:51 PM	2026-03-17 14:10:37.166985
3007	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Stoneface - Neon Slick	1	8/21/2025 11:11 AM	2026-03-17 14:10:37.170167
3008	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Epigram - Temptation	1	8/21/2025 11:11 AM	2026-03-17 14:10:37.17382
3009	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Epigram - Liam's Lager	1	8/21/2025 11:11 AM	2026-03-17 14:10:37.179856
3010	pbelanger	MAMA MCDONOUGH'S IRISH PUB	Large Tap Marker	Downeast - Cider Donut	1	8/21/2025 11:06 AM	2026-03-17 14:10:37.182516
3011	jmeharg	BLUE BEAR HOSPITALITY LLC	Large Tap Marker	Able - Lady of the Lake	1	8/20/2025 4:29 PM	2026-03-17 14:10:37.185521
3012	jaustin	MAIN CRUST CO.	Large Tap Marker	Frost - Little Lush	1	8/20/2025 4:14 PM	2026-03-17 14:10:37.18875
3013	pwollert	BIRDIES	Large Tap Marker	Shipyard - Pumpkin Head	1	8/20/2025 4:03 PM	2026-03-17 14:10:37.191909
3014	rconstant	LI'L LOBSTER BOAT	Large Tap Marker	Jack's Abby - Copper Legend	1	8/20/2025 3:24 PM	2026-03-17 14:10:37.194443
3015	amartin	UNION PUBLIC HOUSE	Large Tap Marker	Epigram - Temptation	1	8/20/2025 2:56 PM	2026-03-17 14:10:37.197413
3016	amartin	SPECTACLE MANAGEMENT INC	Large Tap Marker	Epigram - Temptation	1	8/20/2025 2:18 PM	2026-03-17 14:10:37.200374
3017	amartin	SPECTACLE MANAGEMENT INC	Large Tap Marker	Jack's Abby - Copper Legend	1	8/20/2025 2:18 PM	2026-03-17 14:10:37.203073
3018	amartin	SPECTACLE MANAGEMENT INC	Large Tap Marker	Shipyard - Pumpkin Head	1	8/20/2025 2:18 PM	2026-03-17 14:10:37.205663
3020	ddooling	SEVMAR MEDITERRANEAN BISTRO	Large Tap Marker	Shipyard - Pumpkin Head	1	8/20/2025 2:13 PM	2026-03-17 14:10:37.211606
3021	rconstant	LA CARRETA - LONDONDERRY	Large Tap Marker	Shipyard - Pumpkin Head	1	8/20/2025 2:07 PM	2026-03-17 14:10:37.215245
3022	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	BBCO - Lighthouse	1	8/20/2025 2:01 PM	2026-03-17 14:10:37.218091
3023	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Stoneface - Neon Slick	1	8/20/2025 1:50 PM	2026-03-17 14:10:37.22126
3024	sshaunessy	BOWLING ACRES	Large Tap Marker	14th Star - Oktoberfest	1	8/20/2025 1:40 PM	2026-03-17 14:10:37.223965
3019	lnorton	COPPER DOOR - BEDFORD	Large Tap Marker	Shipyard - Pumpkin Head	2	8/20/2025 2:17 PM	2026-03-17 19:05:56.438139
3056	maanderson	NATIONAL CLUB (THE)	Large Tap Marker	Spaten	2	8/18/2025 2:23 PM	2026-03-17 19:05:56.442787
3059	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Exhibit A - Goody Shoes	2	8/14/2025 4:08 PM	2026-03-17 19:05:56.445359
3065	jaustin	GUERRILLA GRILL	Large Tap Marker	Maine Beer Co - Dinner	3	8/14/2025 3:09 PM	2026-03-17 19:05:56.448427
3029	lortiz	PIZZICO - ITALIAN RESTAURANT - NASHUA	Large Tap Marker	Shipyard - Pumpkin Head	1	8/20/2025 1:09 PM	2026-03-17 14:10:37.237584
3031	pbelanger	WOODBOUND INN	Large Tap Marker	Kelsen - Spacetown	1	8/20/2025 11:59 AM	2026-03-17 14:10:37.242961
3033	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	Mich Ultra	1	8/20/2025 11:51 AM	2026-03-17 14:10:37.24838
3034	pbelanger	EMMAS 321	Large Tap Marker	Epigram - Temptation	1	8/20/2025 11:43 AM	2026-03-17 14:10:37.251379
3046	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	BBCO - Good Company	1	8/19/2025 1:47 PM	2026-03-17 14:10:37.28235
3054	lortiz	LONGHORN STEAK #5457 - NASHUA	Large Tap Marker	Shipyard - Pumpkin Head	1	8/18/2025 4:13 PM	2026-03-17 14:10:37.314822
3055	jcannamucio	DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)	Large Tap Marker	603 Brew - Slightly Tstd	1	8/18/2025 3:52 PM	2026-03-17 14:10:37.317589
3058	ggage	99 REST - NASHUA	Large Tap Marker	Shipyard - Pumpkin Head	1	8/18/2025 11:43 AM	2026-03-17 14:10:37.463485
3060	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Other Half - Ideal Wave	1	8/14/2025 4:08 PM	2026-03-17 14:10:37.469376
3061	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Other Half - Hop Showers	1	8/14/2025 4:08 PM	2026-03-17 14:10:37.472655
3063	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	Jack's Abby - Copper Legend	1	8/14/2025 3:38 PM	2026-03-17 14:10:37.478445
3066	jaustin	GUERRILLA GRILL	Large Tap Marker	Jack's Abby - Copper Legend	1	8/14/2025 3:09 PM	2026-03-17 14:10:37.487143
3067	jgiuffrida	LIM'S SPORTS BAR & CAFE	Large Tap Marker	Shipyard - Pumpkin Head	1	8/14/2025 2:20 PM	2026-03-17 14:10:37.490168
3069	jgiuffrida	TOMO STEAKHOUSE	Large Tap Marker	Shipyard - Pumpkin Head	1	8/14/2025 1:35 PM	2026-03-17 14:10:37.495824
3068	lortiz	LUI LUI - NASHUA	Large Tap Marker	Shipyard - Pumpkin Head	2	8/14/2025 1:51 PM	2026-03-17 19:05:56.451043
3070	jsewall	REVO CASINO AND SOCIAL HOUSE	Large Tap Marker	Tuckerman - Pale Ale	2	8/14/2025 9:06 AM	2026-03-17 19:05:56.45375
3073	jaustin	BRICKHOUSE PIZZA & WINGS	Large Tap Marker	Gold Road Mango Cart	1	8/13/2025 8:44 PM	2026-03-17 14:10:37.50658
3074	jaustin	MAIN CRUST CO.	Large Tap Marker	Jack's Abby - Copper Legend	1	8/13/2025 3:44 PM	2026-03-17 14:10:37.509481
3075	jaustin	MAIN CRUST CO.	Large Tap Marker	21 Amend - Hell High Water	1	8/13/2025 3:44 PM	2026-03-17 14:10:37.512618
3077	amartin	CHICKEN N CHIP'S	Large Tap Marker	Shipyard - Pumpkin Head	2	8/13/2025 2:21 PM	2026-03-17 19:05:56.458077
3078	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	von Trapp - Radler	1	8/13/2025 2:16 PM	2026-03-17 14:10:37.524022
3079	lnorton	NH SPORTSPLEX	Large Tap Marker	Mich Ultra	1	8/13/2025 1:17 PM	2026-03-17 14:10:37.52924
3080	scamuso	EVVIVA TRATTORIA - NASHUA	Large Tap Marker	Concord Craft - Four Rivers	1	8/13/2025 12:52 PM	2026-03-17 14:10:37.531874
3081	scamuso	EVVIVA TRATTORIA - NASHUA	Large Tap Marker	603 Brew - Toast Pumpkin	1	8/13/2025 12:52 PM	2026-03-17 14:10:37.535567
3082	amartin	SAN FRANCISCO KITCHEN INC	Large Tap Marker	Bud Light	1	8/13/2025 12:36 PM	2026-03-17 14:10:37.53865
3083	pbelanger	MEXICA MEXICAN RESTAURANT	Large Tap Marker	Kona - Big Wave	1	8/13/2025 12:02 PM	2026-03-17 14:10:37.541823
3084	pwollert	POUR HOUSE (THE)	Large Tap Marker	Kona - Big Wave	1	8/12/2025 1:58 PM	2026-03-17 14:10:37.54472
3085	lnorton	LA VAKA MEXICAN RESTAURANT	Large Tap Marker	Gold Road Mango Cart	1	8/12/2025 1:52 PM	2026-03-17 14:10:37.548365
3095	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Large Tap Marker	Shipyard - Pumpkin Head	2	8/11/2025 2:18 PM	2026-03-17 19:05:56.461353
3098	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Shipyard - Pumpkin Head	2	8/11/2025 9:16 AM	2026-03-17 19:05:56.464025
3088	rconstant	SUPPAS PIZZA LONDONDERRY	Large Tap Marker	Shipyard - Pumpkin Head	1	8/12/2025 11:39 AM	2026-03-17 14:10:37.556196
3089	ggage	ALAMO TEXAS BAR-B-QUE & TEQUILA BAR	Large Tap Marker	Downeast - Cider Donut	1	8/12/2025 11:09 AM	2026-03-17 14:10:37.559316
3107	jsewall	CHILI'S - W.LEB	Large Tap Marker	Shipyard - Pumpkin Head	2	8/7/2025 12:16 PM	2026-03-17 19:05:56.46709
3112	pbelanger	EMMAS 321	Large Tap Marker	Jack's Abby - Copper Legend	2	8/6/2025 12:21 PM	2026-03-17 19:05:56.470477
3123	jsewall	99 REST - W.LEB	Large Tap Marker	Shipyard - Pumpkin Head	2	8/4/2025 8:25 AM	2026-03-17 19:05:56.474228
3094	lortiz	RED ROBIN BURGERS #515 NASHUA	Large Tap Marker	Downeast - Cider Donut	1	8/11/2025 3:54 PM	2026-03-17 14:10:37.572564
3097	jmorse	RAMUNTOS - CLAREMONT	Large Tap Marker	Shipyard - Pumpkin Head	1	8/11/2025 12:00 PM	2026-03-17 14:10:37.581045
3099	jsewall	WEATHERVANE - W.LEB	Large Tap Marker	New Belgium - Fat Tire	1	8/11/2025 8:15 AM	2026-03-17 14:10:37.586335
3100	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Equilibrium - Field Theory	1	8/7/2025 2:55 PM	2026-03-17 14:10:37.588657
3113	sshaunessy	MI JALISCO - PETERBORO	Large Tap Marker	Concord Craft - Four Rivers	1	8/6/2025 12:19 PM	2026-03-17 14:10:37.624829
3114	jgrumblatt	THE REFINERY	Large Tap Marker	Shipyard - Pumpkin Head	1	8/6/2025 12:14 PM	2026-03-17 14:10:37.627126
3115	lnorton	MANCHESTER COUNTRY CLUB	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	8/5/2025 3:22 PM	2026-03-17 14:10:37.630238
3116	ggage	OLDE TOWNE TAVERN	Large Tap Marker	Downeast - Cider Donut	1	8/5/2025 1:09 PM	2026-03-17 14:10:37.632893
3117	jmeharg	STONEBRIDGE COUNTRY CLUB	Large Tap Marker	Bud Light	1	8/5/2025 12:47 PM	2026-03-17 14:10:37.63589
3120	jmeharg	AMERICAN LEGION POST 59 - HILLSBORO	Large Tap Marker	Shipyard - Pumpkin Head	1	8/4/2025 1:10 PM	2026-03-17 14:10:37.643862
3122	jmeharg	HILLSBORO HOUSE OF PIZZA	Large Tap Marker	Shipyard - Pumpkin Head	1	8/4/2025 12:21 PM	2026-03-17 14:10:37.64911
3125	rconstant	ROCCO'S PIZZA	Large Tap Marker	Shipyard - Pumpkin Head	2	8/3/2025 1:25 PM	2026-03-17 19:05:56.477035
3128	lnorton	MURPHY'S TAPROOM AND CARRIAGE HOUSE	Large Tap Marker	Shipyard - Pumpkin Head	2	7/31/2025 1:55 PM	2026-03-17 19:05:56.480733
3127	lnorton	RIVER ROAD TAVERN	Large Tap Marker	von Trapp - Vienna	1	7/31/2025 3:12 PM	2026-03-17 14:10:37.663775
3151	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Stoneface - Sunday Sauce	2	7/24/2025 3:45 PM	2026-03-17 19:05:56.48319
3130	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Weihenstephaner - Hefe	1	7/30/2025 1:47 PM	2026-03-17 14:10:37.672252
3131	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	von Trapp - Vienna	1	7/30/2025 1:38 PM	2026-03-17 14:10:37.674928
3132	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Concord Craft - Blue Coggler	1	7/30/2025 1:38 PM	2026-03-17 14:10:37.677207
3133	jaustin	GUERRILLA GRILL	Large Tap Marker	Able - Lady of the Lake	1	7/30/2025 1:35 PM	2026-03-17 14:10:37.680482
3134	jaustin	GUERRILLA GRILL	Large Tap Marker	Able - Burn the Ships	1	7/30/2025 1:35 PM	2026-03-17 14:10:37.684685
3135	jgrumblatt	STOCKWELL RESTAURANT	Large Tap Marker	Able - Lady of the Lake	1	7/30/2025 1:23 PM	2026-03-17 14:10:37.688012
3152	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Zero Gravity - Jaws Czech	2	7/24/2025 3:45 PM	2026-03-17 19:05:56.48602
3137	pbelanger	EMMAS 321	Large Tap Marker	von Trapp - Vienna	2	7/30/2025 12:15 PM	2026-03-17 14:10:37.693324
3138	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	Von Trapp - NZ Pilsner	1	7/30/2025 10:36 AM	2026-03-17 14:10:37.695754
3139	ggage	99 REST - NASHUA	Large Tap Marker	Jack's Abby - Porch Fest	1	7/30/2025 9:15 AM	2026-03-17 14:10:37.699718
3140	pwollert	POUR HOUSE (THE)	Large Tap Marker	Gold Road Mango Cart	1	7/29/2025 2:34 PM	2026-03-17 14:10:37.702272
3153	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Maine Beer Co - Waters	3	7/24/2025 3:45 PM	2026-03-17 19:05:56.488582
3169	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Fiddlehead - IPA	2	7/22/2025 9:38 AM	2026-03-17 19:05:56.491012
3143	jgrumblatt	THE BLUE CANOE	Large Tap Marker	Kona - Big Wave	1	7/28/2025 3:07 PM	2026-03-17 14:10:37.713403
3144	jgrumblatt	THE BLUE CANOE	Large Tap Marker	Tuckerman - Pale Ale	1	7/28/2025 3:07 PM	2026-03-17 14:10:37.717329
3145	jgrumblatt	THE BLUE CANOE	Large Tap Marker	Maine Beer Co - Lunch	1	7/28/2025 3:07 PM	2026-03-17 14:10:37.720065
3146	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	Gold Road Mango Cart	1	7/28/2025 2:47 PM	2026-03-17 14:10:37.724799
3147	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Citizen Cider - Strawb Haze	1	7/28/2025 1:20 PM	2026-03-17 14:10:37.727347
3148	ddooling	TAVERN IN THE SQUARE SALEM LLC	Large Tap Marker	Jack's Abby - Porch Fest	1	7/28/2025 12:48 PM	2026-03-17 14:10:37.730496
3149	jgrumblatt	SALT HILL PUB - NEWPORT	Large Tap Marker	Gold Road Mango Cart	1	7/24/2025 4:20 PM	2026-03-17 14:10:37.73282
3150	jgrumblatt	SALT HILL PUB - NEWPORT	Large Tap Marker	Kona - Big Wave	1	7/24/2025 4:20 PM	2026-03-17 14:10:37.735677
3154	jaustin	BRICKHOUSE PIZZA & WINGS	Large Tap Marker	603 Brew - Straw Wheat	1	7/24/2025 3:36 PM	2026-03-17 14:10:37.749262
3155	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Tuckerman - Pale Ale	1	7/24/2025 2:46 PM	2026-03-17 14:10:37.752125
3181	jaustin	MAIN CRUST CO.	Large Tap Marker	Kona - Big Wave	2	7/16/2025 3:40 PM	2026-03-17 19:05:56.493625
3159	amartin	TOSTAO'S TAPAS BAR	Large Tap Marker	Stoneface - IPA	1	7/23/2025 3:39 PM	2026-03-17 14:10:37.765028
3160	sshaunessy	COOPER'S HILL	Large Tap Marker	von Trapp - Helles	1	7/23/2025 2:11 PM	2026-03-17 14:10:37.768351
3161	pbelanger	EMMAS 321	Large Tap Marker	Maine Beer Co - Waters	1	7/23/2025 1:00 PM	2026-03-17 14:10:37.771224
3162	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Mighty Squirrel - Fluff	1	7/23/2025 11:35 AM	2026-03-17 14:10:37.774023
3163	jcannamucio	NOURIA ENERGY # 1268 - HAMPSTEAD	Large Tap Marker	Able - Burn the Ships	1	7/22/2025 3:03 PM	2026-03-17 14:10:37.776336
3165	amartin	ODD FELLOWS BREWING COMPANY	Large Tap Marker	Jack's Abby - House Lager	1	7/22/2025 2:09 PM	2026-03-17 14:10:37.782202
3166	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Henniker - Picnic	1	7/22/2025 2:08 PM	2026-03-17 14:10:37.786651
3167	jgrumblatt	SALT HILL PUB - NEWBURY	Large Tap Marker	Gold Road Mango Cart	1	7/22/2025 1:05 PM	2026-03-17 14:10:37.789473
3170	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Zero Gravity - Jaws Czech	1	7/22/2025 8:56 AM	2026-03-17 14:10:37.799751
3171	lortiz	CHILI'S - NASHUA - DW HWY	Large Tap Marker	Dos Equis Amber	1	7/21/2025 1:44 PM	2026-03-17 14:10:37.802
3173	jjohnson	SNAX	Large Tap Marker	von Trapp - Radler	1	7/21/2025 12:33 PM	2026-03-17 14:10:37.808376
3174	jsewall	LEBANON LODGE OF ELKS	Large Tap Marker	von Trapp - Helles	1	7/21/2025 11:45 AM	2026-03-17 14:10:37.811174
3175	jaustin	CHILI'S - KEENE	Large Tap Marker	Gold Road Mango Cart	1	7/21/2025 11:10 AM	2026-03-17 14:10:37.813431
3176	jaustin	GUERRILLA GRILL	Large Tap Marker	Throwback - Cheek Squeezer	1	7/17/2025 2:22 PM	2026-03-17 14:10:37.816748
3177	jaustin	GUERRILLA GRILL	Large Tap Marker	14th Star - Mexican Lager	1	7/17/2025 2:22 PM	2026-03-17 14:10:37.820094
3179	jaustin	KEENE COUNTRY CLUB INC	Large Tap Marker	Concord Craft - Safe Space	1	7/17/2025 12:05 PM	2026-03-17 14:10:37.827397
3180	ddooling	TAVERN IN THE SQUARE SALEM LLC	Large Tap Marker	Gold Road Mango Cart	1	7/16/2025 5:36 PM	2026-03-17 14:10:37.831228
3182	jaustin	MAIN CRUST CO.	Large Tap Marker	Able - Burn the Ships	1	7/16/2025 3:40 PM	2026-03-17 14:10:37.837589
3183	jaustin	MAIN CRUST CO.	Large Tap Marker	Able - Lady of the Lake	1	7/16/2025 3:40 PM	2026-03-17 14:10:37.84011
3201	amartin	CASA VIEJA MEXICAN GRILL	Large Tap Marker	Downeast - Original	2	7/9/2025 2:04 PM	2026-03-17 19:05:56.496464
3185	jaustin	TEMPESTA'S	Large Tap Marker	Concord Craft - White Mtn White	1	7/16/2025 12:09 PM	2026-03-17 14:10:37.845641
3186	sshaunessy	BOWLING ACRES	Large Tap Marker	Henniker - Damn Sure	1	7/16/2025 11:53 AM	2026-03-17 14:10:37.848628
3187	jsewall	ARIANA'S RESTAURANT	Large Tap Marker	Fiddlehead - IPA	1	7/16/2025 10:31 AM	2026-03-17 14:10:37.851088
3203	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	Stoneface - Duderino	2	7/9/2025 12:05 PM	2026-03-17 19:05:56.498917
3215	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	von Trapp - Helles	2	7/2/2025 1:53 PM	2026-03-17 19:05:56.501826
3229	jaustin	LOCAL BURGER OF KEENE	Large Tap Marker	21 Amend - Hell High Water	2	6/25/2025 2:08 PM	2026-03-17 19:05:56.504261
3236	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Mich Ultra	2	6/25/2025 10:56 AM	2026-03-17 19:05:56.50706
3192	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Stoneface - Reg Sch Pro	1	7/14/2025 5:37 PM	2026-03-17 14:10:37.867094
3242	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	603 Brew - Hard Seltzer	2	6/23/2025 6:11 PM	2026-03-17 19:05:56.509546
3194	sshaunessy	UNION COFFEE COMPANY	Large Tap Marker	Zero Gravity - Shandy	1	7/14/2025 2:57 PM	2026-03-17 14:10:37.87326
3197	jaustin	BRICKHOUSE PIZZA & WINGS	Large Tap Marker	Banded - Charm	1	7/10/2025 4:32 PM	2026-03-17 14:10:37.881369
3198	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Stoneface - Reg Sch Pro	1	7/10/2025 4:28 PM	2026-03-17 14:10:37.884067
3200	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Bells - Oberon	1	7/9/2025 2:42 PM	2026-03-17 14:10:37.88959
3202	pbelanger	RUSTIC TABLE (THE)	Large Tap Marker	603 Brew - Summa	1	7/9/2025 12:52 PM	2026-03-17 14:10:37.894713
3204	jgrumblatt	THE REFINERY	Large Tap Marker	Downeast - Peach Mango	1	7/9/2025 11:43 AM	2026-03-17 14:10:37.900985
3205	jgrumblatt	THE REFINERY	Large Tap Marker	Downeast - Guava Passion	1	7/9/2025 11:43 AM	2026-03-17 14:10:37.903291
3208	jaustin	KEENE COUNTRY CLUB INC	Large Tap Marker	603 Brew - Summa	1	7/3/2025 4:43 PM	2026-03-17 14:10:37.911204
3210	amartin	BACKSTREET BAR & GRILL LLC	Large Tap Marker	603 Brew - Summa	1	7/3/2025 2:37 PM	2026-03-17 14:10:37.917198
3211	jaustin	AMERICAN LEGION POST 4 - KEENE	Large Tap Marker	Fiddlehead - IPA	1	7/3/2025 12:04 PM	2026-03-17 14:10:37.919693
3212	jaustin	AMERICAN LEGION POST 4 - KEENE	Large Tap Marker	Bud Light	1	7/3/2025 12:04 PM	2026-03-17 14:10:37.922442
3213	sshaunessy	WATERHOUSE BISTRO	Large Tap Marker	Able - Burn the Ships	1	7/2/2025 3:42 PM	2026-03-17 14:10:37.924831
3216	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	Founders - Mortal Bloom	1	7/2/2025 1:47 PM	2026-03-17 14:10:37.933775
3217	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Mighty Squirrel - Fluff	1	6/30/2025 4:41 PM	2026-03-17 14:10:37.936266
3218	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Founders - Nitro Rubaeus Rasp Ale	1	6/30/2025 4:41 PM	2026-03-17 14:10:37.939306
3219	sshaunessy	UNION COFFEE COMPANY	Large Tap Marker	Wormtown - Be Hoppy	1	6/30/2025 3:03 PM	2026-03-17 14:10:37.941611
3220	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Sea Dog - Blueberry	1	6/26/2025 3:53 PM	2026-03-17 14:10:37.945784
3222	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Widowmaker - Blue Comet	1	6/26/2025 11:35 AM	2026-03-17 14:10:37.951968
3223	jsewall	99 REST - W.LEB	Large Tap Marker	603 Brew - Hard Seltzer	1	6/26/2025 7:48 AM	2026-03-17 14:10:37.954338
3224	jaustin	MAIN CRUST CO.	Large Tap Marker	Able - Glory Not Prey	1	6/25/2025 3:48 PM	2026-03-17 14:10:37.957197
3228	pwollert	BIRDIES	Large Tap Marker	Zero Gravity - Shandy	1	6/25/2025 2:10 PM	2026-03-17 14:10:37.96903
3230	jaustin	LOCAL BURGER OF KEENE	Large Tap Marker	Sea Dog - Blueberry	1	6/25/2025 2:08 PM	2026-03-17 14:10:37.975547
3231	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Zero Gravity - Jaws Czech	1	6/25/2025 1:10 PM	2026-03-17 14:10:37.978217
3232	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Jack's Abby - Blood Orange Wheat	1	6/25/2025 1:10 PM	2026-03-17 14:10:37.981373
3233	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Fiddlehead - White	1	6/25/2025 1:10 PM	2026-03-17 14:10:37.984329
3234	lnorton	COPPER DOOR - BEDFORD	Large Tap Marker	Gold Road Mango Cart	1	6/25/2025 12:44 PM	2026-03-17 14:10:37.987823
3235	sshaunessy	BOWLING ACRES	Large Tap Marker	Stoneface - Reg Sch Pro	1	6/25/2025 11:57 AM	2026-03-17 14:10:37.991094
3237	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	von Trapp - Radler	1	6/25/2025 9:36 AM	2026-03-17 14:10:37.996894
3238	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Mich Ultra	1	6/25/2025 4:38 AM	2026-03-17 14:10:37.999717
3239	jmorse	CLAREMONT LODGE OF ELKS	Large Tap Marker	Mich Ultra	1	6/24/2025 3:12 PM	2026-03-17 14:10:38.002375
3240	jcannamucio	GRUMPY'S BAR & GRILL	Large Tap Marker	Mich Ultra	1	6/24/2025 12:59 PM	2026-03-17 14:10:38.00513
3241	jaustin	SUMMIT STORES - KEENE	Large Tap Marker	Captain Eli's	1	6/24/2025 12:24 PM	2026-03-17 14:10:38.00765
3243	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	True North - Violet	1	6/23/2025 3:41 PM	2026-03-17 14:10:38.012693
3244	jmorse	POLISH AMER CITIZENS CLUB-CLAREMONT	Large Tap Marker	Mich Ultra	1	6/23/2025 3:39 PM	2026-03-17 14:10:38.015464
3246	rconstant	AJ'S SPORTS BAR & GRILL	Large Tap Marker	Mich Ultra	1	6/23/2025 12:19 PM	2026-03-17 14:10:38.022467
3249	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Stoneface - Reg Sch Pro	1	6/19/2025 3:02 PM	2026-03-17 14:10:38.031427
3250	lnorton	RIVER ROAD TAVERN	Large Tap Marker	BBCO - Time Chimp	1	6/19/2025 3:02 PM	2026-03-17 14:10:38.035151
3252	maanderson	PENUCHE'S ALE HOUSE-NASHUA	Large Tap Marker	Mich Ultra	1	6/19/2025 2:28 PM	2026-03-17 14:10:38.042206
3253	jaustin	GUERRILLA GRILL	Large Tap Marker	Stoneface - Reg Sch Pro	1	6/19/2025 2:28 PM	2026-03-17 14:10:38.044712
3254	jaustin	GUERRILLA GRILL	Large Tap Marker	Zero Gravity - Shandy	1	6/19/2025 2:28 PM	2026-03-17 14:10:38.048326
3255	jaustin	GUERRILLA GRILL	Large Tap Marker	BBCO - Time Chimp	1	6/19/2025 2:28 PM	2026-03-17 14:10:38.051122
3258	jaustin	MAIN CRUST CO.	Large Tap Marker	Downeast - Drier Side	1	6/19/2025 12:29 PM	2026-03-17 14:10:38.059649
3259	jcannamucio	HANNAFORD #8190 - HAMPSTEAD	Large Tap Marker	Bud Light	1	6/19/2025 12:21 PM	2026-03-17 14:10:38.062816
3260	sshaunessy	WATERHOUSE BISTRO	Large Tap Marker	Jack's Abby - Blood Orange Wheat	1	6/18/2025 3:23 PM	2026-03-17 14:10:38.065759
3263	jmeharg	BLUE BEAR HOSPITALITY LLC	Large Tap Marker	Able - Burn the Ships	1	6/18/2025 4:40 AM	2026-03-17 14:10:38.07475
3264	jmeharg	BLUE BEAR HOSPITALITY LLC	Large Tap Marker	Downeast - Blackberry	1	6/18/2025 4:40 AM	2026-03-17 14:10:38.077935
3265	jgrumblatt	FORESTERS OF AMERICA	Large Tap Marker	Gold Road Mango Cart	1	6/17/2025 4:21 PM	2026-03-17 14:10:38.080726
3266	rconstant	SUPPAS PIZZA LONDONDERRY	Large Tap Marker	Concord Craft - Safe Space	1	6/17/2025 4:07 PM	2026-03-17 14:10:38.083927
3267	ggage	AMERICAN LEGION POST 23 - MILFORD	Large Tap Marker	Mich Ultra	1	6/17/2025 3:13 PM	2026-03-17 14:10:38.086585
3268	bgermano	STAGE HANDS RESTAURANT	Large Tap Marker	Able - Lady of the Lake	1	6/17/2025 2:45 PM	2026-03-17 14:10:38.089123
3269	pbelanger	ARLINGTON INN & TAVERN (THE)	Large Tap Marker	Gold Road Mango Cart	1	6/17/2025 11:20 AM	2026-03-17 14:10:38.091765
3270	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Concord Craft - White Mtn White	1	6/16/2025 3:22 PM	2026-03-17 14:10:38.094789
3272	jsewall	HANNAFORD #8266 - W.LEB	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	6/16/2025 1:49 PM	2026-03-17 14:10:38.09962
3273	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Von Trapp - NZ Pilsner	1	6/16/2025 1:05 PM	2026-03-17 14:10:38.102891
3275	rconstant	99 REST - LONDONDERRY	Large Tap Marker	Dos Equis	1	6/16/2025 9:55 AM	2026-03-17 14:10:38.108701
3276	jgiuffrida	DREO FOOD AND DRINK	Large Tap Marker	Stoneface - IPA	1	6/12/2025 3:36 PM	2026-03-17 14:10:38.112022
3277	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Equilibrium - Dream Wave	1	6/12/2025 3:31 PM	2026-03-17 14:10:38.114736
3279	amartin	SURF RESTAURANT INC	Large Tap Marker	Wormtown - Yard Party	1	6/12/2025 3:18 PM	2026-03-17 14:10:38.120559
3280	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Concord Craft - Blue Coggler	1	6/12/2025 2:32 PM	2026-03-17 14:10:38.123526
3282	jaustin	BRICKHOUSE PIZZA & WINGS	Large Tap Marker	Foundation - Raspberry	1	6/12/2025 1:07 PM	2026-03-17 14:10:38.130015
3283	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Sea Dog - Sun Fish	1	6/12/2025 11:23 AM	2026-03-17 14:10:38.133149
3284	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Able - Lady of the Lake	1	6/12/2025 11:23 AM	2026-03-17 14:10:38.136366
3285	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Fiddlehead - Second	1	6/12/2025 11:23 AM	2026-03-17 14:10:38.139526
3286	ggage	ROUTE 13 STATELINE CONV MART	Large Tap Marker	Maine Beer Co - Lunch	1	6/12/2025 9:51 AM	2026-03-17 14:10:38.14211
3287	jaustin	LOCAL BURGER OF KEENE	Large Tap Marker	Stoneface - IPA	1	6/11/2025 4:22 PM	2026-03-17 14:10:38.145615
3288	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Maine Beer Co - Wolfe's Neck	1	6/11/2025 3:30 PM	2026-03-17 14:10:38.148465
3289	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Able - Emma Wood	1	6/11/2025 3:30 PM	2026-03-17 14:10:38.151263
3290	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	Founders - All Day Shandy	1	6/11/2025 1:53 PM	2026-03-17 14:10:38.154108
3291	sshaunessy	BOWLING ACRES	Large Tap Marker	Exhibit A - Cats Meow	1	6/11/2025 11:55 AM	2026-03-17 14:10:38.157366
3292	jmeharg	TOLL BOOTH TAVERN (THE)	Large Tap Marker	603 Brew - Summa	1	6/11/2025 6:18 AM	2026-03-17 14:10:38.160495
3293	pwollert	POUR HOUSE (THE)	Large Tap Marker	von Trapp - Radler	1	6/10/2025 3:49 PM	2026-03-17 14:10:38.163828
3294	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	Concord Craft - Four Rivers	1	6/10/2025 2:12 PM	2026-03-17 14:10:38.166758
3296	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Able - Victory Nor Defeat	1	6/9/2025 4:54 PM	2026-03-17 14:10:38.173122
3297	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Von Trapp - NZ Pilsner	1	6/9/2025 4:54 PM	2026-03-17 14:10:38.177339
3300	jmorse	POLISH AMER CITIZENS CLUB-CLAREMONT	Large Tap Marker	New Belgium - Fat Tire	1	6/9/2025 3:00 PM	2026-03-17 14:10:38.18677
3310	jgiuffrida	TOMO STEAKHOUSE	Large Tap Marker	Kona - Big Wave	2	6/5/2025 1:55 PM	2026-03-17 19:05:56.514
3302	jmorse	RAMUNTOS - CLAREMONT	Large Tap Marker	603 Brew - Summa	1	6/9/2025 12:38 PM	2026-03-17 14:10:38.193131
3311	jsewall	CHILI'S - W.LEB	Large Tap Marker	Sea Dog - Blueberry	3	6/5/2025 12:33 PM	2026-03-17 19:05:56.516807
3304	ggage	GATE CITY CASINO	Large Tap Marker	Stella Artois	1	6/5/2025 3:16 PM	2026-03-17 14:10:38.198518
3305	ggage	GATE CITY CASINO	Large Tap Marker	New Belgium - Juicy Haze	1	6/5/2025 3:11 PM	2026-03-17 14:10:38.201175
3306	ggage	GATE CITY CASINO	Large Tap Marker	Stoneface - IPA	1	6/5/2025 3:11 PM	2026-03-17 14:10:38.2038
3307	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Von Trapp - NZ Pilsner	1	6/5/2025 3:06 PM	2026-03-17 14:10:38.206996
3308	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Mighty Squirrel - Fluff	1	6/5/2025 3:06 PM	2026-03-17 14:10:38.210093
3341	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Fiddlehead - Second	2	5/29/2025 4:19 PM	2026-03-17 19:05:56.521646
3312	sshaunessy	TOWN HALL TAPHOUSE AND EATERY	Large Tap Marker	Fiddlehead - IPA	1	6/4/2025 3:25 PM	2026-03-17 14:10:38.223738
3313	sshaunessy	TOWN HALL TAPHOUSE AND EATERY	Large Tap Marker	Old Speckled Hen	1	6/4/2025 3:25 PM	2026-03-17 14:10:38.226812
3314	sshaunessy	TOWN HALL TAPHOUSE AND EATERY	Large Tap Marker	Henniker - Picnic	1	6/4/2025 3:25 PM	2026-03-17 14:10:38.229233
3315	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Old Speckled Hen	1	6/4/2025 3:20 PM	2026-03-17 14:10:38.232067
3316	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Sea Dog - Blueberry	1	6/4/2025 3:15 PM	2026-03-17 14:10:38.235041
3317	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Zero Gravity - Shandy	1	6/4/2025 3:15 PM	2026-03-17 14:10:38.237712
3323	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Zero Gravity - Green State	1	6/4/2025 1:34 PM	2026-03-17 14:10:38.255199
3324	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Jack's Abby - Lavenade	1	6/4/2025 1:34 PM	2026-03-17 14:10:38.257926
3326	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Wormtown - Yard Party	1	6/4/2025 11:02 AM	2026-03-17 14:10:38.263873
3327	maanderson	LUK'S BAR & GRILL	Large Tap Marker	Maine Beer Co - Lunch	1	6/4/2025 10:31 AM	2026-03-17 14:10:38.266203
3328	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Mighty Squirrel - Fluff	1	6/4/2025 5:59 AM	2026-03-17 14:10:38.27
3329	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Von Trapp - NZ Pilsner	1	6/4/2025 5:58 AM	2026-03-17 14:10:38.272728
3331	jmeharg	VILLAGE TRESTLE (THE)	Large Tap Marker	Fiddlehead - White	1	6/3/2025 12:04 PM	2026-03-17 14:10:38.278261
3332	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Mich Ultra	1	6/3/2025 11:37 AM	2026-03-17 14:10:38.281037
3335	jsewall	LYME COUNTRY STORE	Large Tap Marker	Sea Dog - Sun Fish	1	6/3/2025 9:27 AM	2026-03-17 14:10:38.288816
3336	maanderson	STROKERS	Large Tap Marker	21 Amend - Hell High Water	1	6/3/2025 9:25 AM	2026-03-17 14:10:38.291874
3338	pwollert	MADAME SHERRI'S	Large Tap Marker	Concord Craft - White Mtn White	1	6/2/2025 10:56 AM	2026-03-17 14:10:38.297177
3339	jsewall	ARIANA'S RESTAURANT	Large Tap Marker	Sea Dog - Sun Fish	1	5/29/2025 4:41 PM	2026-03-17 14:10:38.299774
3340	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Able - Lady of the Lake	1	5/29/2025 4:19 PM	2026-03-17 14:10:38.302612
3342	jgrumblatt	MARKET BASKET #53 CLAREMNT	Large Tap Marker	Henniker - Miles & Miles	1	5/29/2025 4:13 PM	2026-03-17 14:10:38.307884
3343	jaustin	GUERRILLA GRILL	Large Tap Marker	603 Brew - Summa	1	5/29/2025 3:40 PM	2026-03-17 14:10:38.310404
3345	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	603 Brew - Scenic	1	5/29/2025 3:08 PM	2026-03-17 14:10:38.316763
3346	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Zero Gravity - Cone Head	1	5/29/2025 12:20 PM	2026-03-17 14:10:38.319685
3347	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Fiddlehead - IPA	1	5/29/2025 11:46 AM	2026-03-17 14:10:38.322166
3348	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Gold Road Mango Cart	1	5/29/2025 11:46 AM	2026-03-17 14:10:38.325218
3349	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Concord Craft - White Mtn White	1	5/28/2025 4:01 PM	2026-03-17 14:10:38.327701
3350	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Stoneface - Coral Star	1	5/28/2025 4:01 PM	2026-03-17 14:10:38.330164
3351	jmeharg	BLUE BEAR HOSPITALITY LLC	Large Tap Marker	603 Brew - Hard Seltzer	1	5/28/2025 2:57 PM	2026-03-17 14:10:38.332877
3352	bgermano	STAGE HANDS RESTAURANT	Large Tap Marker	Maine Beer Co - Lunch	1	5/28/2025 2:49 PM	2026-03-17 14:10:38.335798
3354	jaustin	LOCAL BURGER OF KEENE	Large Tap Marker	Fiddlehead - IPA	1	5/28/2025 1:14 PM	2026-03-17 14:10:38.340718
3355	pwollert	GRANITE GORGE PARTNERSHIP	Large Tap Marker	603 Brew - Winni	1	5/28/2025 11:45 AM	2026-03-17 14:10:38.342951
3356	pwollert	GRANITE GORGE PARTNERSHIP	Large Tap Marker	Kona - Big Wave	1	5/28/2025 11:45 AM	2026-03-17 14:10:38.345664
3357	pwollert	GRANITE GORGE PARTNERSHIP	Large Tap Marker	Downeast - Original	1	5/28/2025 11:45 AM	2026-03-17 14:10:38.347962
3358	pwollert	GRANITE GORGE PARTNERSHIP	Large Tap Marker	Stoneface - IPA	1	5/28/2025 11:45 AM	2026-03-17 14:10:38.350406
3359	pwollert	GRANITE GORGE PARTNERSHIP	Large Tap Marker	Lord Hobo - Boomsauce	1	5/28/2025 11:45 AM	2026-03-17 14:10:38.353808
3360	pwollert	GRANITE GORGE PARTNERSHIP	Large Tap Marker	Mich Ultra	1	5/28/2025 11:45 AM	2026-03-17 14:10:38.356496
3361	jgrumblatt	NEW LONDON INN/COACH HOUSE RESTAURANT	Large Tap Marker	Henniker - Miles & Miles	1	5/28/2025 10:40 AM	2026-03-17 14:10:38.359943
3362	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	Carlson - Oak Hill	1	5/28/2025 10:19 AM	2026-03-17 14:10:38.362664
3377	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Maine Beer Co - Dinner	2	5/22/2025 2:14 PM	2026-03-17 19:05:56.524928
3395	pbelanger	EMMAS 321	Large Tap Marker	Mighty Squirrel - Kiwi White	2	5/21/2025 11:26 AM	2026-03-17 19:05:56.531232
3399	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Concord Craft - Pina Colada	2	5/21/2025 11:14 AM	2026-03-17 19:05:56.533644
3366	pwollert	POUR HOUSE (THE)	Large Tap Marker	603 Brew - Summa	1	5/27/2025 3:26 PM	2026-03-17 14:10:38.372594
3369	jgrumblatt	SALT HILL PUB - NEWBURY	Large Tap Marker	Kona - Big Wave	1	5/27/2025 12:09 PM	2026-03-17 14:10:38.380931
3370	rconstant	SMOKE SHACK CAFE	Large Tap Marker	Founders - All Day Shandy	1	5/27/2025 11:58 AM	2026-03-17 14:10:38.383575
3371	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Wormtown - Yard Party	1	5/26/2025 2:41 PM	2026-03-17 14:10:38.389281
3372	jaustin	CHILI'S - KEENE	Large Tap Marker	Sea Dog - Sun Fish	1	5/26/2025 11:19 AM	2026-03-17 14:10:38.391922
3373	pwollert	21 ROXBURY BAR & GRILL	Large Tap Marker	Henniker - Wrking Man Porter	1	5/22/2025 3:55 PM	2026-03-17 14:10:38.394248
3374	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Mighty Squirrel - Kiwi White	1	5/22/2025 3:49 PM	2026-03-17 14:10:38.39716
3375	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	BBCO - Dank Wizard	1	5/22/2025 3:49 PM	2026-03-17 14:10:38.400859
3378	lnorton	RIVER ROAD TAVERN	Large Tap Marker	21 Amend - Hell High Water	1	5/22/2025 2:14 PM	2026-03-17 14:10:38.412515
3379	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Upper Pass - Blue Lemon	1	5/22/2025 2:14 PM	2026-03-17 14:10:38.415731
3381	maanderson	NATIONAL CLUB (THE)	Large Tap Marker	von Trapp - Dunkel	1	5/22/2025 1:06 PM	2026-03-17 14:10:38.420999
3382	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	Able - Victory Nor Defeat	1	5/21/2025 4:30 PM	2026-03-17 14:10:38.424051
3387	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	603 Brew - IPA	1	5/21/2025 3:49 PM	2026-03-17 14:10:38.437946
3388	amartin	FODY'S TAVERN (NASHUA)	Large Tap Marker	Gold Road Mango Cart	1	5/21/2025 3:02 PM	2026-03-17 14:10:38.440343
3392	jaustin	KEENE COUNTRY CLUB INC	Large Tap Marker	Fiddlehead - IPA	1	5/21/2025 2:39 PM	2026-03-17 14:10:38.45179
3393	jcannamucio	SADDLE UP SALOON	Large Tap Marker	Gold Road Mango Cart	1	5/21/2025 1:28 PM	2026-03-17 14:10:38.454768
3394	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Wormtown - Summer	1	5/21/2025 12:16 PM	2026-03-17 14:10:38.457703
3396	pbelanger	EMMAS 321	Large Tap Marker	BBCO - Creatures Magic	1	5/21/2025 11:26 AM	2026-03-17 14:10:38.463826
3397	pbelanger	EMMAS 321	Large Tap Marker	Stoneface - Coral Star	1	5/21/2025 11:26 AM	2026-03-17 14:10:38.466726
3398	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Maine Beer Co - Dinner	1	5/21/2025 11:14 AM	2026-03-17 14:10:38.470445
3400	jsewall	WEATHERVANE - W.LEB	Large Tap Marker	Maine Beer Co - Lunch	1	5/21/2025 10:33 AM	2026-03-17 14:10:38.480442
3401	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	Carlson - Honey Crisp	1	5/21/2025 10:24 AM	2026-03-17 14:10:38.483491
3402	jmeharg	BLUE BEAR HOSPITALITY LLC	Large Tap Marker	Concord Craft - White Mtn White	1	5/21/2025 7:55 AM	2026-03-17 14:10:38.489655
3407	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Sea Dog - Blueberry	1	5/19/2025 7:12 PM	2026-03-17 14:10:38.506237
3408	jcannamucio	ATKINSON RESORT AND COUNTRY CLUB	Large Tap Marker	Sea Dog - Sun Fish	1	5/19/2025 4:36 PM	2026-03-17 14:10:38.50926
3409	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Upper Pass - Blue Lemon	1	5/19/2025 3:45 PM	2026-03-17 14:10:38.512273
3410	sshaunessy	UNION COFFEE COMPANY	Large Tap Marker	BBCO - Creatures Magic	1	5/19/2025 2:39 PM	2026-03-17 14:10:38.515199
3411	lnorton	MANCHESTER COUNTRY CLUB	Large Tap Marker	Lord Hobo - Boomsauce	1	5/19/2025 12:57 PM	2026-03-17 14:10:38.518741
3412	lnorton	MANCHESTER COUNTRY CLUB	Large Tap Marker	603 Brew - Hard Seltzer	1	5/19/2025 12:57 PM	2026-03-17 14:10:38.521732
3413	lnorton	MANCHESTER COUNTRY CLUB	Large Tap Marker	Founders - All Day Shandy	1	5/19/2025 12:57 PM	2026-03-17 14:10:38.524506
3414	lnorton	RIVER ROAD TAVERN	Large Tap Marker	BBCO - Straw Whale	1	5/15/2025 3:32 PM	2026-03-17 14:10:38.52716
3415	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Stoneface - Coral Star	1	5/15/2025 3:32 PM	2026-03-17 14:10:38.529771
3416	amartin	BACKSTREET BAR & GRILL LLC	Large Tap Marker	Downeast - Original	1	5/15/2025 1:06 PM	2026-03-17 14:10:38.532469
3417	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Large Tap Marker	Able - Lady of the Lake	1	5/15/2025 11:20 AM	2026-03-17 14:10:38.535663
3418	jjohnson	CANTORE'S PIZZA	Large Tap Marker	Downeast - Drier Side	1	5/15/2025 11:20 AM	2026-03-17 14:10:38.538334
3433	pbelanger	EMMAS 321	Large Tap Marker	BBCO - Lighthouse	2	5/14/2025 12:25 PM	2026-03-17 19:05:56.536855
3444	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	Sea Dog - Blueberry	2	5/12/2025 1:33 PM	2026-03-17 19:05:56.541738
3456	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	Bud Light	2	5/8/2025 11:43 AM	2026-03-17 19:05:56.547966
3462	jaustin	GUERRILLA GRILL	Large Tap Marker	Henniker - Picnic	2	5/7/2025 1:09 PM	2026-03-17 19:05:56.550582
3428	jaustin	GUERRILLA GRILL	Large Tap Marker	Dos Equis Amber	1	5/14/2025 2:50 PM	2026-03-17 14:10:38.56838
3430	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Fiddlehead - White	1	5/14/2025 12:54 PM	2026-03-17 14:10:38.573732
3432	pbelanger	EMMAS 321	Large Tap Marker	Frost - Starchild	1	5/14/2025 12:25 PM	2026-03-17 14:10:38.579777
3434	pbelanger	EMMAS 321	Large Tap Marker	Jack's Abby - Brite as Hell	1	5/14/2025 12:25 PM	2026-03-17 14:10:38.586001
3435	pbelanger	EMMAS 321	Large Tap Marker	Concord Craft - Blue Coggler	1	5/14/2025 12:25 PM	2026-03-17 14:10:38.589042
3436	jmorse	CLAREMONT LODGE OF ELKS	Large Tap Marker	Shipyard - Summer	1	5/13/2025 2:01 PM	2026-03-17 14:10:38.591856
3437	ggage	THE BRICKHOUSE RESTAURANT AND BREWERY	Large Tap Marker	Dos Equis Amber	1	5/13/2025 9:28 AM	2026-03-17 14:10:38.59558
3438	ddooling	TAVERN IN THE SQUARE SALEM LLC	Large Tap Marker	Henniker - Kolsch	1	5/12/2025 4:06 PM	2026-03-17 14:10:38.598213
3439	ddooling	TAVERN IN THE SQUARE SALEM LLC	Large Tap Marker	Stoneface - Sunday Sauce	1	5/12/2025 4:06 PM	2026-03-17 14:10:38.601137
3442	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	Jack's Abby - House Lager	1	5/12/2025 2:26 PM	2026-03-17 14:10:38.609999
3443	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Von Trapp - Dortmunder	1	5/12/2025 2:11 PM	2026-03-17 14:10:38.612957
3445	jgiuffrida	LIM'S SPORTS BAR & CAFE	Large Tap Marker	Kona - Big Wave	1	5/12/2025 1:32 PM	2026-03-17 14:10:38.618763
3451	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	Founders - Imperial Thorn	1	5/8/2025 3:13 PM	2026-03-17 14:10:38.63518
3452	pbelanger	MAMA MCDONOUGH'S IRISH PUB	Large Tap Marker	Budweiser	1	5/8/2025 1:43 PM	2026-03-17 14:10:38.638869
3453	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Widowmaker - Mindcrawler	1	5/8/2025 1:42 PM	2026-03-17 14:10:38.646835
3454	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Widowmaker - Riff City	1	5/8/2025 1:42 PM	2026-03-17 14:10:38.649392
3457	jsewall	SAWTOOTH KITCHEN LLC	Large Tap Marker	Wicked Weed Pernicious	1	5/8/2025 11:12 AM	2026-03-17 14:10:38.657517
3458	jaustin	MAIN CRUST CO.	Large Tap Marker	BBCO - Straw Whale	1	5/7/2025 3:40 PM	2026-03-17 14:10:38.660059
3459	pwollert	MADAME SHERRI'S	Large Tap Marker	Citizen Cider - Juicy Haze	1	5/7/2025 3:02 PM	2026-03-17 14:10:38.662431
3465	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Wicked Weed Pernicious	1	5/7/2025 11:58 AM	2026-03-17 14:10:38.679773
3466	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Throwback - Cheek Squeezer	1	5/7/2025 11:58 AM	2026-03-17 14:10:38.682836
3467	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Able - Victory Nor Defeat	1	5/7/2025 11:58 AM	2026-03-17 14:10:38.685877
3468	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Founders - All Day Shandy	1	5/7/2025 11:58 AM	2026-03-17 14:10:38.688568
3469	ggage	OLDE KILKENNY PUB	Large Tap Marker	Founders - All Day Shandy	1	5/7/2025 11:19 AM	2026-03-17 14:10:38.691349
3470	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	Von Trapp - Dortmunder	1	5/7/2025 10:04 AM	2026-03-17 14:10:38.693726
3472	pwollert	POUR HOUSE (THE)	Large Tap Marker	Concord Craft - White Mtn White	1	5/6/2025 2:01 PM	2026-03-17 14:10:38.698389
3473	pwollert	POUR HOUSE (THE)	Large Tap Marker	Henniker - Picnic	1	5/6/2025 2:01 PM	2026-03-17 14:10:38.700767
3474	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	Able - Lady of the Lake	1	5/6/2025 1:55 PM	2026-03-17 14:10:38.703013
3476	pwollert	SAKA HIBACHI STEAKHOUSE	Large Tap Marker	Fiddlehead - IPA	1	5/6/2025 9:47 AM	2026-03-17 14:10:38.708063
3477	pwollert	SAKA HIBACHI STEAKHOUSE	Large Tap Marker	Stoneface - IPA	1	5/6/2025 9:47 AM	2026-03-17 14:10:38.710403
3478	pwollert	SAKA HIBACHI STEAKHOUSE	Large Tap Marker	Bud Light	1	5/6/2025 9:47 AM	2026-03-17 14:10:38.712603
3481	rconstant	TWINS SMOKE SHOP	Large Tap Marker	603 Brew - Summa	1	5/5/2025 12:57 PM	2026-03-17 14:10:38.719894
3482	rconstant	TWINS SMOKE SHOP	Large Tap Marker	603 Brew - Winni	1	5/5/2025 12:57 PM	2026-03-17 14:10:38.722356
3484	jaustin	CLIFFY'S PUB	Large Tap Marker	Dos Equis Amber	2	5/1/2025 4:17 PM	2026-03-17 19:05:56.554
3485	jaustin	CHILI'S - KEENE	Large Tap Marker	Stella Artois	1	5/1/2025 3:46 PM	2026-03-17 14:10:38.730484
3486	jaustin	CHILI'S - KEENE	Large Tap Marker	Mich Ultra	1	5/1/2025 3:46 PM	2026-03-17 14:10:38.732917
3488	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Maine Beer Co - Another One	2	5/1/2025 3:38 PM	2026-03-17 19:05:56.557792
3489	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Equilibrium - Tomorrow	1	5/1/2025 3:38 PM	2026-03-17 14:10:38.740066
3490	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	Kona - Big Wave	1	5/1/2025 3:23 PM	2026-03-17 14:10:38.742814
3491	pwollert	ALYSONS ORCHARD	Large Tap Marker	Sea Dog - Blueberry	1	5/1/2025 3:00 PM	2026-03-17 14:10:38.745316
3496	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	Henniker - Seltzer Baboosic	2	5/1/2025 10:52 AM	2026-03-17 19:05:56.562432
3493	scamuso	SHORTY'S MEXICAN ROADHOUSE	Large Tap Marker	Downeast - Guava Passion	1	5/1/2025 2:14 PM	2026-03-17 14:10:38.75037
3506	pbelanger	RUSTIC TABLE (THE)	Large Tap Marker	Jack's Abby - Blood Orange Wheat	2	4/29/2025 4:18 PM	2026-03-17 19:05:56.565495
3495	ggage	ALAMO TEXAS BAR-B-QUE & TEQUILA BAR	Large Tap Marker	603 Brew - Hard Seltzer	1	5/1/2025 10:55 AM	2026-03-17 14:10:38.755755
3510	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Jack's Abby - Porch Fest	2	4/28/2025 4:38 PM	2026-03-17 19:05:56.568967
3528	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Able - Burn the Ships	2	4/24/2025 11:20 AM	2026-03-17 19:05:56.572456
3499	jaustin	MAIN CRUST CO.	Large Tap Marker	Wicked Weed Pernicious	1	4/30/2025 3:20 PM	2026-03-17 14:10:38.768722
3500	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Concord Craft - Pandora Kettle	1	4/30/2025 2:04 PM	2026-03-17 14:10:38.771425
3501	amartin	RIVERWALK BAKERY & CAFE	Large Tap Marker	Kona - Big Wave	1	4/30/2025 2:03 PM	2026-03-17 14:10:38.774312
3502	amartin	RIVERWALK BAKERY & CAFE	Large Tap Marker	Gold Road Mango Cart	1	4/30/2025 2:03 PM	2026-03-17 14:10:38.776777
3503	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Banded - Wicked	1	4/30/2025 1:46 PM	2026-03-17 14:10:38.779952
3504	sshaunessy	BOWLING ACRES	Large Tap Marker	21 Amend - Hell High Water	1	4/30/2025 11:45 AM	2026-03-17 14:10:38.782266
3505	ggage	99 REST - NASHUA	Large Tap Marker	Gold Road Mango Cart	1	4/30/2025 8:39 AM	2026-03-17 14:10:38.787025
3507	pwollert	POUR HOUSE (THE)	Large Tap Marker	Dos Equis Amber	1	4/29/2025 2:51 PM	2026-03-17 14:10:38.792672
3508	jaustin	GUERRILLA GRILL	Large Tap Marker	Shocktop	1	4/29/2025 2:41 PM	2026-03-17 14:10:38.795042
3538	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Mich Ultra	3	4/22/2025 3:14 PM	2026-03-17 19:05:56.575709
3511	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	New Belgium - Juicy Haze	1	4/28/2025 3:51 PM	2026-03-17 14:10:38.802469
3512	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	Lord Hobo - Boomsauce	1	4/28/2025 3:51 PM	2026-03-17 14:10:38.805091
3513	jmeharg	BLUE BEAR HOSPITALITY LLC	Large Tap Marker	Concord Craft - Safe Space	1	4/28/2025 3:50 PM	2026-03-17 14:10:38.808436
3515	ggage	ROUTE 13 STATELINE CONV MART	Large Tap Marker	Dos Equis Amber	1	4/28/2025 1:08 PM	2026-03-17 14:10:38.814353
3517	jjohnson	SNAX	Large Tap Marker	Zero Gravity - Madonna	1	4/28/2025 12:15 PM	2026-03-17 14:10:38.81984
3518	jmeharg	HILLSBORO HOUSE OF PIZZA	Large Tap Marker	603 Brew - Summa	1	4/28/2025 11:34 AM	2026-03-17 14:10:38.822971
3519	ggage	ALAMO TEXAS BAR-B-QUE & TEQUILA BAR	Large Tap Marker	Fiddlehead - IPA	1	4/24/2025 3:37 PM	2026-03-17 14:10:38.825974
3520	ggage	ALAMO TEXAS BAR-B-QUE & TEQUILA BAR	Large Tap Marker	Stoneface - Berliner Weisse	1	4/24/2025 3:37 PM	2026-03-17 14:10:38.828724
3521	ggage	ALAMO TEXAS BAR-B-QUE & TEQUILA BAR	Large Tap Marker	Carlson - Honey Crisp	1	4/24/2025 3:37 PM	2026-03-17 14:10:38.831621
3523	maanderson	PENUCHE'S ALE HOUSE-NASHUA	Large Tap Marker	Founders - All Day Shandy	1	4/24/2025 3:22 PM	2026-03-17 14:10:38.837472
3524	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	Able - Burn the Ships	1	4/24/2025 2:46 PM	2026-03-17 14:10:38.840278
3525	jaustin	GUERRILLA GRILL	Large Tap Marker	Founders - All Day Shandy	1	4/24/2025 2:10 PM	2026-03-17 14:10:38.843178
3526	jaustin	GUERRILLA GRILL	Large Tap Marker	Founders - Mortal Bloom	1	4/24/2025 2:10 PM	2026-03-17 14:10:38.845743
3527	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Henniker - Picnic	1	4/24/2025 11:21 AM	2026-03-17 14:10:38.857551
3529	ddooling	PELHAM STREET BLACK WATER GRILL	Large Tap Marker	Kona - Big Wave	1	4/23/2025 5:00 PM	2026-03-17 14:10:38.86296
3530	ddooling	PELHAM STREET BLACK WATER GRILL	Large Tap Marker	Maine Beer Co - Lunch	1	4/23/2025 3:59 PM	2026-03-17 14:10:38.866055
3531	amartin	UNION PUBLIC HOUSE	Large Tap Marker	Jack's Abby - Post Shift	1	4/23/2025 3:45 PM	2026-03-17 14:10:38.868831
3532	jaustin	APPLEBEES - KEENE #6714	Large Tap Marker	Dos Equis Amber	1	4/23/2025 3:39 PM	2026-03-17 14:10:38.871337
3533	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Maine Beer Co - Spring	1	4/23/2025 2:35 PM	2026-03-17 14:10:38.874064
3534	sshaunessy	WATERHOUSE BISTRO	Large Tap Marker	Wormtown - Yard Party	1	4/23/2025 2:20 PM	2026-03-17 14:10:38.876471
3535	jgrumblatt	PETER CHRISTIANS TAVERN	Large Tap Marker	Carlson - Oak Hill	1	4/23/2025 1:06 PM	2026-03-17 14:10:38.878843
3536	jgrumblatt	THE REFINERY	Large Tap Marker	Golden Road AF Mango	2	4/23/2025 12:20 PM	2026-03-17 14:10:38.884507
3537	jgrumblatt	JALISCO MEXICAN BAR & GRILL	Large Tap Marker	Dos Equis	1	4/22/2025 8:32 PM	2026-03-17 14:10:38.887879
3539	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Wormtown - Yard Party	1	4/22/2025 3:08 PM	2026-03-17 14:10:38.892356
3540	sshaunessy	AMERICAN LEGION POST 11 - JAFFREY	Large Tap Marker	Kona - Big Wave	1	4/22/2025 1:55 PM	2026-03-17 14:10:38.894549
3555	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Kona - Big Wave	2	4/21/2025 12:07 PM	2026-03-17 19:05:56.578773
3579	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	BBCO - Dank Wizard	2	4/15/2025 8:55 AM	2026-03-17 19:05:56.583774
3581	jjohnson	SNAX	Large Tap Marker	Industrial - Wrench	2	4/14/2025 12:43 PM	2026-03-17 19:05:56.587142
3545	ggage	VFW #4368 - MILFORD	Large Tap Marker	Gold Road Mango Cart	1	4/22/2025 10:03 AM	2026-03-17 14:10:38.907378
3546	sshaunessy	RILEY'S PLACE	Large Tap Marker	Kona - Big Wave	1	4/21/2025 3:56 PM	2026-03-17 14:10:38.909826
3547	sshaunessy	UNION COFFEE COMPANY	Large Tap Marker	Citizen Cider - Unified Press	1	4/21/2025 3:48 PM	2026-03-17 14:10:38.912208
3548	sshaunessy	UNION COFFEE COMPANY	Large Tap Marker	Stoneface - IPA	1	4/21/2025 3:48 PM	2026-03-17 14:10:38.914553
3549	sshaunessy	UNION COFFEE COMPANY	Large Tap Marker	Zero Gravity - Green State	1	4/21/2025 3:48 PM	2026-03-17 14:10:38.917048
3550	lortiz	RED ROBIN BURGERS #515 NASHUA	Large Tap Marker	Downeast - Peach Mango	1	4/21/2025 3:34 PM	2026-03-17 14:10:38.919405
3551	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	4/21/2025 2:30 PM	2026-03-17 14:10:38.922105
3552	sshaunessy	BIRCHWOOD INN (THE)	Large Tap Marker	Wormtown - Yard Party	1	4/21/2025 1:41 PM	2026-03-17 14:10:38.924758
3554	jcannamucio	CARRIAGE TOWN BAR & GRILL	Large Tap Marker	Gold Road Belgian White	1	4/21/2025 12:30 PM	2026-03-17 14:10:38.929713
3556	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Downeast - Peach Mango	1	4/17/2025 4:18 PM	2026-03-17 14:10:38.934911
3557	lnorton	RIVER ROAD TAVERN	Large Tap Marker	BBCO - Dank Wizard	1	4/17/2025 4:18 PM	2026-03-17 14:10:38.938164
3558	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Austin Street - Instant Crush	1	4/17/2025 4:18 PM	2026-03-17 14:10:38.940706
3563	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Wormtown - Yard Party	1	4/17/2025 12:14 PM	2026-03-17 14:10:38.953391
3566	amartin	CASA VIEJA MEXICAN GRILL	Large Tap Marker	Mich Ultra	1	4/16/2025 3:51 PM	2026-03-17 14:10:38.960742
3568	ddooling	SEVMAR MEDITERRANEAN BISTRO	Large Tap Marker	Gold Road Mango Cart	1	4/16/2025 2:38 PM	2026-03-17 14:10:38.965882
3569	ggage	OLDE KILKENNY PUB	Large Tap Marker	Fiddlehead - Second	1	4/16/2025 2:07 PM	2026-03-17 14:10:38.968575
3570	ggage	OLDE KILKENNY PUB	Large Tap Marker	Mighty Squirrel - Magic Rain	1	4/16/2025 2:07 PM	2026-03-17 14:10:38.971026
3571	jmeharg	BLUE BEAR HOSPITALITY LLC	Large Tap Marker	Henniker - Dinger	1	4/16/2025 1:38 PM	2026-03-17 14:10:38.973917
3572	sshaunessy	PEARL RESTAURANT & OYSTER	Large Tap Marker	New Belgium - Fat Tire	1	4/16/2025 1:28 PM	2026-03-17 14:10:38.976488
3573	sshaunessy	PEARL RESTAURANT & OYSTER	Large Tap Marker	von Trapp - Pilsner	1	4/16/2025 1:28 PM	2026-03-17 14:10:38.978939
3574	sshaunessy	BOWLING ACRES	Large Tap Marker	BBCO - Dank Wizard	1	4/16/2025 12:06 PM	2026-03-17 14:10:38.98201
3575	jgrumblatt	LAKE SUNAPEE COUNTRY CLUB	Large Tap Marker	Downeast - Original	1	4/16/2025 11:58 AM	2026-03-17 14:10:38.984438
3576	pwollert	BIRDIES	Large Tap Marker	Sea Dog - Blueberry	1	4/16/2025 7:43 AM	2026-03-17 14:10:38.987669
3577	ggage	OLDE TOWNE TAVERN	Large Tap Marker	Gold Road Mango Cart	1	4/15/2025 1:37 PM	2026-03-17 14:10:38.990267
3578	jcannamucio	JAMISON'S	Large Tap Marker	Gold Road Belgian White	1	4/15/2025 10:33 AM	2026-03-17 14:10:38.99278
3580	jgiuffrida	DREO FOOD AND DRINK	Large Tap Marker	Kona - Big Wave	1	4/14/2025 3:01 PM	2026-03-17 14:10:38.99797
3582	jjohnson	SNAX	Large Tap Marker	Von Trapp - Dortmunder	1	4/14/2025 12:27 PM	2026-03-17 14:10:39.003245
3586	ddooling	COPPER DOOR - SALEM	Large Tap Marker	Weihenstephaner - Hefe	1	4/14/2025 10:41 AM	2026-03-17 14:10:39.013675
3589	amartin	SAN FRANCISCO KITCHEN INC	Large Tap Marker	Downeast - Original	1	4/10/2025 3:56 PM	2026-03-17 14:10:39.031054
3590	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Mighty Squirrel - Magic Rain	1	4/10/2025 3:02 PM	2026-03-17 14:10:39.033553
3591	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Jack's Abby - Porch Fest	1	4/10/2025 3:02 PM	2026-03-17 14:10:39.037336
3595	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	603 Brew - Beer Hall	1	4/10/2025 12:03 PM	2026-03-17 14:10:39.048822
3596	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Kona - Big Wave	1	4/10/2025 11:34 AM	2026-03-17 14:10:39.051425
3597	jjohnson	CANTORE'S PIZZA	Large Tap Marker	Maine Beer Co - Lunch	1	4/10/2025 10:41 AM	2026-03-17 14:10:39.054909
3602	jgrumblatt	NEWPORT GOLF CLUB	Large Tap Marker	603 Brew - Winni	1	4/9/2025 3:44 PM	2026-03-17 14:10:39.068997
3603	rconstant	LI'L LOBSTER BOAT	Large Tap Marker	Kona - Big Wave	1	4/9/2025 3:43 PM	2026-03-17 14:10:39.071894
3604	rconstant	LI'L LOBSTER BOAT	Large Tap Marker	Gold Road Mango Cart	1	4/9/2025 3:43 PM	2026-03-17 14:10:39.074868
3606	sshaunessy	WATERHOUSE BISTRO	Large Tap Marker	Newburyport - Plum Island	1	4/9/2025 2:40 PM	2026-03-17 14:10:39.080271
3609	maanderson	LUK'S BAR & GRILL	Large Tap Marker	603 Brew - IPA	1	4/9/2025 12:14 PM	2026-03-17 14:10:39.089374
3610	sshaunessy	BOWLING ACRES	Large Tap Marker	Other Half - Big Necatron Vibes	1	4/9/2025 11:56 AM	2026-03-17 14:10:39.091781
3612	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	603 Brew - Summa	1	4/9/2025 10:50 AM	2026-03-17 14:10:39.096411
3615	pwollert	POUR HOUSE (THE)	Large Tap Marker	Von Trapp - Dortmunder	1	4/8/2025 3:15 PM	2026-03-17 14:10:39.104063
3619	rconstant	SUPPAS PIZZA LONDONDERRY	Large Tap Marker	Founders - Mortal Bloom	1	4/8/2025 12:04 PM	2026-03-17 14:10:39.113654
3620	maanderson	PINE VALLEY GOLF COURSE	Large Tap Marker	Gold Road Mango Cart	1	4/8/2025 9:59 AM	2026-03-17 14:10:39.116243
3621	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Gold Road Mango Cart	1	4/7/2025 3:41 PM	2026-03-17 14:10:39.119701
3622	amartin	SAKURA	Large Tap Marker	603 Brew - Summa	1	4/7/2025 3:38 PM	2026-03-17 14:10:39.123133
3623	sshaunessy	BIRCHWOOD INN (THE)	Large Tap Marker	Concord Craft - Safe Space	1	4/7/2025 2:55 PM	2026-03-17 14:10:39.126233
3624	ddooling	MICHAELS FLATBREAD PIZZA CO.	Large Tap Marker	Maine Beer Co - Lunch	1	4/7/2025 1:35 PM	2026-03-17 14:10:39.12951
3625	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Other Half - Tall Kiwi	1	4/3/2025 4:20 PM	2026-03-17 14:10:39.131998
3626	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Fiddlehead - White	1	4/3/2025 4:20 PM	2026-03-17 14:10:39.134369
3627	amartin	SURF RESTAURANT INC	Large Tap Marker	BBCO - Lighthouse	1	4/3/2025 3:25 PM	2026-03-17 14:10:39.137144
3628	maanderson	PENUCHE'S ALE HOUSE-NASHUA	Large Tap Marker	Oskar Blues - Dales Pale	1	4/3/2025 3:23 PM	2026-03-17 14:10:39.139629
3632	jgiuffrida	LIM'S SPORTS BAR & CAFE	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	4/3/2025 1:38 PM	2026-03-17 14:10:39.149548
3633	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	Able - Burn the Ships	1	4/3/2025 1:16 PM	2026-03-17 14:10:39.15193
3634	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Zero Gravity - Madonna	1	4/3/2025 11:27 AM	2026-03-17 14:10:39.15457
3635	jaustin	CHILI'S - KEENE	Large Tap Marker	Sea Dog - Blueberry	1	4/3/2025 11:14 AM	2026-03-17 14:10:39.157757
3637	pbelanger	MEXICA MEXICAN RESTAURANT	Large Tap Marker	Dos Equis Amber	1	4/2/2025 4:58 PM	2026-03-17 14:10:39.163369
3638	pbelanger	MEXICA MEXICAN RESTAURANT	Large Tap Marker	603 Brew - IPA	1	4/2/2025 4:58 PM	2026-03-17 14:10:39.16636
3639	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Tuckerman - Pale Ale	1	4/2/2025 2:45 PM	2026-03-17 14:10:39.168793
3640	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Able - Victory Nor Defeat	1	4/2/2025 2:45 PM	2026-03-17 14:10:39.171242
3641	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Stoneface - Berliner Weisse	1	4/2/2025 2:45 PM	2026-03-17 14:10:39.174095
3642	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Henniker - Roast	1	4/2/2025 2:45 PM	2026-03-17 14:10:39.176393
3643	jmeharg	DANIEL'S PUB INC	Large Tap Marker	Henniker - Dinger	1	4/2/2025 2:17 PM	2026-03-17 14:10:39.178975
3646	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Fiddlehead - Second	1	4/2/2025 1:51 PM	2026-03-17 14:10:39.186489
3647	rconstant	SUPPAS PIZZA LONDONDERRY	Large Tap Marker	Left Hand - Milk Stout	1	4/2/2025 1:38 PM	2026-03-17 14:10:39.189455
3648	rconstant	SUPPAS PIZZA LONDONDERRY	Large Tap Marker	Kona - Big Wave	1	4/2/2025 1:38 PM	2026-03-17 14:10:39.191715
3649	rconstant	SUPPAS PIZZA LONDONDERRY	Large Tap Marker	Downeast - Peach Mango	1	4/2/2025 1:38 PM	2026-03-17 14:10:39.194645
3651	pbelanger	EMMAS 321	Large Tap Marker	Downeast - Peach Mango	1	4/2/2025 12:04 PM	2026-03-17 14:10:39.200118
3652	rconstant	SMOKE SHACK CAFE	Large Tap Marker	Gold Road Mango Cart	1	4/1/2025 4:33 PM	2026-03-17 14:10:39.20271
3655	jmorse	DADDY'S PIZZA	Large Tap Marker	Wicked Weed Pernicious	1	4/1/2025 1:55 PM	2026-03-17 14:10:39.211006
3659	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	True North - Any Tang	1	3/31/2025 2:26 PM	2026-03-17 14:10:39.221317
3660	ggage	CHRYSANTHI'S	Large Tap Marker	Concord Craft - White Mtn White	1	3/31/2025 2:21 PM	2026-03-17 14:10:39.223972
3665	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Wicked Weed Pernicious	3	3/30/2025 12:00 PM	2026-03-17 19:05:56.591633
3662	jaustin	KILKENNY PUB - KEENE	Large Tap Marker	Kona - Big Wave	1	3/31/2025 1:50 PM	2026-03-17 14:10:39.229725
3687	jaustin	A-1 PIZZA & GRILL HINSDALE	Large Tap Marker	Kona - Big Wave	2	3/25/2025 2:58 PM	2026-03-17 19:05:56.59535
3664	rconstant	99 REST - LONDONDERRY	Large Tap Marker	Gold Road Mango Cart	1	3/31/2025 9:09 AM	2026-03-17 14:10:39.235205
3666	lnorton	PRESSED CAFE - BEDFORD	Large Tap Marker	Fiddlehead - White	1	3/27/2025 3:49 PM	2026-03-17 14:10:39.240846
3667	pwollert	21 ROXBURY BAR & GRILL	Large Tap Marker	Able - Lady of the Lake	1	3/27/2025 3:26 PM	2026-03-17 14:10:39.243233
3668	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Maine Beer Co - Spring	1	3/27/2025 3:15 PM	2026-03-17 14:10:39.245401
3669	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Downeast - Drier Side	1	3/27/2025 3:15 PM	2026-03-17 14:10:39.247769
3692	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Tuckerman - Pale Ale	3	3/25/2025 9:30 AM	2026-03-17 19:05:56.598422
3671	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Peak - Sweet Tarts	1	3/27/2025 11:33 AM	2026-03-17 14:10:39.253889
3693	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Upper Pass - First Drop	2	3/25/2025 9:30 AM	2026-03-17 19:05:56.600717
3673	jmeharg	RIVERSIDE GRILLE	Large Tap Marker	Tuckerman - Pale Ale	1	3/26/2025 3:21 PM	2026-03-17 14:10:39.25909
3703	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Other Half - Broccoli	2	3/20/2025 3:11 PM	2026-03-17 19:05:56.605777
3678	amartin	SPECTACLE MANAGEMENT INC	Large Tap Marker	Able - Burn the Ships	1	3/26/2025 3:03 PM	2026-03-17 14:10:39.271703
3679	jgiuffrida	STONECUTTERS PUB	Large Tap Marker	Gold Road Mango Cart	1	3/26/2025 2:16 PM	2026-03-17 14:10:39.274246
3680	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Able - Lady of the Lake	1	3/26/2025 2:00 PM	2026-03-17 14:10:39.276458
3681	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Mighty Squirrel - Hammer	1	3/26/2025 2:00 PM	2026-03-17 14:10:39.278875
3682	pbelanger	EMMAS 321	Large Tap Marker	Jack's Abby - Porch Fest	1	3/26/2025 1:09 PM	2026-03-17 14:10:39.281391
3683	lnorton	COPPER DOOR - BEDFORD	Large Tap Marker	Kona - Big Wave	1	3/26/2025 12:12 PM	2026-03-17 14:10:39.284168
3684	jsewall	WEATHERVANE - W.LEB	Large Tap Marker	Concord Craft - Four Rivers	1	3/26/2025 10:21 AM	2026-03-17 14:10:39.286704
3685	jgrumblatt	RAGGED MOUNTAIN	Large Tap Marker	Stoneface - Duderino	1	3/26/2025 9:38 AM	2026-03-17 14:10:39.289691
3688	ggage	99 REST - NASHUA	Large Tap Marker	Kona - Big Wave	1	3/25/2025 1:08 PM	2026-03-17 14:10:39.298343
3694	maanderson	PENUCHE'S ALE HOUSE-NASHUA	Large Tap Marker	Wicked Weed Pernicious	1	3/24/2025 3:23 PM	2026-03-17 14:10:39.313458
3695	jcannamucio	DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)	Large Tap Marker	603 Brew - Irish Hello	1	3/24/2025 2:39 PM	2026-03-17 14:10:39.316027
3696	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	Maine Beer Co - Lunch	1	3/24/2025 2:18 PM	2026-03-17 14:10:39.318932
3699	scamuso	BISTRO 603	Large Tap Marker	Gold Road Mango Cart	1	3/24/2025 1:28 PM	2026-03-17 14:10:39.327916
3700	maanderson	NATIONAL CLUB (THE)	Large Tap Marker	Wicked Weed Pernicious	1	3/24/2025 12:59 PM	2026-03-17 14:10:39.33077
3702	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Stoneface - Astral Surf	1	3/20/2025 3:11 PM	2026-03-17 14:10:39.336817
3705	amartin	BACKSTREET BAR & GRILL LLC	Large Tap Marker	Kona - Big Wave	1	3/20/2025 2:34 PM	2026-03-17 14:10:39.343785
3707	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Able - Lady of the Lake	1	3/20/2025 11:31 AM	2026-03-17 14:10:39.349782
3708	amartin	UNION PUBLIC HOUSE	Large Tap Marker	Kona - Big Wave	1	3/19/2025 3:39 PM	2026-03-17 14:10:39.354084
3711	maanderson	T-BONES - HUDSON	Large Tap Marker	Mich Ultra	1	3/19/2025 2:03 PM	2026-03-17 14:10:39.361942
3712	jaustin	LOCAL BURGER OF KEENE	Large Tap Marker	Kona - Big Wave	1	3/19/2025 1:26 PM	2026-03-17 14:10:39.364378
3713	jaustin	LOCAL BURGER OF KEENE	Large Tap Marker	Maine Beer Co - Lunch	1	3/19/2025 1:26 PM	2026-03-17 14:10:39.367269
3717	amartin	FODY'S TAVERN (NASHUA)	Large Tap Marker	Kona - Big Wave	1	3/19/2025 12:39 PM	2026-03-17 14:10:39.379089
3747	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Large Tap Marker	603 Brew - IPA	2	3/11/2025 3:16 PM	2026-03-17 19:05:56.609614
3756	ddooling	MICHAELS FLATBREAD PIZZA CO.	Large Tap Marker	Gold Road Mango Cart	2	3/10/2025 2:30 PM	2026-03-17 19:05:56.612789
3766	jaustin	MAIN CRUST CO.	Large Tap Marker	Sea Dog - Blueberry	2	3/5/2025 4:23 PM	2026-03-17 19:05:56.615468
3723	pwollert	BIRDIES	Large Tap Marker	Concord Craft - Safe Space	1	3/19/2025 8:44 AM	2026-03-17 14:10:39.395667
3724	jsewall	TARGET # 3401 - W. LEBANON	Large Tap Marker	Fiddlehead - IPA	1	3/19/2025 8:20 AM	2026-03-17 14:10:39.39808
3725	lnorton	X-GOLF BEDFORD	Large Tap Marker	603 Brew - Summa	1	3/18/2025 2:15 PM	2026-03-17 14:10:39.400647
3726	jmeharg	SNACKSHOT CATERING	Large Tap Marker	Maine Beer Co - Lunch	1	3/18/2025 11:37 AM	2026-03-17 14:10:39.403058
3732	ddooling	T-BONES - SALEM	Large Tap Marker	Gold Road Mango Cart	1	3/17/2025 12:09 PM	2026-03-17 14:10:39.419651
3733	ddooling	T-BONES - SALEM	Large Tap Marker	Weihenstephaner - Hefe	1	3/17/2025 12:09 PM	2026-03-17 14:10:39.42238
3734	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Able - Fighting 69th	1	3/13/2025 4:01 PM	2026-03-17 14:10:39.425039
3736	lnorton	MURPHY'S TAPROOM AND CARRIAGE HOUSE	Large Tap Marker	Wormtown - Irish Red	1	3/13/2025 12:29 PM	2026-03-17 14:10:39.430575
3738	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Able - Fighting 69th	1	3/12/2025 2:49 PM	2026-03-17 14:10:39.435552
3741	jmeharg	DANIEL'S PUB INC	Large Tap Marker	Henniker - Roast	1	3/12/2025 2:03 PM	2026-03-17 14:10:39.443184
3742	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	New Belgium - Fat Tire	1	3/12/2025 1:45 PM	2026-03-17 14:10:39.446027
3743	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Lord Hobo - Boomsauce	1	3/12/2025 1:33 PM	2026-03-17 14:10:39.448923
3744	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Austin Street - Patina	1	3/12/2025 12:46 PM	2026-03-17 14:10:39.451588
3745	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Wormtown - Irish Red	1	3/12/2025 12:46 PM	2026-03-17 14:10:39.454567
3746	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Wicked Weed Pernicious	1	3/12/2025 12:28 PM	2026-03-17 14:10:39.45692
3748	rconstant	SUPPAS PIZZA LONDONDERRY	Large Tap Marker	Wicked Weed Pernicious	1	3/11/2025 1:34 PM	2026-03-17 14:10:39.462795
3751	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Wormtown - Irish Red	1	3/11/2025 11:02 AM	2026-03-17 14:10:39.471905
3752	ggage	AMERICAN LEGION POST 23 - MILFORD	Large Tap Marker	Kona - Big Wave	1	3/11/2025 9:37 AM	2026-03-17 14:10:39.475002
3753	maanderson	STROKERS	Large Tap Marker	Bud Light	1	3/11/2025 9:36 AM	2026-03-17 14:10:39.478446
3755	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	Mich Ultra	1	3/10/2025 3:04 PM	2026-03-17 14:10:39.484606
3757	jjohnson	SNAX	Large Tap Marker	Wicked Weed Pernicious	1	3/10/2025 2:04 PM	2026-03-17 14:10:39.49124
3758	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	Henniker - Roast	1	3/10/2025 1:12 PM	2026-03-17 14:10:39.494686
3761	jaustin	GUERRILLA GRILL	Large Tap Marker	Gold Road Mango Cart	1	3/6/2025 2:43 PM	2026-03-17 14:10:39.504252
3762	lortiz	NOT YOUR AVERAGE JOE'S	Large Tap Marker	Fiddlehead - IPA	1	3/6/2025 1:25 PM	2026-03-17 14:10:39.506896
3763	eleahy	PPC KITCHEN & BAR	Large Tap Marker	Wormtown - Be Juicy	1	3/6/2025 11:21 AM	2026-03-17 14:10:39.510929
3765	jaustin	MAIN CRUST CO.	Large Tap Marker	603 Brew - Knuckle	1	3/5/2025 4:23 PM	2026-03-17 14:10:39.517089
3767	jaustin	MAIN CRUST CO.	Large Tap Marker	Austin Street - Patina	1	3/5/2025 4:23 PM	2026-03-17 14:10:39.522994
3768	jaustin	MAIN CRUST CO.	Large Tap Marker	603 Brew - Beer Hall	1	3/5/2025 4:23 PM	2026-03-17 14:10:39.525752
3769	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Wormtown - Irish Red	1	3/5/2025 3:18 PM	2026-03-17 14:10:39.528689
3770	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Wormtown - Irish Red	1	3/5/2025 2:36 PM	2026-03-17 14:10:39.531029
3773	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Wormtown - Irish Red	1	3/5/2025 1:33 PM	2026-03-17 14:10:39.539144
3774	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Wormtown - Irish Red	1	3/5/2025 1:33 PM	2026-03-17 14:10:39.54208
3775	maanderson	CALI B HUDSON	Large Tap Marker	Bud Light	1	3/5/2025 12:19 PM	2026-03-17 14:10:39.544599
3776	maanderson	CALI B HUDSON	Large Tap Marker	Mich Ultra	1	3/5/2025 12:19 PM	2026-03-17 14:10:39.547132
3780	sshaunessy	BOWLING ACRES	Large Tap Marker	Wicked Weed Pernicious	1	3/5/2025 11:33 AM	2026-03-17 14:10:39.559996
3781	ggage	CHRYSANTHI'S	Large Tap Marker	Gold Road Mango Cart	1	3/4/2025 1:26 PM	2026-03-17 14:10:39.563178
3782	jgrumblatt	SALT HILL PUB - NEWBURY	Large Tap Marker	Concord Craft - White Mtn White	1	3/4/2025 12:31 PM	2026-03-17 14:10:39.566389
3783	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Stoneface - IPA	1	3/4/2025 12:09 PM	2026-03-17 14:10:39.569141
3784	ggage	VFW #4368 - MILFORD	Large Tap Marker	Kona - Big Wave	1	3/4/2025 10:32 AM	2026-03-17 14:10:39.572054
3785	ggage	VFW #4368 - MILFORD	Large Tap Marker	Busch Light	1	3/4/2025 10:32 AM	2026-03-17 14:10:39.575354
3786	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Zero Gravity - Cone Head Haze	2	3/3/2025 2:06 PM	2026-03-17 19:05:56.618992
3788	lortiz	BURTON'S GRILL	Large Tap Marker	Kona - Big Wave	1	3/3/2025 10:41 AM	2026-03-17 14:10:39.584229
3790	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Stoneface - Treat Me	1	2/27/2025 3:24 PM	2026-03-17 14:10:39.590733
3791	maanderson	PEDDLER'S DAUGHTER	Large Tap Marker	Able - Burn the Ships	1	2/27/2025 2:10 PM	2026-03-17 14:10:39.593846
3792	jcannamucio	KINGSTON VETS CLUB INC	Large Tap Marker	Wicked Weed Pernicious	1	2/27/2025 10:28 AM	2026-03-17 14:10:39.596271
3793	jgiuffrida	SAL'S PIZZA OF MILFORD	Large Tap Marker	Henniker - Miles & Miles	1	2/26/2025 6:57 PM	2026-03-17 14:10:39.598866
3789	jsewall	TARGET # 3401 - W. LEBANON	Large Tap Marker	Bud Light	2	3/3/2025 8:03 AM	2026-03-17 19:05:56.62168
3795	sshaunessy	BOWLING ACRES	Large Tap Marker	Frost - Lush	1	2/26/2025 1:20 PM	2026-03-17 14:10:39.604557
3796	sshaunessy	BOWLING ACRES	Large Tap Marker	603 Brew - Winni	1	2/26/2025 1:20 PM	2026-03-17 14:10:39.606983
3797	sshaunessy	COOPER'S HILL	Large Tap Marker	Wormtown - Irish Red	1	2/26/2025 1:16 PM	2026-03-17 14:10:39.609305
3798	rconstant	PASQUALE'S RISTORANTE	Large Tap Marker	Moretti	1	2/26/2025 12:37 PM	2026-03-17 14:10:39.611924
3799	jgrumblatt	RAGGED MOUNTAIN	Large Tap Marker	Fiddlehead - Hodad	1	2/26/2025 9:48 AM	2026-03-17 14:10:39.614588
3807	jmeharg	DANIEL'S PUB INC	Large Tap Marker	Henniker - Space Race	2	2/20/2025 11:54 AM	2026-03-17 19:05:56.624592
3809	jsewall	CHILI'S - W.LEB	Large Tap Marker	von Trapp - Pilsner	3	2/20/2025 11:39 AM	2026-03-17 19:05:56.627429
3802	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Wormtown - Irish Red	1	2/24/2025 4:29 PM	2026-03-17 14:10:39.623427
3803	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Stoneface - Treat Me	1	2/24/2025 4:17 PM	2026-03-17 14:10:39.633111
3804	sshaunessy	BIRCHWOOD INN (THE)	Large Tap Marker	von Trapp - Dunkel	1	2/24/2025 3:09 PM	2026-03-17 14:10:39.635603
3817	jcannamucio	CARRIAGE TOWN BAR & GRILL	Large Tap Marker	Stella Artois	2	2/19/2025 10:48 AM	2026-03-17 19:05:56.630015
3806	jsewall	SAWTOOTH KITCHEN LLC	Large Tap Marker	Kelsen - Paradigm	1	2/20/2025 2:36 PM	2026-03-17 14:10:39.641167
3825	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Other Half - Juice Brawl	2	2/13/2025 3:11 PM	2026-03-17 19:05:56.633039
3810	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Wormtown - Irish Red	1	2/20/2025 11:31 AM	2026-03-17 14:10:39.653182
3832	jaustin	GUERRILLA GRILL	Large Tap Marker	Zero Gravity - Green State	2	2/12/2025 2:00 PM	2026-03-17 19:05:56.635957
3813	jgrumblatt	THE REFINERY	Large Tap Marker	Berkshire - Dandelion	1	2/19/2025 12:55 PM	2026-03-17 14:10:39.661598
3814	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Mich Ultra	1	2/19/2025 12:29 PM	2026-03-17 14:10:39.664072
3815	sshaunessy	BOWLING ACRES	Large Tap Marker	Other Half - Green City	1	2/19/2025 11:58 AM	2026-03-17 14:10:39.666785
3818	scamuso	BISTRO 603	Large Tap Marker	Concord Craft - White Mtn White	1	2/19/2025 10:23 AM	2026-03-17 14:10:39.675996
3820	rconstant	SMOKE SHACK CAFE	Large Tap Marker	Able - Lady of the Lake	1	2/18/2025 3:46 PM	2026-03-17 14:10:39.681645
3821	jsewall	ARIANA'S RESTAURANT	Large Tap Marker	Citizen Cider - Unified Press	1	2/18/2025 10:23 AM	2026-03-17 14:10:39.684185
3822	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Wormtown - Irish Red	1	2/17/2025 3:22 PM	2026-03-17 14:10:39.686865
3823	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	603 Brew - Winni	1	2/17/2025 2:33 PM	2026-03-17 14:10:39.689355
3824	jjohnson	SNAX	Large Tap Marker	von Trapp - Helles	1	2/17/2025 12:00 PM	2026-03-17 14:10:39.692376
3826	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	von Trapp - Pilsner	1	2/13/2025 1:01 PM	2026-03-17 14:10:39.697601
3827	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	603 Brew - Beer Hall	1	2/13/2025 1:01 PM	2026-03-17 14:10:39.700579
3828	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	603 Brew - Winni	1	2/13/2025 12:48 PM	2026-03-17 14:10:39.703079
3830	ddooling	PELHAM STREET BLACK WATER GRILL	Large Tap Marker	Tuckerman - Pale Ale	1	2/12/2025 3:47 PM	2026-03-17 14:10:39.708133
3831	jaustin	GUERRILLA GRILL	Large Tap Marker	Zero Gravity - Cone Head	1	2/12/2025 2:00 PM	2026-03-17 14:10:39.710901
3833	jaustin	GUERRILLA GRILL	Large Tap Marker	Orono - Tubular	1	2/12/2025 2:00 PM	2026-03-17 14:10:39.716166
3834	sshaunessy	BOWLING ACRES	Large Tap Marker	BBCO - Uncanny Valley	1	2/12/2025 1:21 PM	2026-03-17 14:10:39.719218
3838	lnorton	COPPER DOOR - BEDFORD	Large Tap Marker	Jack's Abby - House Lager	1	2/12/2025 12:29 PM	2026-03-17 14:10:39.732118
3839	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Able - Burn the Ships	1	2/12/2025 11:21 AM	2026-03-17 14:10:39.734778
3840	jgrumblatt	SALT HILL PUB - NEWBURY	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	2/11/2025 1:31 PM	2026-03-17 14:10:39.737776
3841	pwollert	POUR HOUSE (THE)	Large Tap Marker	Fiddlehead - Hodad	1	2/11/2025 1:23 PM	2026-03-17 14:10:39.740385
3842	jmeharg	STONEBRIDGE COUNTRY CLUB	Large Tap Marker	Concord Craft - White Mtn White	1	2/11/2025 1:01 PM	2026-03-17 14:10:39.743045
3843	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	BBCO - Wizard	1	2/11/2025 10:34 AM	2026-03-17 14:10:39.745595
3844	ggage	VFW #4368 - MILFORD	Large Tap Marker	Dos Equis Amber	1	2/11/2025 9:50 AM	2026-03-17 14:10:39.748089
3845	scamuso	BISTRO 603	Large Tap Marker	Throwback - Wallis White	1	2/10/2025 4:23 PM	2026-03-17 14:10:39.751171
3856	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	Citizen Cider - BD Donut	2	2/6/2025 11:09 AM	2026-03-17 19:05:56.63934
3847	jjohnson	SNAX	Large Tap Marker	603 Brew - Scenic	1	2/10/2025 1:51 PM	2026-03-17 14:10:39.756927
3848	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	Fiddlehead - White	1	2/10/2025 1:21 PM	2026-03-17 14:10:39.75955
3849	ddooling	COPPER DOOR - SALEM	Large Tap Marker	Kelsen - Paradigm	1	2/10/2025 11:35 AM	2026-03-17 14:10:39.762481
3850	amartin	LA HACIENDA DEL RIO	Large Tap Marker	Sea Dog - Blueberry	1	2/6/2025 2:07 PM	2026-03-17 14:10:39.76515
3878	jcannamucio	CARRIAGE TOWN BAR & GRILL	Large Tap Marker	New Belgium - Juicy Haze	2	2/3/2025 12:02 PM	2026-03-17 19:05:56.641816
3852	maanderson	PENUCHE'S ALE HOUSE-NASHUA	Large Tap Marker	Some - PB Whoopie	1	2/6/2025 1:45 PM	2026-03-17 14:10:39.770609
3853	jaustin	CLIFFY'S PUB	Large Tap Marker	Oskar Blues - Dales Pale	1	2/6/2025 12:38 PM	2026-03-17 14:10:39.773179
3854	maanderson	NATIONAL CLUB (THE)	Large Tap Marker	Zero Gravity - Cone Head	1	2/6/2025 12:24 PM	2026-03-17 14:10:39.775539
3857	amartin	SURF RESTAURANT INC	Large Tap Marker	Henniker - Wrking Man Porter	1	2/5/2025 4:49 PM	2026-03-17 14:10:39.783804
3859	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Tuckerman - Headwall Alt	1	2/5/2025 3:11 PM	2026-03-17 14:10:39.789102
3861	jgiuffrida	STONECUTTERS PUB	Large Tap Marker	Sea Dog - Blueberry	1	2/5/2025 1:15 PM	2026-03-17 14:10:39.794411
3862	pbelanger	EMMAS 321	Large Tap Marker	Concord Craft - Pond Hockey	1	2/5/2025 11:50 AM	2026-03-17 14:10:39.796758
3863	pbelanger	EMMAS 321	Large Tap Marker	Downeast - Pomegranate	1	2/5/2025 11:45 AM	2026-03-17 14:10:39.799872
3864	sshaunessy	BOWLING ACRES	Large Tap Marker	von Trapp - Pilsner	1	2/5/2025 11:43 AM	2026-03-17 14:10:39.802929
3865	sshaunessy	BOWLING ACRES	Large Tap Marker	Frost - Dented	1	2/5/2025 11:43 AM	2026-03-17 14:10:39.805445
3866	jaustin	MAIN CRUST CO.	Large Tap Marker	Wormtown - Be Hoppy	1	2/5/2025 11:30 AM	2026-03-17 14:10:39.807927
3867	pbelanger	RUSTIC TABLE (THE)	Large Tap Marker	von Trapp - Pilsner	1	2/4/2025 3:47 PM	2026-03-17 14:10:39.810835
3868	jmorse	CLAREMONT LODGE OF ELKS	Large Tap Marker	Stella Artois	1	2/4/2025 2:41 PM	2026-03-17 14:10:39.813368
3869	jmorse	DADDY'S PIZZA	Large Tap Marker	Bud Light	1	2/4/2025 1:29 PM	2026-03-17 14:10:39.815821
3871	lnorton	BEDFORD VILLAGE INN & REST.	Large Tap Marker	Moretti	1	2/4/2025 12:07 PM	2026-03-17 14:10:39.822175
3872	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Able - Lady of the Lake	1	2/4/2025 11:50 AM	2026-03-17 14:10:39.82467
3873	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Stoneface - Porter	1	2/3/2025 2:46 PM	2026-03-17 14:10:39.827756
3874	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Kelsen - Spacetown	1	2/3/2025 2:46 PM	2026-03-17 14:10:39.830984
3875	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	Stoneface - Berliner Weisse	1	2/3/2025 2:36 PM	2026-03-17 14:10:39.834014
3876	jmorse	AMERICAN LEGION POST 29 - CLAREMONT	Large Tap Marker	Shocktop	1	2/3/2025 2:27 PM	2026-03-17 14:10:39.83834
3877	lortiz	PIZZICO - ITALIAN RESTAURANT - NASHUA	Large Tap Marker	Downeast - Original	1	2/3/2025 1:11 PM	2026-03-17 14:10:39.840948
3879	ddooling	COPPER DOOR - SALEM	Large Tap Marker	Stoneface - Double Clip	1	2/3/2025 11:16 AM	2026-03-17 14:10:39.846179
3880	jgiuffrida	NAJI'S PIZZA	Large Tap Marker	Jack's Abby - House Lager	1	2/3/2025 10:04 AM	2026-03-17 14:10:39.848745
3881	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Stoneface - Porter	1	1/30/2025 3:39 PM	2026-03-17 14:10:39.851298
3885	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	True North - Bright & Early	1	1/30/2025 2:05 PM	2026-03-17 14:10:39.862635
3886	ddooling	TAVERN IN THE SQUARE SALEM LLC	Large Tap Marker	Downeast - Pomegranate	1	1/30/2025 2:03 PM	2026-03-17 14:10:39.865353
3888	pbelanger	MAMA MCDONOUGH'S IRISH PUB	Large Tap Marker	603 Brew - Winni	1	1/30/2025 12:10 PM	2026-03-17 14:10:39.871159
3889	jsewall	REVO CASINO AND SOCIAL HOUSE	Large Tap Marker	Gold Road Mango Cart	1	1/30/2025 11:56 AM	2026-03-17 14:10:39.87465
3890	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Frost - Brown	1	1/30/2025 11:22 AM	2026-03-17 14:10:39.877585
3891	rconstant	99 REST - LONDONDERRY	Large Tap Marker	Zero Gravity - Cone Head	1	1/30/2025 8:30 AM	2026-03-17 14:10:39.880924
3892	amartin	SPECTACLE MANAGEMENT INC	Large Tap Marker	Stoneface - Full Clip	1	1/29/2025 2:14 PM	2026-03-17 14:10:39.884237
3894	jgrumblatt	THE REFINERY	Large Tap Marker	Exhibit A - Cats Meow	1	1/29/2025 11:17 AM	2026-03-17 14:10:39.890834
3895	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Stella Artois	1	1/29/2025 10:54 AM	2026-03-17 14:10:39.89337
3896	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Frost - Brown	1	1/29/2025 10:54 AM	2026-03-17 14:10:39.896591
3897	pwollert	BIRDIES	Large Tap Marker	von Trapp - Helles	1	1/29/2025 10:19 AM	2026-03-17 14:10:39.899443
3898	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	Gold Road Mango Cart	1	1/29/2025 9:43 AM	2026-03-17 14:10:39.902498
3899	maanderson	STROKERS	Large Tap Marker	Fiddlehead - IPA	1	1/28/2025 3:26 PM	2026-03-17 14:10:39.904867
3900	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Maine Beer Co - Lunch	1	1/28/2025 2:44 PM	2026-03-17 14:10:39.907268
3901	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	BBCO - Little Wizard	1	1/28/2025 12:51 PM	2026-03-17 14:10:39.909762
3902	jcannamucio	JAMISON'S	Large Tap Marker	von Trapp - Dunkel	1	1/28/2025 10:51 AM	2026-03-17 14:10:39.912773
3910	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Gold Road Mango Cart	2	1/27/2025 2:12 PM	2026-03-17 19:05:56.645277
3904	ggage	THE BRICKHOUSE RESTAURANT AND BREWERY	Large Tap Marker	Busch Light	1	1/28/2025 9:43 AM	2026-03-17 14:10:39.917957
3932	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Jack's Abby - Banner	2	1/21/2025 8:30 AM	2026-03-17 19:05:56.650247
3906	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	Zero Gravity - Powder Jones	1	1/27/2025 3:55 PM	2026-03-17 14:10:39.922813
3907	jcannamucio	DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)	Large Tap Marker	Henniker - Kolsch	1	1/27/2025 3:41 PM	2026-03-17 14:10:39.92536
3908	jcannamucio	DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)	Large Tap Marker	Concord Craft - Four Rivers	1	1/27/2025 3:41 PM	2026-03-17 14:10:39.927762
3938	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Maine Beer Co - Peeper	2	1/16/2025 2:22 PM	2026-03-17 19:05:56.652562
3946	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	BBCO - Wizard	2	1/16/2025 11:53 AM	2026-03-17 19:05:56.655598
3912	jmeharg	CHARTWELL'S DINING SERVICES	Large Tap Marker	Busch Light	1	1/27/2025 1:13 PM	2026-03-17 14:10:39.936978
3913	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Large Tap Marker	Mich Ultra	1	1/27/2025 10:24 AM	2026-03-17 14:10:39.93956
3914	amartin	SURF RESTAURANT INC	Large Tap Marker	Fiddlehead - IPA	1	1/23/2025 3:18 PM	2026-03-17 14:10:39.942037
3915	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	BBCO - Lighthouse	1	1/23/2025 3:04 PM	2026-03-17 14:10:39.945107
3919	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Peak - Sweet Tarts	1	1/23/2025 1:53 PM	2026-03-17 14:10:39.955681
3922	sshaunessy	COOPER'S HILL	Large Tap Marker	von Trapp - Dunkel	1	1/22/2025 2:27 PM	2026-03-17 14:10:39.964166
3923	jaustin	TEMPESTA'S	Large Tap Marker	von Trapp - Dunkel	1	1/22/2025 2:27 PM	2026-03-17 14:10:39.966581
3924	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	21 Amend - Hell High Water	1	1/22/2025 2:10 PM	2026-03-17 14:10:39.969032
3926	pbelanger	EMMAS 321	Large Tap Marker	14th Star - Valor	1	1/22/2025 11:54 AM	2026-03-17 14:10:39.974362
3927	jmeharg	VILLAGE TRESTLE (THE)	Large Tap Marker	Henniker - Flap Jack	1	1/21/2025 2:06 PM	2026-03-17 14:10:39.97686
3928	jmeharg	VILLAGE TRESTLE (THE)	Large Tap Marker	Some - PB Whoopie	1	1/21/2025 11:59 AM	2026-03-17 14:10:39.980003
3929	rconstant	SUPPAS PIZZA LONDONDERRY	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	1/21/2025 10:54 AM	2026-03-17 14:10:39.982839
3931	maanderson	PINE VALLEY GOLF COURSE	Large Tap Marker	Stella Artois	1	1/21/2025 9:20 AM	2026-03-17 14:10:39.98787
3933	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Citizen Cider - Juicy Haze	1	1/21/2025 8:30 AM	2026-03-17 14:10:39.994118
3936	jaustin	GUERRILLA GRILL	Large Tap Marker	Equilibrium - Einsteins Quartet	1	1/16/2025 2:51 PM	2026-03-17 14:10:40.003107
3937	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	von Trapp - Dunkel	1	1/16/2025 2:49 PM	2026-03-17 14:10:40.005622
3939	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Henniker - Sour Flower	1	1/16/2025 2:22 PM	2026-03-17 14:10:40.011359
3940	lnorton	RIVER ROAD TAVERN	Large Tap Marker	von Trapp - Dunkel	1	1/16/2025 2:22 PM	2026-03-17 14:10:40.01376
3944	lnorton	PRESSED CAFE - BEDFORD	Large Tap Marker	Southern - Mokah	1	1/16/2025 1:29 PM	2026-03-17 14:10:40.023981
3945	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Able - Burn the Ships	1	1/16/2025 11:53 AM	2026-03-17 14:10:40.026525
3947	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Industrial - Wrench	1	1/16/2025 11:53 AM	2026-03-17 14:10:40.031454
3948	jjohnson	CANTORE'S PIZZA	Large Tap Marker	Citizen Cider - Unified Press	1	1/16/2025 11:11 AM	2026-03-17 14:10:40.033925
3949	sshaunessy	WATERHOUSE BISTRO	Large Tap Marker	von Trapp - Helles	1	1/15/2025 2:54 PM	2026-03-17 14:10:40.036771
3950	sshaunessy	BOWLING ACRES	Large Tap Marker	Able - Burn the Ships	1	1/15/2025 1:25 PM	2026-03-17 14:10:40.041291
3951	lnorton	X-GOLF BEDFORD	Large Tap Marker	603 Brew - Knuckle	1	1/15/2025 12:54 PM	2026-03-17 14:10:40.043796
3952	pbelanger	EMMAS 321	Large Tap Marker	Zero Gravity - Powder Jones	1	1/15/2025 12:21 PM	2026-03-17 14:10:40.046421
3953	pbelanger	EMMAS 321	Large Tap Marker	Frost - Little Lush	1	1/15/2025 12:21 PM	2026-03-17 14:10:40.048863
3955	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	Stoneface - Porter	1	1/14/2025 12:36 PM	2026-03-17 14:10:40.054826
3956	ggage	OLDE TOWNE TAVERN	Large Tap Marker	Able - Lady of the Lake	1	1/14/2025 12:31 PM	2026-03-17 14:10:40.057513
3957	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Fiddlehead - Hodad	1	1/14/2025 10:09 AM	2026-03-17 14:10:40.06028
3970	jsewall	REVO CASINO AND SOCIAL HOUSE	Large Tap Marker	Fiddlehead - IPA	2	1/9/2025 12:11 PM	2026-03-17 19:05:56.658548
3961	maanderson	STROKERS	Large Tap Marker	Stella Artois	1	1/14/2025 8:10 AM	2026-03-17 14:10:40.072027
3979	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Kona - Big Wave	2	1/8/2025 11:02 AM	2026-03-17 19:05:56.661245
3963	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Zero Gravity - Powder Jones	1	1/13/2025 12:44 PM	2026-03-17 14:10:40.077811
3964	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Southern - Irish Cream	1	1/13/2025 12:44 PM	2026-03-17 14:10:40.083155
3965	lnorton	RIVER ROAD TAVERN	Large Tap Marker	603 Brew - Knuckle	1	1/9/2025 4:25 PM	2026-03-17 14:10:40.087021
3966	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Zero Gravity - 40 Thieves	1	1/9/2025 4:25 PM	2026-03-17 14:10:40.090004
3967	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Concord Craft - Pond Hockey	1	1/9/2025 4:25 PM	2026-03-17 14:10:40.093134
3981	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	von Trapp - Echo Love	3	1/8/2025 10:44 AM	2026-03-17 19:05:56.663493
3987	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Downeast - Winter	2	1/7/2025 7:16 AM	2026-03-17 19:05:56.665736
3995	jsewall	SAWTOOTH KITCHEN LLC	Large Tap Marker	Concord Craft - Four Rivers	2	1/2/2025 2:54 PM	2026-03-17 19:05:56.668688
4004	jsewall	99 REST - W.LEB	Large Tap Marker	Able - Burn the Ships	2	1/2/2025 7:54 AM	2026-03-17 19:05:56.672272
3974	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Henniker - King Misanthrope	1	1/8/2025 12:47 PM	2026-03-17 14:10:40.113401
3975	amartin	RIVERWALK BAKERY & CAFE	Large Tap Marker	603 Brew - Winni	1	1/8/2025 12:42 PM	2026-03-17 14:10:40.11619
3976	jgrumblatt	RAGGED MOUNTAIN	Large Tap Marker	14th Star - Maple Br	1	1/8/2025 12:16 PM	2026-03-17 14:10:40.11908
3977	sshaunessy	BOWLING ACRES	Large Tap Marker	Equilibrium - Einsteins Quartet	1	1/8/2025 11:53 AM	2026-03-17 14:10:40.122097
3978	sshaunessy	BOWLING ACRES	Large Tap Marker	Henniker - Wrking Man Porter	1	1/8/2025 11:53 AM	2026-03-17 14:10:40.125955
3980	pbelanger	EMMAS 321	Large Tap Marker	603 Brew - Winni	1	1/8/2025 11:00 AM	2026-03-17 14:10:40.132751
3982	jaustin	APPLEBEES - KEENE #6714	Large Tap Marker	Kona - Big Wave	1	1/7/2025 1:50 PM	2026-03-17 14:10:40.138122
3983	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	Athletic - Run Wild	1	1/7/2025 1:03 PM	2026-03-17 14:10:40.140814
3984	ggage	AMERICAN LEGION POST 23 - MILFORD	Large Tap Marker	Citizen Cider - Juicy Haze	1	1/7/2025 12:52 PM	2026-03-17 14:10:40.143883
3985	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Founders - Curmudgeon Old Ale 2016	1	1/7/2025 11:11 AM	2026-03-17 14:10:40.146901
3986	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Founders - Mortal Bloom	1	1/7/2025 11:11 AM	2026-03-17 14:10:40.149818
3988	jaustin	CLIFFY'S PUB	Large Tap Marker	Mighty Squirrel - Magic Rain	1	1/6/2025 2:41 PM	2026-03-17 14:10:40.156084
3989	ddooling	TAVERN IN THE SQUARE SALEM LLC	Large Tap Marker	603 Brew - Knuckle	1	1/6/2025 2:23 PM	2026-03-17 14:10:40.163681
3990	jaustin	YANKEE LANES / KEENE BOWL	Large Tap Marker	Mich Ultra	1	1/6/2025 11:33 AM	2026-03-17 14:10:40.686047
3992	amartin	ROYAL PIZZA	Large Tap Marker	Sea Dog - Blueberry	1	1/2/2025 3:16 PM	2026-03-17 14:10:40.691896
3996	jsewall	STILL NORTH BOOKS & BAR	Large Tap Marker	Able - Burn the Ships	1	1/2/2025 2:49 PM	2026-03-17 14:10:40.705486
3997	lortiz	LUI LUI - NASHUA	Large Tap Marker	Wormtown - Blizzard	1	1/2/2025 2:17 PM	2026-03-17 14:10:40.708177
4002	ggage	ROUTE 13 STATELINE CONV MART	Large Tap Marker	Athletic - Run Wild	1	1/2/2025 12:15 PM	2026-03-17 14:10:40.722974
4003	jaustin	TEMPESTA'S	Large Tap Marker	Fiddlehead - IPA	1	1/2/2025 11:47 AM	2026-03-17 14:10:40.72711
4005	jmeharg	CROTCHED MOUNTAIN SKI AREA	Large Tap Marker	Concord Craft - Four Rivers	1	1/1/2025 2:15 PM	2026-03-17 14:10:40.732464
4006	lnorton	EVVIVA TRATTORIA - BEDFORD	Large Tap Marker	Fiddlehead - IPA	1	12/31/2024 3:50 PM	2026-03-17 14:10:40.736165
4007	lnorton	EVVIVA TRATTORIA - BEDFORD	Large Tap Marker	Maine Beer Co - Lunch	1	12/31/2024 3:50 PM	2026-03-17 14:10:40.738839
4008	lnorton	EVVIVA TRATTORIA - BEDFORD	Large Tap Marker	Bud Light	1	12/31/2024 3:50 PM	2026-03-17 14:10:40.742
4010	maanderson	KETTLEHEAD BREWING CO - NASHUA	Large Tap Marker	Athletic - Run Wild	1	12/31/2024 12:24 PM	2026-03-17 14:10:40.748354
4012	pbelanger	EMMAS 321	Large Tap Marker	Able - Burn the Ships	1	12/31/2024 11:40 AM	2026-03-17 14:10:40.754696
4013	pbelanger	EMMAS 321	Large Tap Marker	Able - Victory Nor Defeat	1	12/31/2024 11:37 AM	2026-03-17 14:10:40.757428
4014	maanderson	STROKERS	Large Tap Marker	Wormtown - Blizzard	1	12/30/2024 3:59 PM	2026-03-17 14:10:40.760928
4015	pbelanger	RUSTIC TABLE (THE)	Large Tap Marker	Kona - Big Wave	1	12/30/2024 3:03 PM	2026-03-17 14:10:40.76349
4016	jcannamucio	JAMISON'S	Large Tap Marker	True North - Winter Woods	1	12/30/2024 2:22 PM	2026-03-17 14:10:40.767039
4017	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Stoneface - Imaginary Cartwheel	1	12/30/2024 12:44 PM	2026-03-17 14:10:40.769981
4018	rconstant	SUPPAS PIZZA LONDONDERRY	Large Tap Marker	Able - Burn the Ships	1	12/30/2024 12:08 PM	2026-03-17 14:10:40.772718
4019	jgiuffrida	STONECUTTERS PUB	Large Tap Marker	Able - Lady of the Lake	1	12/30/2024 12:04 PM	2026-03-17 14:10:40.775345
4020	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Downeast - Blackberry	1	12/30/2024 10:49 AM	2026-03-17 14:10:40.778197
4021	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	von Trapp - Pilsner	1	12/30/2024 10:49 AM	2026-03-17 14:10:40.780599
4022	jgrumblatt	NEW LONDON INN/COACH HOUSE RESTAURANT	Large Tap Marker	Founders - Porter	1	12/30/2024 9:52 AM	2026-03-17 14:10:40.783072
4024	rconstant	TWINS SMOKE SHOP	Large Tap Marker	BBCO - Lighthouse	1	12/29/2024 4:50 PM	2026-03-17 14:10:40.788985
4025	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Able - Burn the Ships	1	12/29/2024 4:50 PM	2026-03-17 14:10:40.791757
4026	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Stella Artois	1	12/29/2024 3:06 PM	2026-03-17 14:10:40.795285
4023	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Exhibit A - Cats Meow	2	12/29/2024 4:50 PM	2026-03-17 19:05:56.674674
4031	scamuso	TEQUILA JALISCO MEXICAN CUISINE AND CANTINA	Large Tap Marker	Wormtown - Blizzard	2	12/24/2024 12:44 PM	2026-03-17 19:05:56.677553
4029	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Athletic - Run Wild	1	12/26/2024 12:02 PM	2026-03-17 14:10:40.802699
4030	jcannamucio	KINGSTON VETS CLUB INC	Large Tap Marker	Throwback - Rule Roost	1	12/26/2024 10:19 AM	2026-03-17 14:10:40.805191
4046	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	Downeast - Original	2	12/19/2024 1:20 PM	2026-03-17 19:05:56.67975
4064	sshaunessy	BOWLING ACRES	Large Tap Marker	Founders - All Day IPA	2	12/18/2024 11:54 AM	2026-03-17 19:05:56.682689
4036	pwollert	POUR HOUSE (THE)	Large Tap Marker	Jack's Abby - House Lager	1	12/23/2024 2:30 PM	2026-03-17 14:10:40.822429
4037	ggage	AMERICAN LEGION POST 23 - MILFORD	Large Tap Marker	Stella Artois	1	12/23/2024 2:09 PM	2026-03-17 14:10:40.824953
4038	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Left Hand - Candy Cane Nitro	1	12/23/2024 1:28 PM	2026-03-17 14:10:40.827964
4039	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Concord Craft - Pond Hockey	1	12/23/2024 1:28 PM	2026-03-17 14:10:40.830514
4042	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Other Half - Tens of Hundreds	1	12/19/2024 3:44 PM	2026-03-17 14:10:40.840587
4043	amartin	SAN FRANCISCO KITCHEN INC	Large Tap Marker	Stella Artois	1	12/19/2024 2:42 PM	2026-03-17 14:10:40.843169
4044	jsewall	STILL NORTH BOOKS & BAR	Large Tap Marker	Kentucky - Cocoa Porter	1	12/19/2024 2:30 PM	2026-03-17 14:10:40.845684
4045	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Large Tap Marker	Downeast - Winter	1	12/19/2024 1:20 PM	2026-03-17 14:10:40.848168
4047	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	Stoneface - Full Clip	1	12/19/2024 1:19 PM	2026-03-17 14:10:40.85324
4048	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	Maine Beer Co - Lunch	1	12/19/2024 1:19 PM	2026-03-17 14:10:40.856128
4049	jsewall	APPLEBEES - W.LEB #6732	Large Tap Marker	Fiddlehead - IPA	1	12/19/2024 12:10 PM	2026-03-17 14:10:40.858709
4050	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	603 Brew - Knuckle	1	12/19/2024 11:45 AM	2026-03-17 14:10:40.861127
4053	jaustin	BRICKHOUSE PIZZA & WINGS	Large Tap Marker	Stella Artois	1	12/18/2024 4:25 PM	2026-03-17 14:10:40.86818
4056	jaustin	MAIN CRUST CO.	Large Tap Marker	Mighty Squirrel - Magic Rain	1	12/18/2024 3:40 PM	2026-03-17 14:10:40.875983
4057	jaustin	MAIN CRUST CO.	Large Tap Marker	Lord Hobo - Hop Tobaggin	1	12/18/2024 3:40 PM	2026-03-17 14:10:40.878815
4059	amartin	LATIN BAKERY & MULTISERVICE INC	Large Tap Marker	Mich Ultra	1	12/18/2024 3:00 PM	2026-03-17 14:10:40.883901
4060	amartin	LATIN BAKERY & MULTISERVICE INC	Large Tap Marker	Stella Artois	1	12/18/2024 3:00 PM	2026-03-17 14:10:40.886518
4061	amartin	CHICKEN N CHIP'S	Large Tap Marker	Stella Artois	1	12/18/2024 2:59 PM	2026-03-17 14:10:40.888927
4062	pbelanger	EMMAS 321	Large Tap Marker	Zero Gravity - 40 Thieves	1	12/18/2024 12:38 PM	2026-03-17 14:10:40.891388
4063	pbelanger	EMMAS 321	Large Tap Marker	Bells - Two Hearted	1	12/18/2024 12:38 PM	2026-03-17 14:10:40.893691
4065	sshaunessy	BOWLING ACRES	Large Tap Marker	Frost - Double Ponyboy	1	12/18/2024 11:54 AM	2026-03-17 14:10:40.898905
4066	sshaunessy	BOWLING ACRES	Large Tap Marker	Stella Artois	1	12/18/2024 11:54 AM	2026-03-17 14:10:40.901514
4067	rconstant	COACH STOP	Large Tap Marker	Stella Artois	1	12/18/2024 11:14 AM	2026-03-17 14:10:40.904084
4068	rconstant	LA CARRETA - LONDONDERRY	Large Tap Marker	Stella Artois	1	12/18/2024 10:55 AM	2026-03-17 14:10:40.906616
4073	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	Stoneface - IPA	1	12/16/2024 2:54 PM	2026-03-17 14:10:40.919766
4074	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Fiddlehead - Mastermind	1	12/16/2024 2:29 PM	2026-03-17 14:10:40.922344
4075	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Some - PB Whoopie	1	12/16/2024 1:51 PM	2026-03-17 14:10:40.924609
4076	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Zero Gravity - 40 Thieves	1	12/16/2024 1:51 PM	2026-03-17 14:10:41.090344
4077	jjohnson	SNAX	Large Tap Marker	603 Brew - Knuckle	1	12/16/2024 1:42 PM	2026-03-17 14:10:41.093837
4078	ddooling	T-BONES - SALEM	Large Tap Marker	New Belgium - Fat Tire	1	12/16/2024 1:34 PM	2026-03-17 14:10:41.097629
4103	jmorse	HELEN'S PLACE	Large Tap Marker	Concord Craft - Kapital Kolsch	2	12/11/2024 1:21 PM	2026-03-17 19:05:56.685093
4139	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	von Trapp - Trosten	2	12/5/2024 3:29 PM	2026-03-17 19:05:56.687364
4082	jsewall	REVO CASINO AND SOCIAL HOUSE	Large Tap Marker	Wormtown - Be Hoppy	1	12/16/2024 7:30 AM	2026-03-17 14:10:41.111658
4083	jsewall	99 REST - W.LEB	Large Tap Marker	von Trapp - Dunkel	1	12/16/2024 7:14 AM	2026-03-17 14:10:41.11446
4084	jjohnson	SNAX	Large Tap Marker	von Trapp - Dunkel	1	12/12/2024 4:09 PM	2026-03-17 14:10:41.117369
4085	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Henniker - Hugs From	1	12/12/2024 3:53 PM	2026-03-17 14:10:41.121206
4086	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	Carlson - Harvard Harvest	1	12/12/2024 2:28 PM	2026-03-17 14:10:41.124586
4087	amartin	BACKSTREET BAR & GRILL LLC	Large Tap Marker	Able - Victory Nor Defeat	1	12/12/2024 2:10 PM	2026-03-17 14:10:41.127605
4088	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Stoneface - Duderino	1	12/12/2024 1:54 PM	2026-03-17 14:10:41.13104
4089	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Able - Victory Nor Defeat	1	12/12/2024 1:38 PM	2026-03-17 14:10:41.133514
4092	amartin	LYNN'S 102 TAVERN	Large Tap Marker	Tuckerman - Pale Ale	1	12/12/2024 1:10 PM	2026-03-17 14:10:41.143006
4093	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Able - Burn the Ships	1	12/12/2024 11:28 AM	2026-03-17 14:10:41.145699
4094	pbelanger	PHOENIX SMOKEHOUSE AND TAQUERIA	Large Tap Marker	603 Brew - Winni	1	12/12/2024 10:11 AM	2026-03-17 14:10:41.149261
4095	pbelanger	PHOENIX SMOKEHOUSE AND TAQUERIA	Large Tap Marker	Bud Light	1	12/12/2024 10:11 AM	2026-03-17 14:10:41.151862
4096	jaustin	MAIN CRUST CO.	Large Tap Marker	Zero Gravity - 40 Thieves	1	12/11/2024 4:21 PM	2026-03-17 14:10:41.155279
4097	pwollert	BIRDIES	Large Tap Marker	Jack's Abby - House Lager	1	12/11/2024 4:04 PM	2026-03-17 14:10:41.16082
4098	pwollert	BIRDIES	Large Tap Marker	Frost - Little Lush	1	12/11/2024 4:04 PM	2026-03-17 14:10:41.164951
4101	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Wormtown - Blizzard	1	12/11/2024 1:45 PM	2026-03-17 14:10:41.173672
4105	pbelanger	EMMAS 321	Large Tap Marker	Frost - Brown	1	12/11/2024 1:08 PM	2026-03-17 14:10:41.18719
4106	sshaunessy	BOWLING ACRES	Large Tap Marker	Frost - Little Lush	1	12/11/2024 12:42 PM	2026-03-17 14:10:41.190441
4107	jgrumblatt	PETER CHRISTIANS TAVERN	Large Tap Marker	Berkshire - Coffehouse Porter	1	12/11/2024 12:18 PM	2026-03-17 14:10:41.193217
4111	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	Able - Burn the Ships	1	12/11/2024 9:47 AM	2026-03-17 14:10:41.207033
4112	jmeharg	VILLAGE TRESTLE (THE)	Large Tap Marker	603 Brew - Mitz BA RIS	1	12/10/2024 3:44 PM	2026-03-17 14:10:41.210394
4113	jaustin	A-1 PIZZA & GRILL HINSDALE	Large Tap Marker	von Trapp - Pilsner	1	12/10/2024 3:41 PM	2026-03-17 14:10:41.213141
4114	lnorton	BEDFORD VILLAGE INN & REST.	Large Tap Marker	Equilibrium - Wavelength	1	12/10/2024 2:28 PM	2026-03-17 14:10:41.216055
4115	lnorton	BEDFORD VILLAGE INN & REST.	Large Tap Marker	Wormtown - Blizzard	1	12/10/2024 2:28 PM	2026-03-17 14:10:41.218711
4116	lnorton	BEDFORD VILLAGE INN & REST.	Large Tap Marker	Able - Lady of the Lake	1	12/10/2024 2:28 PM	2026-03-17 14:10:41.222367
4117	lnorton	BEDFORD VILLAGE INN & REST.	Large Tap Marker	603 Brew - Winni	1	12/10/2024 2:28 PM	2026-03-17 14:10:41.224938
4118	lnorton	BEDFORD VILLAGE INN & REST.	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	12/10/2024 2:28 PM	2026-03-17 14:10:41.227789
4119	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Citizen Cider - Mimosa Crush	1	12/10/2024 11:39 AM	2026-03-17 14:10:41.231418
4120	jcannamucio	JAMISON'S	Large Tap Marker	True North - Northern	1	12/10/2024 11:05 AM	2026-03-17 14:10:41.234636
4121	jcannamucio	ATKINSON SUNOCO	Large Tap Marker	True North - Northern	1	12/10/2024 10:53 AM	2026-03-17 14:10:41.237162
4122	jsewall	ARIANA'S RESTAURANT	Large Tap Marker	BBCO - Lighthouse	1	12/10/2024 6:08 AM	2026-03-17 14:10:41.240022
4123	rconstant	TWINS SMOKE SHOP	Large Tap Marker	603 Brew - Knuckle	1	12/9/2024 4:03 PM	2026-03-17 14:10:41.242525
4124	jcannamucio	DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)	Large Tap Marker	603 Brew - Coffee Cake Porter	1	12/9/2024 3:25 PM	2026-03-17 14:10:41.245224
4128	scamuso	BISTRO 603	Large Tap Marker	Zero Gravity - Green State	1	12/9/2024 1:07 PM	2026-03-17 14:10:41.256077
4129	scamuso	BISTRO 603	Large Tap Marker	Able - Burn the Ships	1	12/9/2024 1:07 PM	2026-03-17 14:10:41.259206
4130	pbelanger	VFW SOCIAL CLUB	Large Tap Marker	Fiddlehead - IPA	1	12/9/2024 12:49 PM	2026-03-17 14:10:41.262849
4132	scamuso	MILANO HOUSE OF PIZZA-NASHUA	Large Tap Marker	Able - Burn the Ships	1	12/9/2024 12:45 PM	2026-03-17 14:10:41.268487
4133	jsewall	REVO CASINO AND SOCIAL HOUSE	Large Tap Marker	Wormtown - Blizzard	1	12/9/2024 12:03 PM	2026-03-17 14:10:41.271408
4134	jsewall	REVO CASINO AND SOCIAL HOUSE	Large Tap Marker	von Trapp - Helles	1	12/9/2024 12:03 PM	2026-03-17 14:10:41.274685
4135	rconstant	ROCCO'S PIZZA	Large Tap Marker	Able - Burn the Ships	1	12/9/2024 11:17 AM	2026-03-17 14:10:41.27716
4136	sshaunessy	AMERICAN LEGION POST 10 - WILTON	Large Tap Marker	Able - Victory Nor Defeat	1	12/8/2024 10:09 AM	2026-03-17 14:10:41.280304
4137	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Stoneface - Imaginary Cartwheel	1	12/5/2024 4:17 PM	2026-03-17 14:10:41.282916
4138	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	603 Brew - Mitz BA RIS	1	12/5/2024 3:29 PM	2026-03-17 14:10:41.286604
4141	amartin	LYNN'S 102 TAVERN	Large Tap Marker	Jack's Abby - Extra Layer	1	12/5/2024 3:04 PM	2026-03-17 14:10:41.295997
4142	jaustin	CHILI'S - KEENE	Large Tap Marker	Stoneface - IPA	1	12/5/2024 1:39 PM	2026-03-17 14:10:41.299226
4143	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Shocktop	1	12/5/2024 10:48 AM	2026-03-17 14:10:41.301988
4144	sshaunessy	COOPER'S HILL	Large Tap Marker	Downeast - Blackberry	1	12/4/2024 4:01 PM	2026-03-17 14:10:41.305065
4148	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Stoneface - Imaginary Cartwheel	1	12/4/2024 3:24 PM	2026-03-17 14:10:41.316767
4149	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	603 Brew - Beer Hall	1	12/4/2024 3:02 PM	2026-03-17 14:10:41.319145
4152	maanderson	LUK'S BAR & GRILL	Large Tap Marker	Jack's Abby - Extra Layer	1	12/4/2024 1:54 PM	2026-03-17 14:10:41.328169
4153	pbelanger	EMMAS 321	Large Tap Marker	Downeast - Caramel Apple	1	12/4/2024 1:38 PM	2026-03-17 14:10:41.331242
4154	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Jack's Abby - Banner	1	12/4/2024 12:51 PM	2026-03-17 14:10:41.334743
4155	jmeharg	STONEBRIDGE COUNTRY CLUB	Large Tap Marker	Concord Craft - Four Rivers	1	12/3/2024 12:21 PM	2026-03-17 14:10:41.340224
4156	pbelanger	ARLINGTON INN & TAVERN (THE)	Large Tap Marker	Wormtown - Blizzard	1	12/3/2024 10:56 AM	2026-03-17 14:10:41.342849
4157	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Wormtown - Blizzard	1	12/3/2024 10:10 AM	2026-03-17 14:10:41.345241
4158	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Frost - Little Lush	1	12/3/2024 10:10 AM	2026-03-17 14:10:41.348494
4159	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Lord Hobo - Hop Tobaggin	1	12/3/2024 10:10 AM	2026-03-17 14:10:41.351754
4164	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Wormtown - Blizzard	1	12/2/2024 1:17 PM	2026-03-17 14:10:41.367642
4165	ggage	CHRYSANTHI'S	Large Tap Marker	Wormtown - Blizzard	1	12/2/2024 12:21 PM	2026-03-17 14:10:41.370496
4166	jmorse	RAMUNTOS - CLAREMONT	Large Tap Marker	Wormtown - Blizzard	1	12/2/2024 12:00 PM	2026-03-17 14:10:41.373815
4167	scamuso	LAFAYETTE CLUB A.C.	Large Tap Marker	Stella Artois	1	12/2/2024 9:19 AM	2026-03-17 14:10:41.376344
4169	amartin	SURF RESTAURANT INC	Large Tap Marker	Jack's Abby - Extra Layer	1	11/27/2024 3:10 PM	2026-03-17 14:10:41.381889
4170	ddooling	T-BONES - SALEM	Large Tap Marker	Wormtown - Blizzard	1	11/27/2024 2:55 PM	2026-03-17 14:10:41.385289
4171	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Jack's Abby - Toy Soldier	1	11/27/2024 11:56 AM	2026-03-17 14:10:41.387947
4172	jsewall	CHILI'S - W.LEB	Large Tap Marker	Wormtown - Blizzard	1	11/27/2024 11:30 AM	2026-03-17 14:10:41.39081
4173	jaustin	GUERRILLA GRILL	Large Tap Marker	Founders - Porter	1	11/27/2024 11:03 AM	2026-03-17 14:10:41.395103
4174	jaustin	TEMPESTA'S	Large Tap Marker	Bud Light	1	11/27/2024 10:33 AM	2026-03-17 14:10:41.398159
4175	jcannamucio	KINGSTON VETS CLUB INC	Large Tap Marker	Kelsen - Battle Axe	1	11/27/2024 10:14 AM	2026-03-17 14:10:41.400663
4176	jmeharg	BLUE BEAR HOSPITALITY LLC	Large Tap Marker	Concord Craft - Four Rivers	1	11/26/2024 4:36 PM	2026-03-17 14:10:41.403514
4177	sshaunessy	UNWINED	Large Tap Marker	Exhibit A - Goody Shoes	1	11/26/2024 4:18 PM	2026-03-17 14:10:41.40661
4178	pbelanger	EMMAS 321	Large Tap Marker	Downeast - Winter	1	11/26/2024 2:32 PM	2026-03-17 14:10:41.409502
4180	amartin	CHICKEN N CHIP'S	Large Tap Marker	New Belgium - Fat Tire	1	11/26/2024 1:43 PM	2026-03-17 14:10:41.415405
4181	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	603 Brew - Knuckle	1	11/26/2024 10:51 AM	2026-03-17 14:10:41.419608
4182	jsewall	TARGET # 3401 - W. LEBANON	Large Tap Marker	Stoneface - IPA	1	11/26/2024 9:21 AM	2026-03-17 14:10:41.422842
4183	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	603 Brew - Knuckle	1	11/26/2024 9:17 AM	2026-03-17 14:10:41.425503
4184	jmeharg	VILLAGE TRESTLE (THE)	Large Tap Marker	Wormtown - Blizzard	1	11/25/2024 12:28 PM	2026-03-17 14:10:41.43224
4185	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Stoneface - IPA	1	11/25/2024 11:01 AM	2026-03-17 14:10:41.434879
4186	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	von Trapp - Helles	1	11/24/2024 5:17 PM	2026-03-17 14:10:41.438225
4187	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Downeast - Caramel Apple	1	11/24/2024 5:17 PM	2026-03-17 14:10:41.441706
4188	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	11/24/2024 4:22 PM	2026-03-17 14:10:41.444965
4189	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Wormtown - Blizzard	1	11/24/2024 4:22 PM	2026-03-17 14:10:41.447739
4190	jsewall	STILL NORTH BOOKS & BAR	Large Tap Marker	Concord Craft - Kapital Kolsch	1	11/24/2024 7:34 AM	2026-03-17 14:10:41.451168
4191	jsewall	STILL NORTH BOOKS & BAR	Large Tap Marker	Wormtown - Blizzard	1	11/24/2024 7:34 AM	2026-03-17 14:10:41.453742
4192	jsewall	STILL NORTH BOOKS & BAR	Large Tap Marker	Maine Beer Co - Lunch	1	11/24/2024 7:34 AM	2026-03-17 14:10:41.457464
4193	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Stoneface - Porter	1	11/22/2024 6:48 PM	2026-03-17 14:10:41.460115
4194	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Henniker - Footy Pj's	1	11/21/2024 4:28 PM	2026-03-17 14:10:41.46307
4195	ggage	AMERICAN LEGION POST 23 - MILFORD	Large Tap Marker	Shipyard - Boatload Berry	1	11/21/2024 4:28 PM	2026-03-17 14:10:41.465704
4198	amartin	PANDA GOURMET	Large Tap Marker	603 Brew - Winni	1	11/21/2024 2:53 PM	2026-03-17 14:10:41.474869
4199	maanderson	PENUCHE'S ALE HOUSE-NASHUA	Large Tap Marker	Zero Gravity - Cone Head Haze	1	11/21/2024 2:52 PM	2026-03-17 14:10:41.477935
4237	jmeharg	DANIEL'S PUB INC	Large Tap Marker	Henniker - Seltzer Baboosic	2	11/14/2024 11:32 AM	2026-03-17 19:05:56.692232
4201	ddooling	COPPER DOOR - SALEM	Large Tap Marker	Jack's Abby - Extra Layer	1	11/21/2024 12:39 PM	2026-03-17 14:10:41.483318
4202	ddooling	COPPER DOOR - SALEM	Large Tap Marker	Widowmaker - Blue Comet	1	11/21/2024 12:39 PM	2026-03-17 14:10:41.486294
4205	jjohnson	CANTORE'S PIZZA	Large Tap Marker	von Trapp - Pilsner	1	11/21/2024 10:47 AM	2026-03-17 14:10:41.494093
4206	jcannamucio	KINGSTON VETS CLUB INC	Large Tap Marker	Downeast - Caramel Apple	1	11/21/2024 10:09 AM	2026-03-17 14:10:41.496757
4207	scamuso	PINE STREET EATERY	Large Tap Marker	Mich Ultra	1	11/21/2024 8:23 AM	2026-03-17 14:10:41.499337
4211	ggage	OLDE KILKENNY PUB	Large Tap Marker	Founders - All Day Grapefruit IPA	1	11/20/2024 3:49 PM	2026-03-17 14:10:41.50994
4212	jgrumblatt	NEW LONDON INN/COACH HOUSE RESTAURANT	Large Tap Marker	Founders - All Day IPA	1	11/20/2024 3:13 PM	2026-03-17 14:10:41.513161
4213	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	von Trapp - Trosten	1	11/20/2024 1:05 PM	2026-03-17 14:10:41.515444
4216	pwollert	POUR HOUSE (THE)	Large Tap Marker	Stoneface - Porter	1	11/19/2024 1:56 PM	2026-03-17 14:10:41.523808
4217	pwollert	POUR HOUSE (THE)	Large Tap Marker	Stoneface - Duct Tape	1	11/19/2024 1:56 PM	2026-03-17 14:10:41.535708
4218	pwollert	POUR HOUSE (THE)	Large Tap Marker	Stoneface - Full Clip	1	11/19/2024 1:56 PM	2026-03-17 14:10:41.538936
4220	jcannamucio	AXE TOWNE	Large Tap Marker	Maine Beer Co - Lunch	1	11/19/2024 10:34 AM	2026-03-17 14:10:41.544314
4223	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Jack's Abby - Extra Layer	1	11/18/2024 3:06 PM	2026-03-17 14:10:41.552113
4224	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	603 Brew - Knuckle	1	11/18/2024 2:57 PM	2026-03-17 14:10:41.555075
4225	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Fiddlehead - Second	1	11/18/2024 2:41 PM	2026-03-17 14:10:41.557613
4229	amartin	SAKURA	Large Tap Marker	603 Brew - Knuckle	1	11/18/2024 2:29 PM	2026-03-17 14:10:41.570181
4232	ddooling	RALPHIE'S CAFE ITALIANO	Large Tap Marker	Fiddlehead - IPA	1	11/18/2024 12:54 PM	2026-03-17 14:10:41.797496
4233	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Other Half - Motueka + Galaxy	1	11/14/2024 3:59 PM	2026-03-17 14:10:41.799972
4234	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Concord Craft - Four Rivers	1	11/14/2024 2:33 PM	2026-03-17 14:10:41.803621
4236	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Stoneface - Double Clip	1	11/14/2024 12:00 PM	2026-03-17 14:10:41.811048
4238	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Large Tap Marker	Upper Pass - First Drop	1	11/14/2024 10:51 AM	2026-03-17 14:10:41.817895
4240	lnorton	BEDFORD VILLAGE INN & REST.	Large Tap Marker	603 Brew - Knuckle	1	11/13/2024 3:22 PM	2026-03-17 14:10:41.824886
4241	lnorton	BEDFORD VILLAGE INN & REST.	Large Tap Marker	Concord Craft - Kapital Kolsch	1	11/13/2024 3:22 PM	2026-03-17 14:10:41.827943
4242	lnorton	BEDFORD VILLAGE INN & REST.	Large Tap Marker	Kelsen - Battle Axe	1	11/13/2024 3:22 PM	2026-03-17 14:10:41.831755
4243	lnorton	BEDFORD VILLAGE INN & REST.	Large Tap Marker	Downeast - Winter	1	11/13/2024 3:22 PM	2026-03-17 14:10:41.835129
4248	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	New Belgium - Holiday Ale	1	11/13/2024 3:03 PM	2026-03-17 14:10:41.849729
4249	jaustin	MAIN CRUST CO.	Large Tap Marker	Kelsen - Battle Axe	1	11/13/2024 2:40 PM	2026-03-17 14:10:41.852524
4250	jaustin	MAIN CRUST CO.	Large Tap Marker	Banded - Charm	1	11/13/2024 2:40 PM	2026-03-17 14:10:41.856402
4251	rconstant	LI'L LOBSTER BOAT	Large Tap Marker	Maine Beer Co - Lunch	1	11/13/2024 2:21 PM	2026-03-17 14:10:41.859324
4252	jcannamucio	FLACO'S MEXICAN RESTUARANT & CANTINA	Large Tap Marker	Dos Equis Amber	1	11/13/2024 2:16 PM	2026-03-17 14:10:41.862614
4253	jcannamucio	FLACO'S MEXICAN RESTUARANT & CANTINA	Large Tap Marker	Budweiser	1	11/13/2024 2:16 PM	2026-03-17 14:10:41.865312
4255	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Stoneface - Porter	1	11/13/2024 12:03 PM	2026-03-17 14:10:41.87178
4264	ggage	VFW #4368 - MILFORD	Large Tap Marker	Fiddlehead - IPA	2	11/12/2024 9:39 AM	2026-03-17 19:05:56.69503
4258	ggage	NASHUA ELKS LODGE 720	Large Tap Marker	Stella Artois	1	11/13/2024 11:08 AM	2026-03-17 14:10:41.882904
4259	jgrumblatt	SALT HILL PUB - NEWBURY	Large Tap Marker	Concord Craft - Squirrel Fights	1	11/13/2024 9:29 AM	2026-03-17 14:10:41.885451
4260	ddooling	PRESSED CAFE - SALEM	Large Tap Marker	Fiddlehead - IPA	1	11/12/2024 4:05 PM	2026-03-17 14:10:41.888913
4261	jmorse	CLAREMONT LODGE OF ELKS	Large Tap Marker	BBCO - Lighthouse	1	11/12/2024 1:49 PM	2026-03-17 14:10:41.891237
4262	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Large Tap Marker	Wormtown - Blizzard	1	11/12/2024 11:53 AM	2026-03-17 14:10:41.89419
4263	jcannamucio	AXE TOWNE	Large Tap Marker	Fiddlehead - IPA	1	11/12/2024 11:11 AM	2026-03-17 14:10:41.896727
4265	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Kelsen - Spacetown	1	11/12/2024 8:54 AM	2026-03-17 14:10:41.903619
4266	rconstant	ROCCO'S PIZZA	Large Tap Marker	Widowmaker - Blue Comet	1	11/11/2024 2:18 PM	2026-03-17 14:10:41.906708
4267	scamuso	BISTRO 603	Large Tap Marker	Southern - Chestnut Praline	1	11/11/2024 1:23 PM	2026-03-17 14:10:41.909703
4268	scamuso	BISTRO 603	Large Tap Marker	Henniker - Flap Jack	1	11/11/2024 1:23 PM	2026-03-17 14:10:41.912651
4269	scamuso	BISTRO 603	Large Tap Marker	Jack's Abby - Extra Layer	1	11/11/2024 1:23 PM	2026-03-17 14:10:41.915235
4270	jaustin	KEENE COUNTRY CLUB INC	Large Tap Marker	603 Brew - Coffee Cake Porter	1	11/7/2024 3:37 PM	2026-03-17 14:10:41.918392
4271	jjohnson	RAMUNTO'S BRICK & BRICK & BREW PIZZERIA-HANOVER	Large Tap Marker	Zero Gravity - Cone Head	1	11/7/2024 3:09 PM	2026-03-17 14:10:41.92084
4272	jjohnson	RAMUNTO'S BRICK & BRICK & BREW PIZZERIA-HANOVER	Large Tap Marker	Zero Gravity - Green State	1	11/7/2024 3:09 PM	2026-03-17 14:10:41.924512
4273	jaustin	TEMPESTA'S	Large Tap Marker	Downeast - Winter	1	11/7/2024 3:08 PM	2026-03-17 14:10:41.92744
4274	maanderson	PENUCHE'S ALE HOUSE-NASHUA	Large Tap Marker	New Belgium - Holiday Ale	1	11/7/2024 3:07 PM	2026-03-17 14:10:41.931561
4278	jsewall	CHILI'S - W.LEB	Large Tap Marker	Stoneface - Porter	2	11/7/2024 2:38 PM	2026-03-17 19:05:56.698116
4276	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Stoneface - Pink Duct Tape	1	11/7/2024 2:58 PM	2026-03-17 14:10:41.937353
4277	jaustin	GUERRILLA GRILL	Large Tap Marker	Kelsen - Paradigm	1	11/7/2024 2:41 PM	2026-03-17 14:10:41.939849
4280	amartin	SURF RESTAURANT INC	Large Tap Marker	New Belgium - Fat Tire	1	11/7/2024 2:13 PM	2026-03-17 14:10:41.9501
4282	rconstant	AJ'S SPORTS BAR & GRILL	Large Tap Marker	603 Brew - Winni	1	11/7/2024 12:37 PM	2026-03-17 14:10:41.957231
4284	pwollert	WATKINS INN & TAVERN	Large Tap Marker	Maine Beer Co - Lunch	1	11/7/2024 8:15 AM	2026-03-17 14:10:41.966578
4287	jaustin	MAIN CRUST CO.	Large Tap Marker	603 Brew - Coffee Cake Porter	1	11/6/2024 3:19 PM	2026-03-17 14:10:41.975916
4288	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Wicked Weed Pernicious Haze	1	11/6/2024 3:15 PM	2026-03-17 14:10:41.978793
4289	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	11/6/2024 3:14 PM	2026-03-17 14:10:41.982051
4291	pbelanger	EMMAS 321	Large Tap Marker	603 Brew - Knuckle	1	11/6/2024 12:50 PM	2026-03-17 14:10:41.990868
4292	sshaunessy	BOWLING ACRES	Large Tap Marker	Henniker - Dustoff	1	11/6/2024 11:34 AM	2026-03-17 14:10:41.993752
4293	scamuso	APPLEBEES - NASHUA Amherst St	Large Tap Marker	Stella Artois	1	11/6/2024 10:46 AM	2026-03-17 14:10:41.9964
4294	sshaunessy	SUN BAR & GRILL	Large Tap Marker	Concord Craft - Safe Space	1	11/5/2024 4:14 PM	2026-03-17 14:10:41.999647
4295	sshaunessy	AMERICAN LEGION POST 11 - JAFFREY	Large Tap Marker	Tuckerman - Pale Ale	1	11/5/2024 2:36 PM	2026-03-17 14:10:42.002661
4296	jmeharg	VILLAGE TRESTLE (THE)	Large Tap Marker	Downeast - Winter	1	11/5/2024 2:06 PM	2026-03-17 14:10:42.005431
4298	rconstant	TWINS SMOKE SHOP	Large Tap Marker	603 Brew - Coffee Cake Porter	1	11/4/2024 3:11 PM	2026-03-17 14:10:42.010774
4299	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Lord Hobo - Doomsauce	1	11/4/2024 3:11 PM	2026-03-17 14:10:42.013115
4301	scamuso	BISTRO 603	Large Tap Marker	Downeast - Winter	1	11/4/2024 1:52 PM	2026-03-17 14:10:42.018921
4302	ddooling	MICHAELS FLATBREAD PIZZA CO.	Large Tap Marker	Concord Craft - Four Rivers	1	11/4/2024 1:46 PM	2026-03-17 14:10:42.022516
4303	jmeharg	AMERICAN LEGION POST 59 - HILLSBORO	Large Tap Marker	Concord Craft - Four Rivers	1	11/4/2024 12:44 PM	2026-03-17 14:10:42.025454
4305	jsewall	UPPER VALLEY EVENT CENTER	Large Tap Marker	Stoneface - IPA	1	11/4/2024 12:24 PM	2026-03-17 14:10:42.033201
4306	jsewall	UPPER VALLEY EVENT CENTER	Large Tap Marker	von Trapp - Pilsner	1	11/4/2024 12:24 PM	2026-03-17 14:10:42.036144
4308	lnorton	COPPER DOOR - BEDFORD	Large Tap Marker	Southern - Pumking	1	11/4/2024 11:23 AM	2026-03-17 14:10:42.041882
4309	lnorton	COPPER DOOR - BEDFORD	Large Tap Marker	von Trapp - Helles	1	11/4/2024 11:23 AM	2026-03-17 14:10:42.044811
4313	lnorton	PRESSED CAFE - BEDFORD	Large Tap Marker	603 Brew - Coffee Cake Porter	1	10/31/2024 3:52 PM	2026-03-17 14:10:42.056828
4314	maanderson	PEDDLER'S DAUGHTER	Large Tap Marker	Bells - Two Hearted	1	10/31/2024 3:49 PM	2026-03-17 14:10:42.060655
4315	amartin	BACKSTREET BAR & GRILL LLC	Large Tap Marker	Mighty Squirrel - Magic Rain	1	10/31/2024 2:14 PM	2026-03-17 14:10:42.063478
4352	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Large Tap Marker	Citizen Cider - Cran Crush	2	10/28/2024 10:51 AM	2026-03-17 19:05:56.701415
4317	lnorton	X-GOLF BEDFORD	Large Tap Marker	Downeast - Original	1	10/31/2024 1:08 PM	2026-03-17 14:10:42.069232
4318	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	Tuckerman - Pale Ale	1	10/31/2024 12:10 PM	2026-03-17 14:10:42.072194
4320	scamuso	BOBOLA RESTAURANT	Large Tap Marker	Citizen Cider - Unified Press	1	10/31/2024 10:48 AM	2026-03-17 14:10:42.078209
4321	rconstant	PROFESSOR SPORTS PUB	Large Tap Marker	Fiddlehead - White	1	10/30/2024 4:01 PM	2026-03-17 14:10:42.081001
4322	jgrumblatt	SUNA RESTAURANT	Large Tap Marker	Henniker - Flap Jack	1	10/30/2024 3:39 PM	2026-03-17 14:10:42.083882
4323	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	BBCO - Wizard	1	10/30/2024 3:20 PM	2026-03-17 14:10:42.086461
4324	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Champlain Orch - Original	1	10/30/2024 3:20 PM	2026-03-17 14:10:42.089387
4325	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Henniker - Dustoff	1	10/30/2024 3:20 PM	2026-03-17 14:10:42.091925
4329	jaustin	LONGHORN STEAK #0003 - KEENE	Large Tap Marker	Maine Beer Co - Lunch	1	10/30/2024 1:56 PM	2026-03-17 14:10:42.102359
4330	pbelanger	EMMAS 321	Large Tap Marker	Citizen Cider - Cran Crush	1	10/30/2024 1:18 PM	2026-03-17 14:10:42.104767
4331	sshaunessy	BOWLING ACRES	Large Tap Marker	Widowmaker - Mt. Doom	1	10/30/2024 12:02 PM	2026-03-17 14:10:42.107219
4333	maanderson	T-BONES - HUDSON	Large Tap Marker	Stoneface - Porter	1	10/30/2024 11:06 AM	2026-03-17 14:10:42.112785
4334	maanderson	LUK'S BAR & GRILL	Large Tap Marker	Stoneface - Porter	1	10/30/2024 11:05 AM	2026-03-17 14:10:42.115743
4340	sshaunessy	LA PINATA MEXICAN GRILL	Large Tap Marker	Stoneface - IPA	1	10/29/2024 1:10 PM	2026-03-17 14:10:42.134143
4342	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Berkshire - Pumpkin	1	10/29/2024 11:26 AM	2026-03-17 14:10:42.139956
4343	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Cigar City - Jai Alai	1	10/29/2024 10:54 AM	2026-03-17 14:10:42.142621
4344	jsewall	ARIANA'S RESTAURANT	Large Tap Marker	Henniker - Flap Jack	1	10/29/2024 8:50 AM	2026-03-17 14:10:42.145256
4345	lortiz	CHILI'S - NASHUA - DW HWY	Large Tap Marker	603 Brew - Winni	1	10/28/2024 1:43 PM	2026-03-17 14:10:42.147944
4346	jjohnson	SNAX	Large Tap Marker	603 Brew - Wood Devil IPA	1	10/28/2024 1:17 PM	2026-03-17 14:10:42.150878
4347	jjohnson	SNAX	Large Tap Marker	Concord Craft - Safe Space	1	10/28/2024 1:03 PM	2026-03-17 14:10:42.15384
4348	lnorton	T-BONES - BEDFORD	Large Tap Marker	603 Brew - Winni	1	10/28/2024 1:01 PM	2026-03-17 14:10:42.156696
4349	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	603 Brew - Slightly Tstd	1	10/28/2024 12:30 PM	2026-03-17 14:10:42.159595
4350	scamuso	MILANO HOUSE OF PIZZA-NASHUA	Large Tap Marker	Stoneface - IPA	1	10/28/2024 12:09 PM	2026-03-17 14:10:42.162326
4351	lortiz	BURTON'S GRILL	Large Tap Marker	603 Brew - Winni	1	10/28/2024 11:42 AM	2026-03-17 14:10:42.165641
4353	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Large Tap Marker	Concord Craft - Four Rivers	1	10/28/2024 10:26 AM	2026-03-17 14:10:42.170835
4355	jcannamucio	JAMISON'S	Large Tap Marker	Frost - Lush	1	10/27/2024 11:23 AM	2026-03-17 14:10:42.176508
4357	amartin	SAN FRANCISCO KITCHEN INC	Large Tap Marker	Southern - Caramel Pumking	1	10/24/2024 4:01 PM	2026-03-17 14:10:42.181805
4358	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Concord Craft - Four Rivers	1	10/24/2024 2:37 PM	2026-03-17 14:10:42.184738
4359	lnorton	RIVER ROAD TAVERN	Large Tap Marker	603 Brew - Scenic	1	10/24/2024 2:37 PM	2026-03-17 14:10:42.187387
4360	lortiz	NOT YOUR AVERAGE JOE'S	Large Tap Marker	603 Brew - Hard Seltzer	1	10/24/2024 1:37 PM	2026-03-17 14:10:42.189994
4361	lortiz	NOT YOUR AVERAGE JOE'S	Large Tap Marker	603 Brew - Coffee Cake Porter	1	10/24/2024 1:37 PM	2026-03-17 14:10:42.192607
4362	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Large Tap Marker	Henniker - Kolsch	1	10/24/2024 11:26 AM	2026-03-17 14:10:42.195162
4366	jjohnson	CANTORE'S PIZZA	Large Tap Marker	Upper Pass - First Drop	1	10/24/2024 9:58 AM	2026-03-17 14:10:42.206888
4369	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	603 Brew - Coffee Cake Porter	1	10/23/2024 3:52 PM	2026-03-17 14:10:42.215268
4371	pwollert	BIRDIES	Large Tap Marker	Maine Beer Co - Lunch	1	10/23/2024 2:53 PM	2026-03-17 14:10:42.220865
4372	pwollert	BIRDIES	Large Tap Marker	Kona - Big Wave	1	10/23/2024 2:53 PM	2026-03-17 14:10:42.223448
4373	pwollert	BIRDIES	Large Tap Marker	Zero Gravity - Green State	1	10/23/2024 2:53 PM	2026-03-17 14:10:42.225986
4376	pbelanger	EMMAS 321	Large Tap Marker	Stoneface - Porter	1	10/23/2024 12:59 PM	2026-03-17 14:10:42.23499
4377	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Stoneface - IPA	1	10/23/2024 12:44 PM	2026-03-17 14:10:42.237639
4382	lnorton	BEDFORD VILLAGE INN & REST.	Large Tap Marker	Southern - Chestnut Praline	2	10/22/2024 1:51 PM	2026-03-17 19:05:56.704007
4398	rconstant	PROFESSOR SPORTS PUB	Large Tap Marker	Southern - Pumking	2	10/17/2024 3:43 PM	2026-03-17 19:05:56.706946
4404	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Jack's Abby - Copper Legend	2	10/17/2024 1:24 PM	2026-03-17 19:05:56.709495
4381	jmeharg	VILLAGE TRESTLE (THE)	Large Tap Marker	Concord Craft - Squirrel Fights	1	10/22/2024 2:12 PM	2026-03-17 14:10:42.247968
4383	maanderson	PINE VALLEY GOLF COURSE	Large Tap Marker	Stoneface - Porter	1	10/22/2024 1:43 PM	2026-03-17 14:10:42.25323
4384	lnorton	BEDFORD VILLAGE INN & REST.	Large Tap Marker	603 Brew - Coffee Cake Porter	1	10/22/2024 12:29 PM	2026-03-17 14:10:42.255564
4385	maanderson	STROKERS	Large Tap Marker	Downeast - Winter	1	10/22/2024 10:51 AM	2026-03-17 14:10:42.258088
4386	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Downeast - Blackberry	1	10/22/2024 9:29 AM	2026-03-17 14:10:42.260687
4387	scamuso	BISTRO 603	Large Tap Marker	603 Brew - Coffee Cake Porter	1	10/21/2024 4:07 PM	2026-03-17 14:10:42.263277
4430	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	Fiddlehead - IPA	2	10/10/2024 3:32 PM	2026-03-17 19:05:56.712613
4435	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	Founders - Breakfast Stout	2	10/10/2024 1:42 PM	2026-03-17 19:05:56.71679
4392	lnorton	PRESSED CAFE - BEDFORD	Large Tap Marker	Southern - Tiramasu	1	10/21/2024 12:09 PM	2026-03-17 14:10:42.27648
4393	jcannamucio	CARRIAGE TOWN BAR & GRILL	Large Tap Marker	Downeast - Cranberry	1	10/21/2024 12:08 PM	2026-03-17 14:10:42.279403
4394	jmeharg	HILLSBORO HOUSE OF PIZZA	Large Tap Marker	Kona - Big Wave	1	10/21/2024 11:01 AM	2026-03-17 14:10:42.283436
4395	scamuso	SHORTY'S MEXICAN ROADHOUSE	Large Tap Marker	603 Brew - Toast Pumpkin	1	10/21/2024 10:54 AM	2026-03-17 14:10:42.286121
4396	jsewall	WEATHERVANE - W.LEB	Large Tap Marker	603 Brew - Knuckle	1	10/21/2024 8:45 AM	2026-03-17 14:10:42.289073
4399	amartin	BACKSTREET BAR & GRILL LLC	Large Tap Marker	Athletic - Run Wild	1	10/17/2024 3:07 PM	2026-03-17 14:10:42.298617
4401	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	Henniker - Kolsch	1	10/17/2024 1:56 PM	2026-03-17 14:10:42.304875
4402	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	Henniker - Wrking Man Porter	1	10/17/2024 1:48 PM	2026-03-17 14:10:42.307692
4403	lortiz	LUI LUI - NASHUA	Large Tap Marker	Henniker - Flap Jack	1	10/17/2024 1:40 PM	2026-03-17 14:10:42.310249
4405	ddooling	PELHAM STREET BLACK WATER GRILL	Large Tap Marker	603 Brew - Slightly Tstd	1	10/17/2024 1:12 PM	2026-03-17 14:10:42.315381
4409	jgrumblatt	WILDWOOD SMOKEHOUSE	Large Tap Marker	Zero Gravity - Green State	1	10/16/2024 3:58 PM	2026-03-17 14:10:42.327049
4410	jgrumblatt	STOCKWELL RESTAURANT	Large Tap Marker	Zero Gravity - Green State	1	10/16/2024 3:56 PM	2026-03-17 14:10:42.329683
4415	amartin	RIVERWALK BAKERY & CAFE	Large Tap Marker	BBCO - Lighthouse	1	10/16/2024 1:43 PM	2026-03-17 14:10:42.346849
4416	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	Henniker - Hop Slinger IPA	1	10/16/2024 12:58 PM	2026-03-17 14:10:42.349796
4420	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Maine Beer Co - Dinner	1	10/15/2024 3:42 PM	2026-03-17 14:10:42.362768
4421	rconstant	SMOKE SHACK CAFE	Large Tap Marker	von Trapp - Pilsner	1	10/15/2024 3:40 PM	2026-03-17 14:10:42.366702
4424	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Athletic - Run Wild	1	10/15/2024 1:44 PM	2026-03-17 14:10:42.374749
4425	jmeharg	SNACKSHOT CATERING	Large Tap Marker	Concord Craft - Four Rivers	1	10/15/2024 12:22 PM	2026-03-17 14:10:42.37737
4426	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Maine Beer Co - Wolfe's Neck	1	10/14/2024 3:19 PM	2026-03-17 14:10:42.379936
4427	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Zero Gravity - Duck Duck	1	10/14/2024 3:19 PM	2026-03-17 14:10:42.382987
4428	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Stoneface - DDH Mozz	1	10/14/2024 3:19 PM	2026-03-17 14:10:42.385807
4429	pwollert	FRATERNAL ORDER OF EAGLES	Large Tap Marker	Busch Light	1	10/11/2024 11:09 AM	2026-03-17 14:10:42.388853
4433	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Zero Gravity - Duck Duck	1	10/10/2024 1:45 PM	2026-03-17 14:10:42.399427
4434	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Stoneface - DDH Mozz	1	10/10/2024 1:45 PM	2026-03-17 14:10:42.401991
4436	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	von Trapp - Vienna	1	10/10/2024 1:06 PM	2026-03-17 14:10:42.406984
4437	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	True North - Bog Moon	1	10/10/2024 11:19 AM	2026-03-17 14:10:42.40978
4454	ggage	VFW #4368 - MILFORD	Large Tap Marker	Downeast - Pumpkin	3	10/8/2024 9:28 AM	2026-03-17 19:05:56.719825
4441	rconstant	99 REST - LONDONDERRY	Large Tap Marker	Downeast - Original	1	10/10/2024 8:26 AM	2026-03-17 14:10:42.419224
4442	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Fiddlehead - White	1	10/9/2024 2:56 PM	2026-03-17 14:10:42.421487
4445	jgrumblatt	THE REFINERY	Large Tap Marker	Citizen Cider - Unified Press	1	10/9/2024 11:49 AM	2026-03-17 14:10:42.429516
4446	sshaunessy	BOWLING ACRES	Large Tap Marker	Zero Gravity - Duck Duck	1	10/9/2024 11:25 AM	2026-03-17 14:10:42.432009
4447	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Busch Light	1	10/9/2024 9:52 AM	2026-03-17 14:10:42.434342
4448	sshaunessy	BRADYS BAR AND GRILL	Large Tap Marker	Bud Light	1	10/9/2024 9:52 AM	2026-03-17 14:10:42.436949
4449	ggage	99 REST - NASHUA	Large Tap Marker	Budweiser	1	10/9/2024 9:12 AM	2026-03-17 14:10:42.439351
4450	ggage	99 REST - NASHUA	Large Tap Marker	603 Brew - Winni	1	10/9/2024 9:12 AM	2026-03-17 14:10:42.441947
4451	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	Fiddlehead - Mastermind	1	10/9/2024 9:04 AM	2026-03-17 14:10:42.444362
4452	pbelanger	MEXICA MEXICAN RESTAURANT	Large Tap Marker	Equilibrium - Coastline Chromatics	1	10/9/2024 8:36 AM	2026-03-17 14:10:42.447173
4453	rconstant	SUPPAS PIZZA LONDONDERRY	Large Tap Marker	Zero Gravity - Duck Duck	1	10/8/2024 3:41 PM	2026-03-17 14:10:42.449617
4455	scamuso	SHORTY'S MEXICAN ROADHOUSE	Large Tap Marker	Citizen Cider - BD Donut	1	10/7/2024 4:28 PM	2026-03-17 14:10:42.454669
4456	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	New Belgium - Fat Tire	1	10/7/2024 3:42 PM	2026-03-17 14:10:42.457363
4457	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	10/7/2024 3:42 PM	2026-03-17 14:10:42.459886
4458	jcannamucio	CARRIAGE TOWN BAR & GRILL	Large Tap Marker	New Belgium - Juice Force	1	10/7/2024 3:34 PM	2026-03-17 14:10:42.462704
4459	sshaunessy	UNION COFFEE COMPANY	Large Tap Marker	603 Brew - Slightly Tstd	1	10/7/2024 3:29 PM	2026-03-17 14:10:42.465481
4460	sshaunessy	UNION COFFEE COMPANY	Large Tap Marker	Fiddlehead - IPA	1	10/7/2024 3:29 PM	2026-03-17 14:10:42.468356
4461	jsewall	ARIANA'S RESTAURANT	Large Tap Marker	Shipyard - Pumpkin Head	1	10/7/2024 2:22 PM	2026-03-17 14:10:42.471105
4462	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	Berkshire - Marzen	1	10/7/2024 2:19 PM	2026-03-17 14:10:42.473614
4463	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	Wormtown - Be Hoppy	1	10/7/2024 1:44 PM	2026-03-17 14:10:42.476057
4466	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Weihenstephaner - Fiestbier	1	10/7/2024 11:54 AM	2026-03-17 14:10:42.48352
4469	jaustin	CLIFFY'S PUB	Large Tap Marker	Woodland - NA Beer	1	10/3/2024 1:07 PM	2026-03-17 14:10:42.49168
4470	jaustin	DIPLOMAT (THE)	Large Tap Marker	Concord Craft - Oktoberfest	1	10/3/2024 1:05 PM	2026-03-17 14:10:42.494585
4471	jaustin	GUERRILLA GRILL	Large Tap Marker	Wormtown - Fresh Patch	1	10/3/2024 1:04 PM	2026-03-17 14:10:42.497301
4472	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Zero Gravity - Oktoberfest	1	10/3/2024 12:49 PM	2026-03-17 14:10:42.500054
4473	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Stoneface - Oktoberfest	1	10/3/2024 12:49 PM	2026-03-17 14:10:42.502643
4474	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Concord Craft - Apple Crisp	1	10/3/2024 11:51 AM	2026-03-17 14:10:42.505585
4475	jsewall	SAWTOOTH KITCHEN LLC	Large Tap Marker	Berkshire - Coffehouse Porter	1	10/3/2024 11:17 AM	2026-03-17 14:10:42.508749
4476	jmeharg	DANIEL'S PUB INC	Large Tap Marker	Henniker - Flap Jack	1	10/3/2024 4:32 AM	2026-03-17 14:10:42.511492
4477	sshaunessy	BOWLING ACRES	Large Tap Marker	Fiddlehead - IPA	1	10/2/2024 11:28 AM	2026-03-17 14:10:42.514879
4478	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Concord Craft - Four Rivers	1	10/2/2024 11:06 AM	2026-03-17 14:10:42.51819
4479	jcannamucio	JAMISON'S	Large Tap Marker	Berkshire - Marzen	1	10/1/2024 1:12 PM	2026-03-17 14:10:42.522076
4480	jmeharg	VILLAGE TRESTLE (THE)	Large Tap Marker	Downeast - Pumpkin	1	10/1/2024 1:10 PM	2026-03-17 14:10:42.525555
4481	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	True North - Witch	1	10/1/2024 12:57 PM	2026-03-17 14:10:42.530247
4482	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Jack's Abby - Copper Legend	1	10/1/2024 12:57 PM	2026-03-17 14:10:42.532791
4483	jcannamucio	AXE TOWNE	Large Tap Marker	Shipyard - Pumpkin Head	1	10/1/2024 9:22 AM	2026-03-17 14:10:42.536156
4484	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	von Trapp - Dunkel	1	10/1/2024 8:38 AM	2026-03-17 14:10:42.538913
4487	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Jack's Abby - Copper Legend	1	9/30/2024 3:28 PM	2026-03-17 14:10:42.547687
4488	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	Concord Craft - Squirrel Fights	1	9/30/2024 1:55 PM	2026-03-17 14:10:42.550454
4492	jjohnson	SNAX	Large Tap Marker	603 Brew - Octoberfest	1	9/30/2024 12:44 PM	2026-03-17 14:10:42.563757
4493	jcannamucio	THE NEST PUB AND GRILL	Large Tap Marker	Shipyard - Pumpkin Head	1	9/30/2024 11:38 AM	2026-03-17 14:10:42.567128
4494	ddooling	COPPER DOOR - SALEM	Large Tap Marker	Founders - Mortal Bloom	1	9/30/2024 11:27 AM	2026-03-17 14:10:42.571513
4495	lnorton	COPPER DOOR - BEDFORD	Large Tap Marker	Founders - Mortal Bloom	1	9/30/2024 10:44 AM	2026-03-17 14:10:42.576098
4496	jgiuffrida	LONGHORN STEAK #5278 - AMHERST	Large Tap Marker	Shipyard - Pumpkin Head	1	9/30/2024 9:10 AM	2026-03-17 14:10:42.579493
4497	scamuso	SHORTY'S MEXICAN ROADHOUSE	Large Tap Marker	1911 - Cider Donut	1	9/26/2024 4:05 PM	2026-03-17 14:10:42.58419
4498	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Mighty Squirrel - Gourdgeous Pumpkin	1	9/26/2024 3:49 PM	2026-03-17 14:10:42.587267
4499	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Downeast - Pumpkin	1	9/26/2024 3:49 PM	2026-03-17 14:10:42.590302
4505	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Stoneface - Porter	2	9/26/2024 11:13 AM	2026-03-17 19:05:56.722095
4534	jaustin	CLIFFY'S PUB	Large Tap Marker	New Belgium - Fat Tire	2	9/19/2024 1:46 PM	2026-03-17 19:05:56.725149
4502	lnorton	PRESSED CAFE - BEDFORD	Large Tap Marker	1911 - Cider Donut	1	9/26/2024 2:03 PM	2026-03-17 14:10:42.600717
4506	jjohnson	CANTORE'S PIZZA	Large Tap Marker	Bud Light	1	9/26/2024 10:55 AM	2026-03-17 14:10:42.612131
4508	maanderson	KETTLEHEAD BREWING CO - NASHUA	Large Tap Marker	Citizen Cider - BD Donut	1	9/25/2024 1:32 PM	2026-03-17 14:10:42.618622
4509	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	New Belgium - VR 1985 Mango	1	9/25/2024 12:58 PM	2026-03-17 14:10:42.621392
4510	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Southern - Warlock	1	9/25/2024 12:58 PM	2026-03-17 14:10:42.624139
4511	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	von Trapp - Oktober	1	9/25/2024 12:58 PM	2026-03-17 14:10:42.626951
4512	ddooling	SEVMAR MEDITERRANEAN BISTRO	Large Tap Marker	Maine Beer Co - Lunch	1	9/25/2024 12:56 PM	2026-03-17 14:10:42.629583
4516	sshaunessy	BOWLING ACRES	Large Tap Marker	BBCO - Wizard	1	9/25/2024 11:30 AM	2026-03-17 14:10:42.641024
4517	pwollert	POUR HOUSE (THE)	Large Tap Marker	Shipyard - Pumpkin Head	1	9/24/2024 2:59 PM	2026-03-17 14:10:42.643672
4519	jgrumblatt	NEW LONDON INN/COACH HOUSE RESTAURANT	Large Tap Marker	Concord Craft - Four Rivers	1	9/24/2024 11:33 AM	2026-03-17 14:10:42.652807
4521	scamuso	BISTRO 603	Large Tap Marker	Fiddlehead - White	1	9/23/2024 4:15 PM	2026-03-17 14:10:42.659091
4526	sshaunessy	UNION COFFEE COMPANY	Large Tap Marker	Southern - Pumking	1	9/23/2024 2:28 PM	2026-03-17 14:10:42.673993
4527	jmeharg	CHARTWELL'S DINING SERVICES	Large Tap Marker	Henniker - Oktoberfest	1	9/23/2024 11:22 AM	2026-03-17 14:10:42.677676
4532	lnorton	RIVER ROAD TAVERN	Large Tap Marker	True North - Witch	1	9/19/2024 2:29 PM	2026-03-17 14:10:42.694156
4533	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Southern - Caramel Pumking	1	9/19/2024 2:29 PM	2026-03-17 14:10:42.697262
4537	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Concord Craft - Safe Space	1	9/19/2024 12:55 PM	2026-03-17 14:10:42.70916
4538	maanderson	MARGARITAS MEXICAN RESTAURANT-NASHUA	Large Tap Marker	Shipyard - Pumpkin Head	1	9/19/2024 12:33 PM	2026-03-17 14:10:42.711978
4540	jsewall	STILL NORTH BOOKS & BAR	Large Tap Marker	Sea Dog - Sun Fish	1	9/19/2024 11:33 AM	2026-03-17 14:10:42.718305
4541	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Large Tap Marker	Stoneface - IPA	1	9/19/2024 10:27 AM	2026-03-17 14:10:42.721262
4542	pwollert	WATKINS INN & TAVERN	Large Tap Marker	Berkshire - Marzen	1	9/19/2024 10:13 AM	2026-03-17 14:10:42.724855
4543	pwollert	RESTAURANT AT BURDICKS	Large Tap Marker	Ayinger	1	9/19/2024 10:12 AM	2026-03-17 14:10:42.727596
4544	jmeharg	STONEBRIDGE COUNTRY CLUB	Large Tap Marker	Concord Craft - Oktoberfest	1	9/19/2024 8:03 AM	2026-03-17 14:10:42.73003
4548	amartin	RIVERWALK BAKERY & CAFE	Large Tap Marker	Wormtown - Fresh Patch	1	9/18/2024 1:12 PM	2026-03-17 14:10:42.741318
4549	amartin	RIVERWALK BAKERY & CAFE	Large Tap Marker	Kelsen - Battle Axe	1	9/18/2024 1:12 PM	2026-03-17 14:10:42.744284
4550	jgiuffrida	STONECUTTERS PUB	Large Tap Marker	Shipyard - Pumpkin Head	1	9/18/2024 12:54 PM	2026-03-17 14:10:42.746902
4551	sshaunessy	BOWLING ACRES	Large Tap Marker	Stoneface - Full Clip	1	9/18/2024 12:01 PM	2026-03-17 14:10:42.750013
4552	sshaunessy	BOWLING ACRES	Large Tap Marker	Upper Pass - Cloud Drop	1	9/18/2024 12:01 PM	2026-03-17 14:10:42.753246
4554	jjohnson	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	Large Tap Marker	603 Brew - Winni	1	9/18/2024 8:47 AM	2026-03-17 14:10:42.759046
4553	jgrumblatt	STOCKWELL RESTAURANT	Large Tap Marker	von Trapp - Oktober	2	9/18/2024 11:54 AM	2026-03-17 19:05:56.728059
4556	sshaunessy	PEARL RESTAURANT & OYSTER	Large Tap Marker	Concord Craft - Four Rivers	1	9/17/2024 1:21 PM	2026-03-17 14:10:42.764914
4559	jcannamucio	GRUMPY'S BAR & GRILL	Large Tap Marker	Shipyard - Pumpkin Head	2	9/17/2024 9:59 AM	2026-03-17 19:05:56.730903
4597	jsewall	ARIANA'S RESTAURANT	Large Tap Marker	Sea Dog - Blueberry	2	9/9/2024 9:15 AM	2026-03-17 19:05:56.73345
4560	pwollert	BENDER'S BAR AND GRILL	Large Tap Marker	Shipyard - Pumpkin Head	1	9/17/2024 9:34 AM	2026-03-17 14:10:42.777686
4561	scamuso	TEQUILA JALISCO MEXICAN CUISINE AND CANTINA	Large Tap Marker	Citizen Cider - Unified Press	1	9/16/2024 4:15 PM	2026-03-17 14:10:42.781079
4562	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Concord Craft - Four Rivers	1	9/16/2024 3:58 PM	2026-03-17 14:10:42.784005
4563	scamuso	BISTRO 603	Large Tap Marker	Jack's Abby - Copper Legend	1	9/16/2024 2:51 PM	2026-03-17 14:10:42.787491
4564	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Henniker - Picnic	1	9/16/2024 2:29 PM	2026-03-17 14:10:42.790161
4565	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	von Trapp - Helles	1	9/16/2024 2:02 PM	2026-03-17 14:10:42.792908
4598	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	Zero Gravity - Oktoberfest	2	9/8/2024 2:44 PM	2026-03-17 19:05:56.735837
4567	lortiz	BURTON'S GRILL	Large Tap Marker	Downeast - Original	1	9/16/2024 12:43 PM	2026-03-17 14:10:42.798192
4568	lortiz	BURTON'S GRILL	Large Tap Marker	Shipyard - Pumpkin Head	1	9/16/2024 12:43 PM	2026-03-17 14:10:42.800945
4570	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Battery - Flume	1	9/13/2024 8:47 AM	2026-03-17 14:10:42.807014
4571	jaustin	GUERRILLA GRILL	Large Tap Marker	Citizen Cider - BD Donut	1	9/11/2024 2:54 PM	2026-03-17 14:10:42.809824
4572	jaustin	GUERRILLA GRILL	Large Tap Marker	603 Brew - Octoberfest	1	9/11/2024 2:36 PM	2026-03-17 14:10:42.812506
4577	jjohnson	CANTORE'S PIZZA	Large Tap Marker	Citizen Cider - BD Donut	1	9/11/2024 11:23 AM	2026-03-17 14:10:42.826521
4578	jjohnson	CANTORE'S PIZZA	Large Tap Marker	Golden Road AF Mango	1	9/11/2024 11:23 AM	2026-03-17 14:10:42.829995
4579	jgrumblatt	VAIL RESORT/ MOUNT SUNAPEE	Large Tap Marker	Downeast - Original	1	9/11/2024 11:00 AM	2026-03-17 14:10:42.832592
4580	pbelanger	RUSTIC TABLE (THE)	Large Tap Marker	1911 - Cider Donut	1	9/11/2024 7:03 AM	2026-03-17 14:10:42.835087
4581	pbelanger	RUSTIC TABLE (THE)	Large Tap Marker	True North - Witch	1	9/11/2024 7:03 AM	2026-03-17 14:10:42.837607
4583	amartin	FODY'S TAVERN (NASHUA)	Large Tap Marker	Downeast - Original	1	9/10/2024 2:24 PM	2026-03-17 14:10:42.843123
4585	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	14th Star - Valor	1	9/10/2024 1:32 PM	2026-03-17 14:10:42.849018
4586	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Wicked Weed Pernicious	1	9/10/2024 1:32 PM	2026-03-17 14:10:42.852174
4587	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Frost - Plush	1	9/10/2024 1:32 PM	2026-03-17 14:10:42.855865
4589	sshaunessy	BOWLING ACRES	Large Tap Marker	Wormtown - Be Hoppy	1	9/10/2024 11:55 AM	2026-03-17 14:10:42.863041
4590	rconstant	TWINS SMOKE SHOP	Large Tap Marker	603 Brew - Slightly Tstd	1	9/9/2024 2:25 PM	2026-03-17 14:10:42.865969
4596	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Bud Light	1	9/9/2024 9:38 AM	2026-03-17 14:10:42.885768
4599	jsewall	SAWTOOTH KITCHEN LLC	Large Tap Marker	BBCO - Good Company	1	9/5/2024 4:18 PM	2026-03-17 14:10:42.899696
4600	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Shipyard - Pumpkin Head	1	9/5/2024 4:06 PM	2026-03-17 14:10:42.902377
4601	jsewall	110 GRILL - W. LEB	Large Tap Marker	Jack's Abby - Banner	1	9/5/2024 4:04 PM	2026-03-17 14:10:42.905003
4603	amartin	SURF RESTAURANT INC	Large Tap Marker	Berkshire - Marzen	1	9/5/2024 2:53 PM	2026-03-17 14:10:42.912139
4604	amartin	SURF RESTAURANT INC	Large Tap Marker	Concord Craft - Four Rivers	1	9/5/2024 2:53 PM	2026-03-17 14:10:42.914926
4606	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Maine Beer Co - Fall	1	9/5/2024 2:45 PM	2026-03-17 14:10:42.921024
4610	jgrumblatt	SALT HILL PUB - NEWPORT	Large Tap Marker	Shipyard - Pumpkin Head	1	9/5/2024 11:20 AM	2026-03-17 14:10:42.931903
4973	jmorse	RUM BROOK MARKET	Other	Cabot	1	12/23/2025 12:21 PM	2026-03-17 14:10:44.386914
4628	pbelanger	RUSTIC TABLE (THE)	Large Tap Marker	Zero Gravity - Cone Head Haze	2	9/3/2024 9:18 AM	2026-03-17 19:05:56.739042
4664	maanderson	STROKERS	Large Tap Marker	Downeast - Cider Donut	2	8/27/2024 2:42 PM	2026-03-17 19:05:56.742287
4614	amartin	SPECTACLE MANAGEMENT INC	Large Tap Marker	von Trapp - Pilsner	1	9/4/2024 2:11 PM	2026-03-17 14:10:42.947623
4615	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Henniker - Oktoberfest	1	9/4/2024 1:42 PM	2026-03-17 14:10:42.950246
4616	sshaunessy	BOWLING ACRES	Large Tap Marker	Concord Craft - Safe Space	1	9/4/2024 11:56 AM	2026-03-17 14:10:42.952972
4617	ddooling	PRESSED CAFE - SALEM	Large Tap Marker	603 Brew - Slightly Tstd	1	9/4/2024 10:37 AM	2026-03-17 14:10:42.956239
4666	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Southern - Caramel Pumking	2	8/27/2024 12:44 PM	2026-03-17 19:05:56.744706
4619	sshaunessy	SUN BAR & GRILL	Large Tap Marker	603 Brew - Toast Pumpkin	1	9/3/2024 3:02 PM	2026-03-17 14:10:42.96203
4620	jmeharg	SNACKSHOT CATERING	Large Tap Marker	Wormtown - Fresh Patch	1	9/3/2024 2:16 PM	2026-03-17 14:10:42.965517
4621	jmeharg	SNACKSHOT CATERING	Large Tap Marker	Concord Craft - Oktoberfest	1	9/3/2024 2:16 PM	2026-03-17 14:10:42.968688
4622	sshaunessy	HAMPSHIRE HILLS S&F CLUB	Large Tap Marker	Concord Craft - Oktoberfest	1	9/3/2024 1:50 PM	2026-03-17 14:10:42.971466
4623	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	603 Brew - Octoberfest	1	9/3/2024 1:16 PM	2026-03-17 14:10:42.974352
4624	jgrumblatt	NEWBURY PALACE PIZZA	Large Tap Marker	Henniker - Oktoberfest	1	9/3/2024 12:48 PM	2026-03-17 14:10:42.977191
4625	jgrumblatt	SALT HILL PUB - NEWBURY	Large Tap Marker	Downeast - Cider Donut	1	9/3/2024 12:39 PM	2026-03-17 14:10:42.980545
4668	jcannamucio	GRUMPY'S BAR & GRILL	Large Tap Marker	Downeast - Cider Donut	2	8/27/2024 12:37 PM	2026-03-17 19:05:56.74765
4632	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	Tuckerman - Pale Ale	1	8/29/2024 3:43 PM	2026-03-17 14:10:43.001977
4633	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	Fiddlehead - IPA	1	8/29/2024 3:43 PM	2026-03-17 14:10:43.004573
4634	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	Downeast - Original	1	8/29/2024 3:30 PM	2026-03-17 14:10:43.007238
4635	lnorton	PRESSED CAFE - BEDFORD	Large Tap Marker	603 Brew - Toast Pumpkin	1	8/29/2024 3:26 PM	2026-03-17 14:10:43.0098
4636	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Mighty Squirrel - Oktoberfest	1	8/29/2024 2:13 PM	2026-03-17 14:10:43.012334
4637	lnorton	RIVER ROAD TAVERN	Large Tap Marker	von Trapp - Stowe Style	1	8/29/2024 2:13 PM	2026-03-17 14:10:43.014774
4638	maanderson	MARGARITAS MEXICAN RESTAURANT-NASHUA	Large Tap Marker	Downeast - Cider Donut	1	8/29/2024 1:35 PM	2026-03-17 14:10:43.017401
4639	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Wormtown - Be Smooth	1	8/29/2024 11:56 AM	2026-03-17 14:10:43.020033
4640	jsewall	STILL NORTH BOOKS & BAR	Large Tap Marker	Berkshire - Apuckalips	1	8/29/2024 11:41 AM	2026-03-17 14:10:43.022748
4641	jsewall	STILL NORTH BOOKS & BAR	Large Tap Marker	Concord Craft - Oktoberfest	1	8/29/2024 11:41 AM	2026-03-17 14:10:43.025474
4642	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Downeast - Cider Donut	1	8/29/2024 11:29 AM	2026-03-17 14:10:43.028131
4643	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Banded - Zealot	1	8/29/2024 11:29 AM	2026-03-17 14:10:43.030921
4644	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Stoneface - Full Clip	1	8/29/2024 11:29 AM	2026-03-17 14:10:43.033358
4645	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Kentucky - BBA Imp Milk Stout	1	8/29/2024 11:29 AM	2026-03-17 14:10:43.03603
4649	jgrumblatt	SUNA RESTAURANT	Large Tap Marker	Spaten	1	8/28/2024 3:50 PM	2026-03-17 14:10:43.046064
4650	sshaunessy	COOPER'S HILL	Large Tap Marker	603 Brew - Slightly Tstd	1	8/28/2024 3:01 PM	2026-03-17 14:10:43.048893
4653	rconstant	LI'L LOBSTER BOAT	Large Tap Marker	Shipyard - Pumpkin Head	1	8/28/2024 2:22 PM	2026-03-17 14:10:43.057038
4654	jaustin	APPLEBEES - KEENE #6714	Large Tap Marker	Busch Light	1	8/28/2024 2:16 PM	2026-03-17 14:10:43.059755
4655	jaustin	MAIN CRUST CO.	Large Tap Marker	Weihenstephaner - Fiestbier	1	8/28/2024 1:40 PM	2026-03-17 14:10:43.062726
4656	jaustin	MAIN CRUST CO.	Large Tap Marker	Downeast - Cider Donut	1	8/28/2024 1:40 PM	2026-03-17 14:10:43.065266
4657	jaustin	MAIN CRUST CO.	Large Tap Marker	Orono - Tubular	1	8/28/2024 1:40 PM	2026-03-17 14:10:43.067855
4658	sshaunessy	BOWLING ACRES	Large Tap Marker	Frost - Research IPA	1	8/28/2024 1:35 PM	2026-03-17 14:10:43.070507
4660	jcannamucio	SADDLE UP SALOON	Large Tap Marker	Shipyard - Pumpkin Head	1	8/28/2024 1:15 PM	2026-03-17 14:10:43.075968
4661	pbelanger	EMMAS 321	Large Tap Marker	Orono - Tubular	1	8/28/2024 12:16 PM	2026-03-17 14:10:43.079018
4662	jcannamucio	CARRIAGE TOWN BAR & GRILL	Large Tap Marker	Shipyard - Pumpkin Head	1	8/28/2024 10:57 AM	2026-03-17 14:10:43.081875
4665	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Downeast - Cider Donut	1	8/27/2024 12:44 PM	2026-03-17 14:10:43.090807
4667	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Other Half - We're Happy to Juice You	1	8/27/2024 12:44 PM	2026-03-17 14:10:43.09705
4669	sshaunessy	AMHERST COUNTRY CLUB	Large Tap Marker	603 Brew - Toast Pumpkin	1	8/26/2024 4:25 PM	2026-03-17 14:10:43.102948
4671	rconstant	STUMBLE INN BAR & GRILL	Large Tap Marker	Shipyard - Pumpkin Head	1	8/26/2024 3:08 PM	2026-03-17 14:10:43.10876
4672	sshaunessy	UNION COFFEE COMPANY	Large Tap Marker	Foundation - Fetch	1	8/26/2024 2:40 PM	2026-03-17 14:10:43.11157
4673	maanderson	NATIONAL CLUB (THE)	Large Tap Marker	Jack's Abby - Copper Legend	1	8/26/2024 1:31 PM	2026-03-17 14:10:43.11436
4674	ddooling	CHILI'S - SALEM	Large Tap Marker	Shipyard - Pumpkin Head	1	8/26/2024 11:48 AM	2026-03-17 14:10:43.117295
4675	ddooling	T-BONES - SALEM	Large Tap Marker	Shipyard - Pumpkin Head	1	8/26/2024 11:37 AM	2026-03-17 14:10:43.12011
4676	ggage	FAMILY PIZZA AND ROAST BEEF OF NASHUA	Large Tap Marker	Shipyard - Pumpkin Head	1	8/26/2024 6:53 AM	2026-03-17 14:10:43.122834
4677	scamuso	SHORTY'S MEXICAN ROADHOUSE	Large Tap Marker	Shipyard - Pumpkin Head	1	8/22/2024 4:32 PM	2026-03-17 14:10:43.125999
4678	rconstant	ROMANO'S PIZZA LLC	Large Tap Marker	Shipyard - Pumpkin Head	1	8/22/2024 4:07 PM	2026-03-17 14:10:43.129001
4679	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Founders - Mortal Bloom	1	8/22/2024 3:43 PM	2026-03-17 14:10:43.131993
4680	lnorton	RIVER ROAD TAVERN	Large Tap Marker	Stoneface - Dwaynes World	1	8/22/2024 3:43 PM	2026-03-17 14:10:43.134996
4702	pbelanger	EMMAS 321	Large Tap Marker	Mighty Squirrel - Oktoberfest	2	8/21/2024 11:35 AM	2026-03-17 19:05:56.75018
4703	pbelanger	EMMAS 321	Large Tap Marker	True North - Witch	2	8/21/2024 11:33 AM	2026-03-17 19:05:56.75359
4683	amartin	SURF RESTAURANT INC	Large Tap Marker	603 Brew - Summa	1	8/22/2024 3:05 PM	2026-03-17 14:10:43.144189
4706	pbelanger	MEXICA MEXICAN RESTAURANT	Large Tap Marker	14th Star - Tribute	2	8/21/2024 6:30 AM	2026-03-17 19:05:56.755877
4686	scamuso	COURTYARD BY MARRIOTT - NASHUA	Large Tap Marker	Stoneface - DDH Full Clip	1	8/22/2024 1:16 PM	2026-03-17 14:10:43.153281
4687	maanderson	PEDDLER'S DAUGHTER	Large Tap Marker	Shipyard - Pumpkin Head	1	8/22/2024 1:04 PM	2026-03-17 14:10:43.15666
4691	amartin	LYNN'S 102 TAVERN	Large Tap Marker	Downeast - Cider Donut	1	8/22/2024 12:39 PM	2026-03-17 14:10:43.173942
4695	ddooling	PRESSED CAFE - SALEM	Large Tap Marker	Shipyard - Pumpkin Head	1	8/21/2024 2:27 PM	2026-03-17 14:10:43.186141
4696	rconstant	COACH STOP	Large Tap Marker	Shipyard - Pumpkin Head	1	8/21/2024 1:55 PM	2026-03-17 14:10:43.189157
4698	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Maine Beer Co - Dinner	1	8/21/2024 12:46 PM	2026-03-17 14:10:43.201616
4699	sshaunessy	BOWLING ACRES	Large Tap Marker	Wormtown - Fresh Patch	1	8/21/2024 12:31 PM	2026-03-17 14:10:43.205462
4700	sshaunessy	BOWLING ACRES	Large Tap Marker	Budweiser	1	8/21/2024 12:31 PM	2026-03-17 14:10:43.208238
4701	sshaunessy	BOWLING ACRES	Large Tap Marker	Equilibrium - Space Station Dream Lab	1	8/21/2024 12:31 PM	2026-03-17 14:10:43.210953
4704	pbelanger	EMMAS 321	Large Tap Marker	603 Brew - Slightly Tstd	1	8/21/2024 11:33 AM	2026-03-17 14:10:43.21934
4705	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	Concord Craft - Oktoberfest	1	8/21/2024 8:06 AM	2026-03-17 14:10:43.222152
4707	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Jack's Abby - Copper Legend	1	8/20/2024 4:12 PM	2026-03-17 14:10:43.227953
4708	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Stoneface - Dwaynes World	1	8/20/2024 4:12 PM	2026-03-17 14:10:43.230679
4709	pbelanger	RUSTIC TABLE (THE)	Large Tap Marker	Tuckerman - Pale Ale	1	8/20/2024 4:07 PM	2026-03-17 14:10:43.233503
4713	pwollert	POUR HOUSE (THE)	Large Tap Marker	Jack's Abby - Copper Legend	1	8/20/2024 2:10 PM	2026-03-17 14:10:43.248225
4714	pwollert	MADAME SHERRI'S	Large Tap Marker	Shipyard - Pumpkin Head	1	8/20/2024 2:09 PM	2026-03-17 14:10:43.250891
4715	jsewall	ARIANA'S RESTAURANT	Large Tap Marker	Berkshire - Coffehouse Porter	1	8/20/2024 7:32 AM	2026-03-17 14:10:43.253852
4718	sshaunessy	RILEY'S PLACE	Large Tap Marker	Jack's Abby - Copper Legend	1	8/19/2024 3:42 PM	2026-03-17 14:10:43.262059
4719	scamuso	BISTRO 603	Large Tap Marker	Downeast - Pumpkin	1	8/19/2024 3:28 PM	2026-03-17 14:10:43.265007
4722	pwollert	MADAME SHERRI'S	Large Tap Marker	Zero Gravity - Madonna	1	8/19/2024 1:39 PM	2026-03-17 14:10:43.273368
4723	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Large Tap Marker	Wicked Weed Pernicious Haze	1	8/19/2024 10:54 AM	2026-03-17 14:10:43.275954
4729	scamuso	SHORTY'S MEXICAN ROADHOUSE	Large Tap Marker	Downeast - Cider Donut	1	8/15/2024 3:54 PM	2026-03-17 14:10:43.292823
4730	pwollert	21 ROXBURY BAR & GRILL	Large Tap Marker	Jack's Abby - Copper Legend	1	8/15/2024 2:49 PM	2026-03-17 14:10:43.295625
4732	jsewall	CHILI'S - W.LEB	Large Tap Marker	Fiddlehead - IPA	2	8/15/2024 11:48 AM	2026-03-17 19:05:56.758249
4734	jcannamucio	KINGSTON VETS CLUB INC	Large Tap Marker	Kona - Big Wave	1	8/15/2024 10:22 AM	2026-03-17 14:10:43.306424
4735	jaustin	MARGARITA'S - KEENE	Large Tap Marker	Downeast - Cider Donut	1	8/14/2024 2:37 PM	2026-03-17 14:10:43.309048
4736	scamuso	TEQUILA JALISCO MEXICAN CUISINE AND CANTINA	Large Tap Marker	Shipyard - Pumpkin Head	1	8/14/2024 2:33 PM	2026-03-17 14:10:43.311589
4737	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Jack's Abby - House Lager	1	8/14/2024 1:39 PM	2026-03-17 14:10:43.314518
4738	pbelanger	EMMAS 321	Large Tap Marker	Downeast - Pumpkin	1	8/14/2024 12:08 PM	2026-03-17 14:10:43.317103
4733	jjohnson	CANTORE'S PIZZA	Large Tap Marker	Jack's Abby - Banner	2	8/15/2024 10:42 AM	2026-03-17 19:05:56.761362
4740	sshaunessy	COPPER KETTLE	Large Tap Marker	True North - Witch	1	8/13/2024 4:17 PM	2026-03-17 14:10:43.322802
4741	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Large Tap Marker	Jack's Abby - House Lager	1	8/13/2024 3:31 PM	2026-03-17 14:10:43.325543
4742	maanderson	STROKERS	Large Tap Marker	Shipyard - Pumpkin Head	1	8/13/2024 2:42 PM	2026-03-17 14:10:43.329453
4743	jmeharg	SNACKSHOT CATERING	Large Tap Marker	Shipyard - Pumpkin Head	1	8/13/2024 12:37 PM	2026-03-17 14:10:43.332586
4746	maanderson	PINE VALLEY GOLF COURSE	Large Tap Marker	Jack's Abby - Copper Legend	1	8/13/2024 9:53 AM	2026-03-17 14:10:43.341305
4747	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Sea Dog - Blueberry	1	8/12/2024 5:02 PM	2026-03-17 14:10:43.343892
4750	jaustin	CLIFFY'S PUB	Large Tap Marker	Dos Equis	1	8/12/2024 12:42 PM	2026-03-17 14:10:43.352865
4753	ggage	PIZZERIA ZACHARIA	Large Tap Marker	Mighty Squirrel - Cloud Candy	1	8/12/2024 12:01 PM	2026-03-17 14:10:43.361984
4755	jsewall	WEATHERVANE - W.LEB	Large Tap Marker	603 Brew - Scenic	1	8/12/2024 8:29 AM	2026-03-17 14:10:43.367809
4757	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Exhibit A - Panda Punch	1	8/8/2024 3:39 PM	2026-03-17 14:10:43.373599
4758	rconstant	ROMANO'S PIZZA LLC	Large Tap Marker	Kona - Big Wave	1	8/8/2024 3:29 PM	2026-03-17 14:10:43.376469
4759	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	Wicked Weed Pernicious	1	8/8/2024 2:30 PM	2026-03-17 14:10:43.379869
4760	lnorton	WINDHAM RESTAURANT (THE)	Large Tap Marker	Downeast - Original	1	8/8/2024 1:55 PM	2026-03-17 14:10:43.382701
4763	jmorse	FORBES TAVERN AND EVENTS	Large Tap Marker	Maine Beer Co - Lunch	1	8/7/2024 3:31 PM	2026-03-17 14:10:43.391364
4768	sshaunessy	HARLOWS PUBLIC HOUSE	Large Tap Marker	Maine Beer Co - Lunch	1	8/7/2024 12:08 PM	2026-03-17 14:10:43.406253
4769	pbelanger	EMMAS 321	Large Tap Marker	Equilibrium - Wavelength	1	8/7/2024 12:06 PM	2026-03-17 14:10:43.410444
4770	pbelanger	EMMAS 321	Large Tap Marker	von Trapp - Pine 1769	1	8/7/2024 12:06 PM	2026-03-17 14:10:43.413171
4771	pbelanger	RUSTIC TABLE (THE)	Large Tap Marker	Newburyport - Plum Island	1	8/6/2024 4:29 PM	2026-03-17 14:10:43.416379
4772	pwollert	POUR HOUSE (THE)	Large Tap Marker	Fiddlehead - IPA	1	8/6/2024 1:37 PM	2026-03-17 14:10:43.42012
4773	pwollert	MADAME SHERRI'S	Large Tap Marker	Bud Light	1	8/6/2024 1:10 PM	2026-03-17 14:10:43.423045
4774	jcannamucio	JAMISON'S	Large Tap Marker	Downeast - Cider Donut	1	8/6/2024 11:16 AM	2026-03-17 14:10:43.428254
4775	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	Wicked Weed Pernicious Haze	1	8/5/2024 2:46 PM	2026-03-17 14:10:43.430872
4776	ddooling	MICHAELS FLATBREAD PIZZA CO.	Large Tap Marker	Downeast - Original	1	8/5/2024 1:09 PM	2026-03-17 14:10:43.434155
4777	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	Fiddlehead - White	1	8/5/2024 11:59 AM	2026-03-17 14:10:43.440063
4778	jaustin	GUERRILLA GRILL	Large Tap Marker	Golden Road AF Mango	1	8/1/2024 2:11 PM	2026-03-17 14:10:43.444368
4779	rconstant	HUDSON SPEEDWAY (THE)	Large Tap Marker	Budweiser	1	8/1/2024 1:05 PM	2026-03-17 14:10:43.447084
4780	jjohnson	CANTORE'S PIZZA	Large Tap Marker	Downeast - Guava Passion	1	8/1/2024 12:14 PM	2026-03-17 14:10:43.449927
4781	pbelanger	MEXICA MEXICAN RESTAURANT	Large Tap Marker	Other Half - Green City	1	8/1/2024 12:11 PM	2026-03-17 14:10:43.452963
4782	jgrumblatt	VAIL RESORT/ MOUNT SUNAPEE	Large Tap Marker	Mich Ultra	1	8/1/2024 12:11 PM	2026-03-17 14:10:43.456215
4783	jsewall	STILL NORTH BOOKS & BAR	Large Tap Marker	BBCO - Little Wizard	1	8/1/2024 11:38 AM	2026-03-17 14:10:43.460706
4785	jgrumblatt	LITTLE BROTHERS BURGERS	Large Tap Marker	Concord Craft - Pandora Kettle	1	7/31/2024 12:27 PM	2026-03-17 14:10:43.467972
4786	pbelanger	EMMAS 321	Large Tap Marker	Downeast - Cider Donut	1	7/31/2024 10:29 AM	2026-03-17 14:10:43.470953
4787	sshaunessy	HILLTOP CAFE	Large Tap Marker	Maine Beer Co - Peeper	1	7/30/2024 3:46 PM	2026-03-17 14:10:43.474261
4788	sshaunessy	COPPER KETTLE	Large Tap Marker	Zero Gravity - Cone Head Haze	1	7/30/2024 3:44 PM	2026-03-17 14:10:43.477046
4789	ddooling	RALPHIE'S CAFE ITALIANO	Large Tap Marker	Shipyard - Pumpkin Head	1	7/29/2024 3:44 PM	2026-03-17 14:10:43.480132
4790	lnorton	OLD SCHOOL BAR AND GRILL	Large Tap Marker	603 Brew - Winni	1	7/29/2024 3:36 PM	2026-03-17 14:10:43.482901
4791	lnorton	FRIENDLY RED'S - WINDHAM	Large Tap Marker	Shipyard - Pumpkin Head	1	7/29/2024 2:40 PM	2026-03-17 14:10:43.486664
4792	jsewall	SALT HILL PUB - LEBANON	Large Tap Marker	Bud Light	1	7/29/2024 2:31 PM	2026-03-17 14:10:43.490314
4793	jcannamucio	ATKINSON RESORT AND COUNTRY CLUB	Large Tap Marker	Shipyard - Pumpkin Head	1	7/29/2024 1:37 PM	2026-03-17 14:10:43.493941
4794	jmorse	POOR THOMS TAVERN	Large Tap Marker	Weihenstephaner - Hefe	1	7/29/2024 12:57 PM	2026-03-17 14:10:43.49691
4795	amartin	ODD FELLOWS BREWING COMPANY	Large Tap Marker	Carlson - Oak Hill	2	7/29/2024 12:17 PM	2026-03-17 19:05:56.764554
4797	rconstant	PASSACONAWAY COUNTRY CLUB	Large Tap Marker	Founders - All Day IPA	1	7/25/2024 3:36 PM	2026-03-17 14:10:43.788214
4817	jgrumblatt	NEWPORT VETERAN'S CLUB	Large Tap Marker	Stella Artois	2	7/23/2024 4:44 PM	2026-03-17 19:05:56.767119
4826	jaustin	CHILI'S - KEENE	Large Tap Marker	Kona - Big Wave	2	7/18/2024 2:07 PM	2026-03-17 19:05:56.769801
4800	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	von Trapp - Radler	1	7/25/2024 2:46 PM	2026-03-17 14:10:43.797083
4847	jsewall	LEBANON VILLAGE PIZZA	Large Tap Marker	New Belgium - Juicy Haze	3	7/11/2024 11:25 AM	2026-03-17 19:05:56.772067
4805	lortiz	NOT YOUR AVERAGE JOE'S	Large Tap Marker	Sea Dog - Blueberry	1	7/25/2024 2:25 PM	2026-03-17 14:10:43.818448
4806	jmeharg	DANIEL'S PUB INC	Large Tap Marker	Henniker - Ambr App	1	7/25/2024 12:51 PM	2026-03-17 14:10:43.82149
4808	pbelanger	MAMA MCDONOUGH'S IRISH PUB	Large Tap Marker	Concord Craft - Safe Space	1	7/25/2024 10:44 AM	2026-03-17 14:10:43.827588
4809	ggage	GATE CITY CASINO	Large Tap Marker	603 Brew - IPA	1	7/25/2024 9:41 AM	2026-03-17 14:10:43.830779
4812	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Wormtown - Be Hoppy	1	7/24/2024 2:04 PM	2026-03-17 14:10:43.839882
4813	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	New Belgium - Fat Tire	1	7/24/2024 2:04 PM	2026-03-17 14:10:43.843184
4814	amartin	SPECTACLE MANAGEMENT INC	Large Tap Marker	Kona - Big Wave	1	7/24/2024 1:41 PM	2026-03-17 14:10:43.845922
4816	pbelanger	WAL-MART #2057 - RINDGE	Large Tap Marker	Concord Craft - White Mtn White	1	7/24/2024 12:11 PM	2026-03-17 14:10:43.851712
4818	pwollert	MADAME SHERRI'S	Large Tap Marker	Downeast - Original	1	7/23/2024 2:56 PM	2026-03-17 14:10:43.857504
4820	ggage	CHRYSANTHI'S	Large Tap Marker	Sea Dog - Sun Fish	1	7/23/2024 1:54 PM	2026-03-17 14:10:43.86343
4821	sshaunessy	HAMPSHIRE HILLS S&F CLUB	Large Tap Marker	Concord Craft - Four Rivers	1	7/23/2024 11:26 AM	2026-03-17 14:10:43.866974
4827	jsewall	TACOS Y TEQUILA HANOVER	Large Tap Marker	Henniker - Wrking Man Porter	1	7/18/2024 11:25 AM	2026-03-17 14:10:43.889341
4828	ddooling	T-BONES - SALEM	Large Tap Marker	Concord Craft - Four Rivers	1	7/18/2024 9:56 AM	2026-03-17 14:10:43.892094
4829	jaustin	MAIN CRUST CO.	Large Tap Marker	Wicked Weed Pernicious Haze	1	7/17/2024 3:37 PM	2026-03-17 14:10:43.895495
4830	jaustin	MAIN CRUST CO.	Large Tap Marker	Widowmaker - Blue Comet	1	7/17/2024 3:37 PM	2026-03-17 14:10:43.8988
4831	jmeharg	MOLLY'S TAVERN & RESTAURANT	Large Tap Marker	Newburyport - Plum Island	1	7/17/2024 3:16 PM	2026-03-17 14:10:43.902799
4835	pbelanger	EMMAS 321	Large Tap Marker	Widowmaker - Blue Comet	1	7/17/2024 12:51 PM	2026-03-17 14:10:43.917298
4836	pbelanger	EMMAS 321	Large Tap Marker	Zero Gravity - Pisolino	1	7/17/2024 12:51 PM	2026-03-17 14:10:43.920344
4837	ddooling	SEVMAR MEDITERRANEAN BISTRO	Large Tap Marker	Mich Ultra	1	7/17/2024 11:55 AM	2026-03-17 14:10:43.924242
4840	ggage	OLDE KILKENNY PUB	Large Tap Marker	603 Brew - Summa	1	7/16/2024 2:52 PM	2026-03-17 14:10:43.935028
4841	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	BBCO - Elaborate	1	7/16/2024 9:16 AM	2026-03-17 14:10:43.939022
4842	jcannamucio	THE NEST PUB AND GRILL	Large Tap Marker	Kona - Big Wave	1	7/15/2024 12:59 PM	2026-03-17 14:10:43.942036
4843	jcannamucio	CARRIAGE TOWN BAR & GRILL	Large Tap Marker	Kona - Big Wave	1	7/15/2024 12:35 PM	2026-03-17 14:10:43.94516
4844	amartin	LA HACIENDA DEL RIO	Large Tap Marker	Zero Gravity - Cone Head Haze	1	7/11/2024 4:06 PM	2026-03-17 14:10:43.948038
4846	jaustin	GUERRILLA GRILL	Large Tap Marker	Woodland - Ruby Slippers	1	7/11/2024 2:52 PM	2026-03-17 14:10:43.954151
4882	jgrumblatt	STOCKWELL RESTAURANT	Large Tap Marker	Kona - Big Wave	2	6/26/2024 2:50 PM	2026-03-17 19:05:56.774787
4852	lnorton	WINDHAM RESTAURANT (THE)	Large Tap Marker	21 Amend - Hell High Water	1	7/10/2024 1:27 PM	2026-03-17 14:10:43.973511
4854	jaustin	APPLEBEES - KEENE #6714	Large Tap Marker	Sea Dog - Blueberry	1	7/9/2024 2:57 PM	2026-03-17 14:10:43.979883
4859	amartin	SAN FRANCISCO KITCHEN INC	Large Tap Marker	Mighty Squirrel - Magic Rain	1	7/3/2024 2:10 PM	2026-03-17 14:10:43.995798
4860	ddooling	TIO JUAN'S MARGARITAS MEXICAN REST-SALEM	Large Tap Marker	Kona - Big Wave	1	7/3/2024 2:02 PM	2026-03-17 14:10:43.998974
4865	pbelanger	EMMAS 321	Large Tap Marker	Henniker - Ambr App	1	7/3/2024 5:37 AM	2026-03-17 14:10:44.014607
4867	jsewall	ARIANA'S RESTAURANT	Large Tap Marker	Stoneface - IPA	1	7/1/2024 3:15 PM	2026-03-17 14:10:44.020403
4868	jsewall	ARIANA'S RESTAURANT	Large Tap Marker	603 Brew - Summa	1	7/1/2024 3:15 PM	2026-03-17 14:10:44.023666
4869	jjohnson	MOLLYS RESTAURANT	Large Tap Marker	603 Brew - Summa	1	7/1/2024 2:39 PM	2026-03-17 14:10:44.02756
4873	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Large Tap Marker	Captain Eli's	1	6/27/2024 3:23 PM	2026-03-17 14:10:44.04008
4874	jaustin	GUERRILLA GRILL	Large Tap Marker	Austin Street - Anniversary	1	6/27/2024 3:15 PM	2026-03-17 14:10:44.042909
4875	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Fiddlehead - IPA	1	6/27/2024 1:47 PM	2026-03-17 14:10:44.046013
4876	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	603 Brew - Summa	1	6/27/2024 1:47 PM	2026-03-17 14:10:44.049007
4879	jjohnson	AMERICAN LEGION POST 22 - GRAFTON	Large Tap Marker	603 Brew - Summa	1	6/27/2024 10:26 AM	2026-03-17 14:10:44.057901
4881	pbelanger	MEXICA MEXICAN RESTAURANT	Large Tap Marker	Equilibrium - POG Bubbles	1	6/26/2024 4:43 PM	2026-03-17 14:10:44.063868
4885	pbelanger	WEST OF THE BORDER	Large Tap Marker	Upper Pass - First Drop	1	6/26/2024 1:07 PM	2026-03-17 14:10:44.07526
4886	pbelanger	WEST OF THE BORDER	Large Tap Marker	Frost - Starchild	1	6/26/2024 1:07 PM	2026-03-17 14:10:44.077944
4889	jaustin	MAIN CRUST CO.	Large Tap Marker	Zero Gravity - Cone Head Haze	1	6/26/2024 11:16 AM	2026-03-17 14:10:44.086839
4891	jaustin	A-1 PIZZA & GRILL HINSDALE	Large Tap Marker	Downeast - Peach Mango	1	6/25/2024 11:37 AM	2026-03-17 14:10:44.092974
4892	lortiz	CHILI'S - NASHUA - DW HWY	Large Tap Marker	Downeast - Original	1	6/24/2024 3:54 PM	2026-03-17 14:10:44.09625
4893	jjohnson	ZIGGY'S PIZZA - W. LEB	Large Tap Marker	14th Star - Tribute	1	6/24/2024 3:41 PM	2026-03-17 14:10:44.099681
4894	jmorse	AMERICAN LEGION POST 29 - CLAREMONT	Large Tap Marker	Stella Artois	1	6/24/2024 2:55 PM	2026-03-17 14:10:44.102359
4895	jjohnson	MURPHY'S ON THE GREEN	Large Tap Marker	von Trapp - Pilsner	1	6/24/2024 2:34 PM	2026-03-17 14:10:44.105399
4896	jmeharg	AMERICAN LEGION POST 59 - HILLSBORO	Large Tap Marker	Sea Dog - Blueberry	1	6/24/2024 12:36 PM	2026-03-17 14:10:44.10813
4897	ggage	ROUTE 13 STATELINE CONV MART	Large Tap Marker	Concord Craft - Safe Space	1	6/20/2024 3:29 PM	2026-03-17 14:10:44.11147
4898	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Exhibit A - Panda Punch	1	6/20/2024 1:52 PM	2026-03-17 14:10:44.114449
4899	rconstant	HUDSONS NORTH SIDE GRILLE	Large Tap Marker	Austin Street - Offset	1	6/20/2024 1:52 PM	2026-03-17 14:10:44.117714
4900	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Mighty Squirrel - Sour Face	1	6/20/2024 1:29 PM	2026-03-17 14:10:44.120545
4903	lortiz	NOT YOUR AVERAGE JOE'S	Large Tap Marker	603 Brew - Summa	1	6/20/2024 1:19 PM	2026-03-17 14:10:44.13009
4904	jaustin	GUERRILLA GRILL	Large Tap Marker	Upper Pass - First Drop	1	6/20/2024 1:11 PM	2026-03-17 14:10:44.133063
4905	jaustin	GUERRILLA GRILL	Large Tap Marker	Zero Gravity - Cone Head Haze	1	6/20/2024 1:11 PM	2026-03-17 14:10:44.135916
4907	pbelanger	MAMA MCDONOUGH'S IRISH PUB	Large Tap Marker	Tuckerman - Pale Ale	1	6/20/2024 11:25 AM	2026-03-17 14:10:44.141322
4908	jmeharg	RUSTIC ROSE TAVERN	Large Tap Marker	603 Brew - Hard Seltzer	1	6/20/2024 9:21 AM	2026-03-17 14:10:44.143742
4942	jaustin	TEMPESTA'S	Other	Downeast - Pomegranate	3	3/11/2026 2:11 PM	2026-03-17 19:05:56.777921
4955	rconstant	HUDSONS NORTH SIDE GRILLE	Other	Nutrl	2	1/28/2026 12:24 PM	2026-03-17 19:05:56.780404
4957	rconstant	AJ'S SPORTS BAR & GRILL	Other	Bud Light	3	1/22/2026 3:32 PM	2026-03-17 19:05:56.782833
4959	jmorse	CASA JALISCO BAR & GRILL	Other	Dos Equis	3	1/20/2026 10:28 AM	2026-03-17 19:05:56.785626
4913	jaustin	MAIN CRUST CO.	Large Tap Marker	Stoneface - Duderino	1	6/19/2024 10:46 AM	2026-03-17 14:10:44.167459
4914	jaustin	MAIN CRUST CO.	Large Tap Marker	Stoneface - DDH Full Clip	1	6/19/2024 10:46 AM	2026-03-17 14:10:44.170014
4966	jmorse	TAVERNE ON THE SQUARE LLC	Other	Mich Ultra	2	1/5/2026 3:32 PM	2026-03-17 19:05:56.788385
4972	jaustin	BRICKHOUSE PIZZA & WINGS	Other	Downeast - Winter	2	12/23/2025 12:54 PM	2026-03-17 19:05:56.790639
4919	jmorse	TAVERNE ON THE SQUARE LLC	Large Tap Marker	Lord Hobo - Boomsauce	1	6/18/2024 2:05 PM	2026-03-17 14:10:44.184847
4920	pbelanger	ARLINGTON INN & TAVERN (THE)	Large Tap Marker	Tuckerman - Pale Ale	1	6/18/2024 12:49 PM	2026-03-17 14:10:44.187437
4921	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Zero Gravity - Cone Head	1	6/18/2024 9:22 AM	2026-03-17 14:10:44.190586
4922	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Maine Beer Co - Lunch	1	6/18/2024 9:22 AM	2026-03-17 14:10:44.193083
4923	jmorse	TREMONT HOUSE OF PIZZA	Large Tap Marker	Concord Craft - Safe Space	1	6/18/2024 9:22 AM	2026-03-17 14:10:44.195989
4925	rconstant	TWINS SMOKE SHOP	Large Tap Marker	603 Brew - As You Wish	1	6/17/2024 1:52 PM	2026-03-17 14:10:44.202064
4926	rconstant	TWINS SMOKE SHOP	Large Tap Marker	Kentucky - Vanilla Cream	1	6/17/2024 1:52 PM	2026-03-17 14:10:44.204694
4933	jmeharg	COUNTRY SPIRIT RESTAURANT & TAVERN	Large Tap Marker	Henniker - Trail Buddy	1	6/13/2024 4:35 AM	2026-03-17 14:10:44.226718
4934	jgrumblatt	WILDWOOD SMOKEHOUSE	Large Tap Marker	Maine Beer Co - Lunch	1	6/12/2024 3:57 PM	2026-03-17 14:10:44.229419
4935	ggage	OLDE KILKENNY PUB	Large Tap Marker	Wormtown - Beach Fix	1	6/12/2024 3:51 PM	2026-03-17 14:10:44.232626
4938	maanderson	T-BONES - HUDSON	Large Tap Marker	Fiddlehead - IPA	1	6/12/2024 11:19 AM	2026-03-17 14:10:44.249569
4939	jmeharg	ANTRIM MARKET	Mirror	Bud Light	1	1/28/2026 10:55 AM	2026-03-17 14:10:44.253115
4940	eleahy	CUMBERLAND FM #5545 - PLAISTOW	Mirror	BeatBox Vrty	1	2/17/2025 8:24 AM	2026-03-17 14:10:44.256274
4941	rconstant	PASSACONAWAY COUNTRY CLUB	Mirror	Budweiser	1	9/5/2024 3:50 PM	2026-03-17 14:10:44.259649
4943	maanderson	GAGE HILL FARM	Other	Bud Light	1	3/3/2026 11:21 AM	2026-03-17 14:10:44.26879
4944	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Other	Kona - Big Wave	1	3/3/2026 9:10 AM	2026-03-17 14:10:44.271975
4945	amartin	T&T WAY	Other	Dos Equis	1	2/26/2026 4:11 PM	2026-03-17 14:10:44.275493
4946	jgrumblatt	PETER CHRISTIANS TAVERN	Other	Concord Craft - White Mtn White	1	2/25/2026 2:30 PM	2026-03-17 14:10:44.279367
4947	rconstant	COACH STOP	Other	Nutrl	1	2/18/2026 11:36 AM	2026-03-17 14:10:44.282949
4948	jaustin	BRICKHOUSE PIZZA & WINGS	Other	Downeast - Pomegranate	1	2/11/2026 2:06 PM	2026-03-17 14:10:44.288075
4949	maanderson	PINE VALLEY GOLF COURSE	Other	Nutrl	1	2/10/2026 10:03 AM	2026-03-17 14:10:44.291203
4950	rconstant	HANNAFORD #8185 - LONDERY	Other	Mich Ultra	1	2/9/2026 10:48 AM	2026-03-17 14:10:44.297695
4951	jaustin	DIPLOMAT (THE)	Other	Downeast - Prickly Pear	1	2/5/2026 2:11 PM	2026-03-17 14:10:44.301088
4952	pwollert	AMERICAN LEGION POST 4 - KEENE	Other	Mich Ultra	1	2/4/2026 7:43 AM	2026-03-17 14:10:44.304608
4953	tchagnon	JADE DRAGON-MERRIMACK	Other	Budweiser	1	2/3/2026 12:35 PM	2026-03-17 14:10:44.308069
4954	pbelanger	MONADNOCK COUNTRY CLUB	Other	Bud Light	1	2/3/2026 11:13 AM	2026-03-17 14:10:44.311257
4956	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Other	Mich Ultra	1	1/27/2026 2:12 PM	2026-03-17 14:10:44.318962
4958	jgrumblatt	PETER CHRISTIANS TAVERN	Other	Concord Craft - Pond Hockey	1	1/21/2026 1:59 PM	2026-03-17 14:10:44.325968
4960	jaustin	LAB'N LAGER KEENE	Other	Bud Light	1	1/19/2026 3:10 PM	2026-03-17 14:10:44.335169
4961	jaustin	KILKENNY PUB - KEENE	Other	603 Brew - Winni	1	1/19/2026 1:09 PM	2026-03-17 14:10:44.339519
4962	jaustin	DIPLOMAT (THE)	Other	Concord Craft - White Mtn White	1	1/8/2026 3:34 PM	2026-03-17 14:10:44.34494
4963	rconstant	PROFESSOR SPORTS PUB	Other	Nutrl	1	1/8/2026 3:01 PM	2026-03-17 14:10:44.349818
4964	ddooling	HOWIE GLYNN - DERRY	Other	MISC Encompass Conv Items	1	1/7/2026 11:47 AM	2026-03-17 14:10:44.354791
4965	jaustin	TROY DELI & MARKET PLACE	Other	Bud Light	1	1/7/2026 11:42 AM	2026-03-17 14:10:44.361753
4967	jaustin	CHILI'S - KEENE	Other	Downeast - Blackberry	1	1/5/2026 12:22 PM	2026-03-17 14:10:44.368309
4968	jaustin	GUERRILLA GRILL	Other	Downeast - Pumpkin	1	12/31/2025 11:08 AM	2026-03-17 14:10:44.371066
4969	jmeharg	WASHINGTON GENERAL STORE REST	Other	Bud Light	1	12/30/2025 1:29 PM	2026-03-17 14:10:44.374705
4970	jsewall	SHAW'S #4555 - W.LEB	Other	Sparkling Ice	1	12/30/2025 7:29 AM	2026-03-17 14:10:44.377558
4971	maanderson	JUKK INC	Other	Fiddlehead - IPA	1	12/29/2025 9:13 AM	2026-03-17 14:10:44.380807
4974	jmorse	NEWPORT MEAT MARKET	Other	Cabot	1	12/23/2025 9:27 AM	2026-03-17 14:10:44.389795
4975	jmorse	SHOP EXPRESS	Other	Cabot	1	12/23/2025 7:22 AM	2026-03-17 14:10:44.393042
4978	jaustin	TEMPESTA'S	Other	Downeast - Winter	1	12/17/2025 3:59 PM	2026-03-17 14:10:44.400598
4979	jaustin	CHILI'S - KEENE	Other	Downeast - Cranberry	1	12/15/2025 11:21 AM	2026-03-17 14:10:44.40356
4980	jgrumblatt	RAGGED MOUNTAIN	Other	Bud Light	1	12/10/2025 10:08 AM	2026-03-17 14:10:44.407019
4981	tchagnon	SHAW'S #0678 - MERRIMACK - CONTINENTAL	Other	Good 2 grow	1	12/10/2025 9:01 AM	2026-03-17 14:10:44.410521
4982	amartin	BACKSTREET BAR & GRILL LLC	Other	Bud Light	1	12/4/2025 2:53 PM	2026-03-17 14:10:44.413066
4983	scamuso	NASHUA CONVENIENCE	Other	Budweiser	1	12/4/2025 10:18 AM	2026-03-17 14:10:44.415983
4985	pbelanger	MR MIKE'S - FITZWILLIAM	Other	Good 2 grow	1	12/1/2025 3:04 PM	2026-03-17 14:10:44.421129
4986	jsewall	NH-VT SMOKE & BEVERAGE OUTLET INC	Other	Bud Light	1	12/1/2025 9:26 AM	2026-03-17 14:10:44.423756
4987	jaustin	DIPLOMAT (THE)	Other	Downeast - Cranberry	1	11/26/2025 12:38 PM	2026-03-17 14:10:44.42661
4988	jgrumblatt	PETER CHRISTIANS TAVERN	Other	Bud Light	1	11/25/2025 12:25 PM	2026-03-17 14:10:44.428946
4989	jgrumblatt	VAIL RESORT/ MOUNT SUNAPEE	Other	Nutrl	1	11/22/2025 10:31 AM	2026-03-17 14:10:44.431782
4990	jgrumblatt	VAIL RESORT/ MOUNT SUNAPEE	Other	Mich Ultra	1	11/22/2025 10:31 AM	2026-03-17 14:10:44.434056
4991	jgrumblatt	VAIL RESORT/ MOUNT SUNAPEE	Other	Bud Light	1	11/22/2025 10:31 AM	2026-03-17 14:10:44.436909
4992	jmorse	MARKET BASKET #53 CLAREMNT	Other	Mich Ultra	1	11/20/2025 9:49 AM	2026-03-17 14:10:44.439954
4993	jmorse	JIFFY MART #200431 - CLAREMONT	Other	Bud Light	1	11/20/2025 6:04 AM	2026-03-17 14:10:44.443276
4994	jmeharg	BRADFORD MARKET	Other	Bud Light	1	11/18/2025 9:36 AM	2026-03-17 14:10:44.445758
4995	jaustin	KEENE COUNTRY CLUB INC	Other	Bud Light	1	11/13/2025 3:39 PM	2026-03-17 14:10:44.448938
4998	rconstant	PATRIOT GAS	Other	Natty Daddy	1	11/11/2025 12:27 PM	2026-03-17 14:10:44.457845
4999	jaustin	A-1 PIZZA & GRILL HINSDALE	Other	Downeast - Cranberry	1	11/4/2025 3:09 PM	2026-03-17 14:10:44.461408
4976	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Other	Athletic - Run Wild	2	12/18/2025 10:18 AM	2026-03-17 19:05:56.79287
5001	jaustin	CHILI'S - KEENE	Other	Downeast - Caramel Apple	1	11/3/2025 11:23 AM	2026-03-17 14:10:44.470195
5002	jmorse	CLAREMONT MOBIL	Other	Bud Light	1	10/30/2025 2:10 PM	2026-03-17 14:10:44.472774
5004	bgermano	SEVEN ELEV #32504 B- KEENE	Other	Bud Light	1	10/28/2025 12:10 PM	2026-03-17 14:10:44.478514
5005	jaustin	BRICKHOUSE PIZZA & WINGS	Other	Downeast - Caramel Apple	1	10/23/2025 12:13 PM	2026-03-17 14:10:44.481839
4977	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Other	Heineken	2	12/18/2025 10:18 AM	2026-03-17 19:05:56.918102
5007	rconstant	SEVEN ELEV #32502 - LITCHFIELD	Other	Phorm Energy Freedom	1	10/16/2025 12:50 PM	2026-03-17 14:10:44.487838
5008	rconstant	SEVEN ELEV #32502 - LITCHFIELD	Other	Natty Daddy	1	10/16/2025 12:50 PM	2026-03-17 14:10:44.490794
5009	jaustin	RTE. 63 COUNTRY STORE	Other	Mich Ultra	1	10/16/2025 11:18 AM	2026-03-17 14:10:44.494169
5011	jaustin	AMERICAN LEGION POST 4 - KEENE	Other	Budweiser	1	10/15/2025 10:23 AM	2026-03-17 14:10:44.499739
5012	pbelanger	STATELINE GROCERY'S	Other	Busch Light	1	10/13/2025 12:38 PM	2026-03-17 14:10:44.503102
5014	jgiuffrida	MARKET BASKET #31 SALEM	Other	Popwell	1	10/9/2025 2:49 PM	2026-03-17 14:10:44.508829
5015	ddooling	TIO JUAN'S MARGARITAS MEXICAN REST-SALEM	Other	Dos Equis	1	10/9/2025 1:37 PM	2026-03-17 14:10:44.513605
5016	ddooling	BEER STORE LLC (THE) - SALEM	Other	Gold Road Mango Cart	1	10/9/2025 1:37 PM	2026-03-17 14:10:44.516329
5018	jaustin	GUERRILLA GRILL	Other	Stoneface - Crown Shy	1	10/8/2025 12:53 PM	2026-03-17 14:10:44.523007
5020	jaustin	GET-N-GO	Other	Bud Light	1	10/7/2025 12:03 PM	2026-03-17 14:10:44.528697
5021	jaustin	DIPLOMAT (THE)	Other	Heineken	1	10/2/2025 12:56 PM	2026-03-17 14:10:44.531918
5022	ddooling	SEVMAR MEDITERRANEAN BISTRO	Other	Mich Ultra	1	10/1/2025 3:00 PM	2026-03-17 14:10:44.534712
5023	ddooling	HOWIE GLYNN - DERRY	Other	Bud Light	1	10/1/2025 2:13 PM	2026-03-17 14:10:44.537992
5024	jgrumblatt	NEWBURY DELI	Other	Athletic - Upside Dawn	1	9/30/2025 12:06 PM	2026-03-17 14:10:44.540807
5025	jmorse	RAMUNTOS - CLAREMONT	Other	Downeast - Original	1	9/29/2025 1:19 PM	2026-03-17 14:10:44.544256
5026	jmorse	THE 12% SOLUTION	Other	Clearly Canadian Mountain Blackberry	1	9/29/2025 10:08 AM	2026-03-17 14:10:44.54692
5027	jmorse	FORBES TAVERN AND EVENTS	Other	Fiddlehead - IPA	1	9/24/2025 3:19 PM	2026-03-17 14:10:44.550428
5029	jjohnson	SNAX	Other	Downeast - Cider Donut	1	9/22/2025 1:23 PM	2026-03-17 14:10:44.556321
5030	jmorse	THE 12% SOLUTION	Other	Clearly Canadian Country Raspberry	1	9/22/2025 10:15 AM	2026-03-17 14:10:44.55885
5031	jgiuffrida	99 REST - SALEM	Other	Stella Artois	1	9/22/2025 9:49 AM	2026-03-17 14:10:44.561988
5032	ddooling	PELHAM STREET BLACK WATER GRILL	Other	Mich Ultra	1	9/18/2025 1:22 PM	2026-03-17 14:10:44.564521
5033	amartin	LYNN'S 102 TAVERN	Other	Bud Light	1	9/18/2025 1:11 PM	2026-03-17 14:10:44.567903
5034	jaustin	THE PERCH	Other	Dos Equis	1	9/18/2025 11:26 AM	2026-03-17 14:10:44.57035
5039	rconstant	RENEGADES PUB	Other	Mich Ultra	1	9/2/2025 12:02 PM	2026-03-17 14:10:44.585671
4984	jaustin	TEMPESTA'S	Other	Downeast - Cranberry	2	12/3/2025 2:34 PM	2026-03-17 19:05:56.925093
4996	jaustin	GUERRILLA GRILL	Other	Downeast - Caramel Apple	2	11/13/2025 12:53 PM	2026-03-17 19:05:56.928496
4997	jaustin	MAIN CRUST CO.	Other	Henniker - Flap Jack	2	11/12/2025 4:24 PM	2026-03-17 19:05:56.931409
5003	jaustin	GUERRILLA GRILL	Other	Downeast - Cranberry	2	10/30/2025 1:45 PM	2026-03-17 19:05:56.933969
5010	jaustin	MINUTE MART	Other	Mich Ultra	2	10/15/2025 11:08 AM	2026-03-17 19:05:56.936499
5013	tchagnon	MARKET BASKET #33 HUDSON	Other	Sparkling Ice	2	10/9/2025 3:46 PM	2026-03-17 19:05:56.939566
5017	jsewall	99 REST - W.LEB	Other	Stella Artois	2	10/9/2025 8:54 AM	2026-03-17 19:05:56.942262
5019	jmorse	DADDY'S PIZZA	Other	Mich Ultra	2	10/7/2025 1:45 PM	2026-03-17 19:05:56.944901
5028	jmorse	RAMUNTOS - CLAREMONT	Other	Fiddlehead - IPA	3	9/22/2025 1:42 PM	2026-03-17 19:05:56.947598
5035	scamuso	HALUWA	Other	Bud Light	2	9/11/2025 12:09 PM	2026-03-17 19:05:56.951812
5036	rconstant	AJ'S SPORTS BAR & GRILL	Other	Mich Ultra	3	9/10/2025 11:37 AM	2026-03-17 19:05:56.954375
5037	jmorse	TAVERNE ON THE SQUARE LLC	Other	Fiddlehead - IPA	2	9/5/2025 12:47 PM	2026-03-17 19:05:56.95759
5038	tchagnon	MARKET BASKET #33 HUDSON	Other	Shipyard - Pumpkin Head	3	9/2/2025 2:28 PM	2026-03-17 19:05:56.959987
5040	jmorse	THE 12% SOLUTION	Other	Budweiser	3	8/31/2025 9:30 AM	2026-03-17 19:05:56.963218
5041	jgrumblatt	CIRCLE K #7247 - ANDOVER	Other	Bud Light	3	8/27/2025 11:58 AM	2026-03-17 19:05:56.965653
5042	jmeharg	U.S. 202 EXPRESS MINI MART INC	Other	Arizona	2	8/27/2025 9:35 AM	2026-03-17 19:05:56.968058
5043	jmorse	DADDY'S PIZZA	Other	Bud Light	1	8/26/2025 1:37 PM	2026-03-17 14:10:44.598996
5044	pwollert	KEENE DISCOUNT MART	Other	Fiddlehead - IPA	2	8/26/2025 12:33 PM	2026-03-17 14:10:44.602382
5047	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Other	Shipyard - Pumpkin Head	2	8/14/2025 9:30 AM	2026-03-17 19:05:56.970454
5050	tchagnon	MARKET BASKET #33 HUDSON	Other	Bud Light	2	8/8/2025 2:13 PM	2026-03-17 19:05:56.973687
5063	rconstant	STUMBLE INN BAR & GRILL	Other	Mich Ultra	2	7/1/2025 3:56 PM	2026-03-17 19:05:56.976228
5049	rconstant	RENEGADES PUB	Other	Nutrl	1	8/12/2025 12:18 PM	2026-03-17 14:10:44.617313
5067	jmorse	FORBES TAVERN AND EVENTS	Other	Mich Ultra	2	6/18/2025 12:15 PM	2026-03-17 19:05:56.978701
5052	rconstant	WHIP-POOR WILL GOLF CLUB	Other	Nutrl	1	7/24/2025 2:21 PM	2026-03-17 14:10:44.626552
5053	rconstant	AJ'S SPORTS BAR & GRILL	Other	Nutrl	1	7/21/2025 1:49 PM	2026-03-17 14:10:44.628917
5054	tchagnon	HANNAFORD #8015 - PELHAM	Other	Sparkling Ice	1	7/21/2025 6:57 AM	2026-03-17 14:10:44.632179
5055	jmorse	WAL-MART #1975 - CLAREMONT	Other	Mich Ultra	1	7/17/2025 2:42 PM	2026-03-17 14:10:44.63555
5056	rconstant	HIDDEN CREEK COUNTRY CLUB	Other	Mich Ultra	1	7/16/2025 5:40 PM	2026-03-17 14:10:44.638136
5057	ddooling	SALEM CONVENIENCE STORE	Other	MISC Encompass Conv Items	1	7/15/2025 11:30 AM	2026-03-17 14:10:44.641217
5089	jmorse	RAMUNTOS - CLAREMONT	Other	Bud Light	3	5/19/2025 1:13 PM	2026-03-17 19:05:56.981309
5098	jsewall	HANNAFORD #8266 - W.LEB	Other	Bud Light	2	5/1/2025 11:59 AM	2026-03-17 19:05:56.984144
5060	amartin	HANNAFORD #8183 - HUDSON	Other	Bud Light	1	7/3/2025 1:01 PM	2026-03-17 14:10:44.649722
5061	maanderson	TOBACCO JUNCTION - HUDSON	Other	Good Boy J Daly	1	7/2/2025 9:47 AM	2026-03-17 14:10:44.652296
5062	rconstant	STUMBLE INN BAR & GRILL	Other	Kona - Big Wave	1	7/1/2025 3:56 PM	2026-03-17 14:10:44.654749
5064	rconstant	HANNAFORD #8185 - LONDERY	Other	Sparkling Ice	1	6/30/2025 11:27 AM	2026-03-17 14:10:44.659894
5065	lnorton	PRESSED CAFE - BEDFORD	Other	Nutrl	1	6/26/2025 2:19 PM	2026-03-17 14:10:44.662693
5066	jmeharg	MOLLY'S TAVERN & RESTAURANT	Other	Nutrl	1	6/25/2025 4:38 AM	2026-03-17 14:10:44.665312
5068	jaustin	APPLEBEES - KEENE #6714	Other	Dos Equis	1	6/17/2025 1:29 PM	2026-03-17 14:10:44.670692
5069	sshaunessy	AMERICAN LEGION POST 11 - JAFFREY	Other	Mich Ultra	1	6/17/2025 1:02 PM	2026-03-17 14:10:44.673507
5070	maanderson	PINE VALLEY GOLF COURSE	Other	Mich Ultra	1	6/17/2025 9:20 AM	2026-03-17 14:10:44.676161
5071	rconstant	SHAW'S #0484 - LONDERRY	Other	Sparkling Ice	1	6/16/2025 1:16 PM	2026-03-17 14:10:44.67884
5072	jmorse	WAL-MART #1975 - CLAREMONT	Other	Bud Light	1	6/12/2025 2:35 PM	2026-03-17 14:10:44.68163
5073	jaustin	GUERRILLA GRILL	Other	Mich Ultra	1	6/12/2025 2:16 PM	2026-03-17 14:10:44.684369
5074	ddooling	PRESSED CAFE - SALEM	Other	Nutrl	1	6/12/2025 1:17 PM	2026-03-17 14:10:44.686907
5075	maanderson	NATIONAL CLUB (THE)	Other	Bud Light	1	6/12/2025 12:49 PM	2026-03-17 14:10:44.689679
5101	jaustin	MARGARITA'S - KEENE	Other	Downeast - Pomegranate	2	4/24/2025 2:32 PM	2026-03-17 19:05:57.000607
5106	rconstant	STUMBLE INN BAR & GRILL	Other	Bud Light	2	4/21/2025 3:56 PM	2026-03-17 19:05:57.003477
5108	jmorse	WAL-MART #1975 - CLAREMONT	Other	Athletic - Lite	8	4/17/2025 12:47 PM	2026-03-17 19:05:57.00623
5080	jmorse	SUGAR RIVER MARKET & DELI	Other	Phorm Energy Freedom	1	6/11/2025 7:37 AM	2026-03-17 14:10:44.703497
5081	pbelanger	CHA'S GEM SHOP AND CONV	Other	Daily's Cocktails	1	6/10/2025 1:35 PM	2026-03-17 14:10:44.706309
5082	jmorse	AMERICAN LEGION POST 29 - CLAREMONT	Other	Budweiser	1	6/9/2025 2:20 PM	2026-03-17 14:10:44.709473
5083	pbelanger	MEXICA MEXICAN RESTAURANT	Other	Dos Equis	1	6/9/2025 12:41 PM	2026-03-17 14:10:44.712395
5084	rconstant	SEVEN ELEV #32502 - LITCHFIELD	Other	Clubtails	1	6/5/2025 1:28 PM	2026-03-17 14:10:44.715073
5085	jmorse	HANNAFORD #8119 - CLAREMNT	Other	Bud Light	1	6/5/2025 11:42 AM	2026-03-17 14:10:44.718671
5086	sshaunessy	AMERICAN LEGION POST 11 - JAFFREY	Other	Bud Light	1	6/3/2025 12:04 PM	2026-03-17 14:10:44.722554
5087	jmorse	CLAREMONT COUNTRY CLUB	Other	Mich Ultra	1	6/2/2025 4:00 PM	2026-03-17 14:10:44.725617
5090	jmorse	WAL-MART #1975 - CLAREMONT	Other	Fiddlehead - IPA	1	5/15/2025 2:35 PM	2026-03-17 14:10:44.736656
5091	jmorse	CLAREMONT MOBIL	Other	Good 2 grow	1	5/15/2025 1:55 PM	2026-03-17 14:10:44.739489
5092	pbelanger	WHIRLING VAPORS	Other	Bud Light	1	5/15/2025 11:08 AM	2026-03-17 14:10:44.742377
5093	jaustin	MARLBOROUGH CTRY CONVENIENCE	Other	Mich Ultra	1	5/7/2025 12:28 PM	2026-03-17 14:10:44.745228
5094	jaustin	MI JALISCO - KEENE	Other	Dos Equis	1	5/6/2025 1:34 PM	2026-03-17 14:10:44.748652
5095	jaustin	WEST CHESTERFIELD SHELL #200643	Other	Mich Ultra	1	5/6/2025 9:39 AM	2026-03-17 14:10:44.751893
5096	lnorton	PRESSED CAFE - BEDFORD	Other	Fiddlehead - IPA	1	5/1/2025 2:36 PM	2026-03-17 14:10:44.754758
5097	jmorse	HANNAFORD #8119 - CLAREMNT	Other	Sparkling Ice	1	5/1/2025 1:24 PM	2026-03-17 14:10:44.757765
5099	jaustin	GUERRILLA GRILL	Other	Stoneface - Astral Surf	1	4/29/2025 2:41 PM	2026-03-17 14:10:44.764098
5100	rconstant	STUMBLE INN BAR & GRILL	Other	Nutrl	1	4/29/2025 1:30 PM	2026-03-17 14:10:44.766961
5102	jsewall	TACOS Y TEQUILA HANOVER	Other	Dos Equis Amber	1	4/24/2025 9:32 AM	2026-03-17 14:10:44.772264
5103	jmorse	FORBES TAVERN AND EVENTS	Other	Heineken	1	4/23/2025 10:34 AM	2026-03-17 14:10:44.775818
5104	pwollert	MADAME SHERRI'S	Other	Fiddlehead - IPA	1	4/22/2025 10:38 AM	2026-03-17 14:10:44.778612
5105	pwollert	MADAME SHERRI'S	Other	Nutrl	1	4/22/2025 10:38 AM	2026-03-17 14:10:44.78192
5109	rconstant	CONVENIENCE PLUS LONDONDERRY	Other	Bud Light	1	4/14/2025 3:27 PM	2026-03-17 14:10:44.792942
5111	jmorse	WAL-MART #1975 - CLAREMONT	Other	Athletic - Free Wave	1	4/10/2025 11:06 AM	2026-03-17 14:10:44.798758
5112	jaustin	TEMPESTA'S	Other	Mich Ultra	1	4/9/2025 3:04 PM	2026-03-17 14:10:44.801542
5113	jaustin	TEMPESTA'S	Other	Stoneface - IPA	1	4/9/2025 3:04 PM	2026-03-17 14:10:44.804197
5115	rconstant	HANNAFORD #8185 - LONDERY	Other	Sparkling Ice Caf	1	4/9/2025 8:58 AM	2026-03-17 14:10:44.810247
5116	jaustin	BIG DEAL - SPOFFORD	Other	Mich Ultra	1	4/8/2025 3:14 PM	2026-03-17 14:10:44.813633
5117	jgrumblatt	NEWPORT GOLF CLUB	Other	Mich Ultra	1	4/7/2025 3:46 PM	2026-03-17 14:10:44.817619
5118	jgrumblatt	NEWPORT GOLF CLUB	Other	Bud Light	1	4/7/2025 3:46 PM	2026-03-17 14:10:44.822767
5114	jaustin	TEMPESTA'S	Other	Downeast - Peach Mango	2	4/9/2025 3:04 PM	2026-03-17 19:05:57.009454
5120	pbelanger	CHA'S GEM SHOP AND CONV	Other	Nutrl	1	4/3/2025 10:09 AM	2026-03-17 14:10:44.829049
5122	jaustin	A-1 PIZZA & GRILL HINSDALE	Other	Downeast - Peach Mango	1	4/1/2025 12:33 PM	2026-03-17 14:10:44.835886
5123	lnorton	CIRCLE K #7233 - GOFFSTOWN	Other	Mich Ultra	1	4/1/2025 11:53 AM	2026-03-17 14:10:44.839331
5124	maanderson	NASH CASINO	Other	Budweiser	1	3/31/2025 2:37 PM	2026-03-17 14:10:44.843093
5125	rconstant	SHAW'S #0484 - LONDERRY	Other	Mich Ultra	1	3/31/2025 9:53 AM	2026-03-17 14:10:44.846126
5121	jgrumblatt	CIRCLE K #7247 - ANDOVER	Other	Budweiser	2	4/2/2025 12:41 PM	2026-03-17 19:05:57.012378
5128	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Other	Bud Light	1	3/25/2025 12:51 PM	2026-03-17 14:10:44.856846
5129	ddooling	CAMPBELL'S SCOTTISH HIGHLAND GOLF COURSE	Other	Bud Light	1	3/20/2025 11:40 AM	2026-03-17 14:10:44.859752
5130	jgrumblatt	CIRCLE K #7247 - ANDOVER	Other	Mich Ultra	1	3/19/2025 11:55 AM	2026-03-17 14:10:44.862462
5131	jgrumblatt	NEWPORT VETERAN'S CLUB	Other	Bud Light	1	3/18/2025 3:58 PM	2026-03-17 14:10:44.865239
5132	sshaunessy	HAMPSHIRE HILLS S&F CLUB	Other	Bud Light	1	3/18/2025 2:47 PM	2026-03-17 14:10:44.868058
5127	rconstant	99 REST - LONDONDERRY	Other	Bud Light	2	3/27/2025 10:48 AM	2026-03-17 19:05:57.014983
5142	rconstant	HANNAFORD #8185 - LONDERY	Other	Bud Light	2	2/10/2025 9:18 AM	2026-03-17 19:05:57.017427
5135	jaustin	BIG DEAL - SPOFFORD	Other	Budweiser	1	3/10/2025 8:39 AM	2026-03-17 14:10:44.875859
5136	jaustin	T-BIRD MINI MART - HINSDALE	Other	Budweiser	1	3/9/2025 7:31 PM	2026-03-17 14:10:44.878648
5137	jmorse	TREMONT HOUSE OF PIZZA	Other	Nutrl	1	3/4/2025 8:47 AM	2026-03-17 14:10:44.881779
5138	jmeharg	STONEBRIDGE COUNTRY CLUB	Other	Budweiser	1	2/25/2025 11:58 AM	2026-03-17 14:10:44.884542
5139	jmeharg	HANNAFORD #8311 - GOFFSTOWN	Other	Sparkling Ice	1	2/24/2025 4:47 AM	2026-03-17 14:10:44.887329
5143	rconstant	MARKET BASKET #42 LONDERRY	Other	Mich Ultra	2	2/6/2025 12:45 PM	2026-03-17 19:05:57.021018
5141	ddooling	DUSTY'S CONVENIENCE INC.	Other	MISC Encompass Conv Items	1	2/12/2025 3:47 PM	2026-03-17 14:10:44.89407
5144	jaustin	TEMPESTA'S	Other	Busch Light	1	2/5/2025 2:45 PM	2026-03-17 14:10:44.902927
5145	jjohnson	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	Other	Stoneface - Duderino	1	2/4/2025 11:50 AM	2026-03-17 14:10:44.905837
5146	jaustin	GUERRILLA GRILL	Other	Downeast - Pomegranate	1	1/29/2025 2:25 PM	2026-03-17 14:10:44.90846
5147	jsewall	TARGET # 3401 - W. LEBANON	Other	Bud Light	1	1/29/2025 7:26 AM	2026-03-17 14:10:44.911409
5151	rconstant	MARKET BASKET #42 LONDERRY	Other	Athletic - Run Wild	2	1/23/2025 10:30 AM	2026-03-17 19:05:57.023707
5149	jaustin	BIG DEAL - SPOFFORD	Other	Busch	1	1/28/2025 8:12 AM	2026-03-17 14:10:44.917485
5150	jaustin	CHILI'S - KEENE	Other	Downeast - Pomegranate	1	1/27/2025 11:39 AM	2026-03-17 14:10:44.920691
5152	jsewall	REVO CASINO AND SOCIAL HOUSE	Other	Mich Ultra	1	1/20/2025 12:30 PM	2026-03-17 14:10:44.927085
5154	jgrumblatt	MARKET BASKET #53 CLAREMNT	Other	Bud Light	1	1/16/2025 3:19 PM	2026-03-17 14:10:44.932988
5155	jaustin	GUERRILLA GRILL	Other	603 Brew - Knuckle	1	1/16/2025 2:51 PM	2026-03-17 14:10:44.936718
5156	amartin	AMERICAN LEGION POST 3 - NASHUA	Other	Bud Light	1	1/16/2025 1:18 PM	2026-03-17 14:10:44.940241
5157	jaustin	MAIN CRUST CO.	Other	Henniker - Sour Flower	1	1/15/2025 3:08 PM	2026-03-17 14:10:44.944092
5158	maanderson	ACE DISCOUNT CIGARETTES	Other	Bud Light	1	1/7/2025 1:52 PM	2026-03-17 14:10:44.948464
5159	jmorse	RANCHO VIEJO MEXICAN FOOD AND CANTINA	Other	Mich Ultra	1	1/7/2025 1:11 PM	2026-03-17 14:10:44.953139
5160	jmorse	RANCHO VIEJO MEXICAN FOOD AND CANTINA	Other	Dos Equis	1	1/7/2025 1:11 PM	2026-03-17 14:10:44.956798
5162	jmorse	HELEN'S PLACE	Other	von Trapp - Dunkel	1	12/31/2024 12:13 PM	2026-03-17 14:10:44.964776
5153	scamuso	LAFAYETTE CLUB A.C.	Other	Bud Light	2	1/17/2025 11:52 AM	2026-03-17 19:05:57.026349
5161	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Other	Mich Ultra	2	1/6/2025 10:10 AM	2026-03-17 19:05:57.02915
5166	jaustin	GUERRILLA GRILL	Other	Stella Artois	1	12/19/2024 11:08 AM	2026-03-17 14:10:44.978792
5163	jsewall	SALT HILL PUB - LEBANON	Other	Stella Artois	2	12/29/2024 3:06 PM	2026-03-17 19:05:57.032242
5168	jmorse	DADDY'S PIZZA	Other	Nutrl	2	12/17/2024 1:35 PM	2026-03-17 14:10:44.984475
5169	jmorse	RAMUNTOS - CLAREMONT	Other	Mich Ultra	2	12/16/2024 11:18 AM	2026-03-17 14:10:44.987307
5170	jmorse	RAMUNTOS - CLAREMONT	Other	von Trapp - Dunkel	1	12/16/2024 11:18 AM	2026-03-17 14:10:44.99011
5171	jsewall	REVO CASINO AND SOCIAL HOUSE	Other	Misc Keg Other	1	12/9/2024 12:03 PM	2026-03-17 14:10:44.992803
5172	jaustin	MARGARITA'S - KEENE	Other	Downeast - Cranberry	1	12/4/2024 1:23 PM	2026-03-17 14:10:44.995773
5173	jsewall	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	Other	Mich Ultra	1	12/3/2024 1:02 PM	2026-03-17 14:10:44.999593
5174	jaustin	DIPLOMAT (THE)	Other	Downeast - Winter	1	11/27/2024 3:11 PM	2026-03-17 14:10:45.00225
5175	lortiz	BUFFALO WILD WINGS GRILL & BAR - NASHUA	Other	Bud Light	1	11/25/2024 11:57 AM	2026-03-17 14:10:45.005216
5176	jgrumblatt	CIRCLE K #7247 - ANDOVER	Other	Tivoli - Outlaw	1	11/20/2024 12:01 PM	2026-03-17 14:10:45.008231
5177	pwollert	KEENE DISCOUNT MART	Other	Bud Light Next	1	11/19/2024 2:08 PM	2026-03-17 14:10:45.010987
5178	pwollert	RALPH'S SUPERMARKET	Other	Joe Tea	1	11/14/2024 11:13 AM	2026-03-17 14:10:45.013858
5179	jaustin	GUERRILLA GRILL	Other	Downeast - Winter	1	11/7/2024 2:41 PM	2026-03-17 14:10:45.017029
5180	jsewall	APPLEBEES - W.LEB #6732	Other	Stella Artois	1	11/7/2024 10:07 AM	2026-03-17 14:10:45.020355
5181	jsewall	SHAW'S #4555 - W.LEB	Other	Bud Light	1	11/6/2024 3:53 PM	2026-03-17 14:10:45.02331
5182	jaustin	MAIN CRUST CO.	Other	Jack's Abby - Extra Layer	1	11/6/2024 3:19 PM	2026-03-17 14:10:45.035073
5187	jgrumblatt	GD CATERING LLC	Other	Mich Ultra	2	10/28/2024 5:24 PM	2026-03-17 19:05:57.034977
5184	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Other	Bud Light	1	11/4/2024 1:41 PM	2026-03-17 14:10:45.040921
5185	jaustin	GUERRILLA GRILL	Other	603 Brew - Coffee Cake Porter	1	10/31/2024 12:02 PM	2026-03-17 14:10:45.043757
5186	jmorse	CLAREMONT LODGE OF ELKS	Other	Budweiser	1	10/29/2024 3:42 PM	2026-03-17 14:10:45.046796
5188	jgrumblatt	GD CATERING LLC	Other	Budweiser	1	10/28/2024 5:24 PM	2026-03-17 14:10:45.053584
5190	tchagnon	MARKET BASKET #33 HUDSON	Other	Good 2 grow	1	10/25/2024 11:19 AM	2026-03-17 14:10:45.059209
5191	tchagnon	AMERICAN LEGION POST 100 - PELHAM	Other	Budweiser	1	10/22/2024 2:13 PM	2026-03-17 14:10:45.062159
5192	jaustin	BRICKHOUSE PIZZA & WINGS	Other	Downeast - Cranberry	1	10/16/2024 3:37 PM	2026-03-17 14:10:45.065311
5193	amartin	CHICKEN N CHIP'S	Other	Shipyard - Pumpkin Head	1	10/16/2024 2:07 PM	2026-03-17 14:10:45.068251
5194	rconstant	HANNAFORD #8185 - LONDERY	Other	Downeast - Winter	1	10/16/2024 10:15 AM	2026-03-17 14:10:45.071651
5195	jaustin	A-1 PIZZA & GRILL HINSDALE	Other	Henniker - Wrking Man Porter	1	10/15/2024 3:23 PM	2026-03-17 14:10:45.080433
5196	jmorse	CLAREMONT LODGE OF ELKS	Other	Bud Light	1	10/15/2024 1:59 PM	2026-03-17 14:10:45.08401
5197	pbelanger	MAIN STREET MINI MART	Other	Johny Bootlegger	1	10/15/2024 12:11 PM	2026-03-17 14:10:45.08728
5198	rconstant	BEER & WINE NATION - LONDONDERRY	Other	Bud Light	1	10/15/2024 12:04 PM	2026-03-17 14:10:45.090395
5200	jgrumblatt	GD CATERING LLC	Other	Fiddlehead - IPA	1	10/15/2024 9:47 AM	2026-03-17 14:10:45.096906
5201	amartin	SAN FRANCISCO KITCHEN INC	Other	Mich Ultra	1	10/11/2024 11:49 AM	2026-03-17 14:10:45.100232
5202	jgrumblatt	GD CATERING LLC	Other	Stoneface - IPA	1	10/10/2024 5:23 PM	2026-03-17 14:10:45.104237
5203	jaustin	MARGARITA'S - KEENE	Other	Downeast - Blackberry	1	10/10/2024 1:25 PM	2026-03-17 14:10:45.108628
5204	pbelanger	JM NORTH OF THE BORDER	Other	Johny Bootlegger	1	10/9/2024 11:21 AM	2026-03-17 14:10:45.120443
5205	pbelanger	HOMETOWN IRVING	Other	Johny Bootlegger	1	10/9/2024 11:20 AM	2026-03-17 14:10:45.124715
5206	pbelanger	WEST OF THE BORDER	Other	Johny Bootlegger	1	10/9/2024 11:18 AM	2026-03-17 14:10:45.348725
5207	rconstant	BEER & WINE NATION - LONDONDERRY	Other	Johny Bootlegger	1	10/7/2024 1:05 PM	2026-03-17 14:10:45.352804
5189	jgrumblatt	GD CATERING LLC	Other	Bud Light	4	10/28/2024 5:24 PM	2026-03-17 19:05:57.038251
5209	eleahy	SHAW'S #3669 - PLAISTOW	Other	Deep River	1	10/2/2024 8:47 AM	2026-03-17 14:10:45.359823
5210	pbelanger	FAMILY DOLLAR #8262 - WINCHESTER	Other	Bud Light	1	10/1/2024 11:16 AM	2026-03-17 14:10:45.363082
5211	jaustin	CHILI'S - KEENE	Other	603 Brew - Winni	1	9/30/2024 2:33 PM	2026-03-17 14:10:45.367017
5212	ddooling	PEPPERS PUB (NEW)	Other	Shipyard - Pumpkin Head	1	9/26/2024 7:26 AM	2026-03-17 14:10:45.371919
5213	jaustin	BRICKHOUSE PIZZA & WINGS	Other	Downeast - Pumpkin	1	9/19/2024 12:01 PM	2026-03-17 14:10:45.375874
5214	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Other	Downeast - Original	1	9/19/2024 10:28 AM	2026-03-17 14:10:45.379179
5199	jgrumblatt	GD CATERING LLC	Other	Nutrl	3	10/15/2024 9:47 AM	2026-03-17 19:05:57.123808
5234	jmorse	CLAREMONT LODGE OF ELKS	Other	Mich Ultra	2	8/20/2024 2:42 PM	2026-03-17 19:05:57.127087
5217	jsewall	TACOS Y TEQUILA HANOVER	Other	Bud Light	1	9/11/2024 1:59 PM	2026-03-17 14:10:45.390683
5243	jaustin	KILKENNY PUB - KEENE	Other	603 Brew - IPA	2	8/5/2024 1:28 PM	2026-03-17 19:05:57.130043
5219	jmorse	CLAREMONT OPERA HOUSE	Other	Bud Light	1	9/9/2024 11:17 AM	2026-03-17 14:10:45.398861
5221	jmorse	WAL-MART #1975 - CLAREMONT	Other	Athletic - Geralts Gold	1	9/5/2024 10:04 AM	2026-03-17 14:10:45.405875
5222	rconstant	HANNAFORD #8185 - LONDERY	Other	Downeast - Pumpkin	1	9/5/2024 8:53 AM	2026-03-17 14:10:45.411759
5223	jaustin	DIPLOMAT (THE)	Other	Downeast - Cider Donut	1	9/4/2024 3:17 PM	2026-03-17 14:10:45.416897
5224	bgermano	MARKET BASKET #64 SWANZEY	Other	Nutrl Lemonade Vrty	1	8/29/2024 3:35 PM	2026-03-17 14:10:45.420524
5225	rconstant	PASSACONAWAY COUNTRY CLUB	Other	Mich Ultra	1	8/29/2024 3:30 PM	2026-03-17 14:10:45.42445
5226	rconstant	PASSACONAWAY COUNTRY CLUB	Other	Shipyard - Pumpkin Head	1	8/29/2024 3:30 PM	2026-03-17 14:10:45.428068
5227	bgermano	PRICE CHOPPER #208 - KEENE	Other	Shipyard - Pumpkin Head	1	8/29/2024 12:32 PM	2026-03-17 14:10:45.431951
5228	lnorton	MURPHY'S TAPROOM AND CARRIAGE HOUSE	Other	Budweiser	1	8/29/2024 12:22 PM	2026-03-17 14:10:45.434913
5230	jmorse	TREMONT HOUSE OF PIZZA	Other	Mich Ultra	1	8/27/2024 8:49 AM	2026-03-17 14:10:45.441792
5232	tchagnon	HANNAFORD #8015 - PELHAM	Other	Shipyard - Pumpkin Head	1	8/22/2024 2:07 PM	2026-03-17 14:10:45.450249
5233	jmorse	NEWPORT MEAT MARKET	Other	Bud Light	1	8/21/2024 8:13 AM	2026-03-17 14:10:45.453493
5236	jmorse	HELEN'S PLACE	Other	Mich Ultra	1	8/14/2024 2:07 PM	2026-03-17 14:10:45.463546
5237	jaustin	MINUTE MART	Other	Bud Light	1	8/14/2024 10:07 AM	2026-03-17 14:10:45.467076
5238	jmorse	AMERICAN LEGION POST 29 - CLAREMONT	Other	Mich Ultra	1	8/13/2024 2:22 PM	2026-03-17 14:10:45.470415
5239	jmorse	POLISH AMER CITIZENS CLUB-CLAREMONT	Other	Mich Ultra	1	8/13/2024 2:22 PM	2026-03-17 14:10:45.473511
5240	jmorse	CASA JALISCO BAR & GRILL	Other	Mich Ultra	1	8/13/2024 2:20 PM	2026-03-17 14:10:45.477061
5241	jmorse	WAL-MART #1975 - CLAREMONT	Other	Lagunitas - Hoppy Refresher	1	8/8/2024 10:00 AM	2026-03-17 14:10:45.479957
5242	jmorse	TREMONT HOUSE OF PIZZA	Other	Athletic - Upside Dawn	1	8/6/2024 9:06 AM	2026-03-17 14:10:45.483136
5244	jaustin	GUERRILLA GRILL	Other	Downeast - Original	1	8/1/2024 2:11 PM	2026-03-17 14:10:45.488826
5245	jaustin	GUERRILLA GRILL	Other	Downeast - Cider Donut	1	8/1/2024 2:11 PM	2026-03-17 14:10:45.491999
5246	jaustin	GUERRILLA GRILL	Other	603 Brew - Sparkle Bomb	1	8/1/2024 2:11 PM	2026-03-17 14:10:45.494785
5247	jaustin	GUERRILLA GRILL	Other	603 Brew - Summa	1	8/1/2024 2:11 PM	2026-03-17 14:10:45.498264
5248	jgrumblatt	BUBBA'S BAR AND GRILLE	Other	Bud Light	1	8/1/2024 9:11 AM	2026-03-17 14:10:45.501485
5249	jgrumblatt	BUBBA'S BAR AND GRILLE	Other	Nutrl	1	8/1/2024 9:11 AM	2026-03-17 14:10:45.504521
5304	rconstant	99 REST - LONDONDERRY	Promo Item	Mich Ultra	2	5/5/2025 9:32 AM	2026-03-17 19:05:57.132644
5252	jaustin	BIG DEAL - KEENE	Other	Bud Light	1	7/29/2024 1:28 PM	2026-03-17 14:10:45.514355
5253	jmorse	POOR THOMS TAVERN	Other	Citizen Cider - Dirty Mayor	1	7/29/2024 12:57 PM	2026-03-17 14:10:45.518319
5254	jmorse	WAL-MART #1975 - CLAREMONT	Other	Athletic - Oktoberfest	1	7/25/2024 2:17 PM	2026-03-17 14:10:45.521322
5255	jgrumblatt	MARKET BASKET #53 CLAREMNT	Other	Mich Ultra	1	7/24/2024 9:20 PM	2026-03-17 14:10:45.524717
5256	jsewall	TARGET # 3401 - W. LEBANON	Other	Mich Ultra	1	7/24/2024 2:43 PM	2026-03-17 14:10:45.528484
5257	rconstant	SEVEN ELEV #37392 - LONDONDERY - ROCKINGHAM RD	Other	Mich Ultra	1	7/23/2024 9:33 AM	2026-03-17 14:10:45.531247
5258	rconstant	SHAW'S #0484 - LONDERRY	Other	Deep River	1	7/22/2024 3:35 PM	2026-03-17 14:10:45.534702
5259	rconstant	SHAW'S #0484 - LONDERRY	Other	Daily's Cocktails	1	7/22/2024 3:35 PM	2026-03-17 14:10:45.537973
5260	jmorse	POLISH AMER CITIZENS CLUB-CLAREMONT	Other	Bud Light	1	7/22/2024 3:33 PM	2026-03-17 14:10:45.540921
5262	ddooling	SMOKE N BARLEY - SALEM	Other	Mich Ultra	1	7/16/2024 12:31 PM	2026-03-17 14:10:45.546786
5263	ddooling	PELHAM STREET BLACK WATER GRILL	Other	Fiddlehead - IPA	1	7/11/2024 4:12 PM	2026-03-17 14:10:45.549739
5265	ddooling	CHILI'S - SALEM	Other	Dos Equis	1	7/8/2024 11:48 AM	2026-03-17 14:10:45.555652
5268	jaustin	RIVERSIDE GROCERY	Other	Heineken	1	7/2/2024 12:13 PM	2026-03-17 14:10:45.564878
5269	jaustin	BIG DEAL - SPOFFORD	Other	Heineken	1	7/2/2024 12:12 PM	2026-03-17 14:10:45.567781
5272	jmeharg	HANNAFORD #8311 - GOFFSTOWN	Other	Budweiser	1	6/27/2024 3:36 PM	2026-03-17 14:10:45.576514
5274	jgrumblatt	JALISCO MEXICAN BAR & GRILL	Other	Nutrl	1	6/25/2024 2:23 PM	2026-03-17 14:10:45.582827
5275	jgrumblatt	JAKES MARKET AND DELI - GEORGES MILLS	Other	Arizona Hard Lemon T	1	6/25/2024 12:57 PM	2026-03-17 14:10:45.585836
5276	jmorse	TREMONT HOUSE OF PIZZA	Other	Fiddlehead - IPA	1	6/25/2024 9:30 AM	2026-03-17 14:10:45.58837
5277	eleahy	MARKET BASKET #25 PLAISTOW	Other	Daily's Cocktails	1	6/20/2024 2:05 PM	2026-03-17 14:10:45.591245
5280	tchagnon	MARKET BASKET #33 HUDSON	Other	Budweiser	1	6/19/2024 1:02 PM	2026-03-17 14:10:45.601132
5281	jgrumblatt	NEWBURY PALACE PIZZA	Other	Bud Light	1	6/18/2024 1:21 PM	2026-03-17 14:10:45.604149
5282	rconstant	AJ'S SPORTS BAR & GRILL	Other	Budweiser	1	6/17/2024 12:14 PM	2026-03-17 14:10:45.607488
5284	jaustin	GUERRILLA GRILL	Other	Stoneface - Town Car	1	6/13/2024 11:10 AM	2026-03-17 14:10:45.613866
5285	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Other	Busch Light Peach	1	6/13/2024 9:57 AM	2026-03-17 14:10:45.617208
5286	pwollert	THE CLUBHOUSE BAR AND GRILLE	Promo Item	Bud Light	1	2/2/2026 12:38 PM	2026-03-17 14:10:45.620197
5287	rconstant	ROMANO'S PIZZA LLC	Promo Item	Bud Light	1	1/22/2026 12:39 PM	2026-03-17 14:10:45.623056
5288	rconstant	AJ'S SPORTS BAR & GRILL	Promo Item	Mich Ultra	1	1/15/2026 1:03 PM	2026-03-17 14:10:45.626013
5289	jgrumblatt	BUBBA'S BAR AND GRILLE	Promo Item	Athletic - Run Wild	1	12/9/2025 4:12 PM	2026-03-17 14:10:45.628823
5290	eleahy	LA CARRETA - DERRY	Promo Item	Bud Light	1	10/1/2025 1:25 PM	2026-03-17 14:10:45.631946
5292	rconstant	AJ'S SPORTS BAR & GRILL	Promo Item	Bud Light	1	8/25/2025 11:35 AM	2026-03-17 14:10:45.637443
5293	jsewall	APPLEKNOCKERS STORE	Promo Item	Bud Light	1	8/19/2025 1:48 PM	2026-03-17 14:10:45.640425
5294	bgermano	COURTYARD KEENE DOWNTOWN	Promo Item	Bud Light	1	8/19/2025 1:12 PM	2026-03-17 14:10:45.643395
5295	jmorse	IMPERIAL BUFFET & LOUNGE	Promo Item	Nutrl	1	8/5/2025 11:54 AM	2026-03-17 14:10:45.64644
5296	sshaunessy	MI JALISCO - PETERBORO	Promo Item	Bud Light	1	7/23/2025 1:44 PM	2026-03-17 14:10:45.64962
5297	rconstant	99 REST - LONDONDERRY	Promo Item	Bud Light	1	7/14/2025 12:10 PM	2026-03-17 14:10:45.652628
5298	sshaunessy	AMERICAN LEGION POST 11 - JAFFREY	Promo Item	Mich Ultra	1	6/17/2025 1:02 PM	2026-03-17 14:10:45.656085
5299	ddooling	NEW CHIEF WOK	Promo Item	Fiddlehead - IPA	1	6/12/2025 2:25 PM	2026-03-17 14:10:45.658846
5300	ddooling	STATELINE PAYSAVER	Promo Item	Bud Light	1	6/5/2025 2:05 PM	2026-03-17 14:10:45.661604
5301	ddooling	STATELINE PAYSAVER	Promo Item	Mich Ultra	1	6/5/2025 2:05 PM	2026-03-17 14:10:45.664415
5302	ddooling	SAYDES RESTAURANT INC.	Promo Item	Bud Light	1	5/27/2025 12:04 PM	2026-03-17 14:10:45.667717
5303	rconstant	99 REST - LONDONDERRY	Promo Item	Budweiser	1	5/5/2025 9:32 AM	2026-03-17 14:10:45.670371
5305	pbelanger	MEXICA MEXICAN RESTAURANT	Promo Item	Dos Equis	1	4/30/2025 4:56 PM	2026-03-17 14:10:45.676123
5306	lortiz	SHAW'S #3510 - NASHUA - ROYAL RIDGE	Promo Item	Popwell	1	4/16/2025 2:58 PM	2026-03-17 14:10:45.678978
5307	lnorton	RIVER ROAD TAVERN	Promo Item	Bud Light	1	4/3/2025 2:55 PM	2026-03-17 14:10:45.681592
5308	bgermano	MARKET BASKET #64 SWANZEY	Promo Item	Stoneface - IPA	1	3/12/2025 1:37 PM	2026-03-17 14:10:45.684081
5309	jgrumblatt	FORESTERS OF AMERICA	Promo Item	Bud Light	1	3/10/2025 4:44 PM	2026-03-17 14:10:45.686974
5310	jgrumblatt	NEWPORT VETERAN'S CLUB	Promo Item	Bud Light	1	3/10/2025 4:18 PM	2026-03-17 14:10:45.689715
5311	lortiz	LUI LUI - NASHUA	Promo Item	Bud Light	1	1/16/2025 2:22 PM	2026-03-17 14:10:45.692433
5312	jsewall	FOUR CORNERS GENERAL STORE	Promo Item	Bud Light	1	10/22/2024 11:07 AM	2026-03-17 14:10:45.695655
5313	jgrumblatt	GD CATERING LLC	Promo Item	Bud Light	1	10/15/2024 9:47 AM	2026-03-17 14:10:45.698929
5314	jgrumblatt	GD CATERING LLC	Promo Item	Nutrl	1	10/15/2024 9:47 AM	2026-03-17 14:10:45.7019
5315	jgrumblatt	LOYAL ORDER OF MOOSE - NEWPORT	Promo Item	Bud Light	1	9/10/2024 8:31 AM	2026-03-17 14:10:45.705098
5318	amartin	SHAW'S #0113 - NASHUA - MAIN ST	Promo Item	Bud Light	1	9/5/2024 10:38 AM	2026-03-17 14:10:45.714831
5319	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Promo Item	Nutrl	1	9/3/2024 12:56 PM	2026-03-17 14:10:45.71781
5320	rconstant	PASSACONAWAY COUNTRY CLUB	Promo Item	Budweiser	1	8/29/2024 3:30 PM	2026-03-17 14:10:45.721051
5321	rconstant	AMERICAN LEGION POST 27 - LONDONDERRY	Promo Item	Budweiser	1	8/27/2024 12:45 PM	2026-03-17 14:10:45.723746
5322	jsewall	WEATHERVANE - W.LEB	Promo Item	Downeast - Original	1	8/26/2024 2:35 PM	2026-03-17 14:10:45.726772
5323	scamuso	LAFAYETTE CLUB A.C.	Promo Item	Bud Light	1	8/19/2024 3:30 PM	2026-03-17 14:10:45.729725
5324	rconstant	PASSACONAWAY COUNTRY CLUB	Promo Item	Mich Ultra	1	8/1/2024 3:47 PM	2026-03-17 14:10:45.732377
5325	rconstant	SUPPAS PIZZA LONDONDERRY	Promo Item	Mich Ultra	1	7/23/2024 12:40 PM	2026-03-17 14:10:45.734889
5326	rconstant	SUPPAS PIZZA LONDONDERRY	Promo Item	Nutrl	1	7/23/2024 12:40 PM	2026-03-17 14:10:45.737705
5327	rconstant	SUPPAS PIZZA LONDONDERRY	Promo Item	Kona - Big Wave	1	7/23/2024 12:40 PM	2026-03-17 14:10:45.740708
5316	rconstant	PASSACONAWAY COUNTRY CLUB	Promo Item	Bud Light	3	9/5/2024 3:50 PM	2026-03-17 19:05:57.136387
5329	ddooling	PELHAM STREET BLACK WATER GRILL	Promo Item	Nutrl	1	6/13/2024 3:44 PM	2026-03-17 14:10:45.748079
5330	jgrumblatt	LITTLE BROTHERS BURGERS	Promo Item	Mich Ultra	1	6/12/2024 10:36 AM	2026-03-17 14:10:45.750947
5331	amartin	BACKSTREET BAR & GRILL LLC	Small Tap Marker	Maine Beer Co - Lunch	1	3/12/2026 12:48 PM	2026-03-17 14:10:45.754012
5332	jcaron	SMOKE HAUS	Small Tap Marker	Deciduous - Lollipop Rasp	1	3/11/2026 1:32 PM	2026-03-17 14:10:45.756961
5333	lnorton	T-BONES - BEDFORD	Small Tap Marker	Concord Craft - White Mtn White	1	3/5/2026 3:46 PM	2026-03-17 14:10:45.759654
5334	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	Jack's Abby - Porch Fest	1	3/2/2026 4:15 PM	2026-03-17 14:10:45.762736
5335	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	Downeast - Apple Pie	1	2/22/2026 3:22 PM	2026-03-17 14:10:45.76562
5336	jcannamucio	THE NEST PUB AND GRILL	Small Tap Marker	Elysian Space Dust	1	2/22/2026 2:45 PM	2026-03-17 14:10:45.768792
5337	jsewall	WICKED TASTY (CATERING)	Small Tap Marker	Stoneface - IPA	1	2/16/2026 1:24 PM	2026-03-17 14:10:45.771682
5338	jsewall	WICKED TASTY (CATERING)	Small Tap Marker	Downeast - Original	1	2/16/2026 1:24 PM	2026-03-17 14:10:45.774701
5339	jsewall	WICKED TASTY (CATERING)	Small Tap Marker	Mich Ultra	1	2/16/2026 1:24 PM	2026-03-17 14:10:45.777623
5340	maanderson	NASHUA COUNTRY CLUB	Small Tap Marker	Fiddlehead - IPA	1	2/11/2026 2:39 PM	2026-03-17 14:10:45.781094
5317	rconstant	PASSACONAWAY COUNTRY CLUB	Promo Item	Nutrl	2	9/5/2024 3:50 PM	2026-03-17 19:05:57.138941
5342	amartin	NEW NAN KING RESTAURANT	Small Tap Marker	Maine Beer Co - Lunch	1	2/4/2026 3:32 PM	2026-03-17 14:10:45.788062
5343	lnorton	COPPER DOOR - BEDFORD	Small Tap Marker	603 Brew - Winni	1	1/21/2026 1:26 PM	2026-03-17 14:10:45.791264
5344	ddooling	OLD SCHOOL BAR AND GRILL	Small Tap Marker	New Belgium - Juicy Haze	1	1/19/2026 2:20 PM	2026-03-17 14:10:45.794001
5346	ddooling	OLD SCHOOL BAR AND GRILL	Small Tap Marker	New Belgium - Fat Tire	1	1/15/2026 4:00 PM	2026-03-17 14:10:45.80029
5347	eleahy	FODY'S TAVERN (DERRY)	Small Tap Marker	Bud Light	1	1/12/2026 1:25 PM	2026-03-17 14:10:45.803328
5348	lnorton	T-BONES - BEDFORD	Small Tap Marker	603 Brew - Coffee Cake Porter	1	12/18/2025 1:48 PM	2026-03-17 14:10:45.805909
5349	eplatt	THE KITCHEN BY JTAPS	Small Tap Marker	Kona - Big Wave	1	12/10/2025 4:06 PM	2026-03-17 14:10:45.808885
5350	jmorse	COMMON MAN - CLAREMONT	Small Tap Marker	Downeast - Winter	1	12/8/2025 12:50 PM	2026-03-17 14:10:45.811448
5351	amartin	CASEY MAGEE'S	Small Tap Marker	von Trapp - Pilsner	1	12/4/2025 2:50 PM	2026-03-17 14:10:45.814641
5352	jgiuffrida	TOMO STEAKHOUSE	Small Tap Marker	Mich Ultra	1	12/4/2025 11:53 AM	2026-03-17 14:10:45.817685
5353	jcannamucio	JAMISON'S	Small Tap Marker	Goose - Bourb County	1	12/2/2025 10:22 AM	2026-03-17 14:10:45.820727
5355	jgrumblatt	VAIL RESORT/ MOUNT SUNAPEE	Small Tap Marker	Fiddlehead - White	1	11/22/2025 10:31 AM	2026-03-17 14:10:45.827093
5345	lnorton	T-BONES - BEDFORD	Small Tap Marker	603 Brew - Winni	2	1/19/2026 1:27 PM	2026-03-17 19:05:57.141896
5357	ddooling	FIGARO'S MARTINI BAR + KITCHEN	Small Tap Marker	Wormtown - Blizzard	1	11/13/2025 3:14 PM	2026-03-17 14:10:45.832937
5358	rconstant	99 REST - LONDONDERRY	Small Tap Marker	Bud Select	1	11/6/2025 1:13 PM	2026-03-17 14:10:45.835738
5359	rconstant	99 REST - LONDONDERRY	Small Tap Marker	Bud Light	1	11/6/2025 1:13 PM	2026-03-17 14:10:45.838539
5360	rconstant	99 REST - LONDONDERRY	Small Tap Marker	Sea Dog - Blueberry	1	11/6/2025 1:13 PM	2026-03-17 14:10:45.841364
5361	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	Wormtown - Blizzard_2	1	11/3/2025 4:03 PM	2026-03-17 14:10:45.844086
5362	jcannamucio	THE NEST PUB AND GRILL	Small Tap Marker	Downeast - Original	1	11/3/2025 1:29 PM	2026-03-17 14:10:45.847038
5363	lnorton	T-BONES - BEDFORD	Small Tap Marker	Downeast - Original	1	10/30/2025 2:20 PM	2026-03-17 14:10:45.849994
5364	pbelanger	VFW SOCIAL CLUB	Small Tap Marker	Mich Ultra	1	10/27/2025 12:48 PM	2026-03-17 14:10:45.853232
5365	jsewall	THREE TOMATOES TRATTORIA	Small Tap Marker	Zero Gravity - Pisolino	1	10/23/2025 1:42 PM	2026-03-17 14:10:45.85652
5366	pbelanger	WOODBOUND INN	Small Tap Marker	Stella Artois	1	10/22/2025 4:11 PM	2026-03-17 14:10:45.859689
5369	ddooling	OLD SCHOOL BAR AND GRILL	Small Tap Marker	Shipyard - Pumpkin Head	1	10/16/2025 7:22 AM	2026-03-17 14:10:45.868516
5370	jcannamucio	HENHOUSE BAR & GRILL	Small Tap Marker	Maine Beer Co - Lunch	1	10/15/2025 3:52 PM	2026-03-17 14:10:45.871445
5371	lortiz	LONGHORN STEAK #5457 - NASHUA	Small Tap Marker	Bud Light	1	10/13/2025 2:00 PM	2026-03-17 14:10:45.874552
5354	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	Fiddlehead - White	2	11/23/2025 2:33 PM	2026-03-17 19:05:57.144329
5367	lortiz	LONGHORN STEAK #5457 - NASHUA	Small Tap Marker	Maine Beer Co - Lunch	2	10/20/2025 4:54 PM	2026-03-17 19:05:57.147789
5368	ddooling	OLD SCHOOL BAR AND GRILL	Small Tap Marker	603 Brew - Winni	2	10/16/2025 7:22 AM	2026-03-17 19:05:57.150315
5372	jaustin	DIPLOMAT (THE)	Small Tap Marker	Downeast - Cider Donut	2	10/2/2025 12:56 PM	2026-03-17 19:05:57.152562
5374	jmorse	COMMON MAN - CLAREMONT	Small Tap Marker	Shipyard - Pumpkin Head	1	9/29/2025 1:37 PM	2026-03-17 14:10:45.882745
5375	jcannamucio	THE NEST PUB AND GRILL	Small Tap Marker	Shipyard - Pumpkin Head	1	9/8/2025 2:34 PM	2026-03-17 14:10:45.885833
5376	sshaunessy	AMERICAN LEGION POST 10 - WILTON	Small Tap Marker	Downeast - Cider Donut	1	9/7/2025 11:32 AM	2026-03-17 14:10:45.888961
5377	jsewall	LUI LUI - WEST LEBANON	Small Tap Marker	Wormtown - Fresh Patch	1	8/20/2025 11:06 AM	2026-03-17 14:10:45.891763
5382	jaustin	AMERICAN LEGION POST 4 - KEENE	Small Tap Marker	Bud Light	3	7/17/2025 12:05 PM	2026-03-17 19:05:57.154775
5379	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	Zero Gravity - Jaws Czech	1	8/11/2025 4:06 PM	2026-03-17 14:10:45.897637
5385	jsewall	LUI LUI - WEST LEBANON	Small Tap Marker	Gold Road Mango Cart	2	7/2/2025 9:53 AM	2026-03-17 19:05:57.157755
5381	jsewall	TARGET # 3401 - W. LEBANON	Small Tap Marker	Zero Gravity - Green State	1	7/23/2025 11:04 AM	2026-03-17 14:10:45.904218
5383	jaustin	AMERICAN LEGION POST 4 - KEENE	Small Tap Marker	Fiddlehead - IPA	1	7/8/2025 3:12 PM	2026-03-17 14:10:45.910458
5384	jaustin	AMERICAN LEGION POST 4 - KEENE	Small Tap Marker	Bud Select	1	7/8/2025 3:12 PM	2026-03-17 14:10:45.91524
5386	jmorse	COMMON MAN - CLAREMONT	Small Tap Marker	Kona - Big Wave	1	6/23/2025 12:05 PM	2026-03-17 14:10:45.922639
5387	jsewall	PEYTON PLACE RESTAURANT	Small Tap Marker	Concord Craft - Four Rivers	1	6/17/2025 11:47 AM	2026-03-17 14:10:45.926744
5388	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	603 Brew - Summa	1	6/16/2025 3:44 PM	2026-03-17 14:10:45.929777
5389	jaustin	DIPLOMAT (THE)	Small Tap Marker	Gold Road Mango Cart	1	6/12/2025 12:45 PM	2026-03-17 14:10:45.936133
5402	pbelanger	VFW SOCIAL CLUB	Small Tap Marker	Fiddlehead - IPA	2	3/31/2025 1:05 PM	2026-03-17 19:05:57.160077
5391	jgrumblatt	BUBBA'S BAR AND GRILLE	Small Tap Marker	Gold Road Mango Cart	1	6/12/2025 10:05 AM	2026-03-17 14:10:45.942284
5427	ggage	VFW #4368 - MILFORD	Small Tap Marker	Fiddlehead - IPA	2	11/12/2024 9:39 AM	2026-03-17 19:05:57.162482
5393	jgiuffrida	DREO FOOD AND DRINK	Small Tap Marker	Gold Road Mango Cart	1	5/22/2025 3:37 PM	2026-03-17 14:10:45.9488
5394	lnorton	T-BONES - BEDFORD	Small Tap Marker	Kona - Big Wave	1	5/22/2025 11:34 AM	2026-03-17 14:10:45.951947
5395	jmorse	COMMON MAN - CLAREMONT	Small Tap Marker	Fiddlehead - IPA	1	5/12/2025 10:55 AM	2026-03-17 14:10:45.955051
5396	lortiz	MARKET BASKET #13 NASHUA - DW HWY	Small Tap Marker	Fiddlehead - IPA	1	5/7/2025 12:35 PM	2026-03-17 14:10:45.958555
5398	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	Stoneface - Green Duct Tape	1	4/21/2025 4:05 PM	2026-03-17 14:10:45.965163
5401	maanderson	NATIONAL CLUB (THE)	Small Tap Marker	Budweiser	1	3/31/2025 1:10 PM	2026-03-17 14:10:45.980275
5403	lnorton	T-BONES - BEDFORD	Small Tap Marker	Stella Artois	1	3/24/2025 12:08 PM	2026-03-17 14:10:45.987014
5404	lnorton	T-BONES - BEDFORD	Small Tap Marker	Fiddlehead - IPA	1	3/24/2025 12:08 PM	2026-03-17 14:10:45.990233
5405	lnorton	T-BONES - BEDFORD	Small Tap Marker	Bud Light	1	3/24/2025 12:08 PM	2026-03-17 14:10:45.993635
5406	amartin	CASEY MAGEE'S	Small Tap Marker	Stoneface - IPA	1	3/20/2025 2:47 PM	2026-03-17 14:10:45.998167
5407	jaustin	DIPLOMAT (THE)	Small Tap Marker	Downeast - Guava Passion	1	3/12/2025 3:18 PM	2026-03-17 14:10:46.001947
5408	jaustin	DIPLOMAT (THE)	Small Tap Marker	14th Star - Valor	1	3/12/2025 3:15 PM	2026-03-17 14:10:46.006108
5409	jaustin	DIPLOMAT (THE)	Small Tap Marker	Able - Burn the Ships	1	3/12/2025 3:15 PM	2026-03-17 14:10:46.01033
5410	jsewall	HANNAFORD #8266 - W.LEB	Small Tap Marker	Captain Eli's	1	2/27/2025 9:18 AM	2026-03-17 14:10:46.0139
5411	jsewall	STILL NORTH BOOKS & BAR	Small Tap Marker	Fiddlehead - IPA	1	2/20/2025 10:37 AM	2026-03-17 14:10:46.017554
5412	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	Throwback - Wallis White	1	2/3/2025 2:32 PM	2026-03-17 14:10:46.021257
5413	amartin	CASEY MAGEE'S	Small Tap Marker	Tuckerman - Rock Pile IPA	1	1/23/2025 3:46 PM	2026-03-17 14:10:46.0251
5414	jaustin	DIPLOMAT (THE)	Small Tap Marker	Downeast - Original	1	1/9/2025 2:29 PM	2026-03-17 14:10:46.029406
5415	jaustin	DIPLOMAT (THE)	Small Tap Marker	Frost - Lush	1	1/9/2025 2:29 PM	2026-03-17 14:10:46.034055
5416	jgrumblatt	BUBBA'S BAR AND GRILLE	Small Tap Marker	Athletic - Run Wild	1	1/2/2025 9:26 AM	2026-03-17 14:10:46.038899
5417	jsewall	PEYTON PLACE RESTAURANT	Small Tap Marker	von Trapp - Dunkel	1	12/10/2024 1:51 PM	2026-03-17 14:10:46.043973
5419	maanderson	GRUMPY'S CIGARS AND LOUNGE	Small Tap Marker	Wormtown - Blizzard	1	12/4/2024 9:18 AM	2026-03-17 14:10:46.053066
5420	jsewall	LUI LUI - WEST LEBANON	Small Tap Marker	Wormtown - Blizzard	1	11/26/2024 4:00 PM	2026-03-17 14:10:46.056704
5422	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	Wormtown - Blizzard	1	11/24/2024 5:50 PM	2026-03-17 14:10:46.064308
5423	jcannamucio	DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)	Small Tap Marker	Wormtown - Blizzard	1	11/24/2024 1:21 PM	2026-03-17 14:10:46.06841
5425	maanderson	ZO'S PLACE	Small Tap Marker	603 Brew - IPA	1	11/18/2024 12:42 PM	2026-03-17 14:10:46.075814
5428	jaustin	DIPLOMAT (THE)	Small Tap Marker	Jack's Abby - Extra Layer	1	11/7/2024 2:56 PM	2026-03-17 14:10:46.085157
5429	maanderson	GRUMPY'S CIGARS AND LOUNGE	Small Tap Marker	Berkshire - Coffehouse Porter	1	10/30/2024 7:46 AM	2026-03-17 14:10:46.088768
5432	jcannamucio	HENHOUSE BAR & GRILL	Small Tap Marker	Fiddlehead - IPA	1	10/23/2024 4:17 PM	2026-03-17 14:10:46.097725
5474	jmorse	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	Umbrella	Landshark Lager	2	6/3/2025 11:08 AM	2026-03-17 19:05:57.166389
5481	pbelanger	PHOENIX SMOKEHOUSE AND TAQUERIA	Umbrella	Bud Light	2	5/21/2025 11:03 AM	2026-03-17 19:05:57.169388
5483	jaustin	LAB'N LAGER KEENE	Umbrella	Fiddlehead - IPA	2	5/15/2025 1:35 PM	2026-03-17 19:05:57.171943
5437	rconstant	99 REST - LONDONDERRY	Small Tap Marker	Stella Artois	1	10/10/2024 8:26 AM	2026-03-17 14:10:46.111473
5438	jsewall	99 REST - W.LEB	Small Tap Marker	Wormtown - Be Hoppy	1	10/3/2024 2:29 PM	2026-03-17 14:10:46.114274
5440	jgrumblatt	BUBBA'S BAR AND GRILLE	Small Tap Marker	Concord Craft - Four Rivers	1	9/26/2024 9:51 AM	2026-03-17 14:10:46.120413
5441	rconstant	LA CARRETA - LONDONDERRY	Small Tap Marker	Shipyard - Pumpkin Head	1	9/25/2024 10:41 AM	2026-03-17 14:10:46.123303
5443	maanderson	MAIN ST GYRO	Small Tap Marker	Lord Hobo - Boomsauce	1	9/19/2024 1:17 PM	2026-03-17 14:10:46.129459
5445	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	Berkshire - Marzen	1	9/9/2024 3:45 PM	2026-03-17 14:10:46.135819
5446	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	603 Brew - Toast Pumpkin	1	9/9/2024 3:45 PM	2026-03-17 14:10:46.140166
5447	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	1911 - Cider Donut	1	9/9/2024 3:45 PM	2026-03-17 14:10:46.144475
5448	jgrumblatt	BUBBA'S BAR AND GRILLE	Small Tap Marker	Shipyard - Pumpkin Head	1	9/5/2024 9:51 AM	2026-03-17 14:10:46.147887
5449	jcannamucio	RICK'S THE SPIRIT OF KINGSTON	Small Tap Marker	Frost - Research DIPA	1	9/2/2024 3:49 PM	2026-03-17 14:10:46.150452
5450	jcannamucio	HENHOUSE BAR & GRILL	Small Tap Marker	Shipyard - Pumpkin Head	1	8/28/2024 1:15 PM	2026-03-17 14:10:46.153378
5452	jmorse	COMMON MAN - CLAREMONT	Small Tap Marker	Lord Hobo - Boomsauce	1	8/19/2024 3:37 AM	2026-03-17 14:10:46.159556
5453	lnorton	OLD SCHOOL BAR AND GRILL	Small Tap Marker	Shipyard - Pumpkin Head	1	8/15/2024 3:37 PM	2026-03-17 14:10:46.162784
5455	jsewall	LUI LUI - WEST LEBANON	Small Tap Marker	Shipyard - Pumpkin Head	1	8/7/2024 10:30 AM	2026-03-17 14:10:46.169176
5456	ggage	VFW #4368 - MILFORD	Small Tap Marker	Downeast - Cider Donut	1	8/6/2024 10:07 AM	2026-03-17 14:10:46.171821
5457	jmorse	COMMON MAN - CLAREMONT	Small Tap Marker	Stella Artois	1	6/24/2024 3:00 PM	2026-03-17 14:10:46.174957
5458	rconstant	99 REST - LONDONDERRY	Small Tap Marker	Downeast - Blackberry	1	6/24/2024 9:48 AM	2026-03-17 14:10:46.177847
5461	jaustin	BIG DEAL - SPOFFORD	Umbrella	NOCA	1	9/2/2025 1:10 PM	2026-03-17 14:10:46.18844
5462	maanderson	PATEL'S MAMMOTH CONVENIENCE	Umbrella	BL Seltzer Variety	1	8/12/2025 1:44 PM	2026-03-17 14:10:46.191703
5463	rconstant	MARKET BASKET #42 LONDERRY	Umbrella	Kona - Big Wave	1	7/23/2025 11:40 AM	2026-03-17 14:10:46.195013
5464	pwollert	SAKA HIBACHI STEAKHOUSE	Umbrella	Fiddlehead - IPA	1	7/15/2025 11:45 AM	2026-03-17 14:10:46.198102
5465	lnorton	MARKET BASKET #71 BEDFORD	Umbrella	Bud Light	1	6/26/2025 3:50 PM	2026-03-17 14:10:46.201333
5466	lnorton	MARKET BASKET #71 BEDFORD	Umbrella	Nutrl	1	6/26/2025 3:50 PM	2026-03-17 14:10:46.204208
5467	jmorse	MDP MOTORSPORTS PROMOTIONS LLC	Umbrella	BUD LIGHT SELTZER PINK LEMONADE	1	6/23/2025 4:38 PM	2026-03-17 14:10:46.207217
5468	rconstant	AJ'S SPORTS BAR & GRILL	Umbrella	Nutrl	1	6/23/2025 11:01 AM	2026-03-17 14:10:46.210079
5469	jmeharg	TOOKY MILLS PUB	Umbrella	Bud Light	1	6/23/2025 10:34 AM	2026-03-17 14:10:46.212851
5471	jmorse	DADDY'S PIZZA	Umbrella	Landshark Lager	1	6/17/2025 1:30 PM	2026-03-17 14:10:46.218122
5473	rconstant	HUDSONS NORTH SIDE GRILLE	Umbrella	Mich Ultra	1	6/4/2025 11:55 AM	2026-03-17 14:10:46.223679
5476	jsewall	BLACK MAGIC MEXICAN	Umbrella	Mighty Squirrel - Cloud Candy	1	5/29/2025 12:16 PM	2026-03-17 14:10:46.233839
5477	pbelanger	MAMA MCDONOUGH'S IRISH PUB	Umbrella	Bud Light	1	5/29/2025 11:22 AM	2026-03-17 14:10:46.236706
5478	rconstant	SMOKE SHACK CAFE	Umbrella	Mich Ultra	1	5/27/2025 1:04 PM	2026-03-17 14:10:46.240609
5480	sshaunessy	PIZZA PEDDLER & MINI MART	Umbrella	Stella Artois	1	5/21/2025 11:26 AM	2026-03-17 14:10:46.247692
5484	ddooling	GERARDO'S TRATTORIA AMALF	Umbrella	Budweiser	1	5/15/2025 12:10 PM	2026-03-17 14:10:46.268494
5485	bgermano	SWANZEY NEIGHBOR	Umbrella	Fiddlehead - IPA	1	5/13/2025 12:59 PM	2026-03-17 14:10:46.272639
5486	pbelanger	RUSTIC TABLE (THE)	Umbrella	Budweiser	1	5/13/2025 9:36 AM	2026-03-17 14:10:46.275689
5487	pbelanger	RUSTIC TABLE (THE)	Umbrella	Bud Light	1	5/13/2025 9:36 AM	2026-03-17 14:10:46.279428
5488	pwollert	HUNGRY DINER (THE)	Umbrella	Fiddlehead - IPA	1	5/8/2025 2:12 PM	2026-03-17 14:10:46.283244
5489	pbelanger	MEXICA MEXICAN RESTAURANT	Umbrella	Dos Equis	1	5/7/2025 4:30 PM	2026-03-17 14:10:46.286924
5490	jmeharg	BLUE BEAR HOSPITALITY LLC	Umbrella	Fiddlehead - IPA	1	5/7/2025 3:39 PM	2026-03-17 14:10:46.310763
5491	lnorton	PINARDVILLE ATHLETIC CLUB	Umbrella	Bud Light	1	5/6/2025 2:23 PM	2026-03-17 14:10:46.31525
5492	jmorse	MDP MOTORSPORTS PROMOTIONS LLC	Umbrella	Budweiser	1	5/5/2025 4:04 PM	2026-03-17 14:10:46.319253
5493	maanderson	AYOTTES & SMOKIN' JOES PREMIUM CIGARS	Umbrella	Nutrl	1	5/1/2025 1:44 PM	2026-03-17 14:10:46.322273
5495	jmorse	SHOP EXPRESS	Umbrella	Poland Spring	1	4/30/2025 3:22 PM	2026-03-17 14:10:46.330181
5496	jsewall	LUI LUI - WEST LEBANON	Umbrella	Budweiser	1	4/30/2025 1:25 PM	2026-03-17 14:10:46.33483
5497	jsewall	LUI LUI - WEST LEBANON	Umbrella	Fiddlehead - IPA	1	4/30/2025 1:25 PM	2026-03-17 14:10:46.339254
5498	sshaunessy	BOWLING ACRES	Umbrella	Fiddlehead - IPA	1	4/30/2025 12:10 PM	2026-03-17 14:10:46.345612
5499	sshaunessy	SHAW'S #4694 - PETERBORO	Umbrella	Sparkling Ice	1	4/30/2025 11:34 AM	2026-03-17 14:10:46.349995
5500	jmorse	TREMONT HOUSE OF PIZZA	Umbrella	Fiddlehead - IPA	1	4/28/2025 5:55 PM	2026-03-17 14:10:46.353756
5501	jmorse	VFW #808 - CLAREMONT	Umbrella	Budweiser	1	4/28/2025 4:35 PM	2026-03-17 14:10:46.35744
5502	jmorse	CLAREMONT COUNTRY CLUB	Umbrella	Mich Ultra	1	4/28/2025 2:53 PM	2026-03-17 14:10:46.361189
5503	jmorse	TAVERNE ON THE SQUARE LLC	Umbrella	Fiddlehead - IPA	1	4/28/2025 12:44 PM	2026-03-17 14:10:46.364259
5504	jmorse	RAMUNTOS - CLAREMONT	Umbrella	Fiddlehead - IPA	1	4/28/2025 10:46 AM	2026-03-17 14:10:46.367692
5505	maanderson	SOHO RESTAURANT	Umbrella	Bud Light	1	4/25/2025 3:26 PM	2026-03-17 14:10:46.371588
5512	jmeharg	STONEBRIDGE COUNTRY CLUB	Umbrella	Nutrl	3	4/22/2025 1:54 PM	2026-03-17 19:05:57.174487
5507	jaustin	KEENE COUNTRY CLUB INC	Umbrella	Nutrl	1	4/24/2025 3:10 PM	2026-03-17 14:10:46.380799
5508	jaustin	KEENE COUNTRY CLUB INC	Umbrella	Fiddlehead - IPA	1	4/24/2025 3:10 PM	2026-03-17 14:10:46.385133
5509	jmorse	FORBES TAVERN AND EVENTS	Umbrella	Mich Ultra	1	4/23/2025 10:33 AM	2026-03-17 14:10:46.388812
5510	sshaunessy	AMERICAN LEGION POST 11 - JAFFREY	Umbrella	Bud Light	1	4/22/2025 1:55 PM	2026-03-17 14:10:46.391877
5511	sshaunessy	AMERICAN LEGION POST 11 - JAFFREY	Umbrella	Kona - Big Wave	1	4/22/2025 1:55 PM	2026-03-17 14:10:46.395449
5514	sshaunessy	MONADNOCK COUNTRY CLUB	Umbrella	Fiddlehead - IPA	1	4/21/2025 1:39 PM	2026-03-17 14:10:46.406652
5515	rconstant	HUDSONS NORTH SIDE GRILLE	Umbrella	Nutrl	1	4/17/2025 3:20 PM	2026-03-17 14:10:46.410316
5516	jsewall	SALT HILL PUB - LEBANON	Umbrella	Fiddlehead - IPA	1	4/17/2025 12:14 PM	2026-03-17 14:10:46.413657
5519	ddooling	SAYDES RESTAURANT INC.	Umbrella	Budweiser	1	4/15/2025 12:13 PM	2026-03-17 14:10:46.424289
5520	eleahy	SHAW'S #3669 - PLAISTOW	Umbrella	Bud Light	1	4/11/2025 8:18 AM	2026-03-17 14:10:46.427558
5521	maanderson	MARGARITAS MEXICAN RESTAURANT-NASHUA	Umbrella	Bud Light	1	4/10/2025 2:48 PM	2026-03-17 14:10:46.431504
5522	jgrumblatt	NEWPORT GOLF CLUB	Umbrella	Kona - Big Wave	1	4/7/2025 3:46 PM	2026-03-17 14:10:46.43538
5523	jgrumblatt	NEWPORT GOLF CLUB	Umbrella	Nutrl	1	4/7/2025 3:46 PM	2026-03-17 14:10:46.438948
5524	jgrumblatt	MARKET BASKET #53 CLAREMNT	Umbrella	Fiddlehead - IPA	1	4/4/2025 8:05 AM	2026-03-17 14:10:46.443363
5525	jgrumblatt	MARKET BASKET #53 CLAREMNT	Umbrella	Nutrl	1	4/4/2025 8:05 AM	2026-03-17 14:10:46.446919
5526	jgrumblatt	MARKET BASKET #53 CLAREMNT	Umbrella	Bud Light	1	4/4/2025 8:05 AM	2026-03-17 14:10:46.451754
5527	maanderson	PENUCHE'S ALE HOUSE-NASHUA	Umbrella	Kona - Big Wave	1	4/3/2025 3:23 PM	2026-03-17 14:10:46.455714
5528	lnorton	THE FRIENDLY TOAST - BEDFORD	Umbrella	Bud Light	1	4/3/2025 12:51 PM	2026-03-17 14:10:46.459713
5529	jaustin	LOCAL BURGER OF KEENE	Umbrella	Nutrl	1	4/2/2025 3:01 PM	2026-03-17 14:10:46.462963
5530	ddooling	SEVMAR MEDITERRANEAN BISTRO	Umbrella	Kona - Big Wave	1	4/2/2025 8:48 AM	2026-03-17 14:10:46.465798
5531	pwollert	POUR HOUSE (THE)	Umbrella	Budweiser	1	4/1/2025 3:35 PM	2026-03-17 14:10:46.468945
5532	maanderson	PINE VALLEY GOLF COURSE	Umbrella	Nutrl	1	4/1/2025 9:52 AM	2026-03-17 14:10:46.472076
5534	pwollert	WALPOLE GROCERY	Umbrella	Fiddlehead - IPA	1	3/12/2025 1:47 PM	2026-03-17 14:10:46.478252
5535	jmeharg	STONEBRIDGE COUNTRY CLUB	Umbrella	Mich Ultra	1	2/18/2025 4:54 AM	2026-03-17 14:10:46.481306
5536	rconstant	ROMANO'S PIZZA LLC	Umbrella	Kona - Big Wave	1	10/10/2024 3:32 PM	2026-03-17 14:10:46.48493
5537	jsewall	APPLEKNOCKERS STORE	Umbrella	Budweiser	1	8/13/2024 10:42 AM	2026-03-17 14:10:46.489039
5538	jsewall	APPLEKNOCKERS STORE	Umbrella	Mich Ultra	1	8/13/2024 10:42 AM	2026-03-17 14:10:46.492437
5539	pwollert	MADAME SHERRI'S	Umbrella	Fiddlehead - IPA	1	7/30/2024 3:22 PM	2026-03-17 14:10:46.495484
5540	maanderson	LUK'S BAR & GRILL	Umbrella	Kona - Big Wave	1	7/24/2024 11:12 AM	2026-03-17 14:10:46.49881
5541	rconstant	COACH STOP	Umbrella	Stella Artois	1	7/17/2024 1:14 PM	2026-03-17 14:10:46.501967
5543	jaustin	TEMPESTA'S	Umbrella	Mich Ultra	1	7/10/2024 1:36 PM	2026-03-17 14:10:46.508687
5544	lnorton	ON THE CORNER GRILL	Umbrella	Kona - Big Wave	1	7/9/2024 4:26 PM	2026-03-17 14:10:46.511849
5548	jmeharg	SNACKSHOT CATERING	Umbrella	Bud Light	1	6/25/2024 4:45 AM	2026-03-17 14:10:46.52486
5549	pbelanger	VFW SOCIAL CLUB	Umbrella	Bud Light	2	6/24/2024 12:16 PM	2026-03-17 14:10:46.527477
5551	amartin	AMERICAN LEGION POST 3 - NASHUA	Umbrella	Budweiser	1	6/20/2024 2:31 PM	2026-03-17 14:10:46.534127
5552	jaustin	GUERRILLA GRILL	Umbrella	Zero Gravity - Cone Head	1	6/20/2024 1:17 PM	2026-03-17 14:10:46.537689
5553	jaustin	GUERRILLA GRILL	Umbrella	Fiddlehead - IPA	1	6/20/2024 1:17 PM	2026-03-17 14:10:46.541184
5555	rconstant	AJ'S SPORTS BAR & GRILL	Umbrella	Fiddlehead - IPA	1	6/20/2024 12:59 PM	2026-03-17 14:10:46.548629
5556	eleahy	SHAW'S #3669 - PLAISTOW	Umbrella	Sparkling Ice	1	6/19/2024 2:58 PM	2026-03-17 14:10:46.552475
5557	eleahy	MARKET BASKET #25 PLAISTOW	Umbrella	Sparkling Ice	1	6/19/2024 11:44 AM	2026-03-17 14:10:46.556064
5558	jgrumblatt	CIRCLE K #7247 - ANDOVER	Umbrella	Nutrl	1	6/19/2024 11:39 AM	2026-03-17 14:10:46.559855
5559	jgrumblatt	NEWBURY PALACE PIZZA	Umbrella	Fiddlehead - IPA	1	6/18/2024 1:22 PM	2026-03-17 14:10:46.563435
5560	jmorse	WAL-MART #1975 - CLAREMONT	Umbrella	Zero Gravity - Cone Head	1	6/13/2024 1:06 PM	2026-03-17 14:10:46.566516
\.


--
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brands (id, catalog_item_id, name, is_default) FROM stdin;
835	12	Bud light St Pat	f
836	2	Bud Light - St Pats	f
101	1	Athletic - Lite	t
102	1	Bud American Ale	t
103	1	Bud Ice	t
104	1	Bud Light	t
105	1	Bud Light Seltzer Sangria Splash Variety	t
106	1	Budweiser	t
107	1	Busch Light	t
108	1	Dos Equis	t
109	1	Dos Equis Amber	t
110	1	Fiddlehead - Hodad	t
111	1	Fiddlehead - IPA	t
112	1	Gold Road Mango Cart	t
113	1	Good Boy Vodka	t
114	1	Heineken	t
115	1	Hoop Tea	t
116	1	Jack's Abby - Banner	t
117	1	Jack's Abby - Copper Legend	t
118	1	Kona - Big Wave	t
119	1	Mich Ultra	t
120	1	Mich Ultra Org	t
121	1	Mich Ultra Zero	t
122	1	Nutrl	t
123	1	Nutrl Orange	t
124	1	Nutrl Pineapple	t
125	1	Stella Artois	t
126	1	Stoneface - IPA	t
127	1	Wicked Weed	t
128	1	Zero Gravity - Cone Head	t
129	2	603 Brew - Winni	t
130	2	Able - Auburn	t
131	2	Athletic - All Out	t
132	2	Athletic - Free Wave	t
133	2	Athletic - Lite	t
134	2	Athletic - Run Wild	t
135	2	BeatBox Vrty	t
136	2	Beatbox Hard T	t
137	2	Bud Light	t
138	2	Bud Lt Lemon-Ade-Rita	t
139	2	Bud Lt Lime-A-Rita	t
140	2	Bud Lt Straw-Ber-Rita	t
141	2	Bud Lt Summer Rita	t
142	2	Budweiser	t
143	2	Busch Light	t
144	2	Cabot	t
145	2	Citizen Cider - Unified Press	t
146	2	Clubtails	t
147	2	Cutwater Mojito	t
148	2	Cutwater Tequila Paloma	t
149	2	Cutwater Variety	t
150	2	Cutwater Vodka Mule	t
151	2	Daily's Cocktails	t
152	2	Deep River	t
153	2	Devils BB - Orng Smash	t
154	2	Devils BB - Vrty	t
155	2	Dos Equis	t
156	2	Downeast - Original	t
157	2	Downeast - Overboard	t
158	2	Fiddlehead - IPA	t
159	2	Ghost Energy	t
160	2	Gold Road Mango Cart	t
161	2	Good 2 grow	t
162	2	Good Boy J Daly	t
163	2	Guinness Pretzel Pieces	t
164	2	Happy Dad Variety	t
165	2	Heineken	t
166	2	Heineken Silver	t
167	2	Jack's Abby - Banner	t
168	2	Johny Bootlegger	t
169	2	Kona - Big Wave	t
170	2	Links Drinks	t
171	2	Mas+ by Messi	t
172	2	Mich Ultra	t
173	2	Mich Ultra Zero	t
174	2	Murphy's Irish	t
175	2	NOCA	t
176	2	NOCA - Alcolo	t
177	2	Natty Daddy	t
178	2	Natural Ice	t
179	2	Natural Light	t
180	2	New Belgium - Fat Tire	t
181	2	New Belgium - Juice Force	t
182	2	Nutrl	t
183	2	Nutrl Lemonade Vrty	t
184	2	Nutrl Lime	t
185	2	Phorm Energy Blue Blitz	t
186	2	Phorm Energy Freedom	t
187	2	Poland Spring	t
188	2	Popwell	t
189	2	Revitalyte	t
190	2	Ryse Energy + Protein	t
191	2	Ryse Fuel	t
192	2	Ryse Protein	t
193	2	Shipyard - Pumpkin Head	t
194	2	Sparkling Ice	t
195	2	Sparkling Ice Caf	t
196	2	Sparkling Ice Energy	t
197	2	Stella Artois	t
198	2	Super Coffee	t
199	2	The Beast - Mean Green	t
200	2	Tivoli - Outlaw	t
201	2	Wormtown - Irish Red	t
202	3	Bud Light	t
203	3	Busch Light	t
204	3	Concord Craft - Safe Space	t
205	3	Fiddlehead - IPA	t
206	3	Stella Artois	t
207	3	Stoneface - IPA	t
208	4	BL Seltzer Variety	t
209	4	Bud Light	t
210	4	Budweiser	t
211	4	Busch Light	t
212	4	Dos Equis	t
213	4	Fiddlehead - IPA	t
214	4	Good 2 grow	t
215	4	Heineken	t
216	4	Hoop Tea	t
217	4	Kona - Big Wave	t
218	4	Lagunitas - Daytime	t
219	4	Mich Ultra	t
220	4	New Belgium - Fat Tire	t
221	4	Nutrl	t
222	4	Stella Artois	t
223	5	14th Star - Maple Br	t
224	5	14th Star - Mexican Lager	t
225	5	14th Star - N Maple Br	t
226	5	14th Star - Oktoberfest	t
227	5	14th Star - Remix	t
228	5	14th Star - Tribute	t
229	5	14th Star - Valor	t
230	5	1911 - Cider Donut	t
231	5	1911 - Haunted Hayride	t
232	5	1911 - Maple Bourbon Cider	t
233	5	21 Amend - Hell High Water	t
234	5	603 Brew - APL	t
235	5	603 Brew - As You Wish	t
236	5	603 Brew - Beer Hall	t
237	5	603 Brew - Coffee Cake Porter	t
238	5	603 Brew - Hard Seltzer	t
239	5	603 Brew - IPA	t
240	5	603 Brew - Irish Hello	t
241	5	603 Brew - Knuckle	t
242	5	603 Brew - Lono Tiki	t
243	5	603 Brew - Mighty Oak	t
244	5	603 Brew - Mitz BA RIS	t
245	5	603 Brew - Mitz RIS	t
246	5	603 Brew - Octoberfest	t
247	5	603 Brew - Pipes & Drums	t
248	5	603 Brew - Scenic	t
249	5	603 Brew - Seltzer Black Cherry	t
250	5	603 Brew - Slightly Tstd	t
251	5	603 Brew - Smoketoberfest	t
252	5	603 Brew - Straw Wheat	t
253	5	603 Brew - Summa	t
254	5	603 Brew - Toast Pumpkin	t
255	5	603 Brew - Winni	t
256	5	603 Brew - Wood Devil IPA	t
257	5	Able - Auburn	t
258	5	Able - Broad Arrow	t
259	5	Able - Burn the Ships	t
260	5	Able - Emma Wood	t
261	5	Able - Fighting 69th	t
262	5	Able - Gemultich German Lager	t
263	5	Able - Glory Not Prey	t
264	5	Able - Homecoming Pumpkin Ale	t
265	5	Able - Lady of the Lake	t
266	5	Able - Victory Nor Defeat	t
267	5	Athletic - Run Wild	t
268	5	Austin Street - Anniversary	t
269	5	Austin Street - DDH Patina	t
270	5	Austin Street - Florens	t
271	5	Austin Street - Fox Street	t
272	5	Austin Street - Instant Crush	t
273	5	Austin Street - Offset	t
274	5	Austin Street - Patina	t
275	5	Ayinger	t
276	5	BBCO - Barista	t
277	5	BBCO - Creatures Magic	t
278	5	BBCO - Dank Wizard	t
279	5	BBCO - Doom Wizard	t
280	5	BBCO - Elaborate	t
281	5	BBCO - Enchanted	t
282	5	BBCO - Good Company	t
283	5	BBCO - Lighthouse	t
284	5	BBCO - Little Wizard	t
285	5	BBCO - Lunar Wizard	t
286	5	BBCO - Phantom Glow	t
287	5	BBCO - Straw Whale	t
288	5	BBCO - Time Chimp	t
289	5	BBCO - Uncanny Valley	t
290	5	BBCO - Wizard	t
291	5	Banded - Charm	t
292	5	Banded - Dakaiju	t
293	5	Banded - Greenwarden	t
294	5	Banded - Wicked	t
295	5	Banded - Zealot	t
296	5	Battery - Blueberry	t
297	5	Battery - Endless	t
298	5	Battery - Flume	t
299	5	Battery - Flume*2	t
300	5	Battery - Golden Path	t
301	5	Bells - Big hearted	t
302	5	Bells - Christmas Ale	t
303	5	Bells - Kalamazo	t
304	5	Bells - Oberon	t
305	5	Bells - Two Hearted	t
306	5	Berkshire - Apuckalips	t
307	5	Berkshire - Coffehouse Porter	t
308	5	Berkshire - Dandelion	t
309	5	Berkshire - Marzen	t
310	5	Berkshire - Pumpkin	t
311	5	Berkshire - Steel Rail	t
312	5	Bitburger - Premium Pils	t
313	5	Breck Christmas	t
314	5	Breck Vanilla Porter	t
315	5	Bud Light	t
316	5	Bud Select	t
317	5	Budweiser	t
318	5	Busch Light	t
319	5	Captain Eli's	t
320	5	Carlsberg - Lager	t
321	5	Carlson - Berry	t
322	5	Carlson - Harvard Harvest	t
323	5	Carlson - Honey Crisp	t
324	5	Carlson - Oak Hill	t
325	5	Champlain Orch - Kingston Dry	t
326	5	Champlain Orch - Original	t
327	5	Cigar City - Jai Alai	t
328	5	Cigar City - Maduro	t
329	5	Cigar City - Oatmeal Raisin Cookie	t
330	5	Citizen Cider - B Cider	t
331	5	Citizen Cider - BD Apple Pie	t
332	5	Citizen Cider - BD Donut	t
333	5	Citizen Cider - Cran Crush	t
334	5	Citizen Cider - Juicy Haze	t
335	5	Citizen Cider - Mimosa Crush	t
336	5	Citizen Cider - Peach Crush	t
337	5	Citizen Cider - Raspberry Crush	t
338	5	Citizen Cider - Strawb Haze	t
339	5	Citizen Cider - Unified Press	t
340	5	Concord Craft - Apple Crisp	t
341	5	Concord Craft - Blue Coggler	t
342	5	Concord Craft - Conquered	t
343	5	Concord Craft - Four Rivers	t
344	5	Concord Craft - Irish Stout	t
345	5	Concord Craft - Kapital Kolsch	t
346	5	Concord Craft - Oktoberfest	t
347	5	Concord Craft - Pandora Kettle	t
348	5	Concord Craft - Pina Colada	t
349	5	Concord Craft - Pond Hockey	t
350	5	Concord Craft - Safe Space	t
351	5	Concord Craft - Squirrel Fights	t
352	5	Concord Craft - White Mtn White	t
353	5	Deciduous - Easier Operator	t
354	5	Deciduous - Easy Operator	t
355	5	Deciduous - Lollipop Rasp	t
356	5	Deciduous - NH Lager	t
357	5	Dos Equis	t
358	5	Dos Equis Amber	t
359	5	Downeast - Apple Pie	t
360	5	Downeast - Black Cherry	t
361	5	Downeast - Blackberry	t
362	5	Downeast - Caramel Apple	t
363	5	Downeast - Cider Donut	t
364	5	Downeast - Cranberry	t
365	5	Downeast - Drier Side	t
366	5	Downeast - Guava Passion	t
367	5	Downeast - Original	t
368	5	Downeast - Peach Mango	t
369	5	Downeast - Pomegranate	t
370	5	Downeast - Prickly Pear	t
371	5	Downeast - Pumpkin	t
372	5	Downeast - Winter	t
373	5	Elysian Space Dust	t
374	5	Epigram - Liam's Lager	t
375	5	Epigram - Rowdy House	t
376	5	Epigram - Temptation	t
377	5	Equilibrium - Coastline Chromatics	t
378	5	Equilibrium - Dream Wave	t
379	5	Equilibrium - Einsteins Quartet	t
380	5	Equilibrium - Element Carbon	t
381	5	Equilibrium - Field Theory	t
382	5	Equilibrium - Fluctuations	t
383	5	Equilibrium - Light at the end of the Tunnel	t
384	5	Equilibrium - MC2	t
385	5	Equilibrium - Mmm...Osa	t
386	5	Equilibrium - POG Bubbles	t
387	5	Equilibrium - Space Station Dream Lab	t
388	5	Equilibrium - Tidal Balance	t
389	5	Equilibrium - Tomorrow	t
390	5	Equilibrium - Wavelength	t
391	5	Equilibrium - eMCee	t
392	5	Exhibit A - Cats Meow	t
393	5	Exhibit A - Goody Shoes	t
394	5	Exhibit A - Panda Punch	t
395	5	Fiddlehead - Hodad	t
396	5	Fiddlehead - IPA	t
397	5	Fiddlehead - Mastermind	t
398	5	Fiddlehead - Second	t
399	5	Fiddlehead - White	t
400	5	Foundation - Berry Trifle	t
401	5	Foundation - Burnside	t
402	5	Foundation - Epiphany	t
403	5	Foundation - Fetch	t
404	5	Foundation - Raspberry	t
405	5	Founders - All Day Grapefruit IPA	t
406	5	Founders - All Day IPA	t
407	5	Founders - All Day Shandy	t
408	5	Founders - Breakfast Stout	t
409	5	Founders - CBS	t
410	5	Founders - Curmudgeon Old Ale 2016	t
411	5	Founders - Imperial Thorn	t
412	5	Founders - KBS	t
413	5	Founders - Mortal Bloom	t
414	5	Founders - Nitro Rubaeus Rasp Ale	t
415	5	Founders - Porter	t
416	5	Frost - Brown	t
417	5	Frost - Dented	t
418	5	Frost - Double Ponyboy	t
419	5	Frost - Little Lush	t
420	5	Frost - Lush	t
421	5	Frost - Plush	t
422	5	Frost - Research IPA	t
423	5	Frost - Starchild	t
424	5	Gold Road Belgian White	t
425	5	Gold Road Mango Cart	t
426	5	Golden Road AF Mango	t
427	5	Goose - Bourb County	t
428	5	Hacker-Pschorr	t
429	5	Henniker - Ambr App	t
430	5	Henniker - Damn Sure	t
431	5	Henniker - Dinger	t
432	5	Henniker - Dustoff	t
433	5	Henniker - First One Today	t
434	5	Henniker - Flap Jack	t
435	5	Henniker - Flyway	t
436	5	Henniker - Footy Pj's	t
437	5	Henniker - Henni Light	t
438	5	Henniker - Hop Slinger IPA	t
439	5	Henniker - Hugs From	t
440	5	Henniker - King Misanthrope	t
441	5	Henniker - Kolsch	t
442	5	Henniker - Miles & Miles	t
443	5	Henniker - Oktoberfest	t
444	5	Henniker - Picnic	t
445	5	Henniker - Roast	t
446	5	Henniker - Seltzer Baboosic	t
447	5	Henniker - Sour Flower	t
448	5	Henniker - Space Race	t
449	5	Henniker - Trail Buddy	t
450	5	Henniker - West Coast Colab	t
451	5	Henniker - Wrking Man Porter	t
452	5	Industrial - Wrench	t
453	5	Jack's Abby - Banner	t
454	5	Jack's Abby - Blood Orange Wheat	t
455	5	Jack's Abby - Brite as Hell	t
456	5	Jack's Abby - Citrus Wave	t
457	5	Jack's Abby - Copper Legend	t
458	5	Jack's Abby - Extra Layer	t
459	5	Jack's Abby - Framinghammer	t
460	5	Jack's Abby - House Lager	t
461	5	Jack's Abby - Lavenade	t
462	5	Jack's Abby - Porch Fest	t
463	5	Jack's Abby - Post Shift	t
464	5	Jack's Abby - Radler	t
465	5	Jack's Abby - Toy Soldier	t
466	5	Kelsen - Battle Axe	t
467	5	Kelsen - Gallowglass	t
468	5	Kelsen - Paradigm	t
469	5	Kelsen - Spacetown	t
470	5	Kentucky - BBA Imp Milk Stout	t
471	5	Kentucky - Bourbon Barrel Tart Cherry Wheat	t
472	5	Kentucky - Cocoa Porter	t
473	5	Kentucky - Vanilla Cream	t
474	5	Kona - Big Wave	t
475	5	Left Hand - Candy Cane Nitro	t
476	5	Left Hand - Coconut Milk Stout	t
477	5	Left Hand - Man/Hibiscus Belg White Nitro	t
478	5	Left Hand - Mexican Hot Choc Milk Stout	t
479	5	Left Hand - Milk Stout	t
480	5	Lord Hobo - 617 IPA	t
481	5	Lord Hobo - Atomic Black	t
482	5	Lord Hobo - Boomsauce	t
483	5	Lord Hobo - Doomsauce	t
484	5	Lord Hobo - Good Jake	t
485	5	Lord Hobo - Hop Tobaggin	t
486	5	Maine Beer Co - Another One	t
487	5	Maine Beer Co - Dinner	t
488	5	Maine Beer Co - Fall	t
489	5	Maine Beer Co - Lunch	t
490	5	Maine Beer Co - MO	t
491	5	Maine Beer Co - N Mean Tom	t
492	5	Maine Beer Co - Peeper	t
493	5	Maine Beer Co - Red IPA	t
494	5	Maine Beer Co - Spring	t
495	5	Maine Beer Co - Tiny	t
496	5	Maine Beer Co - Waters	t
497	5	Maine Beer Co - Whaleboat	t
498	5	Maine Beer Co - Wolfe's Neck	t
499	5	Mich Ultra	t
500	5	Mighty Squirrel - Cloud Candy	t
501	5	Mighty Squirrel - Dbl Cloud Candy	t
502	5	Mighty Squirrel - Fluff	t
503	5	Mighty Squirrel - Gourdgeous Pumpkin	t
504	5	Mighty Squirrel - Hammer	t
505	5	Mighty Squirrel - Heart	t
506	5	Mighty Squirrel - Kiwi White	t
507	5	Mighty Squirrel - Magic Rain	t
508	5	Mighty Squirrel - Mango Lassi	t
509	5	Mighty Squirrel - Oktoberfest	t
510	5	Mighty Squirrel - Sour Face	t
511	5	Moretti	t
512	5	New Belgium - Fat Tire	t
513	5	New Belgium - Holiday Ale	t
514	5	New Belgium - Juice Force	t
515	5	New Belgium - Juicy Haze	t
516	5	New Belgium - VR 1985 Mango	t
517	5	Newburyport - Plum Island	t
518	5	Old Speckled Hen	t
519	5	Orono - Tubular	t
520	5	Orono - Wicked	t
521	5	Oskar Blues - Dales Pale	t
522	5	Oskar Blues - Dbl Dales Pale	t
523	5	Other Half - Big Necatron Vibes	t
524	5	Other Half - Broccoli	t
525	5	Other Half - Green City	t
526	5	Other Half - Hop Showers	t
527	5	Other Half - Ideal Wave	t
528	5	Other Half - Juice Brawl	t
529	5	Other Half - LACEd in Space	t
530	5	Other Half - Motueka + Galaxy	t
531	5	Other Half - Superfun!	t
532	5	Other Half - Tall Kiwi	t
533	5	Other Half - Tens of Hundreds	t
534	5	Other Half - Ticker Shock	t
535	5	Other Half - We're Happy to Juice You	t
536	5	Paulaner	t
537	5	Peak - Sweet Tarts	t
538	5	Sea Dog - Blood Orange	t
539	5	Sea Dog - Blueberry	t
540	5	Sea Dog - Sun Fish	t
541	5	Shipyard - American Pale Ale	t
542	5	Shipyard - Boatload Berry	t
543	5	Shipyard - Finder Session	t
544	5	Shipyard - Prelude	t
545	5	Shipyard - Pumpkin Head	t
546	5	Shipyard - Signature Series	t
547	5	Shipyard - Smashed Pumpkin	t
548	5	Shipyard - Summer	t
549	5	Shocktop	t
550	5	Shocktop - Pretzel	t
551	5	Some - PB Whoopie	t
552	5	Southern - Caramel Cookie Bar	t
553	5	Southern - Caramel Pumking	t
554	5	Southern - Chestnut Praline	t
555	5	Southern - Irish Cream	t
556	5	Southern - Mokah	t
557	5	Southern - Orange Twist	t
558	5	Southern - Pumking	t
559	5	Southern - Tiramasu	t
560	5	Southern - Warlock	t
561	5	Spaten	t
562	5	Stella Artois	t
563	5	Stoneface - Astral Surf	t
564	5	Stoneface - Berliner Weisse	t
565	5	Stoneface - Coral Star	t
566	5	Stoneface - DDH Full Clip	t
567	5	Stoneface - DDH Mozz	t
568	5	Stoneface - Double Clip	t
569	5	Stoneface - Duct Tape	t
570	5	Stoneface - Duderino	t
571	5	Stoneface - Dwaynes World	t
572	5	Stoneface - Full Clip	t
573	5	Stoneface - Green Duct Tape	t
574	5	Stoneface - IPA	t
575	5	Stoneface - Imaginary Cartwheel	t
576	5	Stoneface - Neon Slick	t
577	5	Stoneface - Oktoberfest	t
578	5	Stoneface - Pink Duct Tape	t
579	5	Stoneface - Porter	t
580	5	Stoneface - Reg Sch Pro	t
581	5	Stoneface - Sunday Sauce	t
582	5	Stoneface - Treat Me	t
583	5	Throwback - Cheek Squeezer	t
584	5	Throwback - Rule Roost	t
585	5	Throwback - Wallis White	t
586	5	True North - Any Tang	t
587	5	True North - Bog Moon	t
588	5	True North - Bright & Early	t
589	5	True North - Coast to Coast	t
590	5	True North - Down By The Bay	t
591	5	True North - Northern	t
592	5	True North - Violet	t
593	5	True North - Winter Woods	t
594	5	True North - Witch	t
595	5	Tuckerman - Headwall Alt	t
596	5	Tuckerman - Pale Ale	t
597	5	Tuckerman - Rock Pile IPA	t
598	5	Upper Pass - Blue Lemon	t
599	5	Upper Pass - Cloud Drop	t
600	5	Upper Pass - First Drop	t
601	5	Victory - Golden Monkey	t
602	5	Von Trapp - Dortmunder	t
603	5	Von Trapp - NZ Pilsner	t
604	5	Von Trapp - Polotmavy	t
605	5	Von Trapp - West Coast	t
606	5	Weihenstephaner - Fiestbier	t
607	5	Weihenstephaner - Hefe	t
608	5	Weihenstephaner - Hefe Dunkel	t
609	5	Weihenstephaner - Kristalweiss	t
610	5	Wicked Weed Pernicious	t
611	5	Wicked Weed Pernicious Haze	t
612	5	Widowmaker - Blue Comet	t
613	5	Widowmaker - Blue Wizard	t
614	5	Widowmaker - Fear	t
615	5	Widowmaker - Green Wizard	t
616	5	Widowmaker - Mindcrawler	t
617	5	Widowmaker - Mt. Doom	t
618	5	Widowmaker - Return to Dust	t
619	5	Widowmaker - Riff	t
620	5	Widowmaker - Riff City	t
621	5	Widowmaker - Spring Wake	t
622	5	Woodland - Festbier	t
623	5	Woodland - NA Beer	t
624	5	Woodland - Ruby Slippers	t
625	5	Wormtown - Be Hoppy	t
626	5	Wormtown - Be Juicy	t
627	5	Wormtown - Be Smooth	t
628	5	Wormtown - Beach Fix	t
629	5	Wormtown - Blizzard	t
630	5	Wormtown - Fresh Patch	t
631	5	Wormtown - Fresh Patch_2	t
632	5	Wormtown - Irish Red	t
633	5	Wormtown - Irish Red_2	t
634	5	Wormtown - Summer	t
635	5	Wormtown - Yard Party	t
636	5	Zero Gravity - 40 Thieves	t
637	5	Zero Gravity - Cone Head	t
638	5	Zero Gravity - Cone Head Haze	t
639	5	Zero Gravity - Duck Duck	t
640	5	Zero Gravity - Evergreen	t
641	5	Zero Gravity - Extra Stout	t
642	5	Zero Gravity - Green State	t
643	5	Zero Gravity - Green State Light	t
644	5	Zero Gravity - Jaws Czech	t
645	5	Zero Gravity - Madonna	t
646	5	Zero Gravity - Oktoberfest	t
647	5	Zero Gravity - Pisolino	t
648	5	Zero Gravity - Powder Jones	t
649	5	Zero Gravity - Shandy	t
650	5	Zero Gravity - Woodchuck	t
651	5	von Trapp - Dunkel	t
652	5	von Trapp - Echo Love	t
653	5	von Trapp - Helles	t
654	5	von Trapp - Oktober	t
655	5	von Trapp - Pilsner	t
656	5	von Trapp - Pine 1769	t
657	5	von Trapp - Radler	t
658	5	von Trapp - Schwarz	t
659	5	von Trapp - Stowe Style	t
660	5	von Trapp - Trosten	t
661	5	von Trapp - Vienna	t
662	6	BeatBox Vrty	t
663	6	Bud Light	t
664	6	Budweiser	t
665	7	603 Brew - Coffee Cake Porter	t
666	7	603 Brew - IPA	t
667	7	603 Brew - Knuckle	t
668	7	603 Brew - Sparkle Bomb	t
669	7	603 Brew - Summa	t
670	7	603 Brew - Toast Pumpkin	t
671	7	603 Brew - Winni	t
672	7	Arizona	t
673	7	Arizona Hard Lemon T	t
674	7	Athletic - Free Wave	t
675	7	Athletic - Geralts Gold	t
676	7	Athletic - Lite	t
677	7	Athletic - Oktoberfest	t
678	7	Athletic - Run Wild	t
679	7	Athletic - Upside Dawn	t
680	7	Bud Light	t
681	7	Bud Light Next	t
682	7	Budweiser	t
683	7	Busch	t
684	7	Busch Light	t
685	7	Busch Light Peach	t
686	7	Cabot	t
687	7	Citizen Cider - Dirty Mayor	t
688	7	Clearly Canadian Country Raspberry	t
689	7	Clearly Canadian Mountain Blackberry	t
690	7	Clubtails	t
691	7	Concord Craft - Pond Hockey	t
692	7	Concord Craft - White Mtn White	t
693	7	Daily's Cocktails	t
694	7	Deep River	t
695	7	Dos Equis	t
696	7	Dos Equis Amber	t
697	7	Downeast - Blackberry	t
698	7	Downeast - Caramel Apple	t
699	7	Downeast - Cider Donut	t
700	7	Downeast - Cranberry	t
701	7	Downeast - Original	t
702	7	Downeast - Peach Mango	t
703	7	Downeast - Pomegranate	t
704	7	Downeast - Prickly Pear	t
705	7	Downeast - Pumpkin	t
706	7	Downeast - Winter	t
707	7	Fiddlehead - IPA	t
708	7	Ghost Energy	t
709	7	Gold Road Mango Cart	t
710	7	Good 2 grow	t
711	7	Good Boy J Daly	t
712	7	Heineken	t
713	7	Henniker - Flap Jack	t
714	7	Henniker - Picnic	t
715	7	Henniker - Sour Flower	t
716	7	Henniker - Wrking Man Porter	t
717	7	Jack's Abby - Extra Layer	t
718	7	Joe Tea	t
719	7	Johny Bootlegger	t
720	7	Kona - Big Wave	t
721	7	Lagunitas - Hoppy Refresher	t
722	7	MISC Encompass Conv Items	t
723	7	Mich Ultra	t
724	7	Misc Keg Other	t
725	7	Natty Daddy	t
726	7	Nutrl	t
727	7	Nutrl Lemonade Vrty	t
728	7	Phorm Energy Freedom	t
729	7	Popwell	t
730	7	Shipyard - Pumpkin Head	t
731	7	Snapple	t
732	7	Sparkling Ice	t
733	7	Sparkling Ice Caf	t
734	7	Stella Artois	t
735	7	Stoneface - Astral Surf	t
736	7	Stoneface - Crown Shy	t
737	7	Stoneface - Duderino	t
738	7	Stoneface - IPA	t
739	7	Stoneface - Sunday Sauce	t
740	7	Stoneface - Town Car	t
741	7	Tivoli - Outlaw	t
742	7	von Trapp - Dunkel	t
743	8	Athletic - Run Wild	t
744	8	Bud Light	t
745	8	Budweiser	t
746	8	Dos Equis	t
747	8	Downeast - Original	t
748	8	Fiddlehead - IPA	t
749	8	Kona - Big Wave	t
750	8	Mich Ultra	t
751	8	Nutrl	t
752	8	Popwell	t
753	8	Stoneface - IPA	t
754	9	14th Star - Valor	t
755	9	1911 - Cider Donut	t
756	9	603 Brew - Coffee Cake Porter	t
757	9	603 Brew - IPA	t
758	9	603 Brew - Summa	t
759	9	603 Brew - Toast Pumpkin	t
760	9	603 Brew - Winni	t
761	9	Able - Burn the Ships	t
762	9	Athletic - Run Wild	t
763	9	Berkshire - Coffehouse Porter	t
764	9	Berkshire - Marzen	t
765	9	Bud Light	t
766	9	Bud Select	t
767	9	Budweiser	t
768	9	Captain Eli's	t
769	9	Concord Craft - Four Rivers	t
770	9	Concord Craft - White Mtn White	t
771	9	Deciduous - Lollipop Rasp	t
772	9	Downeast - Apple Pie	t
773	9	Downeast - Blackberry	t
774	9	Downeast - Cider Donut	t
775	9	Downeast - Guava Passion	t
776	9	Downeast - Original	t
777	9	Downeast - Pomegranate	t
778	9	Downeast - Winter	t
779	9	Elysian Space Dust	t
780	9	Fiddlehead - IPA	t
781	9	Fiddlehead - Second	t
782	9	Fiddlehead - White	t
783	9	Frost - Lush	t
784	9	Frost - Research DIPA	t
785	9	Gold Road Mango Cart	t
786	9	Goose - Bourb County	t
787	9	Jack's Abby - Extra Layer	t
788	9	Jack's Abby - Porch Fest	t
789	9	Kelsen - Battle Axe	t
790	9	Kona - Big Wave	t
791	9	Lord Hobo - Boomsauce	t
792	9	Maine Beer Co - Dinner	t
793	9	Maine Beer Co - Lunch	t
794	9	Mich Ultra	t
795	9	Mighty Squirrel - Cloud Candy	t
796	9	New Belgium - Fat Tire	t
797	9	New Belgium - Juicy Haze	t
798	9	Sea Dog - Blueberry	t
799	9	Shipyard - Pumpkin Head	t
800	9	Some - PB Whoopie	t
801	9	Stella Artois	t
802	9	Stoneface - Green Duct Tape	t
803	9	Stoneface - IPA	t
804	9	Throwback - Wallis White	t
805	9	Tuckerman - Rock Pile IPA	t
806	9	Wormtown - Be Hoppy	t
807	9	Wormtown - Blizzard	t
808	9	Wormtown - Blizzard_2	t
809	9	Wormtown - Fresh Patch	t
810	9	Zero Gravity - Green State	t
811	9	Zero Gravity - Jaws Czech	t
812	9	Zero Gravity - Pisolino	t
813	9	von Trapp - Dunkel	t
814	9	von Trapp - Pilsner	t
815	9	von Trapp - Radler	t
816	10	BL Seltzer Variety	t
817	10	BUD LIGHT SELTZER PINK LEMONADE	t
818	10	Bud Light	t
819	10	Budweiser	t
820	10	Dos Equis	t
821	10	Fiddlehead - IPA	t
822	10	Kona - Big Wave	t
823	10	Landshark Lager	t
824	10	Mich Ultra	t
825	10	Mighty Squirrel - Cloud Candy	t
826	10	NOCA	t
827	10	Nutrl	t
828	10	Poland Spring	t
829	10	Sparkling Ice	t
830	10	Stella Artois	t
831	10	Zero Gravity - Cone Head	t
833	12	Bud light	f
834	12	Mic Ultra	f
\.


--
-- Data for Name: catalog_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalog_items (id, name, icon, color, is_default) FROM stdin;
1	Coaster	⭕	#e8a020	t
2	Display/ Display Enhancer	🖼️	#60b880	t
3	Glass	🥂	#60a0e8	t
4	Illuminated Sign	💡	#f0d020	t
5	Large Tap Marker	🍺	#e05050	t
6	Mirror	🪞	#c080e0	t
7	Other	📦	#808080	t
8	Promo Item	🎁	#e070a0	t
9	Small Tap Marker	🔵	#40c0c0	t
10	Umbrella	☂️	#4080d0	t
12	T Shirts	🎽	\N	f
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, name, rep_username, chain, customer_type, active, created_at, updated_at) FROM stdin;
1	AJ'S SPORTS BAR & GRILL	rconstant	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:30.073905	2026-03-17 15:24:30.073905
2	A L PRIME ENERGY CONSULTANT	eplatt	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.08291	2026-03-17 15:24:30.08291
3	A & M JUNCTION MARKET	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.086725	2026-03-17 15:24:30.086725
4	A & M SANDOWN MARKET	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.089518	2026-03-17 15:24:30.089518
5	RK FOOD MART	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.093422	2026-03-17 15:24:30.093422
6	ACE DISCOUNT CIGARETTES	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.09674	2026-03-17 15:24:30.09674
8	AMHERST COUNTRY CLUB	sshaunessy	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:30.167668	2026-03-17 15:24:30.167668
9	RIVERSIDE GRILLE	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.172141	2026-03-17 15:24:30.172141
10	AMHERST STREET SHELL #1123 - 190 AMHERST - NASHUA	sshaunessy	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:30.175425	2026-03-17 15:24:30.175425
11	TOMAHAWK BUTCHERY & TAVERN (REST)	tchagnon	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.178427	2026-03-17 15:24:30.178427
12	AMPHORA RESTAURANT	eleahy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.18091	2026-03-17 15:24:30.18091
13	A & P CORNER MARKET LLC	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.184654	2026-03-17 15:24:30.184654
14	APPLEBEES - DERRY	eleahy	APPLEBEES	Restaurant	t	2026-03-17 15:24:30.187173	2026-03-17 15:24:30.187173
15	APPLEBEES - NASHUA Amherst St	scamuso	APPLEBEES	Restaurant	t	2026-03-17 15:24:30.189687	2026-03-17 15:24:30.189687
17	ATKINSON RESORT AND COUNTRY CLUB	jcannamucio	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:30.198754	2026-03-17 15:24:30.198754
18	ATKINSON RESORT AND COUNTRY CLUB (CONCESSIONS)	jcannamucio	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:30.20331	2026-03-17 15:24:30.20331
19	ATKINSON VILLAGE STORE	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.206749	2026-03-17 15:24:30.206749
21	BJ'S WHOLESALE -NASHUA #39	jsmoyer	BJ'S WHOLESALE	Club Store	t	2026-03-17 15:24:30.21386	2026-03-17 15:24:30.21386
22	BJ'S WHOLESALE-SALEM #17	jsmoyer	BJ'S WHOLESALE	Club Store	t	2026-03-17 15:24:30.217492	2026-03-17 15:24:30.217492
23	BACKSTREET BAR & GRILL LLC	amartin	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:30.222887	2026-03-17 15:24:30.222887
24	FROGG'S PARTY PAD	nmoore	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:30.226666	2026-03-17 15:24:30.226666
25	KLEMM'S FAMILY STORE	ddooling	Klemm's	Convenience	t	2026-03-17 15:24:30.23002	2026-03-17 15:24:30.23002
26	BANI MINI MARKET	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.234007	2026-03-17 15:24:30.234007
27	BANTAM GRILL	pbelanger	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.236508	2026-03-17 15:24:30.236508
28	COPPER KETTLE	ggage	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.239104	2026-03-17 15:24:30.239104
29	SCAS WORTHEN LLC	lnorton	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.242895	2026-03-17 15:24:30.242895
30	BEDFORD VILLAGE INN & REST.	lnorton	BVI	Restaurant	t	2026-03-17 15:24:30.246572	2026-03-17 15:24:30.246572
31	BEER STORE (THE) - NASHUA	scamuso	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:30.249575	2026-03-17 15:24:30.249575
32	ETNA COUNTRY STORE	jjohnson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.252638	2026-03-17 15:24:30.252638
33	BEST BET STATELINE	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.256217	2026-03-17 15:24:30.256217
34	BIG APPLE FOOD STORE 1113	pbelanger	BIG APPLE	Convenience	t	2026-03-17 15:24:30.259526	2026-03-17 15:24:30.259526
36	BISHOP GUERTIN H.S.	jsweeney	* Independent BELLAVANCE BEVERAGE	School	t	2026-03-17 15:24:30.264843	2026-03-17 15:24:30.264843
37	PELHAM STREET BLACK WATER GRILL	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.26778	2026-03-17 15:24:30.26778
38	LINKS AT LABELLE WINERY (THE)	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.271232	2026-03-17 15:24:30.271232
39	BONHOEFFERS CAFE	jsweeney	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.275915	2026-03-17 15:24:30.275915
41	GATE CITY CASINO	scamuso	* Independent BELLAVANCE BEVERAGE	Casino	t	2026-03-17 15:24:30.283181	2026-03-17 15:24:30.283181
42	BOWLING ACRES	pbelanger	* Independent BELLAVANCE BEVERAGE	Bowling/Billiards	t	2026-03-17 15:24:30.285905	2026-03-17 15:24:30.285905
43	BP GAS - LONDONDERRY	jsweeney	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.289224	2026-03-17 15:24:30.289224
44	BRADYS BAR AND GRILL	pbelanger	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.293097	2026-03-17 15:24:30.293097
45	A LOT OF THAI	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.295918	2026-03-17 15:24:30.295918
46	BRANDO'S PIZZA	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.298932	2026-03-17 15:24:30.298932
47	CASA BLANCA	nmoore	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:30.302044	2026-03-17 15:24:30.302044
48	BRIGHT SPOT	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.305088	2026-03-17 15:24:30.305088
49	BROAD STREET GULF	scamuso	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.308922	2026-03-17 15:24:30.308922
50	BROAD ST. PETROLEUM LLC	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.312602	2026-03-17 15:24:30.312602
51	BROOKDALE FRUIT FARM	jsweeney	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:30.315291	2026-03-17 15:24:30.315291
52	BROOKLINE EVENT CENTER	nmoore	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:30.318785	2026-03-17 15:24:30.318785
53	HUDSON BREWS	maanderson	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:30.322521	2026-03-17 15:24:30.322521
54	BROTHERS BUTCHER	lortiz	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.326166	2026-03-17 15:24:30.326166
55	BUCKLEY'S GREAT STEAKS	tchagnon	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.329086	2026-03-17 15:24:30.329086
56	BURTON'S GRILL	lortiz	BURTON'S GRILL	Restaurant	t	2026-03-17 15:24:30.332717	2026-03-17 15:24:30.332717
60	CAMPBELL'S SCOTTISH HIGHLAND GOLF COURSE	ddooling	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:30.407013	2026-03-17 15:24:30.407013
61	EL TIPICO RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.410728	2026-03-17 15:24:30.410728
62	CAPTAIN'S CORNER	scamuso	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.413632	2026-03-17 15:24:30.413632
63	CARRIAGE TOWN BAR & GRILL	jcannamucio	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:30.416694	2026-03-17 15:24:30.416694
64	CASK & VINE LLC	eleahy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.419126	2026-03-17 15:24:30.419126
65	CARYN'S COUNTRY CONVENIENCE	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.423601	2026-03-17 15:24:30.423601
66	MR. HANDYMAN	jsweeney	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:30.427831	2026-03-17 15:24:30.427831
67	SUPER SMOKE SHOP & MART	nmoore	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:30.432382	2026-03-17 15:24:30.432382
68	CIRCLE K #7238 - SALEM	jgiuffrida	CIRCLE K	Convenience	t	2026-03-17 15:24:30.435721	2026-03-17 15:24:30.435721
69	CIRCLE K #7259 - BEDFORD - TECHNOLOGY DR	tchagnon	CIRCLE K	Convenience	t	2026-03-17 15:24:30.438264	2026-03-17 15:24:30.438264
70	CIRCLE K #7263 - BEDFORD - WHITE AVE	lnorton	CIRCLE K	Convenience	t	2026-03-17 15:24:30.441856	2026-03-17 15:24:30.441856
71	CIRCLE K #7236 - MILFORD	ggage	CIRCLE K	Convenience	t	2026-03-17 15:24:30.444819	2026-03-17 15:24:30.444819
72	CIRCLE K #7234 - DERRY - 28 BYPASS	eleahy	CIRCLE K	Convenience	t	2026-03-17 15:24:30.449345	2026-03-17 15:24:30.449345
73	CIRCLE K #7261 - HUDSON	rconstant	CIRCLE K	Convenience	t	2026-03-17 15:24:30.453205	2026-03-17 15:24:30.453205
74	FRONTERA GRILL OF NASHUA	scamuso	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:30.456419	2026-03-17 15:24:30.456419
75	CHILI'S - NASHUA - DW HWY	lortiz	CHILI'S REST	Restaurant	t	2026-03-17 15:24:30.460327	2026-03-17 15:24:30.460327
76	CHILI'S - SALEM	ddooling	CHILI'S REST	Restaurant	t	2026-03-17 15:24:30.464336	2026-03-17 15:24:30.464336
77	CHIPOTLE - NASH - DW HWY	nmoore	CHIPOTLE MEXI	Restaurant	t	2026-03-17 15:24:30.467242	2026-03-17 15:24:30.467242
79	CHRISTINA'S COUNTRY CAFE (OBER EASY LLC)	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.473364	2026-03-17 15:24:30.473364
80	CHRYSANTHI'S	ggage	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.476453	2026-03-17 15:24:30.476453
81	CHURCH SIDE MARKET	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.479426	2026-03-17 15:24:30.479426
82	HARE OF THE DAWG BAR & GRILL	eleahy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.482599	2026-03-17 15:24:30.482599
83	CLOUD LOUNGE	nmoore	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:30.487347	2026-03-17 15:24:30.487347
84	COLOSSEUM RESTAURANT (THE)	rmarique	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.491673	2026-03-17 15:24:30.491673
85	COMMON MAN - WINDHAM	rmarique	COMMON MAN	Restaurant	t	2026-03-17 15:24:30.494388	2026-03-17 15:24:30.494388
86	COMMON MAN - MERRIMACK	tchagnon	COMMON MAN	Restaurant	t	2026-03-17 15:24:30.497058	2026-03-17 15:24:30.497058
87	COPPER DOOR - BEDFORD	lnorton	T-BONES	Restaurant	t	2026-03-17 15:24:30.50159	2026-03-17 15:24:30.50159
88	COSTCO #307 - NASHUA	jsmoyer	COSTCO	Club Store	t	2026-03-17 15:24:30.504991	2026-03-17 15:24:30.504991
89	BROKEN YOLK GRILL	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.507983	2026-03-17 15:24:30.507983
90	COUSINS CONVENIENCE STORE	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.510844	2026-03-17 15:24:30.510844
91	COUNTRY CORNER MILE	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.513503	2026-03-17 15:24:30.513503
92	COURTYARD BY MARRIOTT - NASHUA	scamuso	COURTYARD MARRIOTT	Hotel/Lodging	t	2026-03-17 15:24:30.518383	2026-03-17 15:24:30.518383
93	THE NEST PUB AND GRILL	jcannamucio	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:30.52141	2026-03-17 15:24:30.52141
94	CUCINA TOSCANA	scamuso	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.52437	2026-03-17 15:24:30.52437
95	CUMBERLAND FM #5409 - DERRY	eleahy	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:30.52704	2026-03-17 15:24:30.52704
96	CUMBERLAND FM #5400 - HUDSON	amartin	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:30.530607	2026-03-17 15:24:30.530607
97	CUMBERLAND FM #5529 - MILFORD-OLD	ggage	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:30.532991	2026-03-17 15:24:30.532991
98	CUMBERLAND FM #5433 - NASHUA - AMHERST ST	sshaunessy	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:30.536103	2026-03-17 15:24:30.536103
99	CUMBERLAND FM #5436 - NASHUA - 111 DW HWY	amartin	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:30.539142	2026-03-17 15:24:30.539142
100	CUMBERLAND FM #5545 - PLAISTOW	eplatt	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:30.542301	2026-03-17 15:24:30.542301
101	CUMBERLAND FM #5544 - SALEM	ddooling	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:30.545733	2026-03-17 15:24:30.545733
102	CUMBERLAND FM #5423 - NASHUA - 308 DW HWY	lortiz	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:30.551592	2026-03-17 15:24:30.551592
103	CVS PHARM #639 - NASH - MAIN ST	amartin	CVS STORES	Drug Store	t	2026-03-17 15:24:30.556307	2026-03-17 15:24:30.556307
104	CVS PHARM #2420 - LONDERY	rconstant	CVS STORES	Drug Store	t	2026-03-17 15:24:30.560299	2026-03-17 15:24:30.560299
105	CVS PHARM #1003 - NASH - DW HWY	lortiz	CVS STORES	Drug Store	t	2026-03-17 15:24:30.563729	2026-03-17 15:24:30.563729
106	CVS PHARM #164 - WINDH - WALL ST	rmarique	CVS STORES	Drug Store	t	2026-03-17 15:24:30.566824	2026-03-17 15:24:30.566824
107	CVS PHARM #1175 - HUDSON	amartin	CVS STORES	Drug Store	t	2026-03-17 15:24:30.570094	2026-03-17 15:24:30.570094
108	CVS PHARM #1004 - SALEM - S.BROADWAY	ddooling	CVS STORES	Drug Store	t	2026-03-17 15:24:30.572894	2026-03-17 15:24:30.572894
109	CVS PHARM #181 - PLAISTOW	eplatt	CVS STORES	Drug Store	t	2026-03-17 15:24:30.57599	2026-03-17 15:24:30.57599
110	CVS PHARM #593 - DERRY	eleahy	CVS STORES	Drug Store	t	2026-03-17 15:24:30.579897	2026-03-17 15:24:30.579897
111	CVS PHARM #723 - NASH - AMHERST ST	jcaron	CVS STORES	Drug Store	t	2026-03-17 15:24:30.584047	2026-03-17 15:24:30.584047
112	CVS PHARM #741 - BEDFORD - S.RIVER RD	tchagnon	CVS STORES	Drug Store	t	2026-03-17 15:24:30.588166	2026-03-17 15:24:30.588166
113	CVS PHARM #902 - MERRIMACK	tchagnon	CVS STORES	Drug Store	t	2026-03-17 15:24:30.591928	2026-03-17 15:24:30.591928
114	CVS PHARM #3063 - PETERBORO	pbelanger	CVS STORES	Drug Store	t	2026-03-17 15:24:30.595325	2026-03-17 15:24:30.595325
119	D & J CORNER MARKET	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.610345	2026-03-17 15:24:30.610345
120	DW HIGHWAY MOBIL INC	tchagnon	CIRCLE K FRANC	Convenience	t	2026-03-17 15:24:30.612896	2026-03-17 15:24:30.612896
121	DW PIZZA INC	tchagnon	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.615189	2026-03-17 15:24:30.615189
122	MARKET AT SWEET HILL FARM	nmoore	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:30.618748	2026-03-17 15:24:30.618748
123	DELAY'S HARVESTER MARKET	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.623504	2026-03-17 15:24:30.623504
124	MARKET BASKET #06 SALEM	jgiuffrida	MARKET BASKET	Supermarket	t	2026-03-17 15:24:30.62737	2026-03-17 15:24:30.62737
125	DERRY SALEM ELKS 2226	ddooling	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:30.630134	2026-03-17 15:24:30.630134
126	DERRY QUICK MART	eleahy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.633366	2026-03-17 15:24:30.633366
127	YA MAS GREEK TAVERNA & BAR	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.636256	2026-03-17 15:24:30.636256
128	NH DISCOUNT STORE	ddooling	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.638989	2026-03-17 15:24:30.638989
129	DODGE'S COUNTRY STORE	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.641902	2026-03-17 15:24:30.641902
130	DOLLAR GENER #13698 - JAFFREY	pbelanger	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:30.644595	2026-03-17 15:24:30.644595
131	DOLLAR GENER #13313 - NASHUA	amartin	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:30.646897	2026-03-17 15:24:30.646897
132	PIZZA PEDDLER & MINI MART	pbelanger	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.649709	2026-03-17 15:24:30.649709
133	603 VAPE & SMOKE	jsweeney	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:30.652097	2026-03-17 15:24:30.652097
134	DUKES COUNTRY STORE	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.655498	2026-03-17 15:24:30.655498
135	DUSTY'S CONVENIENCE INC.	ddooling	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.658875	2026-03-17 15:24:30.658875
136	MONADNOCK COUNTRY CLUB	pbelanger	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:30.661017	2026-03-17 15:24:30.661017
137	FORBES TAVERN AND EVENTS	jmorse	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:30.663274	2026-03-17 15:24:30.663274
138	EARLY BIRD CAFE (THE)	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.665349	2026-03-17 15:24:30.665349
139	EAST HOLLIS ST. VARIETY	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.668013	2026-03-17 15:24:30.668013
140	EL TAPATIO RESTAURANTE MEXICANO LLC	scamuso	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:30.670397	2026-03-17 15:24:30.670397
141	NASHUA ELKS LODGE 720	sshaunessy	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:30.672604	2026-03-17 15:24:30.672604
142	A L PRIME ENERGY MERRIMACK	tchagnon	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.675117	2026-03-17 15:24:30.675117
143	ENERGY NORTH #2216 - AMHERST	jcaron	ENERGY NORTH	Convenience	t	2026-03-17 15:24:30.677839	2026-03-17 15:24:30.677839
144	ENERGY NORTH #2218 - MERRIMACK	tchagnon	ENERGY NORTH	Convenience	t	2026-03-17 15:24:30.680361	2026-03-17 15:24:30.680361
145	ENERGY NORTH #2219 - SALEM - N.BROADWAY	rmarique	ENERGY NORTH	Convenience	t	2026-03-17 15:24:30.682981	2026-03-17 15:24:30.682981
146	RMZ TRAVEL CENTER	rconstant	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.685068	2026-03-17 15:24:30.685068
147	FAMILY PIZZA AND ROAST BEEF OF NASHUA	scamuso	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.687872	2026-03-17 15:24:30.687872
148	FAMILY DOLLAR #8353 - NASHUA	amartin	FAMILY DOLLAR	Other Off-Premise	t	2026-03-17 15:24:30.690009	2026-03-17 15:24:30.690009
149	FANG CHEN'S RESTAURANT	eleahy	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:30.692221	2026-03-17 15:24:30.692221
150	K2 MOBIL MART	lnorton	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.694775	2026-03-17 15:24:30.694775
151	FODY'S TAVERN (NASHUA)	amartin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.697356	2026-03-17 15:24:30.697356
152	FOOD PLUS	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.699866	2026-03-17 15:24:30.699866
153	FOTENE'S MARKET	scamuso	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.702743	2026-03-17 15:24:30.702743
154	50 EAST DERRY ROAD CONVENIENCE	eleahy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.7056	2026-03-17 15:24:30.7056
155	FIRST CHANCE CONV STORE LLC	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.708371	2026-03-17 15:24:30.708371
156	HIMALAYAN CURRY HOUSE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.710464	2026-03-17 15:24:30.710464
157	FRANCESTOWN VILLAGE STORE LLC	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.712679	2026-03-17 15:24:30.712679
158	STATION 101	ggage	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:30.714876	2026-03-17 15:24:30.714876
159	FRIGHT KINGDOM	jsweeney	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:30.717764	2026-03-17 15:24:30.717764
160	GAGE HILL FARM	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.719885	2026-03-17 15:24:30.719885
161	GERARDO'S TRATTORIA AMALF	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.721956	2026-03-17 15:24:30.721956
162	GIORGIO'S RISTORANTE - MILFORD	ggage	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.724281	2026-03-17 15:24:30.724281
163	GIORGIO'S TRATTORIA - MERRIMACK	scamuso	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.726784	2026-03-17 15:24:30.726784
165	GOLDEN DRAGON RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:30.732127	2026-03-17 15:24:30.732127
168	GRAND 38 RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:30.741056	2026-03-17 15:24:30.741056
169	LIM'S SPORTS BAR & CAFE	jgiuffrida	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.74399	2026-03-17 15:24:30.74399
170	GRAPPELLI'S CRAFT PIZZA	pbelanger	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.747011	2026-03-17 15:24:30.747011
171	AMERICAN LEGION POST 13 - GREENVILLE	ggage	American Legion	VFW/Legion	t	2026-03-17 15:24:30.74947	2026-03-17 15:24:30.74947
173	HALCYON CLUB	eleahy	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:30.755228	2026-03-17 15:24:30.755228
174	HAMPSHIRE HILLS S&F CLUB	ggage	* Independent BELLAVANCE BEVERAGE	Recreation/Sports	t	2026-03-17 15:24:30.758004	2026-03-17 15:24:30.758004
175	HAMPSTEAD VIDEO & VARIETY	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.761395	2026-03-17 15:24:30.761395
176	HANNAFORD #8183 - HUDSON	amartin	HANNAFORD	Supermarket	t	2026-03-17 15:24:30.764227	2026-03-17 15:24:30.764227
177	HANNAFORD #8016 - DERRY	eleahy	HANNAFORD	Supermarket	t	2026-03-17 15:24:30.767251	2026-03-17 15:24:30.767251
178	HANNAFORD #8190 - HAMPSTEAD	jcannamucio	HANNAFORD	Supermarket	t	2026-03-17 15:24:30.770805	2026-03-17 15:24:30.770805
179	HANNAFORD #8015 - PELHAM	maanderson	HANNAFORD	Supermarket	t	2026-03-17 15:24:30.773737	2026-03-17 15:24:30.773737
181	HANNAFORD #8186 - NASHUA	sshaunessy	HANNAFORD	Supermarket	t	2026-03-17 15:24:30.779314	2026-03-17 15:24:30.779314
182	HENHOUSE BAR & GRILL	jcannamucio	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:30.782091	2026-03-17 15:24:30.782091
183	HIDDEN CREEK COUNTRY CLUB	rconstant	PASS/HIDDEN	Golf Club	t	2026-03-17 15:24:30.784441	2026-03-17 15:24:30.784441
184	O'SHEAS CAFE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.787323	2026-03-17 15:24:30.787323
185	HOLLIS VILLAGE GROCERY	jcaron	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.790239	2026-03-17 15:24:30.790239
186	HOMESTEAD RESTAURANT & TAVERN	tchagnon	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.793092	2026-03-17 15:24:30.793092
187	HANNAFORD #8436 - BEDFORD - KILTON RD	tchagnon	HANNAFORD	Supermarket	t	2026-03-17 15:24:30.795487	2026-03-17 15:24:30.795487
188	HANNAFORD #8305 - BEDFORD - JENKINS RD	lnorton	HANNAFORD	Supermarket	t	2026-03-17 15:24:30.7983	2026-03-17 15:24:30.7983
189	HANNAFORD #8185 - LONDERY	rconstant	HANNAFORD	Supermarket	t	2026-03-17 15:24:30.801034	2026-03-17 15:24:30.801034
190	HAR HAR MAHADEV INC	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.803381	2026-03-17 15:24:30.803381
191	TOBACCO BARN - NASHUA	lortiz	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:30.806097	2026-03-17 15:24:30.806097
192	BEER STORE LLC (THE) - SALEM	ddooling	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:30.809779	2026-03-17 15:24:30.809779
193	HBTSOTR LLC	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.813202	2026-03-17 15:24:30.813202
194	HOWIE GLYNN - WINDHAM - COBBETS RD.	ddooling	HOWIE GLYNN	Convenience	t	2026-03-17 15:24:30.815565	2026-03-17 15:24:30.815565
195	HOWIE GLYNN - WINDHAM - INDIAN RD	ddooling	HOWIE GLYNN	Convenience	t	2026-03-17 15:24:30.817909	2026-03-17 15:24:30.817909
196	HOWIE GLYNN - SALEM	ddooling	HOWIE GLYNN	Convenience	t	2026-03-17 15:24:30.821043	2026-03-17 15:24:30.821043
197	AMERICAN LEGION POST 48 - HUDSON	amartin	American Legion	VFW/Legion	t	2026-03-17 15:24:30.823896	2026-03-17 15:24:30.823896
198	NEW WORLD GAS - RINDGE	pbelanger	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.826552	2026-03-17 15:24:30.826552
199	HRA MARKET	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.830143	2026-03-17 15:24:30.830143
200	SUN ASIAN BISTRO	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:30.832753	2026-03-17 15:24:30.832753
202	PENALTY BOX BAR & GRILL	jgiuffrida	* Independent BELLAVANCE BEVERAGE	Concessionaire	t	2026-03-17 15:24:30.838585	2026-03-17 15:24:30.838585
203	YOMA FOOD MARKET	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.841331	2026-03-17 15:24:30.841331
204	J DONS STATE LINE	scamuso	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.84549	2026-03-17 15:24:30.84549
206	JADE DRAGON-MERRIMACK	tchagnon	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:30.852804	2026-03-17 15:24:30.852804
207	AMERICAN LEGION POST 11 - JAFFREY	pbelanger	American Legion	VFW/Legion	t	2026-03-17 15:24:30.855378	2026-03-17 15:24:30.855378
208	JB BUTCHER LLC	jcannamucio	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:30.858668	2026-03-17 15:24:30.858668
209	RIVIERA NAYARITA MEXICAN-STYLE SEAFOOD	sshaunessy	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:30.862478	2026-03-17 15:24:30.862478
210	JEANNOTTE'S MARKET	scamuso	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.865236	2026-03-17 15:24:30.865236
211	KASHMIR INDIAN CUISINE	jgiuffrida	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.868407	2026-03-17 15:24:30.868407
212	KENDALL POND PIZZA-WINDHAM	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.871982	2026-03-17 15:24:30.871982
213	SNACKSHOT CATERING	jmeharg	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:30.874915	2026-03-17 15:24:30.874915
214	KEV'S COUNTRY STORE	ddooling	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.877857	2026-03-17 15:24:30.877857
215	KINGSTON VETS CLUB INC	jcannamucio	* Independent BELLAVANCE BEVERAGE	VFW/Legion	t	2026-03-17 15:24:30.880626	2026-03-17 15:24:30.880626
216	KINGSTON 1686 HOUSE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.884247	2026-03-17 15:24:30.884247
217	BUCKLEY'S BAKERY HOLLIS	jcaron	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:30.887608	2026-03-17 15:24:30.887608
218	KIRKPATRICKS CORNER	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.890307	2026-03-17 15:24:30.890307
219	KLEMM'S MOBIL	ddooling	Klemm's	Convenience	t	2026-03-17 15:24:30.893447	2026-03-17 15:24:30.893447
220	LABELLE WINERY EVENTS	jcaron	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:30.896621	2026-03-17 15:24:30.896621
221	LA CARRETA - NASHUA	amartin	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:30.899307	2026-03-17 15:24:30.899307
222	LA CARRETA - DERRY	eleahy	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:30.902972	2026-03-17 15:24:30.902972
223	LA HACIENDA DEL RIO	amartin	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:30.90633	2026-03-17 15:24:30.90633
224	LAFAYETTE CLUB A.C.	sshaunessy	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:30.910284	2026-03-17 15:24:30.910284
225	LAKE STREET CONVENIENCE	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.913119	2026-03-17 15:24:30.913119
226	LANNA ASIAN MARKET LLC	scamuso	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.916318	2026-03-17 15:24:30.916318
227	LEI'S GARDEN INC.	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:30.919828	2026-03-17 15:24:30.919828
228	LILAC BLOSSOM - AMHERST ST.	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:30.926603	2026-03-17 15:24:30.926603
229	LILAC BLOSSOM - SOUTH END	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:30.930351	2026-03-17 15:24:30.930351
230	LI'L LOBSTER BOAT	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.935028	2026-03-17 15:24:30.935028
231	LOBSTER BOAT RESTAURANT	tchagnon	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.943984	2026-03-17 15:24:30.943984
232	BEER & WINE NATION - LONDONDERRY	rconstant	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.947223	2026-03-17 15:24:30.947223
233	ASIAN KITCHEN	ggage	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.950899	2026-03-17 15:24:30.950899
234	LONGHORN STEAK #5278 - AMHERST	jcaron	LONGHORN STEAK N1003	Restaurant	t	2026-03-17 15:24:30.954758	2026-03-17 15:24:30.954758
235	LONGHORN STEAK #5457 - NASHUA	lortiz	LONGHORN STEAK N1003	Restaurant	t	2026-03-17 15:24:30.958222	2026-03-17 15:24:30.958222
238	PB'S CONVENIENCE	nmoore	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:30.969988	2026-03-17 15:24:30.969988
239	LUI LUI - NASHUA	lortiz	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.97519	2026-03-17 15:24:30.97519
240	MCKINNON'S MARKET PLACE	ddooling	* Independent BELLAVANCE BEVERAGE	Grocery	t	2026-03-17 15:24:30.978588	2026-03-17 15:24:30.978588
241	MAIN DUNSTABLE SHELL #1124	sshaunessy	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:30.981225	2026-03-17 15:24:30.981225
242	SEASONS CORNER MARKET #303 SALEM	ddooling	COLBEA/SEASONS	Convenience	t	2026-03-17 15:24:30.984228	2026-03-17 15:24:30.984228
243	TRADER JOE'S # 562	tchagnon	TRADER JOES	Other Off-Premise	t	2026-03-17 15:24:30.987847	2026-03-17 15:24:30.987847
244	MAPLEWOOD PIZZA	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:30.991079	2026-03-17 15:24:30.991079
245	MARGARITAS MEXICAN RESTAURANT-NASHUA	maanderson	MARGARITA'S	Mexican Restaurant	t	2026-03-17 15:24:30.99378	2026-03-17 15:24:30.99378
246	TIO JUAN'S MARGARITAS MEXICAN REST-SALEM	ddooling	MARGARITA'S	Mexican Restaurant	t	2026-03-17 15:24:30.996783	2026-03-17 15:24:30.996783
247	MARKET BASKET #33 HUDSON	maanderson	MARKET BASKET	Supermarket	t	2026-03-17 15:24:30.999932	2026-03-17 15:24:30.999932
248	MARKET BASKET #57 MILFORD	ggage	MARKET BASKET	Supermarket	t	2026-03-17 15:24:31.002336	2026-03-17 15:24:31.002336
249	MARKET BASKET #13 NASHUA - DW HWY	lortiz	MARKET BASKET	Supermarket	t	2026-03-17 15:24:31.005046	2026-03-17 15:24:31.005046
250	MARKET BASKET #39 NASHUA - NORTHWEST BLVD	jcaron	MARKET BASKET	Supermarket	t	2026-03-17 15:24:31.009352	2026-03-17 15:24:31.009352
251	MARKET BASKET #43 NASHUA - AMHERST ST	scamuso	MARKET BASKET	Supermarket	t	2026-03-17 15:24:31.012277	2026-03-17 15:24:31.012277
252	MARKET BASKET #25 PLAISTOW	eplatt	MARKET BASKET	Supermarket	t	2026-03-17 15:24:31.015595	2026-03-17 15:24:31.015595
253	MARKET BASKET #31 SALEM	jgiuffrida	MARKET BASKET	Supermarket	t	2026-03-17 15:24:31.019608	2026-03-17 15:24:31.019608
254	MARKET BASKET #42 LONDERRY	rconstant	MARKET BASKET	Supermarket	t	2026-03-17 15:24:31.02413	2026-03-17 15:24:31.02413
255	MARKET BASKET #71 BEDFORD	lnorton	MARKET BASKET	Supermarket	t	2026-03-17 15:24:31.028517	2026-03-17 15:24:31.028517
256	MARTHA'S EXCHANGE	sshaunessy	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:31.031684	2026-03-17 15:24:31.031684
257	MARYANN'S RESTAURANT - DERRY	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.034771	2026-03-17 15:24:31.034771
258	FLYING BUTCHER OF AMHERST (THE)	jcaron	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:31.038397	2026-03-17 15:24:31.038397
259	MEL'S FUNWAY PARK	rconstant	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:31.042541	2026-03-17 15:24:31.042541
260	MERRIMACK TEN PIN CENTER	tchagnon	* Independent BELLAVANCE BEVERAGE	Bowling/Billiards	t	2026-03-17 15:24:31.04531	2026-03-17 15:24:31.04531
261	MERRIMACK FOOD MART	tchagnon	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.048625	2026-03-17 15:24:31.048625
262	MERRIMACK HOUSE OF PIZZA	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.051224	2026-03-17 15:24:31.051224
263	AMERICAN LEGION POST 98 - MERRIMACK	tchagnon	American Legion	VFW/Legion	t	2026-03-17 15:24:31.055942	2026-03-17 15:24:31.055942
264	METRO MARKET LLC	eleahy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.060166	2026-03-17 15:24:31.060166
265	MI JALISCO - MILFORD	jcaron	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:31.063183	2026-03-17 15:24:31.063183
266	MIKE'S PIE	maanderson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.066903	2026-03-17 15:24:31.066903
267	MILANO HOUSE OF PIZZA-NASHUA	scamuso	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.069907	2026-03-17 15:24:31.069907
269	AMERICAN LEGION POST 23 - MILFORD	ggage	American Legion	VFW/Legion	t	2026-03-17 15:24:31.075029	2026-03-17 15:24:31.075029
270	ALLTOWN FRESH #202736 - E. HOLLIS - NASHUA	amartin	GLOBAL	Convenience	t	2026-03-17 15:24:31.07833	2026-03-17 15:24:31.07833
271	MONT VERNON GENERAL STORE	jcaron	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.080944	2026-03-17 15:24:31.080944
272	MONUMENT SQUARE MARKET	jcaron	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.08334	2026-03-17 15:24:31.08334
273	KSONES THAI DINING	scamuso	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.086028	2026-03-17 15:24:31.086028
274	MR G'S PIZZA INC	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.089179	2026-03-17 15:24:31.089179
275	MR MIKE'S - JAFFREY	pbelanger	GLOBAL	Convenience	t	2026-03-17 15:24:31.092451	2026-03-17 15:24:31.092451
276	ALLTOWN MARKET #200311- PETERBOROUGH	pbelanger	GLOBAL	Convenience	t	2026-03-17 15:24:31.095375	2026-03-17 15:24:31.095375
277	MR. STEER MEATS INC	jsweeney	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:31.103138	2026-03-17 15:24:31.103138
280	99 REST - SALEM	jgiuffrida	99 RESTAURANT	Restaurant	t	2026-03-17 15:24:31.111553	2026-03-17 15:24:31.111553
281	99 REST - NASHUA	sshaunessy	99 RESTAURANT	Restaurant	t	2026-03-17 15:24:31.115166	2026-03-17 15:24:31.115166
282	NASHUA COUNTRY CLUB	maanderson	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:31.118068	2026-03-17 15:24:31.118068
283	NASHUA SHELL #1127 - 620 AMHERST ST	sshaunessy	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:31.121151	2026-03-17 15:24:31.121151
284	NATIONAL CLUB (THE)	scamuso	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:31.123884	2026-03-17 15:24:31.123884
285	NUTFIELD PETROLEUM	rconstant	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.127524	2026-03-17 15:24:31.127524
286	NEW IPSWICH MARKET INC.	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.133199	2026-03-17 15:24:31.133199
287	GRAND INDIA	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.136464	2026-03-17 15:24:31.136464
288	CARIBBEAN BREEZE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.13931	2026-03-17 15:24:31.13931
289	NOURIA ENERGY #1122 - NASH - BROAD ST	sshaunessy	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:31.142501	2026-03-17 15:24:31.142501
290	NOURIA ENERGY #1111 - DERRY	eleahy	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:31.145476	2026-03-17 15:24:31.145476
291	NOURIA ENERGY #1130 - PLAISTOW	jcannamucio	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:31.149039	2026-03-17 15:24:31.149039
292	NOURIA ENERGY #1117 - KINGSTON	jcannamucio	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:31.1519	2026-03-17 15:24:31.1519
293	NORTHLAND VARIETY	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.154868	2026-03-17 15:24:31.154868
296	OLDE KILKENNY PUB	ggage	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:31.164228	2026-03-17 15:24:31.164228
297	LYNN'S 102 TAVERN	amartin	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:31.16782	2026-03-17 15:24:31.16782
298	CVS PHARM #5862 - SALEM - HAMPSTEAD RD	ddooling	CVS STORES	Drug Store	t	2026-03-17 15:24:31.170314	2026-03-17 15:24:31.170314
299	PALMER'S MARKET	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.173882	2026-03-17 15:24:31.173882
300	BLUE MANGO	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.1768	2026-03-17 15:24:31.1768
301	PASSACONAWAY COUNTRY CLUB	rconstant	PASS/HIDDEN	Golf Club	t	2026-03-17 15:24:31.179437	2026-03-17 15:24:31.179437
303	PATEL'S MAMMOTH CONVENIENCE	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.185457	2026-03-17 15:24:31.185457
304	PC CONNECTION	jsweeney	* Independent BELLAVANCE BEVERAGE	Concessionaire	t	2026-03-17 15:24:31.188201	2026-03-17 15:24:31.188201
305	AMERICAN LEGION POST 100 - PELHAM	maanderson	American Legion	VFW/Legion	t	2026-03-17 15:24:31.190982	2026-03-17 15:24:31.190982
306	PEARL RESTAURANT & OYSTER	pbelanger	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.193683	2026-03-17 15:24:31.193683
307	PEDDLER'S DAUGHTER	maanderson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.196335	2026-03-17 15:24:31.196335
308	PENUCHE'S ALE HOUSE-NASHUA	maanderson	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:31.1999	2026-03-17 15:24:31.1999
309	PENGUIN MART LLC	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.202139	2026-03-17 15:24:31.202139
311	PHILLIPS 66 / GIBBS	eleahy	GIBBS/PHILLIPS	Convenience	t	2026-03-17 15:24:31.208088	2026-03-17 15:24:31.208088
312	AXE TOWNE	jcannamucio	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:31.210852	2026-03-17 15:24:31.210852
313	PINE STREET EATERY	sshaunessy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.213609	2026-03-17 15:24:31.213609
314	PIZZICO - ITALIAN RESTAURANT - NASHUA	lortiz	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.216613	2026-03-17 15:24:31.216613
315	PIZZICO - MERRIMACK	tchagnon	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.219743	2026-03-17 15:24:31.219743
316	PIZZAROMA LLC	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.222068	2026-03-17 15:24:31.222068
317	AMERICAN LEGION POST 34 - PLAISTOW	jcannamucio	American Legion	VFW/Legion	t	2026-03-17 15:24:31.224244	2026-03-17 15:24:31.224244
318	PLAISTOW FISH & GAME CLUB	nmoore	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:31.226779	2026-03-17 15:24:31.226779
319	DYNAMITE SUSHI THAI & JAPANESE RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.229432	2026-03-17 15:24:31.229432
320	POLISH AMERICAN CLUB-NASHUA	sshaunessy	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:31.231965	2026-03-17 15:24:31.231965
321	PRIME BUTCHER OF HAMPSTEAD	jcannamucio	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:31.235084	2026-03-17 15:24:31.235084
322	PROFESSOR SPORTS PUB	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.23844	2026-03-17 15:24:31.23844
323	R & B SUPERETTE	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.241648	2026-03-17 15:24:31.241648
324	TOBACCO JUNCTION - PELHAM	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.244165	2026-03-17 15:24:31.244165
325	SMOKE N BARLEY - SALEM	ddooling	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.247612	2026-03-17 15:24:31.247612
326	RED ROBIN BURGERS #515 NASHUA	lortiz	RED ROBIN	Restaurant	t	2026-03-17 15:24:31.250172	2026-03-17 15:24:31.250172
327	REED'S FERRY MARKET	tchagnon	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.252906	2026-03-17 15:24:31.252906
328	RIVER ROAD TAVERN	tchagnon	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.256138	2026-03-17 15:24:31.256138
330	RIVERWALK BAKERY & CAFE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.262992	2026-03-17 15:24:31.262992
331	ROCCO'S PIZZA	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.26619	2026-03-17 15:24:31.26619
333	KINSLEY HOUSE OF PIZZA	scamuso	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.272259	2026-03-17 15:24:31.272259
334	ROMANO'S PIZZA LLC	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.275053	2026-03-17 15:24:31.275053
335	FIRST STORE IN NH	ddooling	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.277742	2026-03-17 15:24:31.277742
336	ROSALINDA MINI MARKET	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.279991	2026-03-17 15:24:31.279991
337	ROUTE 13 STATELINE CONV MART	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.283709	2026-03-17 15:24:31.283709
338	ROWES CORNER MARKET	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.286771	2026-03-17 15:24:31.286771
339	SABATINOS NORTH	eleahy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.289327	2026-03-17 15:24:31.289327
341	SALEM CONVENIENCE STORE	ddooling	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.295087	2026-03-17 15:24:31.295087
342	SALEM HIGH SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:31.297713	2026-03-17 15:24:31.297713
343	SALEM VILLAGE MARKET	ddooling	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.300289	2026-03-17 15:24:31.300289
344	SALLY'S FOOD MARKET INC.	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.303908	2026-03-17 15:24:31.303908
345	SAM'S CLUB #6352	jsmoyer	SAM'S CLUB	Club Store	t	2026-03-17 15:24:31.306402	2026-03-17 15:24:31.306402
346	SAN FRANCISCO KITCHEN INC	amartin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.308964	2026-03-17 15:24:31.308964
347	SAYDES RESTAURANT INC.	jgiuffrida	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:31.311933	2026-03-17 15:24:31.311933
348	NHL EVENTS LLC	nmoore	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:31.315018	2026-03-17 15:24:31.315018
349	SEVEN ELEV #24433 - NASHUA - 361 AMHERST	scamuso	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.317757	2026-03-17 15:24:31.317757
350	SEVEN ELEV #30290 - NASHUA - 496 AMHERST	scamuso	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.320696	2026-03-17 15:24:31.320696
351	SEVEN ELEV #32502 - LITCHFIELD	rconstant	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.323569	2026-03-17 15:24:31.323569
352	SEVEN ELEV #16157 - SALEM - CLUFF CROSS	jgiuffrida	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.326225	2026-03-17 15:24:31.326225
353	SEVEN ELEV #33233 - DERRY - MANCH RD	eleahy	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.32882	2026-03-17 15:24:31.32882
354	SEVEN ELEV #33226 - HUDSON	amartin	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.331638	2026-03-17 15:24:31.331638
355	SEVEN ELEV #33273 - MERRIMACK	tchagnon	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.33416	2026-03-17 15:24:31.33416
356	SHATTUCK GOLF AND DUBLIN ROAD TAPROOM	pbelanger	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:31.337101	2026-03-17 15:24:31.337101
357	SEVEN ELEV #16199 - NASHUA - SPIT BROOK	lortiz	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.339869	2026-03-17 15:24:31.339869
358	SHANGHAI OSAKA RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.343073	2026-03-17 15:24:31.343073
359	SHAW'S #3483- DERRY	eleahy	SHAWS	Supermarket	t	2026-03-17 15:24:31.34631	2026-03-17 15:24:31.34631
360	SHAW'S #0678 - MERRIMACK - CONTINENTAL	tchagnon	SHAWS	Supermarket	t	2026-03-17 15:24:31.349333	2026-03-17 15:24:31.349333
361	SHAW'S #3505 - MERRIMACK - DWH	tchagnon	SHAWS	Supermarket	t	2026-03-17 15:24:31.355293	2026-03-17 15:24:31.355293
362	SHAW'S #0686 - WINDHAM	rmarique	SHAWS	Supermarket	t	2026-03-17 15:24:31.359029	2026-03-17 15:24:31.359029
363	SHAW'S #2492 - MILFORD	jcaron	SHAWS	Supermarket	t	2026-03-17 15:24:31.362064	2026-03-17 15:24:31.362064
364	SHAW'S #3510 - NASHUA - ROYAL RIDGE	lortiz	SHAWS	Supermarket	t	2026-03-17 15:24:31.368422	2026-03-17 15:24:31.368422
365	SHAW'S #0484 - LONDERRY	rconstant	SHAWS	Supermarket	t	2026-03-17 15:24:31.374161	2026-03-17 15:24:31.374161
366	SHAW'S #0113 - NASHUA - MAIN ST	amartin	SHAWS	Supermarket	t	2026-03-17 15:24:31.377087	2026-03-17 15:24:31.377087
367	SHAW'S #3669 - PLAISTOW	eplatt	SHAWS	Supermarket	t	2026-03-17 15:24:31.381217	2026-03-17 15:24:31.381217
368	SHAW'S #4694 - PETERBORO	pbelanger	SHAWS	Supermarket	t	2026-03-17 15:24:31.384702	2026-03-17 15:24:31.384702
369	SHELL MAIN STREET #1125	amartin	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:31.387655	2026-03-17 15:24:31.387655
370	RICOCHET (THE)	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.391483	2026-03-17 15:24:31.391483
371	SMOKE SHACK CAFE	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.394483	2026-03-17 15:24:31.394483
372	SUN MART	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.397906	2026-03-17 15:24:31.397906
373	SKY MEADOW COUNTRY CLUB	maanderson	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:31.400683	2026-03-17 15:24:31.400683
374	SLADES FOOD & SPIRITS	amartin	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:31.404024	2026-03-17 15:24:31.404024
375	SODEXO MANAGEMENT INC	nmoore	* Independent BELLAVANCE BEVERAGE	Concessionaire	t	2026-03-17 15:24:31.406945	2026-03-17 15:24:31.406945
376	VISTA 18 CORP	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.410845	2026-03-17 15:24:31.410845
377	ZOOMIES CORNER MARKET	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.413945	2026-03-17 15:24:31.413945
378	TOBACCO BARN II - MERRIMACK	tchagnon	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.416941	2026-03-17 15:24:31.416941
379	SUZIE'S DINER	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.419837	2026-03-17 15:24:31.419837
380	STELLA BLU	amartin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.422839	2026-03-17 15:24:31.422839
381	HUDSON STATELINE CONVENIENCE	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.427323	2026-03-17 15:24:31.427323
382	SUPER SHELL FOOD MART #1128 - HARRIS RD - NASHUA	sshaunessy	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:31.430261	2026-03-17 15:24:31.430261
383	SUSHI TIME RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.433225	2026-03-17 15:24:31.433225
384	SURF RESTAURANT INC	amartin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.436985	2026-03-17 15:24:31.436985
385	EXIT 1 SMOKE SHOP & MARKET	ddooling	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.441166	2026-03-17 15:24:31.441166
386	SWEET GINGER 2	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.444656	2026-03-17 15:24:31.444656
387	CINEMARK ROCKINGHAM PARK AND XD	jgiuffrida	* Independent BELLAVANCE BEVERAGE	Concessionaire	t	2026-03-17 15:24:31.448336	2026-03-17 15:24:31.448336
388	MARKET AT TUSCAN KITCHEN	ddooling	TUSCAN KITCHEN	Other Off-Premise	t	2026-03-17 15:24:31.45136	2026-03-17 15:24:31.45136
389	MARKET AT TUSCAN KITCHEN (CAFE)	ddooling	TUSCAN KITCHEN	Restaurant	t	2026-03-17 15:24:31.454117	2026-03-17 15:24:31.454117
390	T-BONES - DERRY	eleahy	T-BONES	Restaurant	t	2026-03-17 15:24:31.457628	2026-03-17 15:24:31.457628
391	T-BONES - HUDSON	maanderson	T-BONES	Restaurant	t	2026-03-17 15:24:31.460587	2026-03-17 15:24:31.460587
392	T-BONES - SALEM	ddooling	T-BONES	Restaurant	t	2026-03-17 15:24:31.463524	2026-03-17 15:24:31.463524
393	T-BONES - BEDFORD	lnorton	T-BONES	Restaurant	t	2026-03-17 15:24:31.466407	2026-03-17 15:24:31.466407
394	TAKUMI (NEW)	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.468912	2026-03-17 15:24:31.468912
395	TARGET #1532 - NASHUA - AMHERST ST	jcaron	TARGET	Grocery	t	2026-03-17 15:24:31.471884	2026-03-17 15:24:31.471884
396	TARGET #1228 - NASHUA - DWH	lortiz	TARGET	Grocery	t	2026-03-17 15:24:31.474984	2026-03-17 15:24:31.474984
397	TARGET #1186 - SALEM	jgiuffrida	TARGET	Grocery	t	2026-03-17 15:24:31.477516	2026-03-17 15:24:31.477516
398	IN THE MIX	nmoore	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:31.481272	2026-03-17 15:24:31.481272
399	TEXAS ROADHOUSE	scamuso	TEXAS ROADHOUS	Restaurant	t	2026-03-17 15:24:31.484667	2026-03-17 15:24:31.484667
400	THON KHAO THAI RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.487179	2026-03-17 15:24:31.487179
402	TWELVE PINE LTD	pbelanger	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:31.492366	2026-03-17 15:24:31.492366
403	TOLL BOOTH TAVERN (THE)	jmeharg	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:31.495698	2026-03-17 15:24:31.495698
404	TORTILLA FLAT	tchagnon	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:31.497806	2026-03-17 15:24:31.497806
405	TRADER JOE'S #507	lortiz	TRADER JOES	Other Off-Premise	t	2026-03-17 15:24:31.500247	2026-03-17 15:24:31.500247
406	VFW #5791 - HUDSON	nmoore	VETERANS OF FOREIGN WARS	VFW/Legion	t	2026-03-17 15:24:31.502469	2026-03-17 15:24:31.502469
407	VFW #1617 - DERRY	eleahy	VETERANS OF FOREIGN WARS	VFW/Legion	t	2026-03-17 15:24:31.505218	2026-03-17 15:24:31.505218
408	VFW SOCIAL CLUB	pbelanger	VETERANS OF FOREIGN WARS	VFW/Legion	t	2026-03-17 15:24:31.509491	2026-03-17 15:24:31.509491
409	VFW #1088 - KINGSTON	jcannamucio	VETERANS OF FOREIGN WARS	VFW/Legion	t	2026-03-17 15:24:31.512361	2026-03-17 15:24:31.512361
410	VFW #8641 - MERRIMACK	tchagnon	VETERANS OF FOREIGN WARS	VFW/Legion	t	2026-03-17 15:24:31.515761	2026-03-17 15:24:31.515761
411	VFW #4368 - MILFORD	ggage	VETERANS OF FOREIGN WARS	VFW/Legion	t	2026-03-17 15:24:31.518641	2026-03-17 15:24:31.518641
412	HUNGRY DINER (THE)	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.521359	2026-03-17 15:24:31.521359
414	WAL-MART #1796 - AMHERST	jcaron	WALMART	Supermarket	t	2026-03-17 15:24:31.527543	2026-03-17 15:24:31.527543
415	WAL-MART #2142 - SALEM	rmarique	WALMART	Supermarket	t	2026-03-17 15:24:31.530664	2026-03-17 15:24:31.530664
416	WAL-MART #1753 - DERRY	eleahy	WALMART	Supermarket	t	2026-03-17 15:24:31.532838	2026-03-17 15:24:31.532838
417	WAL-MART #1785 - HUDSON	lortiz	WALMART	Supermarket	t	2026-03-17 15:24:31.535648	2026-03-17 15:24:31.535648
418	WAL-MART #1930 - PLAISTOW	eplatt	WALMART	Supermarket	t	2026-03-17 15:24:31.537906	2026-03-17 15:24:31.537906
419	WALGREENS #9613 - NASHUA - MAIN ST	amartin	WAL-GREENS	Drug Store	t	2026-03-17 15:24:31.540471	2026-03-17 15:24:31.540471
420	WALGREENS #11505 - NASHUA - DW HWY	lortiz	WAL-GREENS	Drug Store	t	2026-03-17 15:24:31.557222	2026-03-17 15:24:31.557222
421	WALGREENS #9447 - NASHUA - AMHERST ST	scamuso	WAL-GREENS	Drug Store	t	2026-03-17 15:24:31.561767	2026-03-17 15:24:31.561767
422	WALGREENS #10378 - HAMPSTEAD	jcannamucio	WAL-GREENS	Drug Store	t	2026-03-17 15:24:31.564151	2026-03-17 15:24:31.564151
423	WALGREENS #12352 - PELHAM	maanderson	WAL-GREENS	Drug Store	t	2026-03-17 15:24:31.566841	2026-03-17 15:24:31.566841
424	WALGREENS #15464 - PLAISTOW	eplatt	WAL-GREENS	Drug Store	t	2026-03-17 15:24:31.569657	2026-03-17 15:24:31.569657
425	WALGREENS #10462 - MILFORD	jcaron	WAL-GREENS	Drug Store	t	2026-03-17 15:24:31.572259	2026-03-17 15:24:31.572259
426	WALGREENS #9646 - MERRIMACK	tchagnon	WAL-GREENS	Drug Store	t	2026-03-17 15:24:31.575026	2026-03-17 15:24:31.575026
427	WALGREENS #9178 - LONDONDERRY	rconstant	WAL-GREENS	Drug Store	t	2026-03-17 15:24:31.57792	2026-03-17 15:24:31.57792
428	WALGREENS #9320 - BEDFORD	lnorton	WAL-GREENS	Drug Store	t	2026-03-17 15:24:31.580457	2026-03-17 15:24:31.580457
429	WASABI SUSHI HIBACHI INC.	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.585155	2026-03-17 15:24:31.585155
430	WATERHOUSE BISTRO	pbelanger	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.587716	2026-03-17 15:24:31.587716
431	WEST HOLLIS STREET SHELL #1126	sshaunessy	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:31.59299	2026-03-17 15:24:31.59299
433	WHITE BIRCH CATERING AND BANQUET HALL (THE)	nmoore	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:31.600113	2026-03-17 15:24:31.600113
434	WINDHAM RESTAURANT (THE)	rmarique	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.603066	2026-03-17 15:24:31.603066
435	WILLARDS IGA STORE	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.605461	2026-03-17 15:24:31.605461
436	WORLD FAMOUS STATE LINE MARKET	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.607852	2026-03-17 15:24:31.607852
437	AMERICAN LEGION POST 10 - WILTON	ggage	American Legion - COD	VFW/Legion	t	2026-03-17 15:24:31.610227	2026-03-17 15:24:31.610227
439	BILL FLYNNS WINDHAM CC INC	eleahy	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:31.616346	2026-03-17 15:24:31.616346
440	WINDHAM COUNTRY STORE	ddooling	Klemm's	Convenience	t	2026-03-17 15:24:31.618784	2026-03-17 15:24:31.618784
441	WINDHAM JUNCTION	jsweeney	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:31.62176	2026-03-17 15:24:31.62176
442	WALIER CHEVROLET	jmalloy	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:31.624235	2026-03-17 15:24:31.624235
444	XTRA MART-HAMPSTEAD	jcannamucio	DRAKE 300	Convenience	t	2026-03-17 15:24:31.630041	2026-03-17 15:24:31.630041
445	LIQUID THERAPY	nmoore	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:31.633142	2026-03-17 15:24:31.633142
446	YANG MING RESTAURANT	ddooling	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.635483	2026-03-17 15:24:31.635483
447	YOSHIMAMA JAPANESE REST	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.638222	2026-03-17 15:24:31.638222
449	HOODKROFT COUNTRY CLUB INC	eleahy	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:31.643406	2026-03-17 15:24:31.643406
450	HUDSON QUICK STOP	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.646155	2026-03-17 15:24:31.646155
451	SULLY'S SUPERETTE	lnorton	AG Supermarkets	Grocery	t	2026-03-17 15:24:31.648917	2026-03-17 15:24:31.648917
452	COUNTRY 3 CORNERS	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.651861	2026-03-17 15:24:31.651861
454	HANNAFORD #8311 - GOFFSTOWN	lnorton	HANNAFORD	Supermarket	t	2026-03-17 15:24:31.657084	2026-03-17 15:24:31.657084
456	AYASOFIA MEDITERRANEAN RESTAURANT	rmarique	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.662718	2026-03-17 15:24:31.662718
457	KINSLEY MARKET	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.665513	2026-03-17 15:24:31.665513
458	HALUWA	sshaunessy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.668603	2026-03-17 15:24:31.668603
459	THAILICIOUS ASIAN FUSION	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.67152	2026-03-17 15:24:31.67152
460	99 REST - LONDONDERRY	rconstant	99 RESTAURANT	Restaurant	t	2026-03-17 15:24:31.673822	2026-03-17 15:24:31.673822
461	BURKE MARKET	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.676481	2026-03-17 15:24:31.676481
462	108 EXPRESS MINI MART	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.679461	2026-03-17 15:24:31.679461
463	U.S. 202 EXPRESS MINI MART INC	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.682413	2026-03-17 15:24:31.682413
465	DESTINATION INDIA RESTAURANT & BAR	eleahy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.687795	2026-03-17 15:24:31.687795
466	HUDSONS NORTH SIDE GRILLE	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.690663	2026-03-17 15:24:31.690663
468	603 BREWERY	rconstant	603 BREWERY	Other On-Premise	t	2026-03-17 15:24:31.696456	2026-03-17 15:24:31.696456
469	CHEN YANG LI RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.699702	2026-03-17 15:24:31.699702
470	DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)	jcannamucio	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.702413	2026-03-17 15:24:31.702413
471	CASA VIEJA MEXICAN GRILL	amartin	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:31.707253	2026-03-17 15:24:31.707253
472	SPIT BROOK MARKET	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.710165	2026-03-17 15:24:31.710165
473	TEMPLE STREET DINER	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.712726	2026-03-17 15:24:31.712726
474	ZHONG'S RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.716157	2026-03-17 15:24:31.716157
475	FERRY MART	tchagnon	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.718727	2026-03-17 15:24:31.718727
476	NASHUA HOUSE OF PIZZA (NEW)	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.721721	2026-03-17 15:24:31.721721
477	CITY LINE MARKET (NEW)	ddooling	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.724776	2026-03-17 15:24:31.724776
478	RED ROBIN GOURMET BURGERS - SALEM	jgiuffrida	RED ROBIN	Restaurant	t	2026-03-17 15:24:31.727643	2026-03-17 15:24:31.727643
479	WHOLE FOODS MARKET - NASHUA - STORE	sshaunessy	WHOLE FOODS	Supermarket	t	2026-03-17 15:24:31.73015	2026-03-17 15:24:31.73015
480	WHOLE FOODS MARKET - NASHUA - BAR	sshaunessy	WHOLE FOODS	Bar/Club	t	2026-03-17 15:24:31.73291	2026-03-17 15:24:31.73291
481	TOMO STEAKHOUSE	jgiuffrida	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.735293	2026-03-17 15:24:31.735293
482	COACH STOP	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.737671	2026-03-17 15:24:31.737671
483	CUMBERLAND FM #5445 - MILFORD NEW	jcaron	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:31.740759	2026-03-17 15:24:31.740759
484	NASHUA CONVENIENCE	scamuso	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.743363	2026-03-17 15:24:31.743363
485	SEVEN ELEV #19555 - NASHUA - MAIN DUNST	sshaunessy	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.746817	2026-03-17 15:24:31.746817
486	PUNTHAI KITCHEN	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.749486	2026-03-17 15:24:31.749486
487	110 GRILL - NASHUA	scamuso	110 GRILL	Restaurant	t	2026-03-17 15:24:31.751981	2026-03-17 15:24:31.751981
488	NOT YOUR AVERAGE JOE'S	lortiz	NOT YOUR AVERAGE JOE'S	Restaurant	t	2026-03-17 15:24:31.754777	2026-03-17 15:24:31.754777
489	TIPICO HONDURENO BAR AND GRILL	nmoore	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:31.757291	2026-03-17 15:24:31.757291
490	THAI CHILI	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.760603	2026-03-17 15:24:31.760603
491	DANVILLE MARKET	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.76306	2026-03-17 15:24:31.76306
492	DEPOT CROSSING LLC	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.765986	2026-03-17 15:24:31.765986
493	POST & BEAM	pbelanger	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.768593	2026-03-17 15:24:31.768593
494	GRUMPY'S BAR & GRILL	jcannamucio	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:31.770905	2026-03-17 15:24:31.770905
495	MOLLY'S TAVERN & RESTAURANT	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.773122	2026-03-17 15:24:31.773122
496	SKYVENTURE NEW HAMPSHIRE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.775228	2026-03-17 15:24:31.775228
497	CALIFORNIA BURRITOS-NASHUA	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.777325	2026-03-17 15:24:31.777325
498	TWINS SMOKE SHOP	rconstant	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:31.779388	2026-03-17 15:24:31.779388
499	STUMBLE INN BAR & GRILL	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.782347	2026-03-17 15:24:31.782347
500	HAFFNERS- ENERGY NORTH	lortiz	ENERGY NORTH	Convenience	t	2026-03-17 15:24:31.785711	2026-03-17 15:24:31.785711
501	FRIENDLY RED'S - WINDHAM	rmarique	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.788203	2026-03-17 15:24:31.788203
502	GOLDEN PALACE	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.791099	2026-03-17 15:24:31.791099
503	POOR BOY'S	nmoore	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:31.794899	2026-03-17 15:24:31.794899
504	W.H. MARKET - NEW	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.798975	2026-03-17 15:24:31.798975
505	DERRY CONVENIENCE	eleahy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.801852	2026-03-17 15:24:31.801852
506	ALLTOWN #202152 - LONDONDERRY	rconstant	GLOBAL	Convenience	t	2026-03-17 15:24:31.806204	2026-03-17 15:24:31.806204
507	JAY'S AMHERST MARKET - NEW	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.810068	2026-03-17 15:24:31.810068
508	SUMO SUSHI	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.813876	2026-03-17 15:24:31.813876
509	LITCHFIELD FOOD MART	rconstant	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.817156	2026-03-17 15:24:31.817156
510	RALPHIE'S CAFE ITALIANO	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.820273	2026-03-17 15:24:31.820273
511	KLEMM-4 MAMMOTH RD	ddooling	Klemm's	Convenience	t	2026-03-17 15:24:31.82706	2026-03-17 15:24:31.82706
512	NEW WORLD GAS - MERRIMACK	tchagnon	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.835253	2026-03-17 15:24:31.835253
513	SPEEDWAY #46190 - DERRY	eleahy	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.839316	2026-03-17 15:24:31.839316
514	SPEEDWAY #44738- NASHUA - E. HOLLIS ST	amartin	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.845329	2026-03-17 15:24:31.845329
516	PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD	eplatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.851296	2026-03-17 15:24:31.851296
517	BUCKLEY'S BAKERY-CAFE	jsweeney	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.854086	2026-03-17 15:24:31.854086
518	BIRCH WOOD VINEYARDS	eleahy	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:31.856321	2026-03-17 15:24:31.856321
519	ARZ MINI MARKET INC	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.859406	2026-03-17 15:24:31.859406
520	CROTCHED MOUNTAIN SKI AREA	jmeharg	VAIL RESORT	Recreation/Sports	t	2026-03-17 15:24:31.862283	2026-03-17 15:24:31.862283
521	OSAKA HIBACHI & CHINESE RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:31.865798	2026-03-17 15:24:31.865798
522	REBEL #896 - LONDONDERRY	rconstant	MIDWEST CONVENIENCE	Convenience	t	2026-03-17 15:24:31.868352	2026-03-17 15:24:31.868352
523	NEW TAJ INDIA	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.871606	2026-03-17 15:24:31.871606
524	PRESSED CAFE - BEDFORD	tchagnon	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.874751	2026-03-17 15:24:31.874751
525	SEVEN ELEV #37359 - SALEM - MAIN STREET	ddooling	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.877905	2026-03-17 15:24:31.877905
526	PORTOFINO ITALIAN RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.881748	2026-03-17 15:24:31.881748
527	SHORTY'S MEXICAN ROADHOUSE	sshaunessy	SHORTY'S	Mexican Restaurant	t	2026-03-17 15:24:31.886034	2026-03-17 15:24:31.886034
528	TARGET #2009 - BEDFORD	tchagnon	TARGET	Grocery	t	2026-03-17 15:24:31.889608	2026-03-17 15:24:31.889608
529	EL PAISANO MINI MARKET	nmoore	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.892731	2026-03-17 15:24:31.892731
531	WHOLE FOODS - BEDFORD - STORE	tchagnon	WHOLE FOODS	Supermarket	t	2026-03-17 15:24:31.898645	2026-03-17 15:24:31.898645
532	DRIVE CUSTOM FIT	jsweeney	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:31.901446	2026-03-17 15:24:31.901446
533	DIYA MART	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.904207	2026-03-17 15:24:31.904207
534	FODY'S TAVERN (DERRY)	eleahy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.906984	2026-03-17 15:24:31.906984
535	RICK'S THE SPIRIT OF KINGSTON	jcannamucio	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.909819	2026-03-17 15:24:31.909819
536	DOLLAR GENERAL #21301- WALPOLE	pwollert	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:31.912636	2026-03-17 15:24:31.912636
537	AYOTTES & SMOKIN' JOES PREMIUM CIGARS	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.915479	2026-03-17 15:24:31.915479
538	A AND S FOODMART	rconstant	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.917834	2026-03-17 15:24:31.917834
539	SHAKING SEAFOOD	jgiuffrida	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.920843	2026-03-17 15:24:31.920843
541	LA CARRETA - LONDONDERRY	rconstant	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:31.926684	2026-03-17 15:24:31.926684
542	ALVIRNE HIGH SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:31.928961	2026-03-17 15:24:31.928961
543	AMERICAN LEGION POST 59 - HILLSBORO	jmeharg	American Legion	VFW/Legion	t	2026-03-17 15:24:31.931728	2026-03-17 15:24:31.931728
544	AMERICAN LEGION POST 27 - LONDONDERRY	rconstant	American Legion	VFW/Legion	t	2026-03-17 15:24:31.934277	2026-03-17 15:24:31.934277
545	AMHERST MIDDLE SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:31.937383	2026-03-17 15:24:31.937383
546	ANTRIM MARKET	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.939999	2026-03-17 15:24:31.939999
547	BEDFORD BAGEL CAFE LLC	jsweeney	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.943283	2026-03-17 15:24:31.943283
548	EPICUREAN FEAST	jsweeney	CORPORATE CHEF	Other On-Premise	t	2026-03-17 15:24:31.94595	2026-03-17 15:24:31.94595
549	TROMBLY GARDENS	nmoore	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:31.949593	2026-03-17 15:24:31.949593
550	MI JALISCO - PETERBORO	pbelanger	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:31.952662	2026-03-17 15:24:31.952662
551	SEVEN ELEV #37392 - LONDONDERY - ROCKINGHAM RD	rconstant	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:31.955316	2026-03-17 15:24:31.955316
552	HILLSBORO HOUSE OF PIZZA	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.957907	2026-03-17 15:24:31.957907
553	BUDGET GAS & FOOD MART	lnorton	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:31.960286	2026-03-17 15:24:31.960286
554	CAMPBELL HIGHSCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:31.963313	2026-03-17 15:24:31.963313
555	CAMPUS CORNER PINKERTON	jsweeney	SCHOOLS	Convenience	t	2026-03-17 15:24:31.966598	2026-03-17 15:24:31.966598
556	CARRABBA'S ITALIAN GRILL LLC	tchagnon	CARRABBAS	Restaurant	t	2026-03-17 15:24:31.969875	2026-03-17 15:24:31.969875
557	CASTRO'S BACKROOM - NASHUA	sshaunessy	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:31.972781	2026-03-17 15:24:31.972781
558	HANOVER INN-CATERING	jjohnson	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:31.975697	2026-03-17 15:24:31.975697
560	BEDFORD HIGH SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:31.981773	2026-03-17 15:24:31.981773
561	PURPLE FINCH CAFE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:31.985269	2026-03-17 15:24:31.985269
562	CIRCLE K #7233 - GOFFSTOWN	lnorton	CIRCLE K	Convenience	t	2026-03-17 15:24:31.987915	2026-03-17 15:24:31.987915
563	CIRCLE K #7230 - HILLSBORO	jmeharg	CIRCLE K	Convenience	t	2026-03-17 15:24:31.990745	2026-03-17 15:24:31.990745
564	ALLTOWN FRESH #202756 - NASHUA	scamuso	GLOBAL	Convenience	t	2026-03-17 15:24:31.993278	2026-03-17 15:24:31.993278
565	DOUBLETREE BY HILTON NASHUA	scamuso	INTERCONTINENTAL	Hotel/Lodging	t	2026-03-17 15:24:31.996282	2026-03-17 15:24:31.996282
566	COLD SPRINGS CAMPGROUND	jmeharg	* Independent BELLAVANCE BEVERAGE	Campground	t	2026-03-17 15:24:31.999352	2026-03-17 15:24:31.999352
567	CONVENIENCE PLUS LONDONDERRY	rconstant	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.002336	2026-03-17 15:24:32.002336
568	TEMPLE STREET MARKET	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.005317	2026-03-17 15:24:32.005317
569	COUNTRY SPIRIT RESTAURANT & TAVERN	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.007985	2026-03-17 15:24:32.007985
570	CRAVINGS CAFE & GIFT SHOP	jsweeney	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.011021	2026-03-17 15:24:32.011021
571	CUMBERLAND FM #5422 - HILLSBORO	jmeharg	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:32.013771	2026-03-17 15:24:32.013771
572	CUMBERLAND FM #5441 - GOFFS - S.MAST RD	lnorton	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:32.016214	2026-03-17 15:24:32.016214
574	LAKE VIEW CONVENIENT	jgiuffrida	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.021895	2026-03-17 15:24:32.021895
575	DANIEL'S PUB INC	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.025291	2026-03-17 15:24:32.025291
576	AUTUMN HILL CAMPGROUND	jmeharg	* Independent BELLAVANCE BEVERAGE	Campground	t	2026-03-17 15:24:32.027998	2026-03-17 15:24:32.027998
577	SNACK CORNER	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.031117	2026-03-17 15:24:32.031117
578	DOLLAR GENER #13284 - HILLSBORO	jmeharg	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.034143	2026-03-17 15:24:32.034143
579	DOLLAR TREE #3654 - PLAISTOW	jcannamucio	DOLLAR TREE	Soda Only	t	2026-03-17 15:24:32.037677	2026-03-17 15:24:32.037677
580	MICHAELS FLATBREAD PIZZA CO.	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.041031	2026-03-17 15:24:32.041031
581	KUMO SUSHI	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.043917	2026-03-17 15:24:32.043917
582	ASAHI RESTAURANT AND BAR	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.046234	2026-03-17 15:24:32.046234
583	MILLENNIUM CABARET OF BEDFORD	tchagnon	* Independent BELLAVANCE BEVERAGE	Adult Entertain	t	2026-03-17 15:24:32.048643	2026-03-17 15:24:32.048643
584	MURPHY'S TAPROOM AND CARRIAGE HOUSE	lnorton	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:32.051616	2026-03-17 15:24:32.051616
585	MCCARTHY MIDDLE SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.054607	2026-03-17 15:24:32.054607
586	PRANCING PONY	nmoore	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:32.057114	2026-03-17 15:24:32.057114
587	FAIRGROUNDS MIDDLE SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.060014	2026-03-17 15:24:32.060014
588	NUTFIELD COUNTRY STORE	rconstant	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.062283	2026-03-17 15:24:32.062283
589	FAMILY DOLLAR #23493 - HILLSBORO	jmeharg	FAMILY DOLLAR	Convenience	t	2026-03-17 15:24:32.065088	2026-03-17 15:24:32.065088
590	BIG LOTS # 1446 - DERRY	jsweeney	BIG LOTS	Other Off-Premise	t	2026-03-17 15:24:32.067822	2026-03-17 15:24:32.067822
591	BIG LOTS # 1513 - GOFFSTOWN	jsweeney	BIG LOTS	Other Off-Premise	t	2026-03-17 15:24:32.070731	2026-03-17 15:24:32.070731
592	BIG LOTS # 1586 - NASHUA	jsweeney	BIG LOTS	Other Off-Premise	t	2026-03-17 15:24:32.073873	2026-03-17 15:24:32.073873
593	FRIENDLY BEAVER CAMPGROUND	jmeharg	* Independent BELLAVANCE BEVERAGE	Campground	t	2026-03-17 15:24:32.076768	2026-03-17 15:24:32.076768
594	HOWIE GLYNN & SONS CONVENIENCE	eleahy	HOWIE GLYNN	Convenience	t	2026-03-17 15:24:32.080142	2026-03-17 15:24:32.080142
595	809 LOUNGE & MEXICAN GRILL	sshaunessy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.084407	2026-03-17 15:24:32.084407
596	GILBERT H HOOD MIDDLE	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.087357	2026-03-17 15:24:32.087357
597	SALEM HIGH MARKETING	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.090641	2026-03-17 15:24:32.090641
599	MOBIL ON THE RUN #200626 - HENNIKER	jmeharg	GLOBAL	Convenience	t	2026-03-17 15:24:32.097956	2026-03-17 15:24:32.097956
600	GOFFSTOWN HIGH SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.100607	2026-03-17 15:24:32.100607
601	SHELL #1115 - GOFFSTOWN	lnorton	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:32.103678	2026-03-17 15:24:32.103678
602	JAMISON'S	jcannamucio	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.106136	2026-03-17 15:24:32.106136
603	SEASONS CORNER MARKET # 304 NASHUA	amartin	COLBEA/SEASONS	Convenience	t	2026-03-17 15:24:32.109012	2026-03-17 15:24:32.109012
604	HEAVENS FOOD MART LLC	lnorton	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.111527	2026-03-17 15:24:32.111527
605	HEAVENS COUNTRY STORE LLC	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.11399	2026-03-17 15:24:32.11399
608	YANG YANG KITCHEN CHINESE CUISINE	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.122829	2026-03-17 15:24:32.122829
610	GRILL 603	ggage	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.129794	2026-03-17 15:24:32.129794
611	HUDSON MEMORIAL MIDDLE	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.132644	2026-03-17 15:24:32.132644
612	SOUTHERN NH MEDICAL -- COFFEE SHOP	jsweeney	* Independent BELLAVANCE BEVERAGE	Recreation/Sports	t	2026-03-17 15:24:32.135401	2026-03-17 15:24:32.135401
613	CALI B HUDSON	maanderson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.138493	2026-03-17 15:24:32.138493
614	MIZU CHEN	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.141323	2026-03-17 15:24:32.141323
615	CRACKER BARREL OLD COUNTRY STORE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.143594	2026-03-17 15:24:32.143594
616	KAT'S COUNTRY CORNER	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.146073	2026-03-17 15:24:32.146073
617	MARYANNS DINER - SALEM	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.149835	2026-03-17 15:24:32.149835
618	COPPER DOOR - SALEM	ddooling	T-BONES	Restaurant	t	2026-03-17 15:24:32.152792	2026-03-17 15:24:32.152792
619	KWIK STOP	rconstant	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.155677	2026-03-17 15:24:32.155677
620	LANCTOTS GROCERY	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.158087	2026-03-17 15:24:32.158087
621	TOMAHAWK BUTCHERY & TAVERN	tchagnon	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:32.162272	2026-03-17 15:24:32.162272
622	LITCHFIELD MIDDLE SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.165717	2026-03-17 15:24:32.165717
623	PAPA Z'S	jjohnson	JAKE'S MARKET	Convenience	t	2026-03-17 15:24:32.168923	2026-03-17 15:24:32.168923
624	LONDONDERRY COUNTRY CLUB IN	nmoore	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:32.17141	2026-03-17 15:24:32.17141
625	LOYAL ORDER OF MOOSE - HILLSBORO	jmeharg	* Independent BELLAVANCE BEVERAGE	VFW/Legion	t	2026-03-17 15:24:32.174153	2026-03-17 15:24:32.174153
626	LUCCIANO'S CAFE	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.177797	2026-03-17 15:24:32.177797
627	MAMA MCDONOUGH'S IRISH PUB	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.180402	2026-03-17 15:24:32.180402
628	MANCHESTER COUNTRY CLUB	tchagnon	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:32.186977	2026-03-17 15:24:32.186977
629	DOLLAR GENER #17389 - HENNIKER	jmeharg	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.189585	2026-03-17 15:24:32.189585
630	MASTER WOK	jsweeney	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.192039	2026-03-17 15:24:32.192039
631	MERRIMACK MIDDLE SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.195161	2026-03-17 15:24:32.195161
632	MERRIMACK HIGH SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.198394	2026-03-17 15:24:32.198394
633	MILK'N IT	jsweeney	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:32.201958	2026-03-17 15:24:32.201958
634	PANDA GOURMET	amartin	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.204784	2026-03-17 15:24:32.204784
636	NASHUA HIGH SCHOOL SOUTH	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.21122	2026-03-17 15:24:32.21122
637	NASHUA HIGH SCHOOL NORTH	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.213797	2026-03-17 15:24:32.213797
638	CHARTWELL'S DINING SERVICES	jmeharg	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:32.216498	2026-03-17 15:24:32.216498
639	NEW HARVESTER MARKET INC	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.219178	2026-03-17 15:24:32.219178
640	SANDRI STOP - HINSDALE	jaustin	J.W. SANDRI	Convenience	t	2026-03-17 15:24:32.221791	2026-03-17 15:24:32.221791
641	SAKURA	amartin	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.224716	2026-03-17 15:24:32.224716
642	LATIN BAKERY & MULTISERVICE INC	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.228703	2026-03-17 15:24:32.228703
643	HOWIE GLYNN - DERRY	ddooling	HOWIE GLYNN	Convenience	t	2026-03-17 15:24:32.231843	2026-03-17 15:24:32.231843
644	NH SPORTSPLEX	tchagnon	* Independent BELLAVANCE BEVERAGE	Recreation/Sports	t	2026-03-17 15:24:32.237321	2026-03-17 15:24:32.237321
645	FRIENDLY RED'S - CATERING	rmarique	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:32.240929	2026-03-17 15:24:32.240929
646	SADDLE UP SALOON	jcannamucio	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.243794	2026-03-17 15:24:32.243794
647	PATS PEAK	jmeharg	* Independent BELLAVANCE BEVERAGE	Recreation/Sports	t	2026-03-17 15:24:32.247726	2026-03-17 15:24:32.247726
648	PELHAM HIGH SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.25079	2026-03-17 15:24:32.25079
649	PELHAM ELEMENTARY SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.253905	2026-03-17 15:24:32.253905
650	PENNICHUCK MIDDLE SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.257313	2026-03-17 15:24:32.257313
651	PINARDVILLE ATHLETIC CLUB	lnorton	* Independent BELLAVANCE BEVERAGE	VFW/Legion	t	2026-03-17 15:24:32.260046	2026-03-17 15:24:32.260046
652	SUPPA'S PIZZA PELHAM	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.263775	2026-03-17 15:24:32.263775
653	PIZZA BELLA INC	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.26638	2026-03-17 15:24:32.26638
654	PRIME BUTCHER WINDHAM	rmarique	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.268878	2026-03-17 15:24:32.268878
655	OLD SCHOOL BAR AND GRILL	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.271892	2026-03-17 15:24:32.271892
656	PUTNAMS WATERVIEW RESTAURAN	lnorton	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.274623	2026-03-17 15:24:32.274623
657	PASQUALE'S RISTORANTE	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.277489	2026-03-17 15:24:32.277489
658	CVS PHARM #10572 - MILFORD - NASHUA ST	jcaron	CVS STORES	Drug Store	t	2026-03-17 15:24:32.280759	2026-03-17 15:24:32.280759
659	RPM FUEL	lnorton	MOBIL INDEPDNT	Convenience	t	2026-03-17 15:24:32.283234	2026-03-17 15:24:32.283234
660	BUFFALO WILD WINGS GRILL & BAR - NASHUA	lortiz	BUFFALO WILD WINGS	Restaurant	t	2026-03-17 15:24:32.286514	2026-03-17 15:24:32.286514
661	SALEM WOODBURY MIDDLE	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.289386	2026-03-17 15:24:32.289386
663	SAWYERS BREAKFAST & FUNCTION HALL LLC	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.296457	2026-03-17 15:24:32.296457
664	SOUHEGAN HIGH SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.298999	2026-03-17 15:24:32.298999
665	SEVEN ELEV #30292 - LONDONDERY - NASHUA RD	rconstant	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:32.302309	2026-03-17 15:24:32.302309
666	SHAW'S #4514 - HILLSBORO	jmeharg	SHAWS	Supermarket	t	2026-03-17 15:24:32.304996	2026-03-17 15:24:32.304996
667	Z1 XPRESS - GOFFSTOWN	lnorton	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.308483	2026-03-17 15:24:32.308483
668	PELHAM MEMORIAL SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.311426	2026-03-17 15:24:32.311426
670	JOHN STARK H S	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.316781	2026-03-17 15:24:32.316781
671	STARK HOUSE TAVERN (THE)	jmeharg	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:32.321287	2026-03-17 15:24:32.321287
672	STEAK OUT (THE)	lnorton	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:32.324941	2026-03-17 15:24:32.324941
673	SUNNYSIDE ACURA	jsweeney	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:32.331144	2026-03-17 15:24:32.331144
674	SUNSHUI ASIAN CUISINE	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.33385	2026-03-17 15:24:32.33385
675	STONEBRIDGE COUNTRY CLUB	lnorton	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:32.337249	2026-03-17 15:24:32.337249
676	MILFORD CONVENIENCE STORE	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.339665	2026-03-17 15:24:32.339665
677	SUPER WOK RESTAURANT	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.34581	2026-03-17 15:24:32.34581
678	TAIPEI & TOKYO CHINESE	lnorton	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.34846	2026-03-17 15:24:32.34846
679	MOUNTAIN VIEW MIDDLE SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.351864	2026-03-17 15:24:32.351864
680	WALPOLE GROCERY	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.3547	2026-03-17 15:24:32.3547
681	TIMBERLANE MIDDLE SCHOOL	jsweeney	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:32.357147	2026-03-17 15:24:32.357147
682	TIMBERLANE FOOD SERVICE - HS	jsweeney	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:32.359669	2026-03-17 15:24:32.359669
683	TOOKY MILLS PUB	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.361937	2026-03-17 15:24:32.361937
684	TOYOTA OF NASHUA	jsweeney	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:32.363923	2026-03-17 15:24:32.363923
685	JAJABELLES PASTRY	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.366921	2026-03-17 15:24:32.366921
686	VILLAGE TRESTLE (THE)	lnorton	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.370148	2026-03-17 15:24:32.370148
687	XTREME CRAZE	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.37465	2026-03-17 15:24:32.37465
688	DOLLAR GENER #17171 - NEW IPSWICH	ggage	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.376964	2026-03-17 15:24:32.376964
689	RESTAURANT AT BURDICKS	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.379408	2026-03-17 15:24:32.379408
690	WEARE MOBIL	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.38193	2026-03-17 15:24:32.38193
691	W RUNNING BROOK MIDDLE	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.384934	2026-03-17 15:24:32.384934
692	WINDHAM MIDDLE SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.388247	2026-03-17 15:24:32.388247
693	WINDHAM HIGH SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.390997	2026-03-17 15:24:32.390997
694	WORKOUT CLUB OF LONDONDER	jsweeney	WORKOUT CLUB	Recreation/Sports	t	2026-03-17 15:24:32.393996	2026-03-17 15:24:32.393996
695	WORKOUT CLUB OF SALEM	jsweeney	WORKOUT CLUB	Recreation/Sports	t	2026-03-17 15:24:32.398188	2026-03-17 15:24:32.398188
696	NEW WA TOY	lnorton	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.401044	2026-03-17 15:24:32.401044
697	RAPID REFILL #134 - MERRIMACK	tchagnon	MPG CORP	Convenience	t	2026-03-17 15:24:32.404047	2026-03-17 15:24:32.404047
698	SHELL MART	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.407116	2026-03-17 15:24:32.407116
699	RAPID REFILL #140 - MERRIMACK	tchagnon	MPG CORP	Convenience	t	2026-03-17 15:24:32.40968	2026-03-17 15:24:32.40968
700	TUPELO VENUE	eleahy	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:32.412472	2026-03-17 15:24:32.412472
701	COOPER'S HILL	pbelanger	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.414922	2026-03-17 15:24:32.414922
702	ZORVINO VINEYARD	nmoore	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:32.417199	2026-03-17 15:24:32.417199
703	BAR	amartin	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:32.41949	2026-03-17 15:24:32.41949
705	CANAL ST RACING MART	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.425192	2026-03-17 15:24:32.425192
707	TAVERNE ON THE SQUARE LLC	jmorse	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.430792	2026-03-17 15:24:32.430792
708	THE HANCOCK MARKET	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.433422	2026-03-17 15:24:32.433422
709	BRICKHOUSE PIZZA & WINGS	jaustin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.436212	2026-03-17 15:24:32.436212
711	NEW CHIEF WOK	ddooling	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.440851	2026-03-17 15:24:32.440851
712	DOLLAR GENER #18270 - BENNINGTON	jmeharg	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.443122	2026-03-17 15:24:32.443122
713	RK VILLAGE STORE	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.445756	2026-03-17 15:24:32.445756
714	STROKERS	maanderson	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:32.448115	2026-03-17 15:24:32.448115
717	MDP MOTORSPORTS PROMOTIONS LLC	jmorse	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:32.456466	2026-03-17 15:24:32.456466
718	CASA JAVA CAFE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.458857	2026-03-17 15:24:32.458857
719	BAKER HILL GOLF CLUB	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:32.461733	2026-03-17 15:24:32.461733
720	THE LITTLE STORE (MARSH BROS DELI)	jjohnson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.464475	2026-03-17 15:24:32.464475
721	ATKINSON SUNOCO	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.467679	2026-03-17 15:24:32.467679
722	WEDGEWOOD WEDDING & BANQUET CENTER	jcannamucio	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:32.471154	2026-03-17 15:24:32.471154
723	CASEY MAGEE'S	amartin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.473789	2026-03-17 15:24:32.473789
724	DOLLAR GENER #17668 - TROY	jaustin	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.476569	2026-03-17 15:24:32.476569
725	SUMMIT STORES - KEENE	bgermano	SUMMIT	Convenience	t	2026-03-17 15:24:32.479114	2026-03-17 15:24:32.479114
726	COST PLUS WORLD MARKET - # 259681	jgiuffrida	COST PLUS WORLD MARKET	Other Off-Premise	t	2026-03-17 15:24:32.481587	2026-03-17 15:24:32.481587
727	GEORGES AG SUPER	jjohnson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.484358	2026-03-17 15:24:32.484358
728	APPLEKNOCKERS STORE	jsewall	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.487033	2026-03-17 15:24:32.487033
730	MOULTONS MARKET	jcaron	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.492088	2026-03-17 15:24:32.492088
731	MOBIL MART KINGSTON	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.49465	2026-03-17 15:24:32.49465
732	SOHO RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.497915	2026-03-17 15:24:32.497915
733	DON RAMON	tchagnon	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:32.500204	2026-03-17 15:24:32.500204
734	ZIGGY'S PIZZA - SUNAPEE	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.502868	2026-03-17 15:24:32.502868
735	SMOKE HAUS	jcaron	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.505507	2026-03-17 15:24:32.505507
737	CIRCLE K - 7266 -HAMPSTEAD	jcannamucio	CIRCLE K	Convenience	t	2026-03-17 15:24:32.510745	2026-03-17 15:24:32.510745
738	ISLAND POND CONVENIENCE	ddooling	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.513352	2026-03-17 15:24:32.513352
739	JAKE'S MARKET & DELI - LEBANON	jjohnson	JAKE'S MARKET	Convenience	t	2026-03-17 15:24:32.51576	2026-03-17 15:24:32.51576
740	JAKES MARKET AND DELI- NEW LONDON	jgrumblatt	JAKE'S MARKET	Convenience	t	2026-03-17 15:24:32.518101	2026-03-17 15:24:32.518101
741	JAKES MARKET AND DELI - WALPOLE	pwollert	JAKE'S MARKET	Convenience	t	2026-03-17 15:24:32.520137	2026-03-17 15:24:32.520137
742	ZEE QUICK STOP	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.522956	2026-03-17 15:24:32.522956
743	JAKES MARKET AND DELI - GEORGES MILLS	jgrumblatt	JAKE'S MARKET	Convenience	t	2026-03-17 15:24:32.525886	2026-03-17 15:24:32.525886
744	UPPER VALLEY EVENT CENTER	jsewall	* Independent BELLAVANCE BEVERAGE	Hotel/Lodging	t	2026-03-17 15:24:32.528339	2026-03-17 15:24:32.528339
745	RITA'S MEXICAN RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:32.531014	2026-03-17 15:24:32.531014
746	COOKIES CAFE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.534068	2026-03-17 15:24:32.534068
747	JJ'S MART & DELI	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.537398	2026-03-17 15:24:32.537398
748	RUSTY LANTER MARKET #0004	maanderson	RLM RETAIL	Convenience	t	2026-03-17 15:24:32.539668	2026-03-17 15:24:32.539668
749	RK VARIETY	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.543524	2026-03-17 15:24:32.543524
750	APOGEE VAPOR	nmoore	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:32.545753	2026-03-17 15:24:32.545753
751	BANGKOK THAI FOOD	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.548442	2026-03-17 15:24:32.548442
752	NEW NAN KING RESTAURANT	amartin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.550972	2026-03-17 15:24:32.550972
753	HIDDEN VALLEY BAR & GRILL - OFF	eleahy	* Independent BELLAVANCE BEVERAGE	Campground	t	2026-03-17 15:24:32.554352	2026-03-17 15:24:32.554352
754	HIDDEN VALLEY BAR & GRILL	eleahy	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:32.556837	2026-03-17 15:24:32.556837
755	TROY DELI & MARKET PLACE	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.560246	2026-03-17 15:24:32.560246
756	BROTHERS BUTCHER II	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.562621	2026-03-17 15:24:32.562621
757	CORAS MARKET	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.565402	2026-03-17 15:24:32.565402
758	HOLLIS HOUSE OF PIZZA	jsweeney	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.568926	2026-03-17 15:24:32.568926
760	EL PASIANO MEXICAN RESTAURANT - PALM ST.	nmoore	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:32.575061	2026-03-17 15:24:32.575061
761	SWANZEY NEIGHBOR	bgermano	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.578009	2026-03-17 15:24:32.578009
763	ALSTEAD GENERAL STORE	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.584113	2026-03-17 15:24:32.584113
764	BP PELHAM	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.586885	2026-03-17 15:24:32.586885
765	TOKYO'S JAPANESE STEAKHOUSE	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.589986	2026-03-17 15:24:32.589986
766	JIFFY MART #200431 - CLAREMONT	jmorse	GLOBAL	Convenience	t	2026-03-17 15:24:32.59338	2026-03-17 15:24:32.59338
767	JIFFY MART #200432 - NEWPORT	jgrumblatt	GLOBAL	Convenience	t	2026-03-17 15:24:32.596436	2026-03-17 15:24:32.596436
768	JIFFY MART #200434 - HANOVER ST	jjohnson	GLOBAL	Convenience	t	2026-03-17 15:24:32.599356	2026-03-17 15:24:32.599356
769	EXIT 18 TRUCK STOP #444 (JIFFY MART LEBANON HEATER	jjohnson	GLOBAL	Convenience	t	2026-03-17 15:24:32.602106	2026-03-17 15:24:32.602106
770	JIFFY MART #200459 - WALPOLE	pwollert	GLOBAL	Convenience	t	2026-03-17 15:24:32.604716	2026-03-17 15:24:32.604716
771	JIFFY MART #200460 - CHARLESTOWN	pwollert	GLOBAL	Convenience	t	2026-03-17 15:24:32.607449	2026-03-17 15:24:32.607449
772	COLLEGE CONVENIENCE	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.611013	2026-03-17 15:24:32.611013
773	T-BIRD MINI MART - W. SWANZEY	bgermano	GLOBAL	Convenience	t	2026-03-17 15:24:32.614316	2026-03-17 15:24:32.614316
774	T-BIRD MINI MART - HINSDALE	jaustin	GLOBAL	Convenience	t	2026-03-17 15:24:32.617813	2026-03-17 15:24:32.617813
775	T-BIRD MINI MART - SWANZEY MONADNOCK HIGHWAY #676	pwollert	GLOBAL	Convenience	t	2026-03-17 15:24:32.621142	2026-03-17 15:24:32.621142
776	T-BIRD MINI MART - KEENE	bgermano	GLOBAL	Convenience	t	2026-03-17 15:24:32.623632	2026-03-17 15:24:32.623632
777	T-BIRD MINI MART - CLAREMONT-CHARLESTOWN RD	jmorse	GLOBAL	Convenience	t	2026-03-17 15:24:32.627099	2026-03-17 15:24:32.627099
778	CARRS STORE (TBIRD DUBLIN)	jaustin	GLOBAL	Convenience	t	2026-03-17 15:24:32.630626	2026-03-17 15:24:32.630626
779	T-BIRD MINI MART - ANTRIM	jmeharg	GLOBAL	Convenience	t	2026-03-17 15:24:32.634253	2026-03-17 15:24:32.634253
780	T-BIRD MINI MART - CLAREMONT-WASHINGTON ST	jmorse	GLOBAL	Convenience	t	2026-03-17 15:24:32.637472	2026-03-17 15:24:32.637472
781	T-BIRD MINI MART - NEWPORT	jgrumblatt	GLOBAL	Convenience	t	2026-03-17 15:24:32.640095	2026-03-17 15:24:32.640095
782	DOLLAR GENER # 19987 - MERRIMACK	tchagnon	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.643414	2026-03-17 15:24:32.643414
783	DISCOUNT BEVERAGE KING W. LEB	jsewall	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.647233	2026-03-17 15:24:32.647233
784	THE BARN CAFE	jmalloy	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:32.649844	2026-03-17 15:24:32.649844
785	THIRSTY MOOSE	tchagnon	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:32.653326	2026-03-17 15:24:32.653326
786	HOLLIS-BROOKLINE MIDDLE SCHOOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.656584	2026-03-17 15:24:32.656584
787	HOLLIS-BROOKLINE HIGH SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.659265	2026-03-17 15:24:32.659265
788	WINDHAM VARIETY STORES	eleahy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.662439	2026-03-17 15:24:32.662439
789	NEWPORT MEAT MARKET	jmorse	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.666084	2026-03-17 15:24:32.666084
790	TACO TIME COCINA & CANTINA	ggage	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:32.668639	2026-03-17 15:24:32.668639
791	PETER CHRISTIANS TAVERN	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.672264	2026-03-17 15:24:32.672264
792	DOLLAR GENERAL WENTWORTH #19482	jsewall	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.67481	2026-03-17 15:24:32.67481
794	ODD FELLOWS BREWING COMPANY	amartin	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:32.680871	2026-03-17 15:24:32.680871
795	VAIL RESORT/ MOUNT SUNAPEE	jgrumblatt	VAIL RESORT	Recreation/Sports	t	2026-03-17 15:24:32.683696	2026-03-17 15:24:32.683696
797	50 EAST DERRY RD CONVENIENCE - REST	eleahy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.688818	2026-03-17 15:24:32.688818
798	LITTLE BROTHERS BURGERS	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.691632	2026-03-17 15:24:32.691632
799	HAMPSHIRE DOME (THE)	ggage	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:32.694843	2026-03-17 15:24:32.694843
801	ALAMO TEXAS BAR-B-QUE & TEQUILA BAR	ggage	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.702391	2026-03-17 15:24:32.702391
802	DOLLAR GENERAL - PETERBOROUGH #20060	pbelanger	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.706632	2026-03-17 15:24:32.706632
803	KELSEN BREWERY	rconstant	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:32.709104	2026-03-17 15:24:32.709104
804	CHINA GOURMET	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.711456	2026-03-17 15:24:32.711456
805	ON THE CORNER GRILL	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.713984	2026-03-17 15:24:32.713984
806	MONADNOCK FOOD COOP BEER	jaustin	COOP MONADNOCK	Other Off-Premise	t	2026-03-17 15:24:32.716672	2026-03-17 15:24:32.716672
807	PHO TAI LOC	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.718976	2026-03-17 15:24:32.718976
808	DOLLAR GENERAL #19762 GREENVILLE	ggage	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.722153	2026-03-17 15:24:32.722153
809	BEDFORD EVENT CENTER (THE)	nmoore	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:32.724645	2026-03-17 15:24:32.724645
810	JAKE'S MARKET AND DELI- ENFIELD	jjohnson	JAKE'S MARKET	Convenience	t	2026-03-17 15:24:32.727452	2026-03-17 15:24:32.727452
811	TOSTAO'S TAPAS BAR	nmoore	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:32.730336	2026-03-17 15:24:32.730336
812	110 GRILL - W. LEB	jsewall	110 GRILL	Restaurant	t	2026-03-17 15:24:32.73303	2026-03-17 15:24:32.73303
813	THE FRIENDLY TOAST - BEDFORD	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.738646	2026-03-17 15:24:32.738646
814	RENEGADES PUB	rconstant	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:32.742068	2026-03-17 15:24:32.742068
816	INDIA PALACE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.749483	2026-03-17 15:24:32.749483
818	MONTCALM GOLF CLUB	jjohnson	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:32.755691	2026-03-17 15:24:32.755691
819	LABELLE WINERY EVENTS CATERING	jcaron	* Independent BELLAVANCE BEVERAGE	Concessionaire	t	2026-03-17 15:24:32.758734	2026-03-17 15:24:32.758734
820	ALDWORTH HILLTOP KITCHEN - CATERING	jaustin	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:32.763762	2026-03-17 15:24:32.763762
821	BORDERLINE TOBACCO	nmoore	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.767681	2026-03-17 15:24:32.767681
822	A-1 PIZZA & GRILL HINSDALE	jaustin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.770964	2026-03-17 15:24:32.770964
823	ARLINGTON INN & TAVERN (THE)	jaustin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.775069	2026-03-17 15:24:32.775069
824	THE REFINERY	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.778404	2026-03-17 15:24:32.778404
825	MARKET BASKET #84 SALEM	rmarique	MARKET BASKET	Supermarket	t	2026-03-17 15:24:32.781002	2026-03-17 15:24:32.781002
826	CUMBERLAND FARMS #5449 - HUDSON	amartin	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:32.783339	2026-03-17 15:24:32.783339
827	BEDFORD LURGIO MIDDLE SCHOOL	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:32.786408	2026-03-17 15:24:32.786408
828	@RINCHA	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:32.78905	2026-03-17 15:24:32.78905
830	RILEY'S PLACE	ggage	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:32.795152	2026-03-17 15:24:32.795152
831	PIZZERIA ZACHARIA	scamuso	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.797707	2026-03-17 15:24:32.797707
832	TETAL FOOD MART	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.800352	2026-03-17 15:24:32.800352
834	LOS PRIMOS MEXICAN RESTAURANT	tchagnon	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:32.805437	2026-03-17 15:24:32.805437
835	DOLLAR GENER #20596 - MILFORD	ggage	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.80839	2026-03-17 15:24:32.80839
837	FAMILY DOLLAR # 3045 GOFFSTOWN	lnorton	FAMILY DOLLAR	Other Off-Premise	t	2026-03-17 15:24:32.813581	2026-03-17 15:24:32.813581
838	GRASSHOPPERS GARDEN CENTER	jmeharg	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:32.816711	2026-03-17 15:24:32.816711
839	SKY MARKET & BUTCHER SHOP	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.819733	2026-03-17 15:24:32.819733
840	GAME CHANGER SPORTS BAR & GRILL	rconstant	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:32.822191	2026-03-17 15:24:32.822191
841	CASTLETON	nmoore	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:32.824562	2026-03-17 15:24:32.824562
842	BISTRO 603	scamuso	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.827148	2026-03-17 15:24:32.827148
844	CHARLIE'S HOMESTYLE DINER	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.833613	2026-03-17 15:24:32.833613
845	SNAX	jjohnson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.836116	2026-03-17 15:24:32.836116
849	MICKEY'S NY PIZZA	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.847436	2026-03-17 15:24:32.847436
850	ALLTOWN MARKET 202767- WINCHESTER	jaustin	GLOBAL	Convenience	t	2026-03-17 15:24:32.851234	2026-03-17 15:24:32.851234
851	ZIGGY'S PIZZA - ENFIELD	jjohnson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.854086	2026-03-17 15:24:32.854086
852	NOURIA #1188 S BROADWAY	ddooling	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:32.857062	2026-03-17 15:24:32.857062
853	NOURIA # 1187 DW HIGHWAY	lortiz	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:32.859581	2026-03-17 15:24:32.859581
854	BEER & WINE NATION - MERRIMACK	tchagnon	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.862314	2026-03-17 15:24:32.862314
855	PRESSED CAFE - SALEM	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.86499	2026-03-17 15:24:32.86499
857	SEASONS CORNER MARKET # 305 - NASHUA	scamuso	COLBEA/SEASONS	Convenience	t	2026-03-17 15:24:32.871625	2026-03-17 15:24:32.871625
858	WATKINS INN & TAVERN	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.874232	2026-03-17 15:24:32.874232
859	JALISCO MEXICAN BAR & GRILL	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:32.878141	2026-03-17 15:24:32.878141
860	NOURIA ENERGY #1193 - BEDFORD	tchagnon	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:32.880853	2026-03-17 15:24:32.880853
861	INDIAN ROCK MARKET & SMOKE SHOP	rmarique	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.883416	2026-03-17 15:24:32.883416
862	ARLINGTON INN & TAVERN CATERING	jaustin	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:32.886088	2026-03-17 15:24:32.886088
865	SALT HILL NEWPORT - CATERING	jgrumblatt	SALT HILL PUB	Catering	t	2026-03-17 15:24:32.895373	2026-03-17 15:24:32.895373
866	BARBARA'S CORNER STORE	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.898429	2026-03-17 15:24:32.898429
867	DOLLAR GENERAL #22557 - SUNAPEE	jgrumblatt	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.900765	2026-03-17 15:24:32.900765
871	DIPLOMAT (THE)	jaustin	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:32.911563	2026-03-17 15:24:32.911563
872	BRIGHT SIDE BREWING	jjohnson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.914225	2026-03-17 15:24:32.914225
873	MOBIL MART- LONDONDERRY	rconstant	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.916558	2026-03-17 15:24:32.916558
875	FERN CAFE	jmalloy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.921862	2026-03-17 15:24:32.921862
876	AXEL'S THROW HOUSE	sshaunessy	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:32.924385	2026-03-17 15:24:32.924385
877	LOS REYES STREET TACOS & MORE	nmoore	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:32.926786	2026-03-17 15:24:32.926786
878	ARTISAN CHEF CATERING	ddooling	TUSCAN KITCHEN	Catering	t	2026-03-17 15:24:32.929289	2026-03-17 15:24:32.929289
879	AMERICAN LEGION POST 3 - NASHUA	amartin	American Legion	VFW/Legion	t	2026-03-17 15:24:32.933157	2026-03-17 15:24:32.933157
881	CUMBERLAND FARMS #5450 -NASHUA - AMHERST ST	scamuso	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:32.93839	2026-03-17 15:24:32.93839
882	NUTFIELD SPIRITS	eleahy	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:32.941326	2026-03-17 15:24:32.941326
883	WONDER CASINO	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.943842	2026-03-17 15:24:32.943842
886	CIRCLE K #7247 - ANDOVER	jgrumblatt	CIRCLE K	Convenience	t	2026-03-17 15:24:32.951669	2026-03-17 15:24:32.951669
887	DOLLAR GENERAL # 23246 - WEARE	jmeharg	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.954542	2026-03-17 15:24:32.954542
888	SAWTOOTH KITCHEN LLC	jsewall	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.957076	2026-03-17 15:24:32.957076
890	HUDSON SPEEDWAY (THE)	rconstant	* Independent BELLAVANCE BEVERAGE	Concessionaire	t	2026-03-17 15:24:32.961825	2026-03-17 15:24:32.961825
891	APPLESEED LAKESIDE REST	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.964471	2026-03-17 15:24:32.964471
893	BRADFORD MARKET	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.969722	2026-03-17 15:24:32.969722
895	CARDIGAN MOUNTAIN SCHOOL	jmalloy	SCHOOLS	School	t	2026-03-17 15:24:32.975054	2026-03-17 15:24:32.975054
896	EVANS EXPRESS - CANAAN	jjohnson	EVAN'S FUEL	Convenience	t	2026-03-17 15:24:32.977659	2026-03-17 15:24:32.977659
897	PLEASANT VALLEY STORE	jjohnson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.980088	2026-03-17 15:24:32.980088
899	DOLLAR GENER #14774 - CHARLESTWN	pwollert	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:32.986087	2026-03-17 15:24:32.986087
900	BORDER BREWERY	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.989567	2026-03-17 15:24:32.989567
901	BIRDS NEST (KHS)	jmalloy	SCHOOLS	School	t	2026-03-17 15:24:32.992248	2026-03-17 15:24:32.992248
902	RALPH'S SUPERMARKET	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:32.99537	2026-03-17 15:24:32.99537
903	SUMNER HOUSE	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:32.998159	2026-03-17 15:24:32.998159
904	CHESTERFIELD SCHOOL	jmalloy	SCHOOLS	School	t	2026-03-17 15:24:33.00076	2026-03-17 15:24:33.00076
905	WEST CHESTERFIELD SHELL #200643	jaustin	GLOBAL	Convenience	t	2026-03-17 15:24:33.004081	2026-03-17 15:24:33.004081
906	AMERICAN LEGION POST 29 - CLAREMONT	jmorse	American Legion	VFW/Legion	t	2026-03-17 15:24:33.006486	2026-03-17 15:24:33.006486
907	BIRNEY'S MINI MART	jmorse	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.009097	2026-03-17 15:24:33.009097
908	CLAREMONT COUNTRY CLUB	jmorse	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:33.011633	2026-03-17 15:24:33.011633
909	CLAREMONT LODGE OF ELKS	jmorse	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:33.014067	2026-03-17 15:24:33.014067
910	CLAREMONT MOBIL	jmorse	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.016606	2026-03-17 15:24:33.016606
911	COMMON MAN - CLAREMONT	jmorse	COMMON MAN	Restaurant	t	2026-03-17 15:24:33.019156	2026-03-17 15:24:33.019156
912	CUMBERLAND FM #5419 - CLAREMNT - WASH ST	jmorse	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:33.021821	2026-03-17 15:24:33.021821
913	CUMBERLAND FM #5421 - CLAREMNT - PLEASANT ST	jmorse	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:33.024333	2026-03-17 15:24:33.024333
914	CVS PHARM #5347 - CLAREMONT	jmorse	CVS STORES	Drug Store	t	2026-03-17 15:24:33.027154	2026-03-17 15:24:33.027154
915	DADDY'S PIZZA	jmorse	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.030066	2026-03-17 15:24:33.030066
917	FAMILY DOLLAR #24196 - CLAREMONT	jmorse	FAMILY DOLLAR	Other Off-Premise	t	2026-03-17 15:24:33.036585	2026-03-17 15:24:33.036585
918	NASHUA HIGH SCHOOL SOUTH (STORE)	jsweeney	SCHOOLS	School	t	2026-03-17 15:24:33.039086	2026-03-17 15:24:33.039086
919	HANNAFORD #8119 - CLAREMNT	jmorse	HANNAFORD	Supermarket	t	2026-03-17 15:24:33.041794	2026-03-17 15:24:33.041794
920	IMPERIAL BUFFET & LOUNGE	jmorse	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:33.044997	2026-03-17 15:24:33.044997
921	SHERATON HOTEL (ARBI FARMS)	maanderson	* Independent BELLAVANCE BEVERAGE	Hotel/Lodging	t	2026-03-17 15:24:33.047971	2026-03-17 15:24:33.047971
924	LEO'S ONE STOP	jmorse	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.055893	2026-03-17 15:24:33.055893
925	MARKET BASKET #53 CLAREMNT	jmorse	MARKET BASKET	Supermarket	t	2026-03-17 15:24:33.058325	2026-03-17 15:24:33.058325
927	VISION CIGAR AND CIGARETTE WHOLESALE LLC	jsweeney	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:33.063732	2026-03-17 15:24:33.063732
928	PLEASANT ST MOBIL	jmorse	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.066664	2026-03-17 15:24:33.066664
929	POLISH AMER CITIZENS CLUB-CLAREMONT	jmorse	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:33.069237	2026-03-17 15:24:33.069237
930	WALGREENS #9177 - LEBANON	jsewall	WAL-GREENS	Drug Store	t	2026-03-17 15:24:33.071805	2026-03-17 15:24:33.071805
931	RAMUNTOS - CLAREMONT	jmorse	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.074143	2026-03-17 15:24:33.074143
932	PAR28	jgiuffrida	* Independent BELLAVANCE BEVERAGE	Recreation/Sports	t	2026-03-17 15:24:33.076451	2026-03-17 15:24:33.076451
933	SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )	jmorse	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:33.079022	2026-03-17 15:24:33.079022
934	TREMONT HOUSE OF PIZZA	jmorse	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.082373	2026-03-17 15:24:33.082373
936	VFW #808 - CLAREMONT	jmorse	VETERANS OF FOREIGN WARS	VFW/Legion	t	2026-03-17 15:24:33.08892	2026-03-17 15:24:33.08892
937	WAL-MART #1975 - CLAREMONT	jmorse	WALMART	Supermarket	t	2026-03-17 15:24:33.091706	2026-03-17 15:24:33.091706
938	THE 12% SOLUTION	jsewall	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.094044	2026-03-17 15:24:33.094044
939	DANBURY COUNTRY STORE	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.09703	2026-03-17 15:24:33.09703
940	RAGGED MOUNTAIN	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Recreation/Sports	t	2026-03-17 15:24:33.100122	2026-03-17 15:24:33.100122
941	DUBLIN GENERAL STORE	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.103321	2026-03-17 15:24:33.103321
942	DARTMOUTH COACH	jmalloy	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:33.105928	2026-03-17 15:24:33.105928
943	JIFFY MART #200691 - WESTMORELAND	pwollert	GLOBAL	Convenience	t	2026-03-17 15:24:33.108466	2026-03-17 15:24:33.108466
945	EVANS EXPRESS - ENFIELD	jjohnson	EVAN'S FUEL	Convenience	t	2026-03-17 15:24:33.114683	2026-03-17 15:24:33.114683
946	CALIFORNIA BURRITOS-AMHERST	scamuso	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.118091	2026-03-17 15:24:33.118091
947	RUSTIC ROSE TAVERN	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.12076	2026-03-17 15:24:33.12076
948	ENFIELD GAS & FOOD	jjohnson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.123917	2026-03-17 15:24:33.123917
949	SIMON'S EXIT 16 MOBIL	jjohnson	SIMON'S	Convenience	t	2026-03-17 15:24:33.127456	2026-03-17 15:24:33.127456
950	UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO	jjohnson	* Independent BELLAVANCE BEVERAGE	Recreation/Sports	t	2026-03-17 15:24:33.13105	2026-03-17 15:24:33.13105
951	SEVMAR MEDITERRANEAN BISTRO	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.136026	2026-03-17 15:24:33.136026
952	MR MIKE'S - FITZWILLIAM	pbelanger	GLOBAL	Convenience	t	2026-03-17 15:24:33.1391	2026-03-17 15:24:33.1391
953	STATELINE GROCERY'S	pbelanger	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.141381	2026-03-17 15:24:33.141381
954	REDLINE ATHLETICS	nmoore	* Independent BELLAVANCE BEVERAGE	Recreation/Sports	t	2026-03-17 15:24:33.144326	2026-03-17 15:24:33.144326
955	GOSHEN COUNTRY STORE	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.147127	2026-03-17 15:24:33.147127
956	SPYGLASS BREWING COMPANY (REST)	maanderson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.149828	2026-03-17 15:24:33.149828
957	CIRCLE K #7240 - GRANTHAM	jmorse	CIRCLE K	Convenience	t	2026-03-17 15:24:33.152432	2026-03-17 15:24:33.152432
960	CIRCLE K #7245 - HANOVER	jsewall	CIRCLE K	Convenience	t	2026-03-17 15:24:33.160938	2026-03-17 15:24:33.160938
961	CVS PHARM #5938 - HANOVER	jjohnson	CVS STORES	Drug Store	t	2026-03-17 15:24:33.163855	2026-03-17 15:24:33.163855
963	DARTMOUTH DINING-TOPSIDE	jmalloy	SCHOOLS	Soda Only	t	2026-03-17 15:24:33.169789	2026-03-17 15:24:33.169789
964	HANOVER CONSUMER COOP	jjohnson	HANOVER COOP GROUP	Other Off-Premise	t	2026-03-17 15:24:33.172271	2026-03-17 15:24:33.172271
965	HANOVER INN	jjohnson	* Independent BELLAVANCE BEVERAGE	Hotel/Lodging	t	2026-03-17 15:24:33.175095	2026-03-17 15:24:33.175095
966	STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)	jsewall	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:33.17777	2026-03-17 15:24:33.17777
969	STEWART'S SHOP #523 - HANOVER	jjohnson	STEWART'S SHOP	Convenience	t	2026-03-17 15:24:33.185739	2026-03-17 15:24:33.185739
970	MURPHY'S ON THE GREEN	jjohnson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.188851	2026-03-17 15:24:33.188851
971	RAMUNTO'S BRICK & BRICK & BREW PIZZERIA-HANOVER	jjohnson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.191856	2026-03-17 15:24:33.191856
972	RICHMOND MIDDLE SCHOOL	jmalloy	SCHOOLS	School	t	2026-03-17 15:24:33.194691	2026-03-17 15:24:33.194691
975	STINSON'S VILLAGE STORE	jsewall	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.202069	2026-03-17 15:24:33.202069
977	UMPLEBY'S BAKERY & CAFE'	jmalloy	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:33.206948	2026-03-17 15:24:33.206948
980	MAIN STREET MARKETPLACE	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.214274	2026-03-17 15:24:33.214274
981	RTE. 63 COUNTRY STORE	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.216797	2026-03-17 15:24:33.216797
983	WAL-MART #1907 - HINSDALE	jaustin	WALMART	Supermarket	t	2026-03-17 15:24:33.221339	2026-03-17 15:24:33.221339
984	LULL FARM - HOLLIS	jsweeney	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:33.224008	2026-03-17 15:24:33.224008
985	21 ROXBURY BAR & GRILL	pwollert	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:33.226374	2026-03-17 15:24:33.226374
986	AMERICAN LEGION POST 4 - KEENE	pwollert	American Legion	VFW/Legion	t	2026-03-17 15:24:33.228598	2026-03-17 15:24:33.228598
987	APPLEBEES - KEENE #6714	jaustin	APPLEBEES	Restaurant	t	2026-03-17 15:24:33.230838	2026-03-17 15:24:33.230838
988	ATHEN'S PIZZA	bgermano	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.23295	2026-03-17 15:24:33.23295
989	BEAVER STREET MARKET	bgermano	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.234929	2026-03-17 15:24:33.234929
990	BIG DEAL - KEENE	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.237019	2026-03-17 15:24:33.237019
992	CHESHIRE VILLAGE PIZZA	bgermano	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.242078	2026-03-17 15:24:33.242078
993	CHILI'S - KEENE	jaustin	CHILI'S REST	Restaurant	t	2026-03-17 15:24:33.244373	2026-03-17 15:24:33.244373
994	CIRCLE K # 7257 - KEENE	pwollert	CIRCLE K	Convenience	t	2026-03-17 15:24:33.247147	2026-03-17 15:24:33.247147
996	CUMBERLAND FM #5425 - KEENE	bgermano	CUMBERLAND FRM N1013	Convenience	t	2026-03-17 15:24:33.252082	2026-03-17 15:24:33.252082
997	CVS PHARM #640 - KEENE	pwollert	CVS STORES	Drug Store	t	2026-03-17 15:24:33.254389	2026-03-17 15:24:33.254389
998	ASH CIGAR LOUNGE	jcannamucio	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:33.256644	2026-03-17 15:24:33.256644
1000	JENNA'S MARKET	pwollert	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:33.261277	2026-03-17 15:24:33.261277
1002	FRATERNAL ORDER OF EAGLES	pwollert	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:33.265929	2026-03-17 15:24:33.265929
1003	HANNAFORD #8163 - KEENE	bgermano	HANNAFORD	Supermarket	t	2026-03-17 15:24:33.268711	2026-03-17 15:24:33.268711
1005	ITALIAN CLUB	pwollert	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:33.27302	2026-03-17 15:24:33.27302
1006	OAK CRAFT PIZZA - SALEM	rmarique	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.275731	2026-03-17 15:24:33.275731
1007	TEMPESTA'S	jaustin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.277936	2026-03-17 15:24:33.277936
1008	CRAZY NOODLE	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:33.280448	2026-03-17 15:24:33.280448
1009	ROYAL PIZZA	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.282784	2026-03-17 15:24:33.282784
1010	KEENE C.C. PRO SHOP	jaustin	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:33.285364	2026-03-17 15:24:33.285364
1011	KEENE COUNTRY CLUB INC	jaustin	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:33.287717	2026-03-17 15:24:33.287717
1012	KEENE DISCOUNT MART	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.290068	2026-03-17 15:24:33.290068
1013	KEENE LODGE OF ELKS	pwollert	* Independent BELLAVANCE BEVERAGE	VFW/Legion	t	2026-03-17 15:24:33.292251	2026-03-17 15:24:33.292251
1014	SAXY CHEF LLC	jmalloy	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:33.294791	2026-03-17 15:24:33.294791
1015	KHS - CAFETERIA	jmalloy	SCHOOLS	School	t	2026-03-17 15:24:33.297033	2026-03-17 15:24:33.297033
1016	KILKENNY PUB - KEENE	jaustin	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:33.299317	2026-03-17 15:24:33.299317
1017	KMS - CAFETERIA	jmalloy	SCHOOLS	School	t	2026-03-17 15:24:33.302086	2026-03-17 15:24:33.302086
1018	LAB'N LAGER KEENE	jaustin	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:33.304601	2026-03-17 15:24:33.304601
1019	LOCAL BURGER OF KEENE	jaustin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.307447	2026-03-17 15:24:33.307447
1020	LONGHORN STEAK #0003 - KEENE	jaustin	LONGHORN STEAK N1003	Restaurant	t	2026-03-17 15:24:33.31075	2026-03-17 15:24:33.31075
1021	JIFFY MART #200692 - KEENE	pwollert	GLOBAL	Convenience	t	2026-03-17 15:24:33.313002	2026-03-17 15:24:33.313002
1022	CLIFFY'S PUB	jaustin	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:33.315338	2026-03-17 15:24:33.315338
1024	MARGARITA'S - KEENE	jaustin	MARGARITA'S	Mexican Restaurant	t	2026-03-17 15:24:33.320097	2026-03-17 15:24:33.320097
1025	MI JALISCO - KEENE	jaustin	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:33.323287	2026-03-17 15:24:33.323287
1026	MONADNOCK FOOD COOP NA	jaustin	COOP MONADNOCK	Other Off-Premise	t	2026-03-17 15:24:33.325745	2026-03-17 15:24:33.325745
1028	SPECTACLE MANAGEMENT INC	amartin	* Independent BELLAVANCE BEVERAGE	Concessionaire	t	2026-03-17 15:24:33.331144	2026-03-17 15:24:33.331144
1029	PINE VALLEY GOLF COURSE	maanderson	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:33.33415	2026-03-17 15:24:33.33415
1030	POUR HOUSE (THE)	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.336654	2026-03-17 15:24:33.336654
1031	PLAISTOW MINI EXPRESS	eplatt	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.339158	2026-03-17 15:24:33.339158
1032	PRICE CHOPPER #208 - KEENE	bgermano	PRICE CHOPPER	Supermarket	t	2026-03-17 15:24:33.341391	2026-03-17 15:24:33.341391
1034	SANDRI STOP MART - KEENE	jaustin	J.W. SANDRI	Convenience	t	2026-03-17 15:24:33.345957	2026-03-17 15:24:33.345957
1035	STAGE HANDS RESTAURANT	bgermano	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.34915	2026-03-17 15:24:33.34915
1037	HATCH CONVENIENCE STORE	scamuso	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.354808	2026-03-17 15:24:33.354808
1038	TARGET #2120 - KEENE	bgermano	TARGET	Grocery	t	2026-03-17 15:24:33.357442	2026-03-17 15:24:33.357442
1041	VFW #799 - KEENE	jaustin	VETERANS OF FOREIGN WARS	Bar/Club	t	2026-03-17 15:24:33.366659	2026-03-17 15:24:33.366659
1042	WAL-MART #3549 - KEENE	bgermano	WALMART	Supermarket	t	2026-03-17 15:24:33.369599	2026-03-17 15:24:33.369599
1043	WALGREENS #3154 - KEENE	pwollert	WAL-GREENS	Drug Store	t	2026-03-17 15:24:33.372351	2026-03-17 15:24:33.372351
1044	AMERICAN LEGION POST 22 - GRAFTON	jjohnson	American Legion	VFW/Legion	t	2026-03-17 15:24:33.37522	2026-03-17 15:24:33.37522
1045	FOUNDATION KITCHEN AND BAR	eleahy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.379225	2026-03-17 15:24:33.379225
1047	CVS PHARM #647 - W.LEB	jsewall	CVS STORES	Drug Store	t	2026-03-17 15:24:33.385215	2026-03-17 15:24:33.385215
1048	EVANS EXPRESS - LEBANON	jjohnson	EVAN'S FUEL	Convenience	t	2026-03-17 15:24:33.388758	2026-03-17 15:24:33.388758
1049	ENTERTAINMENT CINEMAS - LEBANON	jjohnson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.39183	2026-03-17 15:24:33.39183
1050	FAST STOP/CHAMPLAIN FARMS	jjohnson	CHAMPLAIN FARMS	Convenience	t	2026-03-17 15:24:33.394465	2026-03-17 15:24:33.394465
1051	GUSANOZ MEXICAN REST	jjohnson	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:33.396853	2026-03-17 15:24:33.396853
1052	LEBANON COOP	jjohnson	HANOVER COOP GROUP	Other Off-Premise	t	2026-03-17 15:24:33.400416	2026-03-17 15:24:33.400416
1053	HOMESTEAD GROCERY & CONVENIENCE	jcaron	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.403365	2026-03-17 15:24:33.403365
1054	LEBANON LODGE OF ELKS	jsewall	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:33.405979	2026-03-17 15:24:33.405979
1055	MAPLEFIELDS	jjohnson	MAPLEFIELDS	Convenience	t	2026-03-17 15:24:33.409659	2026-03-17 15:24:33.409659
1056	AAANM AHMAD LLC	jjohnson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.412906	2026-03-17 15:24:33.412906
1057	PPC KITCHEN & BAR	eplatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.415629	2026-03-17 15:24:33.415629
1059	PRICE CHOPPER #227 - LEBANON	jjohnson	PRICE CHOPPER	Supermarket	t	2026-03-17 15:24:33.422483	2026-03-17 15:24:33.422483
1060	PRICE CHOPPER #167 - W.LEB	jjohnson	PRICE CHOPPER	Supermarket	t	2026-03-17 15:24:33.42526	2026-03-17 15:24:33.42526
1062	SALT HILL PUB - LEBANON	jsewall	SALT HILL PUB	Restaurant	t	2026-03-17 15:24:33.430887	2026-03-17 15:24:33.430887
1065	THREE TOMATOES TRATTORIA	jsewall	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.441641	2026-03-17 15:24:33.441641
1066	WICKED GOOD BUTCHAH	lnorton	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:33.444317	2026-03-17 15:24:33.444317
1068	LYME COUNTRY STORE	jsewall	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.450043	2026-03-17 15:24:33.450043
1069	BUBBA'S BAR AND GRILLE	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.452911	2026-03-17 15:24:33.452911
1071	MARLBOROUGH FOOD MART	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.459196	2026-03-17 15:24:33.459196
1073	MAIN CRUST CO.	jaustin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.465567	2026-03-17 15:24:33.465567
1074	MARLBOROUGH CTRY CONVENIENCE	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.468364	2026-03-17 15:24:33.468364
1075	MARLBOROUGH SCHOOL	jmalloy	SCHOOLS	School	t	2026-03-17 15:24:33.47145	2026-03-17 15:24:33.47145
1077	MILFORD HIGH SCHOOL	jmalloy	SCHOOLS	School	t	2026-03-17 15:24:33.477705	2026-03-17 15:24:33.477705
1078	MILFORD MIDDLE SCHOOL	jmalloy	SCHOOLS	School	t	2026-03-17 15:24:33.480698	2026-03-17 15:24:33.480698
1079	WHITE BIRCH GENERAL STORE	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.48363	2026-03-17 15:24:33.48363
1080	5 STAR BEVERAGE	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.486468	2026-03-17 15:24:33.486468
1081	STATELINE GROCERY	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.489434	2026-03-17 15:24:33.489434
1082	COLBY-SAWYER COLLEGE - GALLIGAN'S PUB	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:33.492328	2026-03-17 15:24:33.492328
1083	EVANS EXPRESS - NEW LONDON	jgrumblatt	EVAN'S FUEL	Convenience	t	2026-03-17 15:24:33.495095	2026-03-17 15:24:33.495095
1084	FOUR CORNERS-FLYING GOOSE Brewery	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.497935	2026-03-17 15:24:33.497935
1086	HANNAFORD #8246 - NEW LONDON	jgrumblatt	HANNAFORD	Supermarket	t	2026-03-17 15:24:33.504298	2026-03-17 15:24:33.504298
1088	NEWBURY DELI	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:33.510824	2026-03-17 15:24:33.510824
1089	KEARSAGE COOP	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:33.515261	2026-03-17 15:24:33.515261
1090	LAKE SUNAPEE COUNTRY CLUB	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:33.518004	2026-03-17 15:24:33.518004
1092	NEW LONDON INN/COACH HOUSE RESTAURANT	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.524786	2026-03-17 15:24:33.524786
1093	MI CORAZON MEXICAN GRILL	jmeharg	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:33.527963	2026-03-17 15:24:33.527963
1094	STOCKWELL RESTAURANT	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.530642	2026-03-17 15:24:33.530642
1095	NEWBURY PALACE PIZZA	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.533944	2026-03-17 15:24:33.533944
1096	NEWBURY QUICK STOP	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.536576	2026-03-17 15:24:33.536576
1097	SALT HILL PUB - NEWBURY	jgrumblatt	SALT HILL PUB	Restaurant	t	2026-03-17 15:24:33.539828	2026-03-17 15:24:33.539828
1098	CIRCLE K #7204 - NEWPORT	jmorse	CIRCLE K	Convenience	t	2026-03-17 15:24:33.542638	2026-03-17 15:24:33.542638
1099	CORONIS MARKET	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.545088	2026-03-17 15:24:33.545088
1100	DOLLAR GENER #13857 - NEWPORT	jgrumblatt	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:33.548063	2026-03-17 15:24:33.548063
1101	FORESTERS OF AMERICA	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:33.551604	2026-03-17 15:24:33.551604
1102	LOYAL ORDER OF MOOSE - NEWPORT	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Private Club	t	2026-03-17 15:24:33.554669	2026-03-17 15:24:33.554669
1103	NEWPORT GOLF CLUB	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:33.558132	2026-03-17 15:24:33.558132
1104	WICKED TASTY (CATERING)	jsewall	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:33.561176	2026-03-17 15:24:33.561176
1107	NEWPORT VETERAN'S CLUB	jgrumblatt	* Independent BELLAVANCE BEVERAGE	VFW/Legion	t	2026-03-17 15:24:33.570907	2026-03-17 15:24:33.570907
1109	SALT HILL PUB - NEWPORT	jgrumblatt	SALT HILL PUB	Restaurant	t	2026-03-17 15:24:33.57821	2026-03-17 15:24:33.57821
1110	SHAW'S #4534 - NEWPORT	jgrumblatt	SHAWS	Supermarket	t	2026-03-17 15:24:33.58165	2026-03-17 15:24:33.58165
1111	SHOP EXPRESS	jmorse	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.585094	2026-03-17 15:24:33.585094
1112	PLEASANT ST SMOKE & BEER	jmorse	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:33.588713	2026-03-17 15:24:33.588713
1114	MIGHTY MOOSE MART - WINCHESTER STREET	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.594624	2026-03-17 15:24:33.594624
1115	PAPAGALLOS RESTAURANT	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.597723	2026-03-17 15:24:33.597723
1116	PATTERSON GROCERY & DELI	jsewall	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.601725	2026-03-17 15:24:33.601725
1117	PEYTON PLACE RESTAURANT	jsewall	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.604772	2026-03-17 15:24:33.604772
1119	RED ARROW DINER - LONDONDERRY	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.611101	2026-03-17 15:24:33.611101
1120	BAGEL MILL	pbelanger	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.614492	2026-03-17 15:24:33.614492
1122	FOUR CORNERS GENERAL STORE	jsewall	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.620869	2026-03-17 15:24:33.620869
1123	AR VILLAGE STORE	jsewall	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.624203	2026-03-17 15:24:33.624203
1124	PROCTORS GENERAL STORE	jjohnson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.627464	2026-03-17 15:24:33.627464
1125	POOR THOMS TAVERN	jsewall	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:33.630441	2026-03-17 15:24:33.630441
1126	WOODBOUND INN	pbelanger	* Independent BELLAVANCE BEVERAGE	Hotel/Lodging	t	2026-03-17 15:24:33.634642	2026-03-17 15:24:33.634642
1127	JOHNOS GREENVILLE MARKET	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.637803	2026-03-17 15:24:33.637803
1129	JAKE'S 5 STAR CONVENIENCE	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.646054	2026-03-17 15:24:33.646054
1130	HANNAFORD #8180 - RINDGE	pbelanger	HANNAFORD	Supermarket	t	2026-03-17 15:24:33.64878	2026-03-17 15:24:33.64878
1131	HOMETOWN IRVING	pbelanger	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.652823	2026-03-17 15:24:33.652823
1134	MARKET BASKET #47 RINDGE	pbelanger	MARKET BASKET	Supermarket	t	2026-03-17 15:24:33.667104	2026-03-17 15:24:33.667104
1135	TASTE	jjohnson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.670242	2026-03-17 15:24:33.670242
1136	JM NORTH OF THE BORDER	pbelanger	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.674841	2026-03-17 15:24:33.674841
1137	WAL-MART #2057 - RINDGE	pbelanger	WALMART	Supermarket	t	2026-03-17 15:24:33.67802	2026-03-17 15:24:33.67802
1138	WEST OF THE BORDER	pbelanger	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.680741	2026-03-17 15:24:33.680741
1139	SULLIVAN COUNTRY STORE	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.683603	2026-03-17 15:24:33.683603
1140	GRANITE GORGE PARTNERSHIP	pwollert	* Independent BELLAVANCE BEVERAGE	Recreation/Sports	t	2026-03-17 15:24:33.687145	2026-03-17 15:24:33.687145
1142	BIG DEAL - SPOFFORD	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.694187	2026-03-17 15:24:33.694187
1143	FRIENDLY REDS - DERRY	eleahy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.69685	2026-03-17 15:24:33.69685
1144	MILL VILLAGE CTRY STORE	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.700061	2026-03-17 15:24:33.700061
1145	MR MIKE'S - STODDARD	pwollert	GLOBAL	Convenience	t	2026-03-17 15:24:33.703316	2026-03-17 15:24:33.703316
1146	SUNNYCREST FARM	nmoore	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:33.706458	2026-03-17 15:24:33.706458
1148	EVANS EXPRESS - SUNAPEE	jgrumblatt	EVAN'S FUEL	Convenience	t	2026-03-17 15:24:33.712454	2026-03-17 15:24:33.712454
1149	NOURIA ENERGY # 1268 - HAMPSTEAD	jcannamucio	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:33.716154	2026-03-17 15:24:33.716154
1150	BENDER'S BAR AND GRILL	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.719363	2026-03-17 15:24:33.719363
1151	PEPPERS PUB (NEW)	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.722067	2026-03-17 15:24:33.722067
1152	WILDWOOD SMOKEHOUSE	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.724599	2026-03-17 15:24:33.724599
1153	CASA JALISCO BAR & GRILL	jmorse	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:33.72722	2026-03-17 15:24:33.72722
1154	DOLLAR GENER #13534 - SWANZEY	pwollert	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:33.730503	2026-03-17 15:24:33.730503
1155	MARKET BASKET #64 SWANZEY	bgermano	MARKET BASKET	Supermarket	t	2026-03-17 15:24:33.733179	2026-03-17 15:24:33.733179
1156	ROUTE 10 MINI MART	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.735599	2026-03-17 15:24:33.735599
1157	VYBEZ RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.738606	2026-03-17 15:24:33.738606
1158	MRHS LUNCH PROGRAM	jmalloy	SCHOOLS	School	t	2026-03-17 15:24:33.741695	2026-03-17 15:24:33.741695
1159	MINUTE MART	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.74443	2026-03-17 15:24:33.74443
1161	RIVERSIDE GROCERY	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.75069	2026-03-17 15:24:33.75069
1162	ALYSONS ORCHARD	pwollert	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:33.753771	2026-03-17 15:24:33.753771
1163	DIAMOND PIZZA	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.756743	2026-03-17 15:24:33.756743
1164	FAMILY DOLLAR #8638 - WALPOLE	pwollert	FAMILY DOLLAR	Other Off-Premise	t	2026-03-17 15:24:33.76022	2026-03-17 15:24:33.76022
1166	APPLE CINEMAS	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.766483	2026-03-17 15:24:33.766483
1167	POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES	jjohnson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.769626	2026-03-17 15:24:33.769626
1168	SHAW'S #3533 - WALPOLE	pwollert	SHAWS	Supermarket	t	2026-03-17 15:24:33.772671	2026-03-17 15:24:33.772671
1169	WALGREENS #11985 - WALPOLE	pwollert	WAL-GREENS	Drug Store	t	2026-03-17 15:24:33.775832	2026-03-17 15:24:33.775832
1171	SHAWNEE GENERAL STORE	jsewall	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.781951	2026-03-17 15:24:33.781951
1172	99 REST - W.LEB	jsewall	99 RESTAURANT	Restaurant	t	2026-03-17 15:24:33.784733	2026-03-17 15:24:33.784733
1173	APPLEBEES - W.LEB #6732	jsewall	APPLEBEES	Restaurant	t	2026-03-17 15:24:33.787817	2026-03-17 15:24:33.787817
1174	BJ'S WHOLESALE-W.LEB #320	jsmoyer	BJ'S WHOLESALE	Club Store	t	2026-03-17 15:24:33.791164	2026-03-17 15:24:33.791164
1175	CHILI'S - W.LEB	jsewall	CHILI'S REST	Restaurant	t	2026-03-17 15:24:33.79415	2026-03-17 15:24:33.79415
1176	CIRCLE K #7246 - W.LEB	jsewall	CIRCLE K	Convenience	t	2026-03-17 15:24:33.796783	2026-03-17 15:24:33.796783
1177	WORLD CUP GOLF CENTER	nmoore	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:33.800699	2026-03-17 15:24:33.800699
1179	HANNAFORD #8266 - W.LEB	jsewall	HANNAFORD	Supermarket	t	2026-03-17 15:24:33.80767	2026-03-17 15:24:33.80767
1180	STEWART'S SHOP #525 -WEST LEBANON	jsewall	STEWART'S SHOP	Convenience	t	2026-03-17 15:24:33.81059	2026-03-17 15:24:33.81059
1181	TARGET # 3401 - W. LEBANON	jsewall	TARGET	Grocery	t	2026-03-17 15:24:33.81412	2026-03-17 15:24:33.81412
1182	KOTO JAPANESE STEAK HOUSE - W.LEB	jsewall	KOTO (Clarke)	Chinese Restaurant	t	2026-03-17 15:24:33.817137	2026-03-17 15:24:33.817137
1184	STATELINE PAYSAVER	ddooling	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.822955	2026-03-17 15:24:33.822955
1185	RANCHO VIEJO MEXICAN FOOD AND CANTINA	jmorse	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:33.825646	2026-03-17 15:24:33.825646
1186	SANDRI STOP - W.LEB	jsewall	J.W. SANDRI	Convenience	t	2026-03-17 15:24:33.82911	2026-03-17 15:24:33.82911
1187	SHAW'S #4555 - W.LEB	jsewall	SHAWS	Supermarket	t	2026-03-17 15:24:33.832007	2026-03-17 15:24:33.832007
1189	WAL-MART #2138 - W.LEB	jsewall	WALMART	Supermarket	t	2026-03-17 15:24:33.837835	2026-03-17 15:24:33.837835
1190	WEATHERVANE - W.LEB	jsewall	WEATHERVANE SEAFOOD (Clarke)	Restaurant	t	2026-03-17 15:24:33.841103	2026-03-17 15:24:33.841103
1192	ZIGGY'S PIZZA - W. LEB	jjohnson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.846843	2026-03-17 15:24:33.846843
1194	PARK N GO	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.853146	2026-03-17 15:24:33.853146
1195	WILTON LYNDEBOROUGH HIGH SCHOOL	jmalloy	SCHOOLS	School	t	2026-03-17 15:24:33.855973	2026-03-17 15:24:33.855973
1196	CHA'S GEM SHOP AND CONV	pbelanger	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.859143	2026-03-17 15:24:33.859143
1197	FAMILY DOLLAR #8262 - WINCHESTER	jaustin	FAMILY DOLLAR	Other Off-Premise	t	2026-03-17 15:24:33.861947	2026-03-17 15:24:33.861947
1199	MAIN STREET MINI MART	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.867728	2026-03-17 15:24:33.867728
1200	THE YOLK GRILL LLC	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.870559	2026-03-17 15:24:33.870559
1201	RUSTIC TABLE (THE)	jaustin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.873308	2026-03-17 15:24:33.873308
1202	VFW #3968 - WINCHESTER	jaustin	VETERANS OF FOREIGN WARS	Private Club	t	2026-03-17 15:24:33.87598	2026-03-17 15:24:33.87598
1203	THE ARTISAN HOTEL	ddooling	* Independent BELLAVANCE BEVERAGE	Hotel/Lodging	t	2026-03-17 15:24:33.879899	2026-03-17 15:24:33.879899
1204	DOLLAR GENER #16772 - CANAAN	jjohnson	DOLLAR GENERAL	Other Off-Premise	t	2026-03-17 15:24:33.882793	2026-03-17 15:24:33.882793
1205	YANKEE LANES / KEENE BOWL	jaustin	* Independent BELLAVANCE BEVERAGE	Bowling/Billiards	t	2026-03-17 15:24:33.886061	2026-03-17 15:24:33.886061
1206	ROY'S MARKET	pbelanger	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.890056	2026-03-17 15:24:33.890056
1207	EMMAS 321	pbelanger	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.892974	2026-03-17 15:24:33.892974
1209	SUNA RESTAURANT	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.898735	2026-03-17 15:24:33.898735
1211	ALLAN'S VENDING	jmalloy	* Independent BELLAVANCE BEVERAGE	Soda Only	t	2026-03-17 15:24:33.904803	2026-03-17 15:24:33.904803
1212	RED ARROW DINER - NASHUA	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.907857	2026-03-17 15:24:33.907857
1213	GRUMPY'S CIGARS AND LOUNGE	nmoore	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:33.910735	2026-03-17 15:24:33.910735
1214	TA GROUP USA	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.914233	2026-03-17 15:24:33.914233
1215	FAMILY DOLLAR # 10210 ENFIELD	jjohnson	FAMILY DOLLAR	Other Off-Premise	t	2026-03-17 15:24:33.917121	2026-03-17 15:24:33.917121
1217	VALLARTA TACOS AND BURRITOS	ddooling	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:33.924084	2026-03-17 15:24:33.924084
1219	HELEN'S PLACE	jmorse	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.930245	2026-03-17 15:24:33.930245
1221	KELARI TAVERNA & BAR	maanderson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.936309	2026-03-17 15:24:33.936309
1222	CHICKEN N CHIP'S	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.939485	2026-03-17 15:24:33.939485
1223	DW DINER	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.942187	2026-03-17 15:24:33.942187
1224	MOLLYS RESTAURANT	jsewall	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.946848	2026-03-17 15:24:33.946848
1225	RK BOTTOMS UP CONVENIENCE	pbelanger	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.949702	2026-03-17 15:24:33.949702
1226	LUI LUI - WEST LEBANON	jsewall	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.952475	2026-03-17 15:24:33.952475
1227	LUK'S BAR & GRILL	maanderson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.955799	2026-03-17 15:24:33.955799
1228	PIZZA CHEF OF NEW LONDON	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.958399	2026-03-17 15:24:33.958399
1229	LEBANON VILLAGE PIZZA	jsewall	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.961135	2026-03-17 15:24:33.961135
1230	NEWPORT VILLAGE PIZZA	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.963959	2026-03-17 15:24:33.963959
1231	GUERRILLA GRILL	jaustin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.967669	2026-03-17 15:24:33.967669
1232	SUN BAR & GRILL	jcaron	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.970955	2026-03-17 15:24:33.970955
1233	THE BALDWIN SENIOR LIVING	rconstant	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:33.973586	2026-03-17 15:24:33.973586
1234	BENSONS CAFE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.976627	2026-03-17 15:24:33.976627
1235	CELEBRATIONS AT CAFE 505 NCC	jsweeney	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:33.979366	2026-03-17 15:24:33.979366
1237	BUXTONS PIZZA	eleahy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:33.985504	2026-03-17 15:24:33.985504
1238	MEXICA MEXICAN RESTAURANT	pbelanger	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:33.988818	2026-03-17 15:24:33.988818
1239	LA MICHAOCANA MARKET LLC	scamuso	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:33.99194	2026-03-17 15:24:33.99194
1242	SHAKE SHACK - SALEM	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.001835	2026-03-17 15:24:34.001835
1243	LA VAKA MEXICAN RESTAURANT	lnorton	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:34.004691	2026-03-17 15:24:34.004691
1244	QUICK MART - NASHUA	nmoore	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.007496	2026-03-17 15:24:34.007496
1245	UNION PUBLIC HOUSE	amartin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.011459	2026-03-17 15:24:34.011459
1246	BLACK COW CONVENIENCE	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.014095	2026-03-17 15:24:34.014095
1247	X-GOLF BEDFORD	lnorton	* Independent BELLAVANCE BEVERAGE	Recreation/Sports	t	2026-03-17 15:24:34.017097	2026-03-17 15:24:34.017097
1249	TEQUILA JALISCO MEXICAN CUISINE AND CANTINA	scamuso	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:34.024305	2026-03-17 15:24:34.024305
1250	TOBACCO JUNCTION - HUDSON	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.027798	2026-03-17 15:24:34.027798
1251	KEARSARGE REGIONAL HIGH SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.030609	2026-03-17 15:24:34.030609
1252	SOUTH MEADOW MIDDLE SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.033753	2026-03-17 15:24:34.033753
1253	CONVAL HIGH SCHOOL FOOD SERVICE	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.036908	2026-03-17 15:24:34.036908
1254	KEARSARGE REGIONAL MIDDLE SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.040354	2026-03-17 15:24:34.040354
1256	HAMPSTEAD M. SCHOOL	jsweeney	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.046081	2026-03-17 15:24:34.046081
1257	SANBORN M. S.	jsweeney	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.051033	2026-03-17 15:24:34.051033
1258	BOYNTON MIDDLE SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.053782	2026-03-17 15:24:34.053782
1259	SANBORN REG HIGH SCHOOL	jsweeney	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.056797	2026-03-17 15:24:34.056797
1260	LEBANON HIGH SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.059377	2026-03-17 15:24:34.059377
1261	WEARE MID SCHOOL	jsweeney	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.062768	2026-03-17 15:24:34.062768
1262	HANOVER HIGH SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.066759	2026-03-17 15:24:34.066759
1263	INDIAN RIVER SCHOOL*	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.06986	2026-03-17 15:24:34.06986
1264	MASCOMA REGIONAL HIGH SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.073719	2026-03-17 15:24:34.073719
1266	ZO'S PLACE	maanderson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.080137	2026-03-17 15:24:34.080137
1267	MASCENIC REGIONAL HIGH SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.082685	2026-03-17 15:24:34.082685
1268	WEST SWANZEY MEATS	pwollert	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.085199	2026-03-17 15:24:34.085199
1269	SABOR BRAZIL	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.08841	2026-03-17 15:24:34.08841
1270	STONECUTTERS PUB	ggage	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.09131	2026-03-17 15:24:34.09131
1271	WHIP-POOR WILL GOLF CLUB	rconstant	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:34.094107	2026-03-17 15:24:34.094107
1272	SOUHEGAN WOODS GOLF CLUB	jcaron	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:34.096772	2026-03-17 15:24:34.096772
1273	RACING MART - NASHUA	scamuso	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.100789	2026-03-17 15:24:34.100789
1275	MERIDEN DELI MART	jsewall	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.106613	2026-03-17 15:24:34.106613
1276	SUPPAS PIZZA LONDONDERRY	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.109026	2026-03-17 15:24:34.109026
1278	KETTLEHEAD BREWING CO - NASHUA	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.114846	2026-03-17 15:24:34.114846
1280	THE FRIENDLY TOAST - NASHUA	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.119932	2026-03-17 15:24:34.119932
1281	THE BRICKHOUSE RESTAURANT AND BREWERY	ggage	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.122513	2026-03-17 15:24:34.122513
1282	CENTER MARKET	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.125404	2026-03-17 15:24:34.125404
1283	AXE PLAY	nmoore	* Independent BELLAVANCE BEVERAGE	Recreation/Sports	t	2026-03-17 15:24:34.128602	2026-03-17 15:24:34.128602
1284	BUFFALO BO'S	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.130973	2026-03-17 15:24:34.130973
1285	LOST COWBOY BREWING	scamuso	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.13337	2026-03-17 15:24:34.13337
1286	MAIN ST BAGEL & DELI SHOP	jsweeney	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.135958	2026-03-17 15:24:34.135958
1288	BLACK FOREST DINER	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.141094	2026-03-17 15:24:34.141094
1289	THE BLACK FOREST	nmoore	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.143792	2026-03-17 15:24:34.143792
1291	MADAME SHERRI'S	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.151028	2026-03-17 15:24:34.151028
1292	AR SMOKE BEER & CIGAR	ggage	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.153444	2026-03-17 15:24:34.153444
1293	THE KITCHEN BY JTAPS	eplatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.156974	2026-03-17 15:24:34.156974
1294	MAIN ST GYRO	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.1596	2026-03-17 15:24:34.1596
1295	NOURIA ENERGY #1250 - WINDHAM	rmarique	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:34.162223	2026-03-17 15:24:34.162223
1296	NOURIA ENERGY #1194- LONDONDERRY	rconstant	NOURIA ENERGY	Convenience	t	2026-03-17 15:24:34.164751	2026-03-17 15:24:34.164751
1297	NATURE'S GREEN GROCER	pbelanger	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.167205	2026-03-17 15:24:34.167205
1298	PIZZA LISA	jsweeney	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.169937	2026-03-17 15:24:34.169937
1299	OLDE TOWNE TAVERN	ggage	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.172353	2026-03-17 15:24:34.172353
1300	DREWSVILLE GENERAL STORE	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.176114	2026-03-17 15:24:34.176114
1302	HAWAIIAN ISLE RESTAURANT	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.18131	2026-03-17 15:24:34.18131
1303	THE FRIENDLY TOAST - SALEM	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.183946	2026-03-17 15:24:34.183946
1304	HARLOWS PUBLIC HOUSE	pbelanger	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:34.186626	2026-03-17 15:24:34.186626
1307	KULICKS SUPERMARKET	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.196861	2026-03-17 15:24:34.196861
1308	DW PIZZERIA	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.199598	2026-03-17 15:24:34.199598
1311	MR G'S LIQUIDATION CENTER	jmalloy	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.207743	2026-03-17 15:24:34.207743
1312	MONA'S MEDITERRANEAN	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.210252	2026-03-17 15:24:34.210252
1314	NEWPORT HIGH SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.215568	2026-03-17 15:24:34.215568
1315	NEWPORT MIDDLE SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.218345	2026-03-17 15:24:34.218345
1317	NEW WORLD GAS - HUDSON	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.223233	2026-03-17 15:24:34.223233
1318	STEVEN'S HIGH SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.225547	2026-03-17 15:24:34.225547
1319	CLAREMONT MIDDLE SCOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.228202	2026-03-17 15:24:34.228202
1320	LEBANON MIDDLE SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.2311	2026-03-17 15:24:34.2311
1321	HYLA BROOK ESTATE	eleahy	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.234251	2026-03-17 15:24:34.234251
1322	BLUE BEAR HOSPITALITY LLC	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.237497	2026-03-17 15:24:34.237497
1323	TAVERN IN THE SQUARE SALEM LLC	ddooling	TAVERN IN THE SQUARE	Restaurant	t	2026-03-17 15:24:34.240083	2026-03-17 15:24:34.240083
1324	BIRDIES	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.242395	2026-03-17 15:24:34.242395
1325	HOUSE OF NOODLES	nmoore	* Independent BELLAVANCE BEVERAGE	Chinese Restaurant	t	2026-03-17 15:24:34.244909	2026-03-17 15:24:34.244909
1326	EAST DERRY TAVERN (CATERING)	eleahy	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:34.247319	2026-03-17 15:24:34.247319
1327	CRACK'D KITCHEN AND COFFEE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.249842	2026-03-17 15:24:34.249842
1329	PLAISTOW QUICK MART	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.254748	2026-03-17 15:24:34.254748
1330	VAPE VIBES-PLAISTOW	nmoore	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.257041	2026-03-17 15:24:34.257041
1331	THE CITY TOBACCO AND BEVERAGE CENTER #7 - PLAISTOW	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.259326	2026-03-17 15:24:34.259326
1332	FLACO'S MEXICAN RESTUARANT & CANTINA	jcannamucio	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:34.2618	2026-03-17 15:24:34.2618
1334	WHOLE FOODS MARKET - NASHUA - 272 DW HWY	lortiz	WHOLE FOODS	Supermarket	t	2026-03-17 15:24:34.266643	2026-03-17 15:24:34.266643
1335	3Z BOYZZZ DELI & MARKET	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.269019	2026-03-17 15:24:34.269019
1336	PHOENIX SMOKEHOUSE AND TAQUERIA	pbelanger	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.27182	2026-03-17 15:24:34.27182
1337	RHINO CIGAR LOUNGE BY OWL SHOP TOBACCONISTS LLC	rmarique	* Independent BELLAVANCE BEVERAGE	Cocktail Lounge	t	2026-03-17 15:24:34.274217	2026-03-17 15:24:34.274217
1338	REVO CASINO AND SOCIAL HOUSE	jsewall	* Independent BELLAVANCE BEVERAGE	Casino	t	2026-03-17 15:24:34.280211	2026-03-17 15:24:34.280211
1339	NASHUA BINGO	amartin	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.282498	2026-03-17 15:24:34.282498
1340	PLAISTOW CIGAR COMPANY	nmoore	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.284821	2026-03-17 15:24:34.284821
1342	SUGAR RIVER MARKET & DELI	jmorse	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.290308	2026-03-17 15:24:34.290308
1343	DREO FOOD AND DRINK	jgiuffrida	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.292775	2026-03-17 15:24:34.292775
1344	HUDSON CONVENIENCE MART	amartin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.295177	2026-03-17 15:24:34.295177
1345	THE CAPITAL GRILLE	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.297493	2026-03-17 15:24:34.297493
1346	EVVIVA TRATTORIA - BEDFORD	lnorton	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.299829	2026-03-17 15:24:34.299829
1348	TWO GUYS SMOKE SHOP	nmoore	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.304457	2026-03-17 15:24:34.304457
1349	NH-VT SMOKE & BEVERAGE OUTLET INC	jsewall	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.30672	2026-03-17 15:24:34.30672
1350	SUNSTONE BREWING	nmoore	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.309417	2026-03-17 15:24:34.309417
1352	OMNIUM BREWING	nmoore	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.314195	2026-03-17 15:24:34.314195
1353	THE SPICE	maanderson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.316641	2026-03-17 15:24:34.316641
1354	NASH CASINO	maanderson	* Independent BELLAVANCE BEVERAGE	Casino	t	2026-03-17 15:24:34.318843	2026-03-17 15:24:34.318843
1355	PLAISTOW TOBACCO JUNCTION	jcannamucio	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.321266	2026-03-17 15:24:34.321266
1356	ANGUS LEA GOLF COURSE (VR)	jmeharg	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:34.323994	2026-03-17 15:24:34.323994
1357	EVVIVA TRATTORIA - NASHUA	scamuso	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.326911	2026-03-17 15:24:34.326911
1359	OTTOS FOOD AND DRINK	bgermano	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.331486	2026-03-17 15:24:34.331486
1360	BLUE SEAL - KEENE	jmalloy	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.333783	2026-03-17 15:24:34.333783
1361	THE ACADEMY AT MAIN	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.336318	2026-03-17 15:24:34.336318
1362	BEAN TOWNE COFFEE HOUSE & CAFE	nmoore	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.338916	2026-03-17 15:24:34.338916
1363	RACING MART - JAFFREY	pbelanger	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.341405	2026-03-17 15:24:34.341405
1364	LIBATIONS ON LOCATION	pwollert	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:34.344279	2026-03-17 15:24:34.344279
1365	JJ MARKET	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.347293	2026-03-17 15:24:34.347293
1366	LA FIAMMA WOOD FIRED PIZZERIA	jcannamucio	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.349611	2026-03-17 15:24:34.349611
1367	HENNIKER HOUSE OF COFFEE CAFE LLC	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.352114	2026-03-17 15:24:34.352114
1368	NH BEER & TOBACCO OUTLET	lortiz	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.354519	2026-03-17 15:24:34.354519
1369	SAKA HIBACHI STEAKHOUSE	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.357036	2026-03-17 15:24:34.357036
1370	WHIRLING VAPORS	bgermano	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.359553	2026-03-17 15:24:34.359553
1372	NOBLE RAMEN HOUSE	jaustin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.364111	2026-03-17 15:24:34.364111
1373	FOUR POINTS BY SHERATON	tchagnon	* Independent BELLAVANCE BEVERAGE	Hotel/Lodging	t	2026-03-17 15:24:34.366359	2026-03-17 15:24:34.366359
1374	CASTRO'S CIGAR LOUNGE LLC	lnorton	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.368705	2026-03-17 15:24:34.368705
1375	TOWN HALL TAPHOUSE AND EATERY	ggage	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.371266	2026-03-17 15:24:34.371266
1376	OLIVE AND OAK LLC	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.373763	2026-03-17 15:24:34.373763
1377	WESTMORELAND GENERAL STORE	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.376054	2026-03-17 15:24:34.376054
1378	GET-N-GO	jaustin	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.378232	2026-03-17 15:24:34.378232
1379	FLASK LLC	ggage	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:34.381079	2026-03-17 15:24:34.381079
1380	THE OUTLET	eleahy	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.383358	2026-03-17 15:24:34.383358
1381	FIGARO'S MARTINI BAR + KITCHEN	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.385828	2026-03-17 15:24:34.385828
1382	KARV GREEK KOUZINA	rmarique	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.388343	2026-03-17 15:24:34.388343
1383	FRIENDLY RED'S - HUDSON	maanderson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.390998	2026-03-17 15:24:34.390998
1384	WINDHAM SHELL MART	rmarique	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.393313	2026-03-17 15:24:34.393313
1385	RUM BROOK MARKET	jmorse	JAKE'S MARKET	Convenience	t	2026-03-17 15:24:34.395649	2026-03-17 15:24:34.395649
1386	WILTON MOBIL MART	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.398219	2026-03-17 15:24:34.398219
1387	BLACK BIRD MARKET AND DELI	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.400796	2026-03-17 15:24:34.400796
1388	FIELD OF DREAMS	jgiuffrida	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.403339	2026-03-17 15:24:34.403339
1389	TAVERN IN THE SQUARE SALEM LLC (CATERING)	ddooling	TAVERN IN THE SQUARE	Catering	t	2026-03-17 15:24:34.405834	2026-03-17 15:24:34.405834
1390	GIABELLA'S	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.408079	2026-03-17 15:24:34.408079
1391	PATRIOT GAS	rconstant	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.410549	2026-03-17 15:24:34.410549
1393	DIAMONDS OF CHOCOLATE	jmalloy	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.415898	2026-03-17 15:24:34.415898
1394	BUBA STREET NOODLE & BAR LLC	jaustin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.418258	2026-03-17 15:24:34.418258
1395	SMOKEY'S VAPES	rconstant	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.420694	2026-03-17 15:24:34.420694
1396	WINDHAM GOURMET	rmarique	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.423466	2026-03-17 15:24:34.423466
1398	HOPTIMYSTIC BREWING	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.428859	2026-03-17 15:24:34.428859
1399	CASEYS DINER NH	jcannamucio	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.431332	2026-03-17 15:24:34.431332
1400	THE BLUE CANOE	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.433697	2026-03-17 15:24:34.433697
1401	WASHINGTON GENERAL STORE	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.436921	2026-03-17 15:24:34.436921
1402	WASHINGTON GENERAL STORE REST	jmeharg	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.440808	2026-03-17 15:24:34.440808
1403	FALL MOUNTAIN REGIONAL HIGH SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.444395	2026-03-17 15:24:34.444395
1404	HINSDALE MIDDLE/HIGH SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.447226	2026-03-17 15:24:34.447226
1405	CONANT HIGH SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.45004	2026-03-17 15:24:34.45004
1406	JAFFREY MIDDLE SCHOOL	jmalloy	FRESH PICKS - WHITSONS	School	t	2026-03-17 15:24:34.453161	2026-03-17 15:24:34.453161
1407	DERRY ONE-STOP	eleahy	ONE STOP	Convenience	t	2026-03-17 15:24:34.455905	2026-03-17 15:24:34.455905
1409	AMIGOS MEXICAN CANTINA	jcaron	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:34.461711	2026-03-17 15:24:34.461711
1410	TAVERN IN THE SQUARE BEDFORD LLC	tchagnon	TAVERN IN THE SQUARE	Restaurant	t	2026-03-17 15:24:34.464577	2026-03-17 15:24:34.464577
1411	KELSEN BREWING COMPANY REST	eleahy	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.467974	2026-03-17 15:24:34.467974
1412	THE PERCH	jaustin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.470982	2026-03-17 15:24:34.470982
1413	TJ'S DELI AND CATERING	sshaunessy	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:34.474126	2026-03-17 15:24:34.474126
1414	SEVEN ELEV #32504 B- KEENE	bgermano	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:34.476806	2026-03-17 15:24:34.476806
1415	GRANITE GAS	ggage	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.479674	2026-03-17 15:24:34.479674
1416	CROYDON GENERAL STORE	jmorse	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.482329	2026-03-17 15:24:34.482329
1417	PELHAM MARKET & PROVISIONS	maanderson	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.485019	2026-03-17 15:24:34.485019
1418	BUDGET LUCKY MART	tchagnon	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.487816	2026-03-17 15:24:34.487816
1419	RANCHO WALPOLE, INC.	pwollert	* Independent BELLAVANCE BEVERAGE	Mexican Restaurant	t	2026-03-17 15:24:34.490832	2026-03-17 15:24:34.490832
1420	THE CROSSRHOADS	ggage	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:34.493355	2026-03-17 15:24:34.493355
1421	ARIHANT CORP	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.496123	2026-03-17 15:24:34.496123
1422	SAKANA JAPANESE RESTAURANT	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.499369	2026-03-17 15:24:34.499369
1423	JESSE'S STEAKHOUSE	jjohnson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.502912	2026-03-17 15:24:34.502912
1424	ALL IN ONE MARKET	jmeharg	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.505724	2026-03-17 15:24:34.505724
1425	MILE AWAY EVENTS	ggage	* Independent BELLAVANCE BEVERAGE	Catering	t	2026-03-17 15:24:34.50891	2026-03-17 15:24:34.50891
1426	THE CLUBHOUSE BAR AND GRILLE	pwollert	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.511678	2026-03-17 15:24:34.511678
1427	CYNTHIA'S	jcannamucio	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.514592	2026-03-17 15:24:34.514592
1428	CRAVIN'S MARKET & DELI	jmalloy	JAKE'S MARKET	Restaurant	t	2026-03-17 15:24:34.517566	2026-03-17 15:24:34.517566
1429	TAVERN ON THE GREENS	jmeharg	* Independent BELLAVANCE BEVERAGE	Golf Club	t	2026-03-17 15:24:34.521069	2026-03-17 15:24:34.521069
1430	T&T WAY	amartin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.524331	2026-03-17 15:24:34.524331
1431	COMMON MAN - DERRY	eleahy	COMMON MAN	Convenience	t	2026-03-17 15:24:34.527032	2026-03-17 15:24:34.527032
1432	CODEX B.A.R	amartin	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:34.529608	2026-03-17 15:24:34.529608
1433	FISH & CHIX	eleahy	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.532762	2026-03-17 15:24:34.532762
1434	PIZZA HAVEN	pbelanger	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.535527	2026-03-17 15:24:34.535527
1435	O'NEIL CINEMAS	rconstant	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.538802	2026-03-17 15:24:34.538802
1436	SEVEN ELEV #46189A - SALEM - N. BROADWAY	rmarique	SEVEN ELEVEN BT	Convenience	t	2026-03-17 15:24:34.54217	2026-03-17 15:24:34.54217
1437	SPEEDY MART	jjohnson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.544915	2026-03-17 15:24:34.544915
1438	VAPE VIBES-SALEM	nmoore	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.548483	2026-03-17 15:24:34.548483
1439	TRATTORIA VILLAGIO MILFORD	ggage	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.551231	2026-03-17 15:24:34.551231
1440	OGIE BREWING	jcaron	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.554073	2026-03-17 15:24:34.554073
1441	KPS SMOKE & TOBACO OUTLET	lortiz	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.557992	2026-03-17 15:24:34.557992
1443	GRANFANALLYS PIZZA PUB	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.564107	2026-03-17 15:24:34.564107
1444	SUNNYSIDE STOP	sshaunessy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.567079	2026-03-17 15:24:34.567079
1445	JUKK INC	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.571737	2026-03-17 15:24:34.571737
1446	TOBACCO BARN II - HUDSON	amartin	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.575476	2026-03-17 15:24:34.575476
1447	ELATION SALON	jcannamucio	* Independent BELLAVANCE BEVERAGE	Other On-Premise	t	2026-03-17 15:24:34.579053	2026-03-17 15:24:34.579053
1448	LINA & SAM'S MINI MART	eleahy	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.581796	2026-03-17 15:24:34.581796
1450	BUDDY T'S	jsewall	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.647709	2026-03-17 15:24:34.647709
1451	BARK & BEVY CO.	jjohnson	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.651	2026-03-17 15:24:34.651
1452	AV WINE BAR INC	ddooling	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.653989	2026-03-17 15:24:34.653989
1453	OLD BOY'S BUTCHER SHOP LLC	scamuso	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.656848	2026-03-17 15:24:34.656848
1454	CRAFT MARKET AT RIVERSIDE	bgermano	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.659926	2026-03-17 15:24:34.659926
1455	QUALITY FUEL & MART	jcaron	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.66285	2026-03-17 15:24:34.66285
1456	KARMA SMOKE & BEER OUTLET	lnorton	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.665374	2026-03-17 15:24:34.665374
1457	ROLLING SPIRITS	nmoore	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.670123	2026-03-17 15:24:34.670123
1458	M SQUARED	eleahy	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.672747	2026-03-17 15:24:34.672747
1459	OTTO PORTLAND	tchagnon	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.675295	2026-03-17 15:24:34.675295
1460	PELHAM TOBACCO DISCOUNT MART	maanderson	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.677975	2026-03-17 15:24:34.677975
1461	LA GUIRA RESTAURANT & SPORTS BAR	amartin	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.681351	2026-03-17 15:24:34.681351
1462	THE MALLARD	rconstant	* Independent BELLAVANCE BEVERAGE	Restaurant	t	2026-03-17 15:24:34.684362	2026-03-17 15:24:34.684362
1463	DINKBEES	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.687438	2026-03-17 15:24:34.687438
1464	GILSUM VILLAGE STORE-	pwollert	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.690763	2026-03-17 15:24:34.690763
1466	BLUE SEAL - WALPOLE	jmalloy	* Independent BELLAVANCE BEVERAGE	Other Off-Premise	t	2026-03-17 15:24:34.697083	2026-03-17 15:24:34.697083
1470	NEWBURY QUICK STOP -	jgrumblatt	* Independent BELLAVANCE BEVERAGE	Convenience	t	2026-03-17 15:24:34.70814	2026-03-17 15:24:34.70814
1471	THE OWLS NEST	jaustin	* Independent BELLAVANCE BEVERAGE	Bar/Club	t	2026-03-17 15:24:34.711392	2026-03-17 15:24:34.711392
\.


--
-- Data for Name: event_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_reports (id, event_id, staff_name, attendee_count, served_count, brand_comments, total_spend, image_urls, submitted_at, updated_at) FROM stdin;
1	1	Alyssa M.	10	9	People Loved the taste	25	["data:image/jpeg;base64,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"]	2026-03-19 12:49:49.619591	2026-03-19 13:16:08.164
2	2	Amanda	20	15	\N	75	["data:image/jpeg;base64,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"]	2026-03-20 17:55:29.831898	2026-03-20 17:55:29.831
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, title, account, brand, date, start_time, end_time, notes, pos_items, staff_requested, rep_username, status, staff_assigned, pos_approved, pos_requested, created_at, approved_at, approved_by, rep_or_supplier_present) FROM stdin;
9	Nutrl Sampling	PEDDLER'S DAUGHTER	Nutrl	2026-03-26	15:30	17:30	Sample Nütrl and promote Ultra for the qualifier game to see if Ireland moves on for another chance to qualify for the World Cup. If they win, they will play Tuesday. If they win Tuesday, they qualify for the WC! Raffle off Ultra / Nütrl item.	["Raffle Items"]	1	maanderson	pending	[]	f	t	2026-03-19 17:41:54.538996	\N	\N	f
11	Kona Sampling	HOWIE GLYNN - DERRY	Kona - Big Wave	2026-03-27	17:00	19:00	Kona tasting at Howie Glynn in Derry. There are two Derry locations, please use the address: 418 ISLAND POND ROAD Derry, NH. Check IDs, offer samples.	["Sample Cups"]	1	ddooling	pending	[]	f	t	2026-03-19 17:45:02.408395	\N	\N	f
4	Able Ebenezer	LEBANON COOP	Able - Burn the Ships	2026-03-20	15:00	17:00	Off Prem tasting - Joe Bouley	[]	1	jjohnson	approved	["Amanda","Adrianne"]	f	f	2026-03-19 17:21:22.923277	2026-03-20 18:25:25.616	Marketing Manager	f
3	Fiddlehead Tap Takeover	CASEY MAGEE'S	Fiddlehead - IPA	2026-03-26	18:00	19:00	Swag bags plus table set up for tasting and a raffle prize	["Coaster","Promo Item"]	2	amartin	approved	[]	t	t	2026-03-18 19:55:46.117666	2026-03-18 19:57:29.422	Marketing Manager	f
13	Fiddlehead Tap Takeover	BACKSTREET BAR & GRILL LLC	Fiddlehead - Mastermind	2026-03-21	19:00	20:00	See Mark when you get there for table setup	["Sample Cups","Raffle Items","Promo Bag"]	1	amartin	approved	[]	f	t	2026-03-20 18:21:50.427597	2026-03-20 18:25:27.517	Marketing Manager	t
12	603 Tasting	AMERICAN LEGION POST 48 - HUDSON	603 Brew - IPA	2026-03-28	18:00	20:00	Table set up for tastings. Check in with Mark when you get there. 	["Raffle Items","Sample Cups"]	2	amartin	pending	[]	f	t	2026-03-20 17:51:38.742404	\N	\N	f
6	Bud Light Hoops Mania Prelim	BUDDY T'S	Bud Light	2026-03-20	18:00	20:00	BL Mini Hoops Mania Prelim Round! Play mini basketball game to pick a winner for the local finals. Award certificate. See info deck, fill out the survey. *asked Frontrunner - IN	[]	1	jsewall	approved	["Adrianne"]	f	f	2026-03-19 17:24:54.622317	2026-03-20 17:53:01.352	Marketing Manager	f
7	Sampling Founders	BEER STORE LLC (THE) - SALEM	Founders - All Day IPA	2026-03-22	12:00	14:00	Beer Store Salem Sampling- Lexington - BRIAN BOUFF	[]	0	ddooling	approved	[]	f	f	2026-03-19 17:36:20.555285	2026-03-20 17:53:11.273	Marketing Manager	t
2	603 Tap Takeover	COPPER DOOR - SALEM	603 Brew - IPA	2026-03-20	18:00	19:00	Table with cups and swag bags	["Coaster","Promo Item"]	2	ddooling	approved	["Adrianne","Amanda"]	t	t	2026-03-17 20:21:35.528521	2026-03-17 20:23:10.846	Marketing Manager	f
8	Bud Light Mini Hoops Mania Finals	NASH CASINO	Bud Light	2026-03-22	13:00	16:00	BL Mini Hoops Mania Local Finals Round! Play large pop-a-shot basketball game to pick a winner for the local finals. Award trophy - they are going to LAS VEGAS. See info deck, fill out the survey. With Adrianne	[]	1	maanderson	approved	["Amanda","Alicia"]	f	f	2026-03-19 17:40:09.826409	2026-03-20 18:25:35.132	Marketing Manager	f
5	Pint Night - Trivia	STONEBRIDGE COUNTRY CLUB	Concord Craft - Safe Space	2026-03-20	18:00	20:00	Pint Night at Stonebridge CC Trivia - ED CIOTO	[]	1	lnorton	approved	["Adrianne"]	f	f	2026-03-19 17:23:22.590199	2026-03-20 18:22:35.786	Marketing Manager	f
10	Fiddlehead Pint Night	RENEGADES PUB	Fiddlehead - IPA	2026-03-26	18:00	20:00	Fiddlehead Pint Night - FAYE	["Sample Cups"]	0	rconstant	pending	[]	f	t	2026-03-19 17:43:30.279509	\N	\N	t
1	Fiddlehead Tap Takeover	SURF RESTAURANT INC	Fiddlehead - IPA	2026-03-19	18:00	19:00	Need Swag bags. Table set up for Tastings with cups. 	["Coaster","Promo Item"]	2	amartin	approved	["Amanda","Adrianne"]	t	t	2026-03-17 17:56:36.753084	2026-03-17 17:57:37.567	Marketing Manager	f
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (id, catalog_item_id, brand_id, item_type, brand, quantity, updated_at) FROM stdin;
2	1	19	Coaster	Mich Ultra	0	2026-03-17 12:30:48.739776
3	1	14	Coaster	Heineken	0	2026-03-17 12:30:48.742507
4	1	6	Coaster	Budweiser	0	2026-03-17 12:30:48.745403
6	5	60	Large Tap Marker	Mich Ultra	0	2026-03-17 12:30:48.750541
7	5	54	Large Tap Marker	Fiddlehead - IPA	0	2026-03-17 12:30:48.752826
8	5	56	Large Tap Marker	Heineken	0	2026-03-17 12:30:48.756215
10	9	92	Small Tap Marker	Stella Artois	0	2026-03-17 12:30:48.761457
11	3	35	Glass	Heineken	0	2026-03-17 12:30:48.764304
12	3	34	Glass	Budweiser	0	2026-03-17 12:30:48.767106
13	8	74	Promo Item	Bud Light	0	2026-03-17 12:30:48.769417
14	8	76	Promo Item	Busch Light	0	2026-03-17 12:30:48.772568
15	4	41	Illuminated Sign	Bud Light	0	2026-03-17 12:30:48.775259
16	4	44	Illuminated Sign	Heineken	0	2026-03-17 12:30:48.778128
17	10	95	Umbrella	Bud Light	0	2026-03-17 12:30:48.78086
18	10	99	Umbrella	Mich Ultra	0	2026-03-17 12:30:48.783686
9	9	82	Small Tap Marker	Bud Light	10	2026-03-17 12:30:48.758984
20	12	833	T Shirts	Bud light	10	2026-03-17 17:39:58.296606
21	5	255	Large Tap Marker	603 Brew - Winni	9	2026-03-17 20:16:46.77926
5	5	49	Large Tap Marker	Bud Light	9	2026-03-17 12:30:48.748165
19	1	112	Coaster	Gold Road Mango Cart	9	2026-03-17 14:31:54.700342
1	1	4	Coaster	Bud Light	10	2026-03-17 12:30:48.737115
\.


--
-- Data for Name: pos_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pos_requests (id, rep_username, customer, item_type, brand, quantity, status, created_at, fulfilled_at) FROM stdin;
1	maanderson	TEST ACCOUNT	Coaster	Bud Light	1	Fulfilled	2026-03-17 12:41:21.771996	2026-03-17 14:24:20.177
2	ddooling	ARTISAN CHEF CATERING	Large Tap Marker	603 Brew - Winni	1	Pending	2026-03-17 20:18:17.043358	\N
4	amartin	AMERICAN LEGION POST 48 - HUDSON	Coaster	Gold Road Mango Cart	1	Fulfilled	2026-03-19 19:51:37.363191	2026-03-20 17:43:22.028
3	amartin	CODEX B.A.R	Large Tap Marker	Bud Light	1	Fulfilled	2026-03-18 01:33:29.170181	2026-03-20 18:18:07.798
\.


--
-- Data for Name: promo_staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promo_staff (id, name, phone, email, notes, password_hash) FROM stdin;
17	Elahh	603-555-1234	Elahh@promo.com		942b38be1d279981ba679d4031db97ad:b69c7711869bce0db8503c8fbda56a2b8d82dd4083cb03a30f361bdda68561d2
18	Adrianne	603-555-1235	Adrianne@promo.com		0c8c9796e90edba0a3012ac5e0f9d82f:081fab609593c55eda152474c5a226aed90b3c8d6eb35d61080a056e33f609ac
19	Caroline	603-555-1236	Caroline@promo.com		5083dcde625bfe1a2465fa014b5d618e:1a328a9a35875e647f77a19816923dd7739cb4fb2ad8d94d4e178cf3a300f5a2
20	Joslyn	603-555-1237	Joslyn@promo.com		a181de7cf07d7a3dbc07099ca5b9edf4:5992ccd4fd96f576efdb01ad9b2026283a36b4003dc089b6f125e726ff0113ac
21	Kim	603-555-1238	Kim@promo.com		3f481ca31343f9add414c6938bb99648:c669e2c7da9c58f7b7dd44d9dcf22972afed701c7e58cbeb8c4288b090dce10d
22	Alicia	603-555-1239	Alicia@promo.com		72e344a2dc7b2df09741b1294af938d0:2859cf08751387ad50fd38f97f0cf81ddcaf728cc9fd29302aa1f6250ea9c5de
23	Amanda	603-555-1241	Amanda@promo.com		d91d0be3bf05b935e854c5c56c0656af:c839823eb28093e0b9d01886401a27b8541119dade93aadc377b27d8ebd1d41b
\.


--
-- Data for Name: receive_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.receive_history (id, item_type, brand, quantity, note, created_at) FROM stdin;
1	Large Tap Marker	Bud Light	10	\N	2026-03-17 14:31:31.738023
2	Small Tap Marker	Bud Light	10	\N	2026-03-17 14:31:41.652314
3	Coaster	Gold Road Mango Cart	10	\N	2026-03-17 14:31:54.704096
4	T Shirts	Bud light	10	\N	2026-03-17 17:39:58.345576
5	Large Tap Marker	603 Brew - Winni	10	\N	2026-03-17 20:16:46.782475
6	Coaster	Bud Light	10	\N	2026-03-20 18:17:22.932801
\.


--
-- Data for Name: transfers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transfers (id, rep_username, item_type, brand, quantity, from_account, to_account, is_return, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password_hash, role, display_name, created_at) FROM stdin;
1	warehouse	5c69314a403bf0c7a29ceede13ae05a8:09dff7c4d937f5a55b1c9fedb6b8ae1cf5bbc05198daf520f69665920df80282	warehouse	Warehouse Staff	2026-03-17 12:30:48.277053
2	marketing	e372394446af8e5c1ceb394cd3027628:f651d1969477ffb2b8c4dd4a919f07d87de0140644595de33a2db7c6fb2ed879	marketing	Marketing Manager	2026-03-17 12:30:48.293347
3	adennis	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Adennis	2026-03-17 12:30:48.296507
5	aparente	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Aparente	2026-03-17 12:30:48.303284
7	bhanscom	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Bhanscom	2026-03-17 12:30:48.308631
9	dtaylor	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Dtaylor	2026-03-17 12:30:48.315064
11	epaquette	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Epaquette	2026-03-17 12:30:48.319799
13	gconnor	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Gconnor	2026-03-17 12:30:48.325495
15	jarquiett	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Jarquiett	2026-03-17 12:30:48.33028
25	kford	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Kford	2026-03-17 12:30:48.357349
26	kpeacock	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Kpeacock	2026-03-17 12:30:48.361594
27	krogers	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Krogers	2026-03-17 12:30:48.364856
31	mbertolami	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Mbertolami	2026-03-17 12:30:48.377676
32	mblais	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Mblais	2026-03-17 12:30:48.383345
33	mcanavan	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Mcanavan	2026-03-17 12:30:48.386455
34	ncavallo	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Ncavallo	2026-03-17 12:30:48.389048
36	pvoniderstin	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Pvoniderstin	2026-03-17 12:30:48.39537
39	rdouzanis	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Rdouzanis	2026-03-17 12:30:48.406689
40	rwallace	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Rwallace	2026-03-17 12:30:48.410182
42	sclark	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Sclark	2026-03-17 12:30:48.41687
44	svisentin	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Svisentin	2026-03-17 12:30:48.422075
46	tpiermarini	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Tpiermarini	2026-03-17 12:30:48.427038
47	wmonty	6fe9763d643f9fc6e3cacdb706998c5f:0c6104deb29a7145ad1e8bc71636d0b621941ce9259f602b9c4b33f059733e58	rep	Wmonty	2026-03-17 12:30:48.429293
48	tjebol	69fe81688b8a411ed3aa843c8c6d9b45:bc2d15abdc031040834e9e831ee66d5d8d20cfd0713a336b827c66adc048ac3b	rep	T. Jebol	2026-03-17 14:10:29.083135
49	tpiccinono	69fe81688b8a411ed3aa843c8c6d9b45:bc2d15abdc031040834e9e831ee66d5d8d20cfd0713a336b827c66adc048ac3b	rep	T. Piccinono	2026-03-17 14:10:29.511327
8	ddooling	8ce8742d9640947a4164229787662dea:4ace69b7b156c1d3ebabad44905a130c2d47cd3e688fa91f77e8900197267056	rep	Dustin Dooling	2026-03-17 12:30:48.312149
10	eleahy	d6330ce925306f267e06af3c55b0ae15:698b28f1b50ff62a0da3d00bb35c58efc151611728473c90837d110cf952945d	rep	Ethan Leahy	2026-03-17 12:30:48.317461
12	eplatt	0d38ab40d7a6aa4fb1c4ee74ed57d008:255ddef850b992c23f97fdd4bd7dcdbc6cf5b3d711fb7a9adde7e23899325570	rep	Ethan Platt	2026-03-17 12:30:48.323057
14	ggage	62aef2ca3386591a89c897f5720e6f25:c1781b1f20679ea9ca84a18bff556bbec7087338d92b8e7e5c8d10feebdd2e82	rep	Gary Gage	2026-03-17 12:30:48.327774
16	jaustin	f2aae1681275be96d4f8ce14845883a8:917acd00a1fc7bb09e65df2aba9e549a68d01b195232bb3d517f62160828db7d	rep	Jeff Austin	2026-03-17 12:30:48.333252
17	jcannamucio	afa9fd0cdab88af1007b6f205d02f687:4b1e698dd76f2c2af53d69eaeabb108dcb05ee86b429401475929520349ab268	rep	Jason Cannamucio	2026-03-17 12:30:48.335448
18	jcaron	f4d2c2773285b795a9da388c59757405:5bb3b7da2b4a8d4ce507d99397d94e96dd900fc00889c1c1d18ec4df83793d0a	rep	Joe Caron	2026-03-17 12:30:48.338308
19	jgiuffrida	ae9f4fa470f41c8940c9e579fd01aa41:f271bab2248f5eb1767b7883ff3f2b9d3462b5bfaee0993e8e1f99adb6eaf560	rep	Joe Giuffrida	2026-03-17 12:30:48.341027
20	jgrumblatt	554d4f4b643d9717f8a0e57a2baff07a:92668eaf08ede7d3d8a83c5c291bcbb983a200cbeaa0ab86de08757b38b9f1b8	rep	Jon Grumblatt	2026-03-17 12:30:48.343951
21	jjohnson	914120966009959577dd29234635303f:b8310bc2e9509c19371e25473b5510fe519a70a95a8e4929ed4c9c322693af62	rep	Jesse Johnson	2026-03-17 12:30:48.346312
22	jmeharg	45a8389d29955dda3aebd2a9e6582f2b:fa2f74925882cea34414564fc9fcff1bdbeacbd94dcbec9d26313a49745cfb96	rep	Justin Meharg	2026-03-17 12:30:48.348608
23	jmorse	c93e744a84110024fc8531c8d77973b5:ea60566e9a6d56ca15564ba8f36bf62fc217500e177c69da3174d7d00822da90	rep	Jim Morse	2026-03-17 12:30:48.350909
24	jsewall	a2ccc9151d763fb3ee4f4a7ad101947a:b60d6c74b5e854cba6903653af6c5eef0f5b97cf7e177699b04136365093386f	rep	Josh Sewall	2026-03-17 12:30:48.353951
28	lnorton	7c615a2e06d377db9e78dec00cfce853:c709a0041c9567798ab0fc09cb874ad2ec974a2e3e9ac9f7c8fa46f1fb0dd9f8	rep	Luke Norton	2026-03-17 12:30:48.367893
29	lortiz	ae0e65779ceee63337927b07f501a9b1:04883f861809127ae8b6f7c84e4655d3c689edf048e61ac49d42d3dbaccdb109	rep	Luis Ortiz	2026-03-17 12:30:48.371134
35	pbelanger	4f90711fe60d3d034708b595941a4ad8:6110a765749e4de87b166c5b6f021890e0158142090188a49d61736b87dd029c	rep	Paul Belanger	2026-03-17 12:30:48.391664
37	pwollert	53797535c7bf59e4c786f9cc12dfb0ae:43ff6d899eac90536e3ffb10c44294f08cf0d71950dba117ff2dfff1bfcd5524	rep	Paul Wollert	2026-03-17 12:30:48.39868
38	rconstant	d4ccb22c77a16f1cfd28098c3617b77f:f9c97334f77e6a9529ba52b2ba9ea383606795c6bae23574b0bdbdd5b06ee84f	rep	Ricky Constant	2026-03-17 12:30:48.403753
41	scamuso	162adf2557c218855c31fae8feaf2d2b:c14310d8034d2a38cbb06873fbcb8d1ec074f22f263f04c6b74f202e7e6229ef	rep	Scott Camuso	2026-03-17 12:30:48.412843
43	sshaunessy	1ff08a905bf8e68e9f051cae2e4c6082:c6f50396cab632afed142dafc0f255254355fa30275b59d33245f3429828f05f	rep	Steve Shaunessy	2026-03-17 12:30:48.4191
45	tchagnon	f57ead155c3b791bb5bb276c7ea1211a:df1c910701deb015719711562a3d765fb7212e6102523f16f8ac6351a70cb03d	rep	Tyler Chagnon	2026-03-17 12:30:48.424418
6	bgermano	430d3bb7136290f63e9678d943f0ec78:bba0c4492a7fe4825fb76a99830f9e924b88e0ed09a9b2f2120dc419e9bf5895	rep	Ben Germano	2026-03-17 12:30:48.306174
4	amartin	addfff0dc6fdfc4b58aa390677076c6f:e660792a45aa8b96fc995d3a171da75ee424a029cff988559499d185e4422b0a	rep	Alex Martin	2026-03-17 12:30:48.300147
52	jmalloy	690807de17362bfe4d366ab93abf845d:f3d8bba40efc24cad648c08061445f78356b688317661c82c79c6e7f3f30115f	rep	Jack Malloy	2026-03-17 14:52:12.648415
53	jsmoyer	bd9849547115acdd9598c3138fef8a1d:11009595341844647230d3b1285e14d2d3f54ecf0e0f9f44b45cd56505a01b64	rep	Jerry Smoyer	2026-03-17 14:52:12.661428
54	jsweeney	5f81f6eee856b23b52cc25c392c6a39b:4dbf567ca2a9e7979090b5929b2abe319e41f173597bb7c64590b04f4c4746de	rep	John Sweeney	2026-03-17 14:52:12.732839
30	maanderson	736bbfc648e61e8db819224032db568a:484d6e96f459f50648d73ac68e3fb5630c6e4e24fc1d1b28fdf1452563e8d600	rep	Mark Anderson	2026-03-17 12:30:48.37413
56	nmoore	9959854949e3b99a929063a05358bc45:4130edc65661f3f90e95229b3abe0f7adcfb75c18eabe3869441c454171f44de	rep	Nathan Moore	2026-03-17 14:52:12.748386
57	rmarique	cdb26cc379be7e66b9277c6492b9ca97:0f48881a13eac081a5307a733ea0b8df358caa987a913357672385f2d4c3f913	rep	Richard Marique	2026-03-17 14:52:12.761056
\.


--
-- Name: account_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_assets_id_seq', 5563, true);


--
-- Name: brands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.brands_id_seq', 836, true);


--
-- Name: catalog_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catalog_items_id_seq', 12, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 1472, true);


--
-- Name: event_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_reports_id_seq', 2, true);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_id_seq', 13, true);


--
-- Name: inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_id_seq', 21, true);


--
-- Name: pos_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pos_requests_id_seq', 4, true);


--
-- Name: promo_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promo_staff_id_seq', 23, true);


--
-- Name: receive_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.receive_history_id_seq', 6, true);


--
-- Name: transfers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transfers_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 57, true);


--
-- Name: account_assets account_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_assets
    ADD CONSTRAINT account_assets_pkey PRIMARY KEY (id);


--
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);


--
-- Name: catalog_items catalog_items_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog_items
    ADD CONSTRAINT catalog_items_name_unique UNIQUE (name);


--
-- Name: catalog_items catalog_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog_items
    ADD CONSTRAINT catalog_items_pkey PRIMARY KEY (id);


--
-- Name: customers customers_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_name_unique UNIQUE (name);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: event_reports event_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_reports
    ADD CONSTRAINT event_reports_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);


--
-- Name: pos_requests pos_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos_requests
    ADD CONSTRAINT pos_requests_pkey PRIMARY KEY (id);


--
-- Name: promo_staff promo_staff_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_staff
    ADD CONSTRAINT promo_staff_name_unique UNIQUE (name);


--
-- Name: promo_staff promo_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_staff
    ADD CONSTRAINT promo_staff_pkey PRIMARY KEY (id);


--
-- Name: receive_history receive_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receive_history
    ADD CONSTRAINT receive_history_pkey PRIMARY KEY (id);


--
-- Name: transfers transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: brands brands_catalog_item_id_catalog_items_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_catalog_item_id_catalog_items_id_fk FOREIGN KEY (catalog_item_id) REFERENCES public.catalog_items(id);


--
-- PostgreSQL database dump complete
--

\unrestrict yhxbPC6uQ9ylBiNFnxb1PqDpYOZa7ZT0AjPc3xZfWz0yOl4bJACPXNyD8GcYUOD

