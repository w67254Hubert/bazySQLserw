
1. To zapytanie pokaże nam, po jakich przystankach i w jakich godzinach przejeżdża dana linia po przystankach, jak i kolejność tych przystanków.}

    SELECT * FROM RozkladJazdy WHERE LiniaID = 1 order by KolejnoscNaTrasie

2. Podane poniżej zapytanie pokazuje nam 5 następnych przystanków z pominięciem 2 pierwszych}
    SELECT * FROM RozkladJazdy where LiniaID=1
    ORDER BY KolejnoscNaTrasie
    OFFSET 2 rows
    FETCH next 5 rows only

3. Wynikiem poniższego zapytania będzie harmonogram jazdy na danym przystanku.}

    SELECT LiniaID, godzinaPrzyjazdu FROM RozkladJazdy WHERE PrzystanekID
    
    = 1 order by godzinaPrzyjazdu 

4 Zapytanie wybiera wszystkie linie zawarte w rozkładzie jazdy}

    SELECT DISTINCT LiniaID FROM RozkladJazdy;

5. Zapytanie zlicza ilość odwiedzonych przez daną linie przystanków podczas przejazdu.

    SELECT LiniaID, COUNT(*) AS IloscPrzys FROM RozkladJazdy 
    
    GROUP BY LiniaID
6. Podanie poniżej zapytanie poda nam ile w sumie i ile średnio poszczególny klient wydał na bilety}

    SELECT PasazerID, 

    sUM(Cena) OVER (PARTITION BY PasazerID) AS MAXWydatki,
       
    AVG(Cena) OVER (PARTITION BY PasazerID) AS srCenaBil
       
    FROM KupBilety;

7. Zapytanie pokaże nam wszystkie imiona i nazwiska zawarte w bazie}

    SELECT Imie,Nazwisko FROM Pracownicy UNION
    SELECT Imie,Nazwisko FROM Pasazerowie;

Zapytania zawierające JOIN

1. Za pomocą przedstawionego złączenia tablic dowiadujemy się imiona i nazwiska osób które kupiły bilet}
    
    SELECT KupBilety.KupBiletyID, KupBilety.Cena, KupBilety.DataZakupu, Pasazerowie.Imie+' '+Pasazerowie.Nazwisko as pasarzer
    
    FROM KupBilety JOIN Pasazerowie ON KupBilety.PasazerID = Pasazerowie.PasazerID

2. Wynikiem zapytania będzie wyświetlenie, przez jakie przystanki i w jakich godzinach przejedzie podana linia.}
    
    SELECT RozkladJazdy.godzinaPrzyjazdu, Przystanki.NazwaPrzystanku, Linia.Linia
    
    FROM RozkladJazdy 
    
    JOIN Przystanki ON RozkladJazdy.PrzystanekID = Przystanki.PrzystanekID
    
    JOIN Linia ON RozkladJazdy.LiniaID = Linia.LiniaID
    
    WHERE linia=2
    
    ORDER BY KolejnoscNaTrasie

3. Wynikiem zapytania będzie pokazanie jakie linie i w jakich godzinach będą przyjeżdżać na przystanek o podanej nazwie}
    
    SELECT R.godzinaPrzyjazdu, P.NazwaPrzystanku, Linia.Linia 
    
    FROM RozkladJazdy AS R
    
    JOIN Przystanki as P ON R.PrzystanekID = P.PrzystanekID
    
    JOIN Linia ON R.LiniaID = Linia.LiniaID
    
    WHERE NazwaPrzystanku='NazwaPRzystanku'
    
    ORDER BY godzinaPrzyjazdu

4. Wynikiem zapytania będzie Uśredniona cena poszczególnych rodzajów biletów}

    Select R.NazwaBiletu, avg(C.Cena) as średCena
    FROM Rodzajebiletu as R join cennik as C on R.RodzajebiletuID=C.RodzajebiletuID
    group by R.NazwaBiletu
    order by średCena

5.Podzapytanie podaje średnią liczbę lat przepracowanych przez pracowników na danym stanowisku}

    SELECT S.NazwaStanowiska, AVG(DATEDIFF(YEAR, P.dataZatrudnienia, GETDATE())) AS srdLiczLatZatr
    
    FROM Stanowiska as S JOIN Pracownicy as P ON S.StanowiskoID = P.StanowiskoID

    GROUP BY S.NazwaStanowiska;

6. Poniższe zapytanie pokaże nam ID skasowanego biletu razem z osobą, która ten bilet kupiła}

    Select s.skasBiletID, Imie, Nazwisko
    
    from SkasowaneBilety as S
    
    join KupBilety on S.ZakbiletyID=KupBilety.KupBiletyID 
    
    join Pasazerowie as P on KupBilety.PasazerID=P.PasazerID


Zapytania zawierające LEFT, Right, Cross JOIN

1. Zapytanie podane poniżej poda nam Różnice pomiędzy najdroższym i najtańszym biletem}

    Select top 1 (C.Cena-C1.Cena) as ruznica
    
    from cennik as C cross join cennik as C1
    
    order by 1 desc

