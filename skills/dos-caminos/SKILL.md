---
name: dos-caminos
description: Ante una decisión de diseño no trivial, presentar dos caminos genuinamente distintos con sus contras honestos y cerrar con una recomendación propia. Usar antes de comprometerse con un enfoque, cuando hay más de una forma razonable de resolver algo.
---

La primera propuesta suele ser la más obvia, no la mejor. Ponerla al lado de otra obliga a explicitar los supuestos que la primera escondía. Está medido: de tres veces que se hizo esto en una misma sesión, **las tres cambiaron la decisión para mejor** — y en una de ellas la alternativa eliminaba un acoplamiento que la propuesta original creaba.

No es indecisión. Es cómo se ve el espacio de decisión y no solo la conclusión.

## Dos caminos, no dos variantes

Dos versiones del mismo enfoque con un parámetro distinto no son dos caminos: son uno. Los caminos tienen que diferir en **el supuesto de fondo**, no en el detalle.

- Variantes del mismo camino: "caché con TTL de 5 minutos" contra "caché con TTL de 1 hora".
- Caminos distintos: "caché con TTL por reloj" contra "caché atada a la corrida, que se limpia sola al terminar".

Si al escribir el segundo camino te sale una copia del primero con otro número, todavía no encontraste el segundo.

## Qué lleva cada uno

- **El contra honesto.** No el contra decorativo que hace ganar al que ya elegiste. Si un camino tiene un problema real que el otro no tiene, ese problema va escrito, aunque sea el que preferís.
- **Qué es reversible y qué no.** Es la dimensión que más pesa y la que más se olvida. Una decisión reversible se puede tomar rápido y corregir; una irreversible —un esquema con datos ya cargados, un contrato ya entregado, un borrado— merece el doble de discusión aunque parezca menor.
- **Qué se puede diferir.** A veces el mejor camino es no elegir todavía, y decirlo es una respuesta válida.

## Cerrá con una recomendación

Presentar dos opciones y dejarlas abiertas traslada el trabajo en vez de hacerlo. Va una recomendación propia, fundada, y el motivo por el que gana.

Si mientras comparás descubrís que tu primera opción era peor, **decilo explícitamente**. Es el resultado más valioso del ejercicio, no un error que tapar.

## Después

La decisión que salga de acá, si es estructural, se documenta con `documentar-decision` — incluido el camino que perdió y por qué.
