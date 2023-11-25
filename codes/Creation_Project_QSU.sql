-- -----------------------------------------------------
-- Schema Project_BDR
-- -----------------------------------------------------
CREATE SCHEMA Project_BDR;

-- -----------------------------------------------------
-- Table Project_BDR.Inventaires
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Inventaires (
  idInventaires INT NOT NULL UNIQUE,
  tailleMax INT NOT NULL,
  PRIMARY KEY (idInventaires))



-- -----------------------------------------------------
-- Table Project_BDR.Statistiques
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Statistiques (
  idStatistiques INT NOT NULL UNIQUE,
  force INT NULL,
  dex INT NULL,
  intel INT NULL,
  PRIMARY KEY (idStatistiques))



-- -----------------------------------------------------
-- Table Project_BDR.Sorts
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Sorts (
  idSorts INT NOT NULL UNIQUE,
  nom VARCHAR(45) NULL,
  degat INT NULL,
  statLieeDegat VARCHAR(45) NULL,
  PRIMARY KEY (idSorts))



-- -----------------------------------------------------
-- Table Project_BDR.Archetypes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Archetypes (
  idArchetypes INT NOT NULL UNIQUE,
  nom VARCHAR(45) NULL,
  FK_Sorts INT NOT NULL,
  PRIMARY KEY (idArchetypes, FK_Sorts),
  CONSTRAINT fk_Archetypes_Sorts1
    FOREIGN KEY (FK_Sorts)
    REFERENCES Project_BDR.Sorts (idSorts)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table Project_BDR.Metiers
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Metiers (
  idMetiers INT NOT NULL UNIQUE,
  PRIMARY KEY (idMetiers))



-- -----------------------------------------------------
-- Table Project_BDR.Marche
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Marche (
  idMarche INT NOT NULL UNIQUE,
  nom VARCHAR(45) NULL,
  PRIMARY KEY (idMarche))



-- -----------------------------------------------------
-- Table Project_BDR.Personnages
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Personnages (
  idPersonnages INT NOT NULL UNIQUE,
  nom VARCHAR(45) NULL,
  hp INT NULL,
  exp INT NULL,
  argent INT NULL,
  FK_Inventaires INT NOT NULL,
  FK_Statistiques INT NOT NULL,
  FK_Archetypes INT NOT NULL,
  FK_Metier INT NOT NULL,
  FK_Marche INT NOT NULL,
  PRIMARY KEY (idPersonnages, FK_Archetypes, FK_Statistiques, FK_Inventaires, FK_Metier, FK_Marche),
  CONSTRAINT fk_Personnages_Inventaires
    FOREIGN KEY (FK_Inventaires)
    REFERENCES Project_BDR.Inventaires (idInventaires)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Personnages_Statistiques1
    FOREIGN KEY (FK_Statistiques)
    REFERENCES Project_BDR.Statistiques (idStatistiques)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Personnages_Archetypes1
    FOREIGN KEY (FK_Archetypes)
    REFERENCES Project_BDR.Archetypes (idArchetypes)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Personnages_Metiers1
    FOREIGN KEY (FK_Metier)
    REFERENCES Project_BDR.Metiers (idMetiers)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Personnages_Marche1
    FOREIGN KEY (FK_Marche)
    REFERENCES Project_BDR.Marche (idMarche)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table Project_BDR.Prix
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Prix (
  idPrix INT NOT NULL UNIQUE,
  FK_Marche INT NOT NULL,
  prix INT NULL,
  PRIMARY KEY (idPrix, FK_Marche),
  CONSTRAINT fk_Prix_Marche1
    FOREIGN KEY (FK_Marche)
    REFERENCES Project_BDR.Marche (idMarche)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table Project_BDR.Objets
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Objets (
  idObjets INT NOT NULL,
  nom VARCHAR(45) NULL,
  FK_Prix INT NULL,
  Prix_FK_Marche INT NULL,
  PRIMARY KEY (idObjets),
  CONSTRAINT fk_Objets_Prix1
    FOREIGN KEY (FK_Prix , Prix_FK_Marche)
    REFERENCES Project_BDR.Prix (idPrix , FK_Marche)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table Project_BDR.Equipements
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Equipements (
  idEquipements INT NOT NULL,
  modificateurStat VARCHAR(45) NULL,
  FK_Objets INT NOT NULL,
  PRIMARY KEY (idEquipements, FK_Objets),
  CONSTRAINT fk_Equipements_Objets1
    FOREIGN KEY (FK_Objets)
    REFERENCES Project_BDR.Objets (idObjets)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table Project_BDR.Slots
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Slots (
  idSlots INT NOT NULL UNIQUE,
  type VARCHAR(45) NULL,
  FK_Personnage INT NOT NULL,
  FK_Equipements INT NOT NULL,
  Equipements_FK_Objets INT NOT NULL,
  PRIMARY KEY (idSlots, FK_Personnage, FK_Equipements, Equipements_FK_Objets),
  CONSTRAINT fk_Slots_Personnages1
    FOREIGN KEY (FK_Personnage)
    REFERENCES Project_BDR.Personnages (idPersonnages)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Slots_Equipements1
    FOREIGN KEY (FK_Equipements , Equipements_FK_Objets)
    REFERENCES Project_BDR.Equipements (idEquipements , FK_Objets)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table Project_BDR.Inventaires_has_Objets
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Inventaires_has_Objets (
  Inventaires_idInventaires INT NOT NULL UNIQUE,
  Objets_idObjets INT NOT NULL,
  PRIMARY KEY (Inventaires_idInventaires, Objets_idObjets),
  CONSTRAINT fk_Inventaires_has_Objets_Inventaires1
    FOREIGN KEY (Inventaires_idInventaires)
    REFERENCES Project_BDR.Inventaires (idInventaires)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Inventaires_has_Objets_Objets1
    FOREIGN KEY (Objets_idObjets)
    REFERENCES Project_BDR.Objets (idObjets)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table Project_BDR.Consommables
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Consommables (
  idConsommables INT NOT NULL UNIQUE,
  effet VARCHAR(45) NULL,
  valeurNumEffet INT NULL,
  FK_Objets INT NOT NULL,
  PRIMARY KEY (idConsommables, FK_Objets),
  CONSTRAINT fk_Consommables_Objets1
    FOREIGN KEY (FK_Objets)
    REFERENCES Project_BDR.Objets (idObjets)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table Project_BDR.Recettes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Recettes (
  idRecettes INT NOT NULL UNIQUE,
  objetCree VARCHAR(45) NULL,
  FK_Metier INT NOT NULL,
  PRIMARY KEY (idRecettes, FK_Metier),
  CONSTRAINT fk_Recettes_Metiers1
    FOREIGN KEY (FK_Metier)
    REFERENCES Project_BDR.Metiers (idMetiers)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table Project_BDR.Ressources
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project_BDR.Ressources (
  idRessources INT NOT NULL UNIQUE,
  FK_Objets INT NOT NULL,
  FK_Recettes INT NOT NULL,
  PRIMARY KEY (idRessources, FK_Objets, FK_Recettes),
  CONSTRAINT fk_Ressources_Objets1
    FOREIGN KEY (FK_Objets)
    REFERENCES Project_BDR.Objets (idObjets)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Ressources_Recettes1
    FOREIGN KEY (FK_Recettes)
    REFERENCES Project_BDR.Recettes (idRecettes)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


