set echo off
set verify off
set feed off

drop table tligne purge;
create table tligne (ligne varchar2(200));

variable vnoClient char(4);

prompt    Taper le numero de client;
accept vNoClient

declare
dNoClient char(4) := '&vNoClient';
dNoVehicule char(5);
dCompteur number := 0;

begin

  select noVeh into dNoVehicule from  Tvehicule2017
  where dNoClient = noClient;
  insert into tLigne values ('Numero de Vehicule: ' || dNoVehicule));
  
  select count(*) into dCompteur from TLocation2017 
  where dNoClient = noClient;
  
  if dCompteur > 1
  then insert into tligne values ('Plusieurs locations en cours pour ce client');
  else
    insert into tligne values ('Numero du vehicule : ' || dNoVehicule);
  end if;
  exception
  when no_data_found insert into tligne values ('Le client n''a pas loué de vehicule');
  
end;
./

select * from tLigne;

set feed on;
set verify on;
set echo on;
