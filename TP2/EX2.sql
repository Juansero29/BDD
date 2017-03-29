SET echo off
SET verify off

DROP TABLE TLIGNES PURGE;
CREATE TABLE TLIGNES (
  lignes VARCHAR2(2000)
);

VARIABLE vNoClient char(4);

SELECT *
FROM TCLIENT2017;

PROMPT Taper le numero du client dont vous voulez connaitre la liste des locations en cours
ACCEPT vNoClient;
DECLARE
  dNoClient  CHAR(4);
  dNoCat     CHAR(4);
  dNoVeh     CHAR(5);
  dDateDebut DATE;
  dModele    VARCHAR2(30);
  dCpt       NUMBER := 0;

  dMsg       VARCHAR2(100);
  CURSOR C IS SELECT
                NOCAT,
                L.NOVEH,
                DATEDEB,
                MODELE
              FROM TLOCATION2017 L, TVEHICULE2017 V
              WHERE L.NOVEH = V.NOVEH
              ORDER BY 1, 2;


BEGIN

  dNoClient := '&vNoClient';
  dMsg := 'Le client saisi n''existe pas';
  SELECT NOCLIENT
  INTO dNoClient -- Check that it's possible to insert the values into the variable being used in the 'where' instruction.
  FROM TCLIENT2017
  WHERE NOCLIENT = dNoClient;

  OPEN C;
  FETCH C INTO dNoCat, dNoVeh, dDateDebut, dModele;
  IF C%NOTFOUND
  THEN INSERT INTO tlignes VALUES ('Pas de location en cours pour ce client');
  ELSE
    WHILE C%FOUND
    LOOP
      INSERT INTO tlignes VALUES (dNoCat || '  ' || dNoVeh || '  ' || dDateDebut || '  ' || dModele);
      FETCH C INTO dNoCat, dNoVeh, dDateDebut, dModele;
      dCpt := dCpt + 1;
    END LOOP;

  END IF;

  CLOSE C;

  INSERT INTO TLIGNES VALUES ('Nombre de locations en cours:  ' || dCpt);

  EXCEPTION
  WHEN NO_DATA_FOUND THEN INSERT INTO TLIGNE VALUES (dMsg);

END;
/
SELECT *
FROM tlignes;

SET echo on;
SET verify on;