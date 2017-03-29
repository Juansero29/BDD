SET echo off
SET verify off

DROP TABLE TLIGNES PURGE;
CREATE TABLE TLIGNES (
  lignes VARCHAR2(2000)
);

VARIABLE vNoClient CHAR(4);

SELECT *
FROM TCLIENT2017;

PROMPT Taper le numero du client a supprimer
ACCEPT vNoClient;

DECLARE
  dNoClient  CHAR(4) := '&vNoClient';
  dNoClient2 CHAR(4) := NULL;
  dCpt       NUMBER := 0;
  dMsg       VARCHAR2(200);

    client_inex EXCEPTION;
    location_cours EXCEPTION;

BEGIN
  SELECT NOCLIENT
  INTO dNoClient2
  FROM TCLIENT2017
  WHERE NOCLIENT = dNoClient;

  IF dNoClient IS NULL
  THEN RAISE client_inex;
  END IF;

  SELECT COUNT(*)
  INTO dCpt
  FROM TLOCATION2017
  WHERE NOCLIENT = dNoClient;

  IF dCpt > 0
  THEN RAISE location_cours;
  END IF;

  SELECT COUNT(*)
  INTO dCpt
  FROM TLOCATRETOUR2017
  WHERE NOCLIENT = dNoClient;

  DELETE FROM TLOCATRETOUR2017
  WHERE NOCLIENT = dNoClient;


  INSERT INTO TLIGNES VALUES (dCpt || '  locations retournees ont ete supprimees');


  DELETE FROM TCLIENT2017
  WHERE NOCLIENT = dNoClient;

  INSERT INTO TLIGNES VALUES ('Le client a bien ete supprime');


  EXCEPTION
  WHEN client_inex THEN INSERT INTO TLIGNES VALUES ('Client inconnu. ');
  WHEN location_cours THEN INSERT INTO TLIGNES VALUES ('Des locations sont en cours: suppression impossible');

END;
/
SELECT *
FROM tlignes;

SET echo on;
SET verify on;