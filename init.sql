drop table if exists utilisateur CASCADE;
drop table if exists suivi CASCADE;
drop table if exists amis CASCADE;
drop table if exists abonne CASCADE;
drop table if exists categorie CASCADE;
drop table if exists emojis CASCADE;
drop table if exists photo CASCADE;
drop table if exists publication CASCADE;
drop table if exists publie CASCADE;
drop table if exists lieu CASCADE;
drop table if exists cause CASCADE;
drop table if exists evenement_passe CASCADE;
drop table if exists evenement_a_venir CASCADE;
drop table if exists annonce CASCADE;
drop table if exists organise CASCADE;
drop table if exists interesse CASCADE;
drop table if exists genre CASCADE;
drop table if exists sous_genre_de CASCADE;
drop table if exists film CASCADE;
drop table if exists serie CASCADE;
drop table if exists participe CASCADE;
drop table if exists tag CASCADE;
drop table if exists realise CASCADE;
drop table if exists joue CASCADE;
drop table if exists projete CASCADE;


CREATE TABLE utilisateur (
  id_utilisateur integer PRIMARY KEY,
  login VARCHAR(50) NOT NULL,
  role VARCHAR(50) NOT NULL,
  nb_abonne integer,
  nb_abonnement integer,
  mot_de_passe TEXT NOT NULL,
  genre VARCHAR(1),
  age integer
);

