set search_path to rpg;

------------------------------------------------------------------------------------------------------------------------
--Make view to see all the equipments that our characters have
create or replace view inventory_view
as select objets.nom, objets.type, count(objets.idobjets) as nombre, estdansinventaire.inventaires_idinventaires
from estdansinventaire
join objets on estdansinventaire.objets_idobjets = objets.idobjets
group by objets.nom, objets.type, estdansinventaire.inventaires_idinventaires;

--Function to avoid to the select request on the view every time we want to see the inventory of a character
create or replace function character_inventory(character_id INTEGER)
RETURNS TABLE(nom VARCHAR, nombre BIGINT, type VARCHAR)
AS $$
BEGIN
    RETURN QUERY
    SELECT iv.nom, iv.nombre, iv.type
    FROM inventory_view as iv
    JOIN personnages p ON iv.inventaires_idinventaires = p.fk_inventaire
    WHERE p.idpersonnages = character_id;
END;

$$ language 'plpgsql';

--Select to see the inventory of a character
SELECT * FROM character_inventory(2);

------------------------------------------------------------------------------------------------------------------------
--Function to see the slot of a character
create or replace function character_slot(character_id INTEGER)
RETURNS TABLE(type_equipement VARCHAR(45), nom_personnage VARCHAR) AS
$$
BEGIN
    RETURN QUERY
    SELECT  s.type_equipement, p.nom
    FROM slots s
    JOIN personnages p ON s.fk_personnage = p.idpersonnages
    WHERE p.idpersonnages = character_id;
END;
$$ language 'plpgsql';

--Select to see the slot of a character
SELECT * FROM character_slot(2);

------------------------------------------------------------------------------------------------------------------------
--TODO: doesn't work yet
--Function to create a new inventory for a new character
create or replace function before_insert_character()
    returns trigger as
$$
declare new_idinventaires int;
begin
    insert into inventaire (taillemax) values (10) returning idinventaires into new_idinventaires;

    return new.fk_inventaire = new_idinventaires;
end;
$$ language 'plpgsql';


--Trigger to create a new inventory for a new character
create or replace trigger before_create_character
    before insert on personnages
    for each row
    execute function  before_insert_character();
--It's missing the fk_inventaire in the insert statement to see the result. A new inventory is created but not the character
insert into personnages (nom, hp, exp, argent, force, dex, intel,  fk_archetypes, fk_metier) values ('Edwinou ',2, 50, 10000, 10, 5, 50,10,0) returning *;
------------------------------------------------------------------------------------------------------------------------

-- insert elements in the table estdansinventaire to see if the view is working
INSERT INTO estdansinventaire(objets_idobjets, inventaires_idinventaires) VALUES
(300, 2),
(300, 2);

------------------------------------------------------------------------------------------------------------------------

