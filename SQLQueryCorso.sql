--QUERY SU SINGOLA TABELLA:

--1- Selezionare tutte le software house americane (3)
select * from software_houses
select * from software_houses where Country = 'United States'

--2- Selezionare tutti i giocatori della città di 'Rogahnland' (2)
select * from players
select * from players where city = 'Rogahnland'

--3- Selezionare tutti i giocatori il cui nome finisce per "a" (220)
select * from players where name like '%a'

--4- Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)
select * from reviews
select * from reviews where player_id = 800

--5- Contare quanti tornei ci sono stati nell'anno 2015 (9)
select * from tournaments
select count(*) from tournaments where year = 2015

--6- Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)
select * from awards where description like '%facere%'

--7- Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG), mostrandoli una sola volta (del videogioco vogliamo solo l'ID) (287)
select * from category_videogame
select distinct videogame_id from category_videogame where category_id IN (2,6)

--8- Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)
select * from reviews where rating >= 2 and rating <=4

--9- Selezionare tutti i dati dei videogiochi rilasciati nell'anno 2020 (46)
select * from videogames
select * from videogames where release_date >= '20200101' and release_date <= '20201231'

--10- Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da stelle, mostrandoli una sola volta (443)
select distinct reviews.videogame_id from reviews where reviews.videogame_id IN (Select videogames.id from videogames) and reviews.rating = 5

--*********** BONUS ***********

--11- Selezionare il numero e la media delle recensioni per il videogioco con ID = 412 (review number = 12, avg_rating = 3)
select count(r.videogame_id),AVG(r.rating) from reviews r where r.videogame_id IN (Select v.id from videogames v where v.id = 412)

--12- Selezionare il numero di videogame che la software house con ID = 1 ha rilasciato nel 2018 (13)
select count(*) from videogames v where v.software_house_id IN (select s.id from software_houses s where id=1) and (v.release_date between ('20180101') and ('20181231'))

--12:48
--QUERY CON GROUP BY

--1- Contare quante software house ci sono per ogni paese (3)
select count(*),country from software_houses group by country

--2- Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l'ID) (500)
select videogame_id,count(*) as receivedReviews from reviews group by videogame_id

--3- Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)
select * from pegi_label_videogame
select count(*) as videogamesNumber, pegi_label_id from pegi_label_videogame group by pegi_label_id

--4- Mostrare il numero di videogiochi rilasciati ogni anno (11)
select DATEPART(year,release_date),count(*) as videogamesReleased from videogames  group by DATEPART(year,release_date)

--5- Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l'ID) (7)
select * from devices
select * from device_videogame
select count(dv.device_id) as numberOfGames from device_videogame dv where dv.device_id IN (Select d.id from devices d) group by dv.device_id

--6- Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l'ID) (500)
select videogame_id,AVG(rating) as averageRating from reviews group by videogame_id order by averageRating desc

--12:48
--QUERY CON JOIN

--1- Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)
select * from players
select * from reviews
select distinct p.* from players p Inner Join reviews r ON p.id = r.player_id

--2- Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)
select * from videogames
select * from tournament_videogame
select * from tournaments
select distinct v.id as tournamentsGamesId  from tournament_videogame t inner join videogames v ON t.videogame_id = v.id INNER JOIN tournaments tt ON t.tournament_id = tt.id where tt.year = 2016

--3- Mostrare le categorie di ogni videogioco (1718)
select * from category_videogame
select * from categories
select * from videogames
select v.id,c.description from videogames v INNER JOIN category_videogame cv ON cv.videogame_id = v.id INNER JOIN categories c ON c.id = cv.category_id

--4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)
select distinct sh.* from software_houses sh inner join videogames v on sh.id = v.software_house_id where v.release_date > '20200101'

--5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)
select * from awards
select * from award_videogame
select * from videogames
select * from software_houses
select a.*, sh.id,sh.name from awards a inner join award_videogame av on a.id = av.award_id inner join videogames v on v.id = av.videogame_id inner join software_houses sh on v.software_house_id = sh.id

--6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)
--7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)
--8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)
--9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)
--*********** BONUS ***********
--10- Selezionare i dati della prima software house che ha rilasciato un gioco, assieme ai dati del gioco stesso (software house id : 5)
--11- Selezionare i dati del videogame (id, name, release_date, totale recensioni) con più recensioni (videogame id : 398)
--12- Selezionare la software house che ha vinto più premi tra il 2015 e il 2016 (software house id : 1)
--13- Selezionare le categorie dei videogame i quali hanno una media recensioni inferiore a 2 (10)
--12:48
--(non le facciamo tutte, spendiamo solo un po' di tempo per vedere/rinfrescare la memoria i concetti più complessi)