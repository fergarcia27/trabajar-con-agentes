---
name: el-desempate-importa-mas-que-el-umbral
description: Cuando un agrupamiento incremental fragmente el mismo hecho en varios grupos, o cuando la reacción sea mover el umbral de similitud. Antes de tocar el umbral, revisar el criterio de desempate entre candidatos.
origen: Sin Ruido
skill: medir-antes-de-resolver
---

Sin Ruido agrupa noticias comparando cada una contra los clusters abiertos y
contra las sueltas. La primera versión se quedaba con **el mejor candidato
global**.

El resultado: una noticia suelta casi idéntica (0,96 de similitud) le ganaba a un
cluster que ya era un match válido (0,87), y nacía **un cluster paralelo del
mismo hecho**.

Cambiar la regla a *"un cluster que supera el umbral le gana a cualquier suelta"*
llevó, el mismo día, de **50 clusters con 19 pares para fusionar a 26 sin
ninguno**.

**Mismo algoritmo, mismo umbral, mismos datos. Sólo el desempate.**

## Y fusionar después es el parche, no el arreglo

La reacción natural a la fragmentación es un paso de fusión posterior. Eso trata
el síntoma: la causa estaba en el criterio de asignación, y un paso de fusión
agrega una segunda heurística que también hay que calibrar.

## Lo transferible

En cualquier asignación incremental —agrupar, rutear, asignar a colas, elegir un
shard— hay dos decisiones distintas que se confunden en una:

- **El umbral**: ¿esto es lo bastante parecido?
- **El desempate**: entre varios que pasan, ¿cuál gana?

El umbral es el que se toca siempre porque es un número visible en la config. El
desempate suele estar implícito en un `max()` o en el orden de un loop, no tiene
nombre, y **es el que decide la forma del resultado**. Si el resultado está
fragmentado o duplicado, mirá ahí antes que al número.

Ver [[como-elegir-un-agrupamiento]], de donde salió este caso, y
[[auditar-contra-la-fuente-no-el-titulo]], que salió de diagnosticar justamente
estos clusters mirando títulos en vez de cuerpos.
