--- Archétypes
INSERT INTO archetypes(idarchetypes, Nom) VALUES
(1, 'Iop'),
(2, 'Eniripsa'),
(3, 'Osamodas'),
(4, 'Sacrieur'),
(5, 'Féca'),
(6, 'Xélor'),
(7, 'Ecaflip'),
(8, 'Enutrof'),
(9, 'Sram'),
(10, 'Cra'),
(11, 'Sadida'),
(12, 'Pandawa');

--- Sorts
INSERT INTO sorts(nom, degat, type, fk_archetypes_idarchetypes) VALUES
('Epee du Chevalier', 60, 'Force', 1), -- Iop
('Soins Eniripsa', 25, 'Intelligence', 2), -- Eniripsa
('Invocation du Dragon', 35, 'Invocation', 3), -- Osamodas
('Bouclier Sacré', 50, 'Intelligence', 4), -- Sacrieur
('Epée du Jugement', 65, 'Force', 5), -- Féca
('Invocation de la Marionnette', 30, 'Intelligence', 6), -- Xelor
('Roulette Chanceuse', 40, 'Force', 7), -- Ecaflip
('Pelle du Trésor', 70, 'Agilite', 8), -- Enutrof
('Coup de lOmbre', 55, 'Intelligence', 9), --Sram
('Fleche du Precision', 45, 'Agilite', 10), -- Cra
('Pouvoir Naturel', 55, 'Dexterite', 11), -- Sadida
('Karcham', 60, 'Agilite', 12); -- Pandawa





-- Objets
-- Equipements



-- Ajouter une nouvelle ressource en utilisant l'ID de l'objet
INSERT INTO objets(idobjets, nom, type) VALUES
(100, 'Bottes du Bouftou', 'Equipement'),
(101, 'Chapeau du Tofu', 'Equipement'),
(102, 'Cape du Prespic', 'Equipement'),
(103, 'Amulette du Mulou', 'Equipement'),
(104, 'Épée du Meulou', 'Equipement'),
(105, 'Bouclier du Bwork', 'Equipement'),
(106, 'Anneau du Scarafeuille', 'Equipement'),
(107, 'Bâton du Tofu', 'Equipement');


INSERT INTO equipements(fk_objets, type_equipement, hp, force, dex, intel) VALUES
(100, 'Bottes', 0, 0, 6, 0),
(101, 'Chapeau', 15, 0, 5, 12),
(102, 'Cape', 10, 0, 8, 5),
(103, 'Amulette', 8, 3, 4, 10),
(104, 'Épée', 0, 15, 2, 0),
-- Pour le Bouclier du Bwork
(105, 'Bouclier', 15, 0, 5, 0),

-- Pour l'Anneau du Scarafeuille
(106, 'Anneau', 12, 2, 6, 8),

-- Pour le Bâton du Tofu
(107, 'Bâton', 10, 3, 4, 12);


-- Consommables

INSERT INTO objets(idobjets, nom, type) VALUES
(200, 'Pain Prenelle', 'Consommable'),
(201, 'Potion de Vie', 'Consommable'),
(202, 'Potion de Mana', 'Consommable'),

(204, 'Pain Incarnam', 'Consommable');

INSERT INTO consommables(fk_objets, hp) VALUES
(200, 150),
-- Pour la Potion de Vie
(201, 100),

-- Pour la Potion de Mana
(202, 0),

-- Pour l'Eau de source

(204, 15);

-- Ressources
INSERT INTO objets (idobjets, nom, type) VALUES
(300, 'Blé', 'Ressource'),
(301, 'Fer', 'Ressource'),
(302, 'Bois', 'Ressource'),
(303, 'Cuivre', 'Ressource'),
(304, 'Or', 'Ressource'),
(305, 'Pierre précieuse', 'Ressource'),
(306, 'Eau de source', 'Ressource'),
(307, 'Ortie', 'Ressource'),
(308, 'Poudre de Perlinpainpain', 'Ressource');

INSERT INTO ressources(fk_objets) VALUES
(300),
(301),
(302),
(303),
(304),
(305),
(306),
(307),
(308);

-- Métiers
INSERT INTO metiers(idmetiers, nom) VALUES
(0, 'Paysan'),
(1, 'Alchimiste');

INSERT INTO recettes(idrecettes, consommables_fk_objets, metier_fk) VALUES
(0, 204, 0), --Recette pain Incarnam -- paysan
(1, 201, 1); --Potion de vie -- alchimiste

INSERT INTO ressources_has_recettes(ressources_fk_objets, recettes_idrecettes) VALUES
-- Le pain d'Incarnam a comme ingrédient eau de source et blé
(300, 0),

(306, 0),
-- Potion de vie : poudre perlinpainpain + eau
(306, 1),
(308, 1);
-- personnages

INSERT INTO inventaire(idinventaires, taillemax) VALUES
(0, 50),
(1, 60),
(2, 150);
INSERT INTO personnages(idpersonnages, nom, hp, exp, argent, force, dex, intel, fk_inventaire, fk_archetypes, fk_metier) VALUES
(0, 'Rafou', 42, 150, 200, 5, 10, 15, 0, 1, 0),
(1, 'Sinaf19', 42, 300, 100, 5, 10, 15, 1, 2, 0),
(2, 'Sainane', 3, 450, 150, 5, 1, 15, 2, 3, 1);

-- Equipement des personnages
INSERT INTO slots(idslots, type_equipement, fk_personnage, fk_equipements) VALUES
(0, 'Bottes', 2, 100);

-- Objet dans inventaire
INSERT INTO estdansinventaire(objets_idobjets, inventaires_idinventaires) VALUES
(300, 2),
(102, 2),
(200, 2);
