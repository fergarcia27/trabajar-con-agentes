---
name: como-realizar-apunte-metodo-zettelkasten
description: Cuando vayas a escribir una nota nueva de la bitácora, a decidir cómo organizar apuntes que tienen que servir en otro proyecto, o a montar un vault desde cero. Qué se toma de Zettelkasten, qué no aplica cuando el lector es un agente, y qué falla antes que el formato.
origen: Sin Ruido
---

Esta bitácora es Zettelkasten en su forma: notas atómicas, enlaces internos, un índice. Pero **el lector no es una persona que navega: es un agente que
consulta**, y esa diferencia cambia qué parte del método rinde.

## Lo que se toma, y funciona

**Una lección por archivo.** Es lo central de Zettelkasten y es lo que más rinde.
Dos pruebas, y hacen falta las dos:

- *¿Alguien buscaría esto por su cuenta, sin saber que la otra nota existe?* Si
  sí, y está enterrado en la sección 4 de un documento sobre otra cosa, no es una
  nota: es algo inencontrable.
- *¿Tiene su propio caso medido?* Si no, es una sección, no una nota. Esta segunda
  prueba existe para no astillar el vault en cincuenta fragmentos.

**Enlazar en vez de jerarquizar.** Las carpetas obligan a elegir un solo lugar; un
enlace no. Y un enlace a una nota que todavía no existe es válido: marca lo
que falta escribir. Esta nota nació justamente de un enlace así.

## Lo que NO aplica, y conviene saberlo

**La emergencia.** El pago prometido de Zettelkasten es que caminando el grafo
encontrás conexiones que no buscabas. Eso le pasa a una persona que hojea. Un
agente hace **una búsqueda y lee una nota**: no vagabundea. Así que el grafo no
está haciendo el trabajo que Luhmann esperaba de él, y no hay que presupuestar
esfuerzo ahí. Los enlaces siguen sirviendo —para llegar de una lección a la de al
lado— pero son secundarios.

**Los identificadores únicos** (`202609141530`). Resuelven un problema de papel:
poder referenciar sin depender del título. Con archivos y búsqueda de texto, un
nombre descriptivo es mejor: se lee en los resultados.

## Lo que carga el peso, y Zettelkasten no tiene

**El `description` del frontmatter, escrito como disparador y no como resumen.**
Es lo que decide si la nota aparece cuando hace falta. Zettelkasten no tiene la
noción de "cuándo debería surgir esto"; el frontmatter de una skill sí, y es de
ahí que se copia.

- Resumen, no sirve: *«Las familias de clustering y qué pregunta decide cuál usar»*
- Disparador, sirve: *«Cuando haya que elegir cómo agrupar elementos parecidos, o
  un clustering esté fragmentando el mismo hecho»*

Uno describe la nota; el otro describe **el momento en que la necesitás**.

## Si la nota es una elección de tecnología

Ahí la forma atómica no alcanza, y la forma establecida es el **ADR** (*Architecture
Decision Record*): contexto, decisión, consecuencias. Pero un ADR se escribe una
vez y no se vuelve, así que para que sirva en otro proyecto le faltan tres campos:

| campo | por qué |
|---|---|
| **Qué lo decidió de verdad** | Una sola restricción, no la tabla comparativa |
| **Cuándo NO replicarlo** | Es lo que lo hace reutilizable en vez de un recuerdo |
| **Qué pasó con las razones** | Revisado después, con un número |

El tercero es el que más rinde y ninguna práctica de ADR lo incluye. Ver
[[elegir-el-caparazon-de-una-app-de-escritorio]]: dos de las tres razones para
elegir Tauri no se sostuvieron —el shell "mínimo" en Rust terminó siendo el 38%
del código, y el updater nunca se usó— y la decisión fue correcta igual. Sin esa
revisión, la nota le habría repetido un argumento falso al próximo proyecto.

## Lo transferible, y es lo que falla antes que el formato

**Una nota que nada carga es una nota que no existe.**

Este vault estuvo escrito y ordenado durante días mientras **11 de sus 23 notas no
llegaban a ninguna sesión**: nada las mencionaba, ni el `CLAUDE.md` global ni
ninguna skill. Las otras 12 sí llegaban, pero por una copia vieja en otra carpeta,
así que editar el vault no cambiaba nada de lo que el agente veía.

La atomicidad, los enlaces y el grafo estaban impecables. El problema era que **no
había puerta**. Antes de discutir cómo organizar los apuntes, resolvé por qué
camino concreto entran al contexto de quien los va a usar — y comprobalo, que no
es lo mismo que suponerlo.

Ver [[una-decision-escrita-se-puede-revertir]].
