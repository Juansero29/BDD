set echo off
set verify off
set feed off

drop table tligne purge;
create table tligne (ligne varchar2(200));

variable vnoVehicule char(5);

prompt    Taper le numero de vehicule recherche:
accept vnoVehicule

declare
dnoVehicule char(5) := '&vnoVehicule';
dImmat char(10);
dModele varchar2(30);
dCompteur number := 0;
dNomClient VARCHAR2(80);


begin
  select count(*) into dCompteur from Tvehicule2017
  where dnoVehicule = noveh;
  
  if dCompteur = 0
    then insert into tligne values ('Le vehicule n''existe pas');
  else
    select immat, modele into dImmat, dModele from  Tvehicule2017
    where dnoVehicule = noveh;
    dCompteur := 0;
    select count(*) into dCompteur from TLocation2017 
    where dnoVehicule = noveh;
    
    insert into tLigne values ('Immatriculation: ' || dImmat || 'Modèle: ' || to_char(dModele));
    
    if dCompteur = 1
    then 
      select C.nomClient into dNomClient from TLocation2017 L, TClient2017 C
      where C.noclient = L.noclient and L.noveh = dnoVehicule;
      insert into tLigne values ('Client: ' || dNomClient); 
    end if;
  end if;
end;
./

select * from tLigne;

set feed on;
set verify on;
set echo on;






































