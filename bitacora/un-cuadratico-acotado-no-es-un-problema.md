---
name: un-cuadratico-acotado-no-es-un-problema
description: Cuando un O(n²) esté anotado como deuda o una proyección de crecimiento parezca alarmante. Antes de optimizar, averiguar si su n está acotada por una ventana.
origen: Sin Ruido
skill: medir-antes-de-resolver
---

`agrupar_pendientes` compara cada noticia suelta contra todas las demás. Está
anotado como deuda desde el principio: **3,6 s con ~200 sueltas, proyectado ~14 s
con 400 y cerca de un minuto con 800.** Un cuadrático de manual.

Medido el 12/09/2026, después de sumar cuatro medios —incluido el generalista
más grande del país, que entró con 95 noticias de una—: **1,33 s.**

## Por qué no creció

Hay **6.980 noticias sueltas** en la base y el agrupamiento evalúa **369**. Sólo
mira la ventana de clusters abiertos (12 h en este proyecto). El costo es
cuadrático **sobre la ventana, no sobre la base**, así que no crece con el
tiempo: crece con cuántas noticias entran en esas 12 horas.

Eso es un **cuadrático acotado por diseño**, y cambia por completo qué hay que
vigilar. La proyección original —"con 800 sueltas tarda un minuto"— nunca iba a
cumplirse, porque nunca va a haber 800 en la ventana con este roster.

## El driver no es el que parece

El costo por noticia depende de si encontró con quién juntarse: `_mejor_match`
sale por un `return` temprano si algún cluster pasa el umbral, así que **el
driver es cuántas no matchean, no cuántas hay**. Hoy fue el peor caso: 369
evaluadas, 369 sin match. Eso tiene nota propia porque aplica fuera de acá —
[[el-driver-del-costo-es-la-salida-temprana]].

**Y esas huérfanas se reevalúan en cada corrida**, a propósito: una nota que hoy
no matcheó puede matchear cuando otro medio cubra el hecho. Con una ventana de
12 h eso son **48 corridas**: la misma huérfana comparada contra las mismas
huérfanas hasta 48 veces. Si el número llegara a doler, **la salida más barata no
es el índice sino no recomparar lo que ya se comparó contra el mismo conjunto**,
y eso no cuesta exactitud.

## El criterio, para no re-discutirlo

Lo que hace re-medir: **>1.000 sin match** por corrida, o el agrupamiento pasando
de **60 s** dentro de un ciclo de 15 minutos. Y uno que no es de tiempo:
**ampliar la ventana** —duplicar las horas cuadruplica el trabajo— hay que
re-medirlo aunque no se sume un solo medio.

Los umbrales completos de este proyecto viven en su `specs/roadmap.md`, punto 4.
Acá no se copian: dos tablas de umbrales derivan.

## El arreglo "obvio" no es gratis

La salida anotada es un índice HNSW/IVFFlat. Son **aproximados**: cambian
exactitud por velocidad, y acá un match perdido es una síntesis que no se publica
y de la que nadie se entera. Tiene nota propia —
[[un-indice-aproximado-cambia-exactitud-por-velocidad]].

## Lo transferible

**Antes de optimizar un cuadrático, averiguá si su n está acotada.** Un O(n²)
sobre 300 elementos fijos es más rápido y mucho más simple que un índice
aproximado. El patrón aparece en todo lo que compara cosas entre sí:
deduplicación, detección de fraude, *record linkage*, "productos similares".

Y las dos preguntas que lo resuelven en un minuto: *¿la n de esta comparación es
el total, o una ventana?* y *¿todos los elementos pagan el costo completo, o hay
una salida temprana que se toma la mayoría?* Si es una ventana, la deuda es mucho más chica de lo que
parece — y el número que hay que vigilar es otro.

Ver [[medir-tumba-el-propio-diseno]], [[como-elegir-un-agrupamiento]] y
[[el-driver-del-costo-es-la-salida-temprana]].
