
CREATE DATABASE TransportMiejski_w67254t
GO
USE TransportMiejski_w67254t
GO
-- Table: KupBilety
CREATE TABLE KupBilety (
    KupBiletyID int  NOT NULL IDENTITY,
    PasazerID int  NOT NULL,
    DataZakupu datetime  NOT NULL,
    Cena smallmoney  NOT NULL,
    BiletomatID int  NOT NULL,
    CONSTRAINT KupBilety_pk PRIMARY KEY  (KupBiletyID)
);

-- Table: Kursy
CREATE TABLE Kursy (
    KursyID int  NOT NULL IDENTITY,
    LiniaID int  NOT NULL,
    PracownikID int  NOT NULL,
    IDPojazdu int  NOT NULL,
    GodzRospoczencia time(0)  NOT NULL,
    GodzZakonczena time(0)  NOT NULL,
    CONSTRAINT Kursy_pk PRIMARY KEY  (KursyID)
);

-- Table: Linia
CREATE TABLE Linia (
    LiniaID int  NOT NULL IDENTITY,
    Linia int  NOT NULL,
    CONSTRAINT Linia_pk PRIMARY KEY  (LiniaID)
);

-- Table: Pasazerowie
CREATE TABLE Pasazerowie (
    PasazerID int  NOT NULL IDENTITY,
    Imie varchar(100)  NOT NULL,
    Nazwisko varchar(200)  NOT NULL,
    NumerTel int  NOT NULL,
    Email varchar(255)  NOT NULL,
    Pesel varchar(11)  NOT NULL,
    CONSTRAINT Pasazerowie_pk PRIMARY KEY  (PasazerID)
);

-- Table: Pojazdy
CREATE TABLE Pojazdy (
    IDPojazdu int  NOT NULL IDENTITY,
    Stan varchar(50)  NOT NULL,
    MarkaModel varchar(300)  NOT NULL,
    DostempneMiejsca int  NOT NULL,
    NumerRejestracyjny varchar(8)  NOT NULL,
    BiletomatID int  NOT NULL,
    CONSTRAINT Pojazdy_pk PRIMARY KEY  (IDPojazdu)
);

-- Table: Pracownicy
CREATE TABLE Pracownicy (
    PracownikID int  NOT NULL IDENTITY,
    StanowiskoID int  NOT NULL,
    Imie varchar(70)  NOT NULL,
    Nazwisko varchar(70)  NOT NULL,
    Pesel varchar(11)  NOT NULL,
    dataZatrudnienia date  NOT NULL,
    CONSTRAINT Pracownicy_pk PRIMARY KEY  (PracownikID)
);

-- Table: Przystanki
CREATE TABLE Przystanki (
    PrzystanekID int  NOT NULL IDENTITY,
    NazwaPrzystanku varchar(200)  NOT NULL,
    Lokalizacja varchar(300)  NOT NULL,
    BiletomatID int  NOT NULL,
    CONSTRAINT Przystanki_pk PRIMARY KEY  (PrzystanekID)
);

-- Table: Rodzajebiletu
CREATE TABLE Rodzajebiletu (
    RodzajebiletuID int  NOT NULL IDENTITY,
    NazwaBiletu varchar(30)  NOT NULL,
    CzasDzialania time(0)  NOT NULL,
    CONSTRAINT Rodzajebiletu_pk PRIMARY KEY  (RodzajebiletuID)
);

-- Table: RozkladJazdy
CREATE TABLE RozkladJazdy (
    RozkladJazdyID int  NOT NULL IDENTITY,
    LiniaID int  NOT NULL,
    PrzystanekID int  NOT NULL,
    KolejnoscNaTrasie int  NOT NULL,
    godzinaPrzyjazdu time(0)  NOT NULL,
    CONSTRAINT RozkladJazdy_pk PRIMARY KEY  (RozkladJazdyID)
);