2. Za pomocą podanego poniżej zapytania zobaczymy na jakich stanowiskach pracują pracownicy}

    SELECT Pracownicy.Imie, Pracownicy.Nazwisko, Stanowiska.NazwaStanowiska
    
    FROM Pracownicy LEFT JOIN Stanowiska ON Pracownicy.StanowiskoID = Stanowiska.StanowiskoID;

3. Podane poniżej zapytanie przedstawi nam, jaki autobus został przypisany do danego kursu.}

    SELECT Kursy.KursyID, Pojazdy.MarkaModel, Pojazdy.DostempneMiejsca
    
    FROM Kursy LEFT JOIN Pojazdy ON Kursy.IDPojazdu = Pojazdy.IDPojazdu

4. Podane zapytanie oceni nam czy cena zakupu biletu jest przystępna.}

    SELECT P.imie,P.Nazwisko, Cena,
    
    CASE WHEN Cena < 10 THEN 'Tanio' WHEN Cena >= 10 AND Cena < 20 THEN 'Przyzwoicie' ELSE 'Drogo' END AS kategorie
    
    FROM KupBilety as K left join Pasazerowie as P on k.PasazerID=p.PasazerID

zapytań z podzapytaniem w części SELECT

1. Zapytanie pokaże nam listę pasażerów razem z ilością biletów, które zakupili}

    SELECT Imie, Nazwisko, 
    
    (SELECT COUNT(*) FROM KupBilety WHERE KupBilety.PasazerID = Pasazerowie.PasazerID) AS TotalTickets
    
    FROM Pasazerowie;

2. Poniższe zapytanie pokazuje nam ile autobusów będzie odjeżdżać z danego przystanku.}

    SELECT NazwaPrzystanku, (
    
    SELECT COUNT(*) FROM RozkladJazdy WHERE RozkladJazdy.PrzystanekID = Przystanki.PrzystanekID) AS liczOdjazdy
    
    FROM Przystanki;

3. Poniższe zapytanie poda nam stan pojazdu na danym kursie dzięki czemu możemy się dowiedzieć czy kurs się odbędzie}

    SELECT KursyID, GodzRospoczencia, GodzZakonczena, (
    
    SELECT Stan FROM Pojazdy WHERE Pojazdy.IDPojazdu = Kursy.IDPojazdu) AS BusModel
    
    FROM Kursy;

zapytań z podzapytaniem w części FROM

1. Zapytanie pokazuje ile wydali poszczególni pasażerowie na bilety}

    SELECT Pasazerowie.Imie, Pasazerowie.Nazwisko, ileWydał
    
    FROM Pasazerowie JOIN (
    SELECT PasazerID, SUM(Cena) AS ileWydał FROM KupBilety GROUP BY PasazerID) AS E

    ON Pasazerowie.PasazerID = E.PasazerID;

2. Zapytanie pokazuje do ilu kursów przypisani są poszczególni pracownicy wymienieni z imienia i nazwiska}

    SELECT Pracownicy.Imie, Pracownicy.Nazwisko, ilekursow
    
    FROM Pracownicy JOIN (
    
    SELECT PracownikID, COUNT(*) AS ilekursow FROM Kursy GROUP BY PracownikID) AS EK
    
    ON Pracownicy.PracownikID = EK.PracownikID;

3. Poniższe zapytanie pokaże nam, jaka jest średnia cen biletów kupionych w autobusach}

    SELECT P.NumerRejestracyjny,P.MarkaModel, srCena
    
    FROM Pojazdy as P JOIN (
    SELECT BiletomatID, AVG(cena) AS srCena FROM kupbilety GROUP BY BiletomatID
    ) AS B ON P.BiletomatID = B.BiletomatID;

Zapytań z podzapytaniem w części WHERE

1. Poniższe zapytanie zlicza liczbę przystanków, po których przejeżdża linia. Podaje tylko te, które mają powyżej 10 przystanków.}

    SELECT LiniaID, COUNT(*) AS IloscPrzystankow
    
    FROM RozkladJazdy
    
    WHERE LiniaID IN (SELECT DISTINCT LiniaID FROM RozkladJazdy WHERE 
    KolejnoscNaTrasie > 1)
    
    GROUP BY LiniaID

Identyczny efekt można osiągnąć dodająca zamiast podzapytania w części WHERE dodać HAVING z następującym warunkiem:}

    HAVING COUNT(*) >5;

2. Zapytanie pokaże nam kursy, na których będzie jechały autobusy Volvo700}
    
    SELECT KursyID, GodzRospoczencia, GodzZakonczena
    
    FROM Kursy
    
    WHERE IDPojazdu IN (SELECT IDPojazdu FROM Pojazdy WHERE MarkaModel = 'Volvo7000');

3. Zapytanie pokazuje nam jakie przystanki mają aktywny biletomat}

    SELECT NazwaPrzystanku
    
    FROM Przystanki
    
    WHERE BiletomatID IN (SELECT BiletomatID FROM biletomaty WHERE stan = 'Aktywny')