CREATE TABLE suivi (
    id_utilisateur integer,
    id_suivi integer,
    PRIMARY KEY (id_utilisateur,id_suivi),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE amis (
    id_utilisateur1 integer, id_utilisateur2 integer,
    PRIMARY KEY (id_utilisateur1, id_utilisateur2),
    FOREIGN KEY (id_utilisateur1) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (id_utilisateur2) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE abonne (
    id_utilisateur integer,
    id_abonne integer,
    PRIMARY KEY (id_utilisateur, id_abonne),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE categorie (
    id_categorie integer PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE emojis (
    id_emojis integer PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

CREATE TABLE photo (
    id_video_photo integer PRIMARY KEY,
    url VARCHAR(1000) NOT NULL
);

CREATE TABLE publication (
    id_publication integer PRIMARY KEY,
    commentaire TEXT,
    reponse boolean,
    sujet integer,
    reaction integer,
    publie_photo integer,
    publication_u integer,
    FOREIGN KEY (sujet) REFERENCES categorie(id_categorie),
    FOREIGN KEY (reaction) REFERENCES emojis(id_emojis),
    FOREIGN KEY (publie_photo) REFERENCES photo(id_video_photo),
    FOREIGN KEY (publication_u) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE lieu(
    id_lieu integer PRIMARY KEY,
    adresse TEXT NOT NULL,
    ville VARCHAR(50)
);

CREATE TABLE cause(
    id_cause integer PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE evenement_passe(
    id_evenement_passe integer PRIMARY KEY,
    date_evenement date,
    lieu_e integer,
    cause_e integer,
    nb_participant integer,
    FOREIGN KEY (lieu_e) REFERENCES lieu(id_lieu),
    FOREIGN KEY (cause_e) REFERENCES cause(id_cause)
);

CREATE TABLE evenement_a_venir(
    id_evenement_a_venir integer PRIMARY KEY,
    prix integer,
    date_evenement date,
    nb_place_dispo integer,
    espace_exterieur boolean,
    lieu_e integer,
    cause_e integer,
    FOREIGN KEY (lieu_e) REFERENCES lieu(id_lieu),
    FOREIGN KEY (cause_e) REFERENCES cause(id_cause)
);

CREATE TABLE annonce (
    id_utilisateur integer,
    id_evenement_a_venir integer,
    PRIMARY KEY (id_utilisateur,id_evenement_a_venir),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (id_evenement_a_venir) REFERENCES evenement_a_venir(id_evenement_a_venir)
);

CREATE TABLE organise (
    organisateur integer,
    evenement integer,
    PRIMARY KEY (organisateur,evenement),
    FOREIGN KEY (organisateur) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (evenement) REFERENCES evenement_a_venir(id_evenement_a_venir)
);

CREATE TABLE interesse (
    id_utilisateur integer,
    id_evenement_a_venir integer,
    PRIMARY KEY (id_utilisateur,id_evenement_a_venir),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (id_evenement_a_venir) REFERENCES evenement_a_venir(id_evenement_a_venir)
);

CREATE TABLE genre(
    id_genre integer PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE sous_genre_de(
    id_genre integer,
    id_sous_genre_de integer,
    PRIMARY KEY (id_genre,id_sous_genre_de),
    FOREIGN KEY (id_genre) REFERENCES genre(id_genre)
);

CREATE TABLE film (
    numero integer PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    date_sortie date,
    genre_f integer,
    FOREIGN KEY (genre_f) REFERENCES genre (id_genre)
);

CREATE TABLE serie (
    numero integer PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    date_sortie date,
    genre_s integer,
    FOREIGN KEY (genre_s) REFERENCES genre (id_genre)
);

CREATE TABLE participe (
    id_utilisateur integer,
    id_evenement_passe integer,
    PRIMARY KEY (id_utilisateur,id_evenement_passe),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (id_evenement_passe) REFERENCES evenement_passe(id_evenement_passe)
);

CREATE TABLE tag (
    id integer,
    tag_film integer,
    tag_serie integer,
    tag_utilisateur integer,
    tag_evenement_passe integer,
    tag_lieu integer,
    tag_evenement_a_venir integer,
    tag_publication integer,
    tag_photo integer,
    PRIMARY KEY (id),
    FOREIGN KEY (tag_film) REFERENCES film(numero),
    FOREIGN KEY (tag_serie) REFERENCES serie(numero),
    FOREIGN KEY (tag_utilisateur) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (tag_evenement_passe) REFERENCES evenement_passe(id_evenement_passe),
    FOREIGN KEY (tag_lieu) REFERENCES lieu(id_lieu),
    FOREIGN KEY (tag_evenement_a_venir) REFERENCES evenement_a_venir(id_evenement_a_venir),
    FOREIGN KEY (tag_publication) REFERENCES publication(id_publication),
    FOREIGN KEY (tag_photo) REFERENCES photo(id_video_photo)
);

CREATE TABLE realise (
    id_realise integer PRIMARY KEY,
    realisateur integer,
    film_realise integer,
    serie_realise integer,
    FOREIGN KEY (realisateur) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (film_realise) REFERENCES film(numero),
    FOREIGN KEY (serie_realise) REFERENCES serie(numero)
);

CREATE TABLE joue (
    id_joue integer PRIMARY KEY,
    acteur integer,
    film_joue integer,
    serie_joue integer,
    FOREIGN KEY (acteur) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (film_joue) REFERENCES film(numero),
    FOREIGN KEY (serie_joue) REFERENCES serie(numero)
);

CREATE TABLE projete (
    id_projete integer PRIMARY KEY,
    evenement integer,
    film_projete integer,
    serie_projete integer,
    FOREIGN KEY (evenement) REFERENCES evenement_a_venir(id_evenement_a_venir),
    FOREIGN KEY (film_projete) REFERENCES film(numero),
    FOREIGN KEY (serie_projete) REFERENCES serie(numero)
);

\COPY utilisateur FROM 'CSV/utilisateur.csv' WITH (FORMAT CSV,HEADER);
\COPY suivi FROM 'CSV/suivi.csv' WITH (FORMAT CSV,HEADER);
\COPY abonne FROM 'CSV/abonne.csv' WITH (FORMAT CSV,HEADER);
\COPY amis FROM 'CSV/amis.csv' WITH (FORMAT CSV,HEADER);
\COPY categorie FROM 'CSV/categorie.csv' WITH (FORMAT CSV,HEADER);
\COPY emojis FROM 'CSV/emojis.csv' WITH (FORMAT CSV,HEADER);
\COPY photo FROM 'CSV/photo.csv' WITH (FORMAT CSV,HEADER);
\COPY publication FROM 'CSV/publication.csv' WITH (FORMAT CSV,HEADER);
\COPY lieu FROM 'CSV/lieu.csv' WITH (FORMAT CSV,HEADER);
\COPY cause FROM 'CSV/cause.csv' WITH (FORMAT CSV,HEADER);
\COPY evenement_passe FROM 'CSV/evenement_passe.csv' WITH (FORMAT CSV,HEADER);
\COPY evenement_a_venir FROM 'CSV/evenement_a_venir.csv' WITH (FORMAT CSV,HEADER);
\COPY annonce FROM 'CSV/annonce.csv' WITH (FORMAT CSV,HEADER);
\COPY organise FROM 'CSV/organise.csv' WITH (FORMAT CSV,HEADER);
\COPY interesse FROM 'CSV/interesse.csv' WITH (FORMAT CSV,HEADER);
\COPY genre FROM 'CSV/genre.csv' WITH (FORMAT CSV,HEADER);
\COPY sous_genre_de FROM 'CSV/sous_genre_de.csv' WITH (FORMAT CSV,HEADER);
\COPY film FROM 'CSV/film.csv' WITH (FORMAT CSV,HEADER);
\COPY serie FROM 'CSV/serie.csv' WITH (FORMAT CSV,HEADER);
\COPY participe FROM 'CSV/participe.csv' WITH (FORMAT CSV,HEADER);
\COPY tag FROM 'CSV/tag.csv' WITH (FORMAT CSV,HEADER);
\COPY realise FROM 'CSV/realise.csv' WITH (FORMAT CSV,HEADER);
\COPY joue FROM 'CSV/joue.csv' WITH (FORMAT CSV,HEADER);
\COPY projete FROM 'CSV/projete.csv' WITH (FORMAT CSV,HEADER);