-- Table: SkasowaneBilety
CREATE TABLE SkasowaneBilety (
    skasBiletID int  NOT NULL IDENTITY,
    dataSkasowania datetime  NOT NULL,
    ZakbiletyID int  NOT NULL,
    KursyID int  NOT NULL,
    CONSTRAINT SkasowaneBilety_pk PRIMARY KEY  (skasBiletID)
);

-- Table: Stanowiska
CREATE TABLE Stanowiska (
    StanowiskoID int  NOT NULL IDENTITY,
    NazwaStanowiska varchar(100)  NOT NULL,
    CONSTRAINT Stanowiska_pk PRIMARY KEY  (StanowiskoID)
);

-- Table: Uprawnienia
CREATE TABLE Uprawnienia (
    UprawnieniaID int  NOT NULL IDENTITY,
    Koduprawnien int  NOT NULL,
    OpisUprawnien varchar(200)  NOT NULL,
    WymaganyWiek int  NOT NULL,
    CONSTRAINT Uprawnienia_pk PRIMARY KEY  (UprawnieniaID)
);

-- Table: UprawnieniaKierowcow
CREATE TABLE UprawnieniaKierowcow (
    UprawnieniaID int  NOT NULL,
    PracownikID int  NOT NULL,
    doKiedy date  NOT NULL,
    CONSTRAINT UprawnieniaKierowcow_pk PRIMARY KEY  (UprawnieniaID)
);

-- Table: ZmianaRozkladu
CREATE TABLE ZmianaRozkladu (
    ZminaRozkladuID int  NOT NULL IDENTITY,
    LiniaID int  NOT NULL,
    PrzysNaTras_ID int  NOT NULL,
    KolejnoscNaTrasie int  NOT NULL,
    GodzinaPrzyjazdu time(0)  NOT NULL,
    odDaty date  NOT NULL,
    CONSTRAINT ZmianaRozkladu_pk PRIMARY KEY  (ZminaRozkladuID)
);

-- Table: biletomaty
CREATE TABLE biletomaty (
    BiletomatID int  NOT NULL IDENTITY,
    model varchar(100)  NOT NULL,
    stan varchar(100)  NOT NULL,
    CONSTRAINT biletomaty_pk PRIMARY KEY  (BiletomatID)
);

-- Table: cennik
CREATE TABLE cennik (
    biletID int  NOT NULL IDENTITY,
    RodzajebiletuID int  NOT NULL,
    zniszka varchar(50)  NOT NULL,
    Cena smallmoney  NOT NULL,
    CONSTRAINT cennik_pk PRIMARY KEY  (biletID)
);

-- Table: kierowcy
CREATE TABLE kierowcy (
    PracownikID int  NOT NULL,
    StanowiskoID int  NOT NULL DEFAULT 2,
    doKiedyBadania date  NOT NULL,
    CONSTRAINT kierowcy_pk PRIMARY KEY  (PracownikID)
);

-- foreign keys
-- Reference: Autobusy_biletomat (table: Pojazdy)
ALTER TABLE Pojazdy ADD CONSTRAINT Autobusy_biletomat
    FOREIGN KEY (BiletomatID)
    REFERENCES biletomaty (BiletomatID);

-- Reference: Bilety_Pasazerowie (table: KupBilety)
ALTER TABLE KupBilety ADD CONSTRAINT Bilety_Pasazerowie
    FOREIGN KEY (PasazerID)
    REFERENCES Pasazerowie (PasazerID);

-- Reference: Kursy_Autobusy (table: Kursy)
ALTER TABLE Kursy ADD CONSTRAINT Kursy_Autobusy
    FOREIGN KEY (IDPojazdu)
    REFERENCES Pojazdy (IDPojazdu);

-- Reference: Kursy_Trasa (table: Kursy)
ALTER TABLE Kursy ADD CONSTRAINT Kursy_Trasa
    FOREIGN KEY (LiniaID)
    REFERENCES Linia (LiniaID);

-- Reference: Kursy_kierowcy (table: Kursy)
ALTER TABLE Kursy ADD CONSTRAINT Kursy_kierowcy
    FOREIGN KEY (PracownikID)
    REFERENCES kierowcy (PracownikID);

