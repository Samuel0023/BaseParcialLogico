
%originarioDe(Genero,Pais).
originarioDe(tango, argentina).
originarioDe(chacarera, argentina).
originarioDe(enka, japon).
originarioDe(deathMetalMelodico, suecia).
originarioDe(celta, europaOccidental).
originarioDe(popLatino, latinoamerica).


%pais(Pais,Region).
pais(noruega, escandinavia).
pais(dinamarca, escandinavia).
pais(suecia, escandinavia).
pais(suecia, europaOccidental).
pais(alemania, europaOccidental).
pais(argentina, latinoamerica).
pais(colombia, latinoamerica).
pais(argentina, tercerMundo).

%produccion(Artista, Trabajo)
produccion(piazzolla, disco(tango,10,acmeMusic)). 
produccion(goyeneche, disco(tango,10,acmeMusic)). 
produccion(leonGieco, disco(rock, 12, utnMusic)).
produccion(darkTranquility, recital(argentina, [deathMetalMelodico, celta])).
produccion(faun, disco(folk, 45, deustcheMusic)).
produccion(faun, homenaje(goyeneche)).
produccion(sayuriIshikawa, homenaje(mercedesSosa)).
produccion(sayuriIshikawa, recital(japon, [enka])).
produccion(shakira, disco(popLatino, 10, antonitoMusic)).
produccion(shakira, disco(popLatino, 5, piqueMusic)).
produccion(mercedesSosa, disco(chacarera, 20, acmeMusic)).

%artista(Artista, Pais)
artista(piazzolla, argentina).
artista(leonGieco, argentina).
artista(darkTranquility, suecia).
artista(faun, alemania).
artista(sayuriIshikawa, japon).
artista(shakira, colombia).
artista(mercedesSosa, argentina).
artista(goyeneche, polonia). %sic

%discografica(Discografica,Pais)
discografica(utnMusic, argentina).
discografica(deustcheMusic, alemania).
