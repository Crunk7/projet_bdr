/*
10 euros -> 10 points de fidélité
Ainsi tous les  10 euros de commande le client a droit à 10 points de fidélités
*/

create or replace function fidelite()
  returns TRIGGER
  as $$
  declare
  begin

  end;
  $$ language plpgsql;


CREATE TRIGGER tri_fidelite
AFTER INSERT ON Commande
FOR EACH ROW
EXECUTE PROCEDURE fidelite();