-- Reference: Pracownicy_Stanowiska (table: Pracownicy)
ALTER TABLE Pracownicy ADD CONSTRAINT Pracownicy_Stanowiska
    FOREIGN KEY (StanowiskoID)
    REFERENCES Stanowiska (StanowiskoID);

-- Reference: PrzystanekNaTrasie_Przystanki (table: RozkladJazdy)
ALTER TABLE RozkladJazdy ADD CONSTRAINT PrzystanekNaTrasie_Przystanki
    FOREIGN KEY (PrzystanekID)
    REFERENCES Przystanki (PrzystanekID);

-- Reference: PrzystanekNaTrasie_Trasa (table: RozkladJazdy)
ALTER TABLE RozkladJazdy ADD CONSTRAINT PrzystanekNaTrasie_Trasa
    FOREIGN KEY (LiniaID)
    REFERENCES Linia (LiniaID);

-- Reference: Przystanki_biletomaty (table: Przystanki)
ALTER TABLE Przystanki ADD CONSTRAINT Przystanki_biletomaty
    FOREIGN KEY (BiletomatID)
    REFERENCES biletomaty (BiletomatID);

-- Reference: SkasowaneBilety_Kursy (table: SkasowaneBilety)
ALTER TABLE SkasowaneBilety ADD CONSTRAINT SkasowaneBilety_Kursy
    FOREIGN KEY (KursyID)
    REFERENCES Kursy (KursyID);

-- Reference: SkasowaneBilety_ZakBilety (table: SkasowaneBilety)
ALTER TABLE SkasowaneBilety ADD CONSTRAINT SkasowaneBilety_ZakBilety
    FOREIGN KEY (ZakbiletyID)
    REFERENCES KupBilety (KupBiletyID);

-- Reference: UprawnieniaKierowcow_Pracownicy (table: UprawnieniaKierowcow)
ALTER TABLE UprawnieniaKierowcow ADD CONSTRAINT UprawnieniaKierowcow_Pracownicy
    FOREIGN KEY (PracownikID)
    REFERENCES Pracownicy (PracownikID);

-- Reference: UprawnieniaKierowcow_Uprawnienia (table: UprawnieniaKierowcow)
ALTER TABLE UprawnieniaKierowcow ADD CONSTRAINT UprawnieniaKierowcow_Uprawnienia
    FOREIGN KEY (UprawnieniaID)
    REFERENCES Uprawnienia (UprawnieniaID);

-- Reference: ZakBilety_biletomat (table: KupBilety)
ALTER TABLE KupBilety ADD CONSTRAINT ZakBilety_biletomat
    FOREIGN KEY (BiletomatID)
    REFERENCES biletomaty (BiletomatID);

-- Reference: cennik_Rodzajebiletu (table: cennik)
ALTER TABLE cennik ADD CONSTRAINT cennik_Rodzajebiletu
    FOREIGN KEY (RodzajebiletuID)
    REFERENCES Rodzajebiletu (RodzajebiletuID);

-- Reference: kierowcy_Pracownicy (table: kierowcy)
ALTER TABLE kierowcy ADD CONSTRAINT kierowcy_Pracownicy
    FOREIGN KEY (PracownikID)
    REFERENCES Pracownicy (PracownikID);

-- Reference: zmianyWprzystankach_PrzystanekNaTrasie (table: ZmianaRozkladu)
ALTER TABLE ZmianaRozkladu ADD CONSTRAINT zmianyWprzystankach_PrzystanekNaTrasie
    FOREIGN KEY (PrzysNaTras_ID)
    REFERENCES RozkladJazdy (RozkladJazdyID);

-- Reference: zmianyWprzystankach_Trasa (table: ZmianaRozkladu)
ALTER TABLE ZmianaRozkladu ADD CONSTRAINT zmianyWprzystankach_Trasa
    FOREIGN KEY (LiniaID)
    REFERENCES Linia (LiniaID);

