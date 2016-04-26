DROP TABLE IF EXISTS dostepnosc;
DROP TABLE IF EXISTS projekt_ma_rezerwacje;
DROP TABLE IF EXISTS wyzywienie_dla_rezerwacji;
DROP TABLE IF EXISTS wyposazenie;
DROP TABLE IF EXISTS dodatkowe_uslugi;
DROP TABLE IF EXISTS rezerwacja;
DROP TABLE IF EXISTS pracownik;
DROP TABLE IF EXISTS sala;
DROP TABLE IF EXISTS dzial;
DROP TABLE IF EXISTS stanowisko;
DROP TABLE IF EXISTS rezerwacja_typ;
DROP TABLE IF EXISTS pietro;
DROP TABLE IF EXISTS wyzywienie;
DROP TABLE IF EXISTS wyposazenie_typ;
DROP TABLE IF EXISTS projekt;

CREATE TABLE stanowisko (
	nazwa			varchar(32),
	CONSTRAINT stanowiska_pkey PRIMARY KEY(nazwa)
);

CREATE TABLE dzial (
	nazwa			varchar(32),
	CONSTRAINT dzial_pkey PRIMARY KEY(nazwa)
);

CREATE TABLE pracownik (
	id			integer,
	imie			varchar(32) NOT NULL,
	nazwisko		varchar(32) NOT NULL,
	pesel			varchar(11) NOT NULL UNIQUE,
	dzial			varchar(32) NOT NULL,
	stanowisko		varchar(32) NOT NULL,
	numer_kontaktowy	varchar(12) NOT NULL,
	email			varchar(32) NOT NULL UNIQUE,
	haslo			varchar(32) NOT NULL,
	CONSTRAINT pracownik_pkey PRIMARY KEY(id)
);
ALTER TABLE pracownik ADD CONSTRAINT pracownik_dzial_fkey FOREIGN KEY (dzial) REFERENCES dzial(nazwa);
ALTER TABLE pracownik ADD CONSTRAINT pracownik_stanowisko_fkey FOREIGN KEY (stanowisko) REFERENCES stanowisko(nazwa);

CREATE TABLE rezerwacja_typ (
	nazwa			varchar(32),
	CONSTRAINT rezerwacja_typ_pkey PRIMARY KEY (nazwa)
);

CREATE TABLE rezerwacja (
	id			integer,
	id_pracownika		integer NOT NULL,
	typ			varchar(32) NOT NULL,
	CONSTRAINT rezerwacja_pkey PRIMARY KEY (id)	
);
ALTER TABLE rezerwacja ADD CONSTRAINT pracownik_fkey FOREIGN KEY (id_pracownika) REFERENCES pracownik(id);
ALTER TABLE rezerwacja ADD CONSTRAINT typ_fkey FOREIGN KEY (typ) REFERENCES rezerwacja_typ(nazwa);

CREATE TABLE dodatkowe_uslugi (
	id			integer,
	nazwa			varchar(32) NOT NULL,
	opis			varchar(32) NOT NULL,
	nr_rezerwacji		integer NOT NULL,
	CONSTRAINT dod_uslugi_pkey PRIMARY KEY (id)
);
ALTER TABLE dodatkowe_uslugi ADD CONSTRAINT rezerwacja_fkey FOREIGN KEY (nr_rezerwacji) REFERENCES rezerwacja(id);

CREATE TABLE pietro (
	nazwa			varchar(32),
	CONSTRAINT pietro_pkey PRIMARY KEY(nazwa)
);

CREATE TABLE sala (
	nazwa			varchar(32),
	pietro			varchar(32) NOT NULL,
	CONSTRAINT sala_pkey PRIMARY KEY (nazwa)
);
ALTER TABLE sala ADD CONSTRAINT sala_pietro_fkey FOREIGN KEY (pietro) REFERENCES pietro(nazwa);

CREATE TABLE dostepnosc (
	dato_godzina		varchar(32),
	rezerwacja		integer,
	sala			varchar(32),
	CONSTRAINT dostepnosc_pkey PRIMARY KEY (dato_godzina, sala)
);
ALTER TABLE dostepnosc ADD CONSTRAINT dostepnosc_rez_fkey FOREIGN KEY (rezerwacja) REFERENCES rezerwacja(id);
ALTER TABLE dostepnosc ADD CONSTRAINT dostepnosc_sala_fkey FOREIGN KEY (sala) REFERENCES sala(nazwa);

CREATE TABLE wyzywienie (
	nazwa			varchar(32),
	CONSTRAINT wyzywienie_pkey PRIMARY KEY (nazwa)
);

CREATE TABLE wyzywienie_dla_rezerwacji (
	wyzywienie_typ		varchar(32),
	rezerwacja		integer NOT NULL,
	sala			varchar(32) NOT NULL,
	ilosc			integer check(ilosc > 0),
	CONSTRAINT wyzywienie_dla_rezerw_pkey PRIMARY KEY (wyzywienie_typ, rezerwacja, sala)
);
ALTER TABLE wyzywienie_dla_rezerwacji ADD CONSTRAINT wdr_wyzywienie_fkey FOREIGN KEY (wyzywienie_typ) REFERENCES wyzywienie(nazwa);
ALTER TABLE wyzywienie_dla_rezerwacji ADD CONSTRAINT wdr_rezerwacja FOREIGN KEY (rezerwacja) REFERENCES rezerwacja(id);
ALTER TABLE wyzywienie_dla_rezerwacji ADD CONSTRAINT wdr_sala FOREIGN KEY (sala) REFERENCES sala(nazwa);

CREATE TABLE wyposazenie_typ (
	nazwa			varchar(32),
	CONSTRAINT wyposazenie_typ_pkey PRIMARY KEY(nazwa)
);

CREATE TABLE wyposazenie (
	nazwa			varchar(32),
	sala			varchar(32),
	stan			varchar(32),
	CONSTRAINT wyposazenie_pkey PRIMARY KEY(nazwa, sala)
);
ALTER TABLE wyposazenie ADD CONSTRAINT wyp_nazwa_fkey FOREIGN KEY (nazwa) REFERENCES wyposazenie_typ(nazwa);
ALTER TABLE wyposazenie ADD CONSTRAINT wyp_sala_fkey FOREIGN KEY (sala) REFERENCES sala(nazwa);

CREATE TABLE projekt (
	nazwa			varchar(32),
	CONSTRAINT projekt_pkey PRIMARY KEY(nazwa)
);

CREATE TABLE projekt_ma_rezerwacje (
	projekt			varchar(32),
	rezerwacja		integer,
	CONSTRAINT pmr_pkey PRIMARY KEY (projekt, rezerwacja)
);
ALTER TABLE projekt_ma_rezerwacje ADD CONSTRAINT pmr_projekt_fkey FOREIGN KEY (projekt) REFERENCES projekt(nazwa);
ALTER TABLE projekt_ma_rezerwacje ADD CONSTRAINT pmr_rezerwacja_fkey FOREIGN KEY (rezerwacja) REFERENCES rezerwacja(id);


















	