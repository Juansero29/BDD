DROP   TABLE   Tlocatretour2017;
DROP   TABLE   Tlocation2017;
DROP   TABLE   Tvehicule2017;
DROP   TABLE   Tremplacement2017;
DROP   TABLE   Tcategorie2017;
DROP   TABLE   Tclient2017;

CREATE   TABLE   Tclient2017
(
noclient		CHAR(4)	PRIMARY KEY,
nom	VARCHAR2(80)	NOT NULL, 
ville	VARCHAR2(80)	NOT NULL,
postal  VARCHAR2(5)     NOT NULL
);


CREATE   TABLE  Tcategorie2017
(
nocat		CHAR(4)	        PRIMARY KEY,
libelle		VARCHAR2(20)	NOT NULL
);

CREATE   TABLE  Tremplacement2017
(
nocat		CHAR(4)	references Tcategorie2017,
nocatequi	CHAR(4)	references Tcategorie2017,
primary key ( nocat,nocatequi)
);

CREATE   TABLE   Tvehicule2017
(
noveh char(5) primary key,
immat char(10) not null,
modele varchar2(30) not null,
couleur varchar2(30) not null,
kilometrage number not null,
nocat CHAR(4) not null references Tcategorie2017
);


CREATE   TABLE	   TLOCATION2017
(
noclient  CHAR(4) references Tclient2017 not null,
noveh char(5) primary key references tvehicule2017,
datedeb date not null,
dateretprev date not null,
kmdeb number not null 
);

CREATE   TABLE	   Tlocatretour2017
(
noclient  CHAR(4) references Tclient2017 not null,
noveh char(5) not null references tvehicule2017,
datedeb date not null,
kmdeb number not null, 
kmfin number not null,
dateretour date not null,
primary key (noveh,datedeb),
check(dateretour>datedeb),
check(kmfin>kmdeb) 
);

insert into Tclient2017 values ('C001','Dupond','Clermont Fd','63000');
insert into Tclient2017 values ('C002','Martin','Aubiere','63170');
insert into Tclient2017 values ('C003','Dutour','Clermont Fd','63000');

insert into Tcategorie2017 values ('CAT1','legere 1');
insert into Tcategorie2017 values ('CAT2','legere 2');
insert into Tcategorie2017 values ('CAT3','monospace 1');
insert into Tcategorie2017 values ('CAT4','monospace 2');

insert into Tremplacement2017 values ('CAT1','CAT2');
insert into Tremplacement2017 values ('CAT3','CAT4');

insert into Tvehicule2017 values ('VE001','aa-2000-za','clio 3','noire',26500,'CAT1');
insert into Tvehicule2017 values ('VE002','bb-3000-za','308','blanche',20000,'CAT2');
insert into Tvehicule2017 values ('VE003','cc-4000-za','clio 3','noire',5000,'CAT2');
insert into Tvehicule2017 values ('VE004','dd-5000-za','308','grise',1200,'CAT1');
insert into Tvehicule2017 values ('VE005','ff-6000-za','Picasso','noire',6600,'CAT3');

insert into Tlocation2017 values ('C001','VE001','30-01-2017','5-02-2017',26500);
insert into Tlocation2017 values ('C001','VE002','28-01-2017','7-02-2017',20000);
insert into Tlocation2017 values ('C002','VE003','29-01-2017','10-02-2017',5000);

insert into Tlocatretour2017 values ('C001','VE001','30-12-2016',24500,25000,'5-01-2017');
insert into Tlocatretour2017 values ('C002','VE001','6-01-2017',25000,26500,'10-01-2017');
insert into Tlocatretour2017 values ('C001','VE002','30-12-2016',18500,20000,'5-01-2017');
insert into Tlocatretour2017 values ('C003','VE003','30-11-2016',1500,2500,'5-12-2016');
insert into Tlocatretour2017 values ('C002','VE003','10-12-2016',2500,5000,'15-12-2016');