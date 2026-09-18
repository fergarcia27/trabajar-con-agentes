---
name: un-indice-aproximado-cambia-exactitud-por-velocidad
description: Antes de aceptar un índice vectorial aproximado (HNSW, IVFFlat) o cualquier estructura que acelere buscando menos, para decidir si el producto tolera perder resultados. Si el match perdido no genera error, la degradación es invisible.
origen: Sin Ruido
skill: medir-antes-de-resolver
---

La salida anotada para el cuadrático del agrupamiento era un índice HNSW o
IVFFlat de pgvector. Suena a decisión de rendimiento y es una decisión de
producto.

**Esos índices son aproximados**: no recorren todo, así que pueden no encontrar
un vecino que existe. Cambian exactitud por velocidad, y eso está bien en muchos
dominios.

Acá no. En un motor cuyo producto es decir *"estos medios cubrieron el mismo
hecho"*, **perder un match no es lentitud: es una síntesis que no se publica**.
Y nadie se entera — no hay excepción, no hay log, no hay diferencia visible entre
"ningún otro medio lo cubrió" y "el índice no lo encontró".

## Lo transferible

**Un fallo que no produce error es más caro que uno que sí**, porque no tiene
quien lo reporte. Antes de aceptar cualquier estructura que acelere buscando
menos —índice aproximado, muestreo, caché con expiración, *bloom filter*—:

1. *¿Cómo se ve un falso negativo desde el producto?* Si se ve igual que un
   verdadero negativo, la degradación es invisible.
2. *¿Cuánta exactitud se pierde?* Es un número que hay que medir, no un supuesto.
   El índice no es gratis ni siquiera cuando haga falta.
3. *¿Se puede detectar después?* Correr lo exacto en batch y comparar contra lo
   aproximado convierte una pérdida invisible en una métrica.

Ver [[un-cuadratico-acotado-no-es-un-problema]] para por qué acá el índice
todavía no hace falta.
