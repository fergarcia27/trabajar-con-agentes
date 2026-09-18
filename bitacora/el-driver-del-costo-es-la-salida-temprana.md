---
name: el-driver-del-costo-es-la-salida-temprana
description: Cuando midas el costo de un bucle que compara cosas entre sí y quieras saber qué lo hace crecer. Si hay un `return` temprano, el driver no es cuántos elementos entran sino cuántos NO encuentran match y pagan el recorrido completo.
origen: Sin Ruido
skill: medir-antes-de-resolver
---

`_mejor_match` hace dos loops, y el segundo tiene una salida temprana adelante:

    1. contra el centroide de cada cluster abierto     -> O(C), barato
    2. SI NINGUNO paso el umbral, contra cada suelta   -> O(S), el cuadratico

**El costo por elemento depende de si encontró con quién juntarse.** Uno que
matchea cuesta O(C) y se va; un huérfano paga el loop completo.

Eso invierte la intuición de qué hay que vigilar. El driver no es la cantidad de
fuentes: es **cuántos elementos no matchean con nada**. Sumar medios que cubren
los mismos hechos **abarata** el agrupamiento —más salidas tempranas—; sumar
medios de nicho lo encarece.

Medido el 12/09/2026, en el peor caso posible: **369 evaluadas, 369 sin match**.
Ninguna salió por el camino barato, así que se pagaron unos 68.000 productos
punto — casi todo el 1,33 s de la corrida.

## Lo transferible

**En un bucle con salida temprana, la métrica que predice el costo no es el
tamaño de la entrada: es la tasa de fallo.** Y son dos números distintos que
suelen moverse en direcciones opuestas — acá, más datos del tipo correcto
**bajan** el costo.

Antes de proyectar el crecimiento de algo así, preguntá: *¿qué fracción toma la
salida temprana hoy, y qué la haría bajar?* Proyectar sobre el total es proyectar
sobre la variable equivocada.

Aparece en cualquier búsqueda con corte: cachés (la tasa de miss, no la de
request), validaciones en cadena, deduplicación, *rate limiting*.

Ver [[un-cuadratico-acotado-no-es-un-problema]], de donde salió este caso, y
[[como-elegir-un-agrupamiento]].
