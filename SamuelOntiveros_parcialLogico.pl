%originarioDe(Genero,Pais).
originarioDe(tango,argentina).
originarioDe(chacarera, argentina).
originarioDe(enka, japon).
originarioDe(deathMetalMelodico, suecia).
originarioDe(celta, europaOccidental).
originarioDe(popLatino, latinoamerica).
originarioDe(edm,tomorrowland).
originarioDe(house,tomorrowland).
originarioDe(futureHouse,tomorrowland).
originarioDe(trance,suecia).
%pais(Pais,Region).%
pais(noruega, escandinavia).
pais(dinamarca, escandinavia).
pais(suecia, escandinavia).
pais(suecia, europaOccidental).
pais(alemania, europaOccidental).
pais(argentina, latinoamerica).
pais(colombia, latinoamerica).
pais(argentina, tercerMundo).
pais(tomorrowland,europaOccidental).

%produccion(Artista, Trabajo)
produccion(piazzolla, disco(tango,10,acmeMusic) ). 
produccion(goyeneche, disco(tango,10,acmeMusic) ). 
produccion(leonGieco, disco(rock, 12, utnMusic)).
produccion(darkTranquility, recital(argentina, [deathMetalMelodico, celta])).
produccion(faun, disco(folk, 45, deustcheMusic)).
produccion(faun, homenaje(goyeneche)).
produccion(sayuriIshikawa, homenaje(mercedesSosa)).
produccion(sayuriIshikawa, recital(japon, [enka])).
produccion(shakira, disco(popLatino, 10, antonitoMusic)).
produccion(shakira, disco(popLatino, 5, piqueMusic)).
produccion(mercedesSosa, disco(chacarera, 20, acmeMusic)).
produccion(hardwell,disco(edm,2,revelatedRecords)).
produccion(dimitri,homenaje(hardwell)).
produccion(hardwell,recital(tomorrowland,[futureHouse,trance])).
%artista(Artista, Pais)
artista(hardwell,tomorrowland).
artista(dimitri,tomorrowland).
artista(piazzolla, argentina).
artista(leonGieco, argentina).
artista(darkTranquility, suecia).
artista(faun, alemania).
artista(sayuriIshikawa, japon).
artista(shakira, colombia).
artista(mercedesSosa, argentina).
artista(goyeneche, polonia). %sic

%discografica(Discografica,Pais).
discografica(utnMusic, argentina).
discografica(deustcheMusic, alemania).
discografica(revelatedRecords,tomorrowland).
%PredicadosAuxliares
generoDisco(disco(Genero,_,_),Genero).
discoGraficaDisco(disco(_,_,Discografica),Discografica).
cantTemasDisco(disco(_,Temas,_),Temas).

generoRecital(recital(_,Genero),Genero).
paisRecital(recital(Pais,_),Pais).

artistaHomenaje(homenaje(Artista),Artista).






%1.
seEscuchaEn(Genero,Pais):-
	esPropio(Genero,Pais).

esPropio(Genero,Pais):-
	originarioDe(Genero,Pais).

esPropio(Genero,Pais):-
	pais(Pais,Region),
	originarioDe(Genero,Region).




%2
fomentaSuCultura(Artista,Pais):-
	pais(Pais,_),
	produccion(Artista,Trabajo),
	generoDisco(Trabajo,Genero),
	seEscuchaEn(Genero,Pais).

fomentaSuCultura(Artista,Pais):-
	pais(Pais,_),
	produccion(Artista,Trabajo),
	esRealizadaEn(Pais,Trabajo).

fomentaSuCultura(Artista,Pais):-
	pais(Pais,_),
	produccion(Artista,Trabajo),
	remita(Pais,Trabajo).

esRealizadaEn(Pais,recital(_,GenerosRecital)):-
	member(Genero,GenerosRecital),
	seEscuchaEn(Genero,Pais).

esRealizadaEn(Pais,disco(_,_,Discografica)):-
	discografica(Discografica,Pais).


remita(Pais,homenaje(Artista)):-
	artista(Artista,PaisNatal),
	Pais == PaisNatal.





%3
paisMultiCultural(Pais):-
	variedadDeGeneros(Pais),
	forall(esPropio(Genero,Pais),not(noExisteArtistaCompone(Pais,Genero))).

variedadDeGeneros(Pais):-
	pais(Pais,_),
	findall(Genero,esPropio(Genero,Pais),ListaDeGeneros),
	length(ListaDeGeneros,CantDeGeneros),
	CantDeGeneros > 3.

	
noExisteArtistaCompone(Pais,Genero):-
	not((artista(Artista,Pais),produccion(Artista,Trabajo),esGenero(Trabajo,Genero))).

esGenero(homenaje(Artista),GeneroNacional):-
	artista(Artista,PaisHomenajeado),
	esPropio(GeneroNacional,PaisHomenajeado).

esGenero(recital(_,GenerosRecital),GeneroNacional):-
	member(GeneroNacional,GenerosRecital).

esGenero(disco(Genero,_,_),GeneroNacional):-
	Genero == GeneroNacional.

%4

referenteMusical(Pais,OtroPais):-
	
	pais(Pais,_),esPropio(_,Pais),
	pais(OtroPais,_),esPropio(_,OtroPais),
	Pais \= OtroPais,
	forall(esPropio(Genero,Pais),esPropio(Genero,OtroPais)),
	esPropio(OtrogGenero,OtroPais),
	not(esPropio(OtrogGenero,Pais)).




%a.fomentaSuCultura(Artista,argentina).
%	Artista=piazzolla;
%	Artista=goyeneche;
%	Artista=shakira;
%	Artista=shakira;
%	Artista=mercedesSosa;
%	Artista=leonGieco;
%	Artista=sayuriIshikawa;
%	False
%	
%	fomentaSuCultura(shakira,Pais).
%	Pais=argentina;
%	Pais=argentina;
%	Pais=colombia;
%	Pais=argentina;
%	Pais=argentina;
%	False
%esIrreversible.
	

%b.en el puntode fomentaSuCultura , se encuentra el predicado
%	esRealizadaEn que relaciona un un pais y un trabajo de un artista.
%	en ese punto hice el uso de polimorfismo , para que si en algun momento deba 
%	ingresar nuevos tipos de trabajo que se relacionen con el Pais, no tenga que 
%	crear otro predicado Auxiliar, directamente una variante del mismo.


%c.si bien la banda es originaria de Argentina, pero ese hecho no lo hemos
%  declarado , entonces no pertenece al universo cerrado que hemos determinado.
%  por ende , cuando hagamos esa consulta , directamente nos dara falso porque
%  rataBlanca no pretenece al universo cerrado de artistas.