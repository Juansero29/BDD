SET echo off
SET verify off

DROP TABLE tlignes PURGE;
CREATE TABLE tlignes (
  lignes VARCHAR2(500)
);

VARIABLE vNoCat char(4);

SELECT *
FROM tVehicule2017;

PROMPT Saisir le numero de la categorie
ACCEPT vNoCat

DECLARE
  dMsg     VARCHAR2(100);
  dNoCat   CHAR(4) := '&vNoCat';
  dNoCat2  CHAR(4);
  dNoVeh   CHAR(5);
  dImmat   CHAR(10);
  dCouleur VARCHAR2(30);
  dModele  VARCHAR2(30);
  CURSOR cur IS SELECT
                  noVeh,
                  immat,
                  couleur,
                  modele
                FROM Tvehicule2017
                WHERE noCat = '&vNoCat' AND noVeh NOT IN (SELECT noVeh
                                                          FROM tLocation2017);

BEGIN

  dMsg := 'Cette catégorie est inconnue';
  SELECT NOCAT
  INTO DNOCAT2
  FROM tCategorie2017
  WHERE noCat = dNoCat;

  OPEN cur;
  FETCH cur INTO dNoVeh, dImmat, dCouleur, dModele;

  IF cur%NOTFOUND
  THEN INSERT INTO tlignes VALUES ('Pas de véhicules libres dans cette catégorie');
  ELSE

    WHILE cur%FOUND
    LOOP
      INSERT INTO tlignes VALUES (dNoVeh || '  ' || dImmat || '  ' || dCouleur || '  ' || dModele);
      FETCH cur INTO dNoVeh, dImmat, dCouleur, dModele;
    END LOOP;

  END IF;

  CLOSE cur;

  EXCEPTION
  WHEN NO_DATA_FOUND THEN INSERT INTO tlignes VALUES (dMsg);

END;
/
SELECT *
FROM tlignes;

SET echo on;
SET verify on;