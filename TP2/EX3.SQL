SET echo off
SET verify off

DROP TABLE TLIGNES PURGE;
CREATE TABLE TLIGNES (
  lignes VARCHAR2(2000)
);

DECLARE
  dNoCat CHAR(4);
  dCmpt NUMBER := 0;

  CURSOR C IS SELECT NOCAT, COUNT(*) FROM TVEHICULE2017 GROUP BY NOCAT;
BEGIN
  OPEN C;
  FETCH C INTO dNoCat, dCmpt;
  IF C%NOTFOUND
  THEN INSERT INTO tlignes VALUES ('Pas de location en cours pour ce client');
  ELSE
    WHILE C%FOUND
    LOOP
      INSERT INTO tlignes VALUES (dNoCat || '  ' || dCmpt);
        FETCH C INTO dNoCat, dCmpt;
    END LOOP;

  END IF;
END;

/
SELECT *
FROM tlignes;

SET echo on;
SET verify on;