---
name: verificar-de-verdad
description: Correr el check que nunca corrió sobre este estado, en vez de razonar que sería equivalente; y no re-correr el que ya corrió sobre el mismo contenido. Usar antes de reportar un trabajo como terminado, antes de un commit o un push, y cuando un paso de verificación falló, se colgó o se salteó.
---

La pregunta no es "¿el árbol es el mismo?" sino **"¿el check llegó a correr sobre este estado?"**. Son distintas más seguido de lo que parece, y la diferencia manda en las dos direcciones.

## De menos: correlo

Si un paso de verificación **falló, se colgó o se salteó**, hay que levantar lo que haga falta y correrlo. Nunca sustituirlo por un razonamiento de equivalencia, por sólido que parezca.

El caso que fija la regla: un `alembic check` se colgó porque la base estaba caída, y el argumento fue que no hacía falta re-correrlo porque el árbol era byte-idéntico a otro donde ya había pasado. Estaba mal por dos motivos. El check nunca había corrido —se colgó, no pasó— y además **no compara archivos: compara contra el esquema vivo de la base**, que un árbol idéntico no prueba.

Ahí está el patrón general: los checks que miran algo **fuera del árbol** —una base, un servicio, la red, el entorno— no se pueden deducir del árbol nunca.

## De más: no lo repitas

Si el check **ya corrió sobre este mismo contenido** y lo único que cambió desde entonces es documentación, un README o un string de versión, volver a correrlo es ceremonia. Decilo y seguí.

## En el reporte: separá lo corrido de lo deducido

Es la parte que hace que todo lo anterior sirva. Al reportar, que se distinga siempre:

- **Lo que corrió**, con su resultado: `712 tests`, `ruff limpio`, `alembic check sin operaciones pendientes`.
- **Lo que no corrió, y por qué no hacía falta**: "no re-corrí la suite porque desde que pasó no cambió una línea de código, solo el roadmap".

Escrito así, quien lee decide si está de acuerdo. Escrito como un "verificado" a secas, no puede.

## Lo irreversible tiene su propia barra

Antes de una operación que no se deshace —un borrado, una migración con datos cargados, una entrega ya firmada— no alcanza con la suite: va la corrida en seco contra los datos reales y el respaldo tomado y **verificado que se puede restaurar**. Un backup que nadie probó a leer es una suposición, no un respaldo.
