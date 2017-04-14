
CREATE DOMAIN instrument AS VARCHAR
CHECK (VALUE IN ('piano', 'guitare', 'basse', 'batterie', 'violon', 'trompette', 'saxophone'));


CREATE DOMAIN style AS TEXT
CHECK (VALUE IN ('Afro beat', 'Ambient', 'Black Métal',
'Blues', 'Bossa Nova', 'chanson française', 'Cold Wave', 'Country', 'Dance', 'Death Métal', 'Disco', 'Drum'n'Bass',
'Dub', 'Electro', 'Electronica', 'Emo rock', 'Folk', 'Folk Rock', 'Funk', 'Fusion', 'Glam Rock', 'Gospel', 'Gothic Metal', 'Grind',
'Groove, RNB', 'Grunge', 'Hard rock', 'Hardcore', 'Heavy Metal', 'Hip-Hop Français', 'House', 'Indie Rock', 'Indus', 'Jazz', 'Jazz Manouche', 'Laid Back', 'Latino', 'Lounge', 'Métal', 'Metal Prog', 'Musique Classique', 'Musique Contemporaine', 'Musique gitane', 'Musique Orientale', 'Musique traditionnelle', 'Musiques de films', 'Néo Metal', 'New Age', 'New Wave', 'Opera', 'Pop' , 'Post Punk', 'Post Rock', 'Power Metal', 'Punk', 'Ragga, Dancehall', 'Raï', 'Rap, Hip-Hop', 'Reggae', 'Reggaeton', 'Rock', 'Rock - Fusion', 'Rock Alternatif', 'rock progressif', 'Rock psychédélique', 'Rock'n'roll', 'Rock-ska', 'Rythm'n'blues', 'Salsa', 'Scène française', 'Ska', 'Slam', 'Soul', 'Stoner', 'Swing', 'Techno', 'Trash Metal', 'Trip-Hop', 'Variétés', 'World', 'Zouk'));


CREATE DOMAIN genre AS TEXT
CHECK (VALUE IN ('Théorie', 'Partitions', 'Biographie', 'Livre Technique'));


CREATE TABLE Commande (
id_commande SERIAL PRIMARY KEY,
date_commande DATE,
id_user INTEGER REFERENCES Utilisateur(id_user) );


CREATE TABLE Utilisateur (
id_user SERIAL PRIMARY KEY,
nom_user VARCHAR(30) NOT NULL,
CHECK (regexp_matches(nom_user, '[a-zA-Z]*')),
prenom_user VARCHAR(30) NOT NULL,
CHECK (regexp_matches(prenom_user, '[a-zA-Z]*')),
mail_user VARCHAR NOT NULL,
CONSTRAINT correct_mail CHECK (mail_user ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),
password_user NOT NULL,
points_fidelite_user INTEGER DEFAULT 0,
CHECK (points_fidelite_user >= 0));


CREATE TABLE Profil_User (
id_profil SERIAL PRIMARY KEY,
nom_profil VARCHAR NOT NULL,
instrument_joue instrument,
id_user INTEGER REFERENCES Utilisateur(id_user) );


CREATE TABLE Artiste (
id_artiste SERIAL PRIMARY KEY,
nom_artiste VARCHAR NOT NULL,
style_artiste style NOT NULL);



CREATE TABLE Aime (
id_artiste INTEGER REFERENCES Artiste(id_artiste),
id_profil INTEGER REFERENCES Profil(id_profil),
PRIMARY KEY(id_artiste, id_profil) );



CREATE TABLE Produit(
id_produit SERIAL PRIMARY KEY,
libelle_produit TEXT NOT NULL,
prix_produit_HT FLOAT NOT NULL);


CREATE TABLE Evenement (
id_evenement SERIAL PRIMARY KEY,
libelle_evenement VARCHAR NOT NULL,
date_debut DATE NOT NULL,
date_fin DATE NOT NULL,
adresse_evenement TEXT NOT NULL,
Pays VARCHAR(30) NOT NULL );



CREATE TABLE Concerne (
id_produit INTEGER REFERENCES Produit(id_produit),
id_commande INTEGER REFERENCES Commande(id_commande),
Quantite INTEGER NOT NULL,
PRIMARY KEY(id_produit, id_commande) );



CREATE TABLE A_Participe_Evenement_Profil (
id_evenement INTEGER REFERENCES Evenement(id_evenement),
id_profil INTEGER REFERENCES Profil(id_profil),
PRIMARY KEY(id_evenement, id_profil) );

CREATE TABLE Abonnement_Cours (
id_abonnement_cours SERIAL PRIMARY KEY,
date_abonnement_cours DATE,
Prix_mensuel_HT_cours FLOAT,
id_user REFERENCES Utilisateur(id_user) );

CREATE TABLE Abonnement_Audio (
id_abonnement_Audio SERIAL PRIMARY KEY,
date_abonnement_Audio DATE,
Prix_mensuel_HT_Audio FLOAT,
id_user REFERENCES Utilisateur(id_user) );



CREATE TABLE Video (
id_video SERIAL PRIMARY KEY,
libelle_video TEXT,
auteur_video TEXT,
Note_video FLOAT,
Duree_video INTEGER );


CREATE TABLE Musique (
id_musique SERIAL PRIMARY KEY,
nom_musique TEXT NOT NULL,
date_enregistrement DATE NOT NULL,
style_musique style NOT NULL );


CREATE TABLE Concerne_Produit_Evenement (
id_evenement INTEGER REFERENCES Evenement(id_evenement),
id_produit INTEGER REFERENCES Produit(id_produit),
PRIMARY KEY (id_evenement, id_produit) );



CREATE TABLE Place_evenement(
id_produit INTEGER PRIMARY KEY REFERENCES Produit(id_produit),
duree_place_evenement FLOAT NOT NULL,
date_place_evenement DATE NOT NULL );


CREATE TABLE Goodies (
id_produit INTEGER PRIMARY KEY REFERENCES Produit(id_produit),
type_goodies TEXT,
couleur_goodies TEXT );


CREATE TABLE CD (
id_produit INTEGER PRIMARY KEY REFERENCES Produit(id_produit),
echantillonnage_CD INTEGER NOT NULL,
nombre_piste_CD INTEGER NOT NULL,
 );


CREATE TABLE Vinyle (
id_produit INTEGER PRIMARY KEY REFERENCES Produit(id_produit),
nombre_tours_vinyle INTEGER,
nombre_face_vinyle INTEGER,
taille_vinyle INTEGER,
nombre_piste_vinyle INTEGER );

CREATE TABLE Musique (
id_musique SERIAL PRIMARY KEY,
nom_musique TEXT,
date_enregistrement_musique DATE,
style_musique style );


CREATE TABLE Contient_Musique_CD (
id_musique INTEGER REFERENCES Musique(id_musique),
id_produit INTEGER REFERENCES Produit(id_produit),
PRIMARY KEY (id_musique, id_produit) );


CREATE TABLE Contient_Musique_Vinyle (
id_musique INTEGER REFERENCES Musique(id_musique),
id_produit INTEGER REFERENCES Produit(id_produit),
PRIMARY KEY (id_musique, id_produit) );

CREATE TABLE Livre (
id_produit INTEGER REFERENCES Produit(id_produit),
auteur_livre TEXT NOT NULL,
nbre_pages INTEGER NOT NULL,
genre_livre genre NOT NULL);
