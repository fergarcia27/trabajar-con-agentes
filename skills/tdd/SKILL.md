---
name: tdd
description: Desarrollo guiado por tests con el bucle rojo-verde, acordando primero en qué límites públicos se testea. Usar al construir una funcionalidad nueva o arreglar un bug, y como referencia de qué hace bueno o malo a un test.
---

El bucle es rojo → verde: primero el test que falla, después el mínimo código que lo hace pasar. Esta skill es lo que hace que de ese bucle salgan tests que valga la pena conservar.

Adaptada de la skill `tdd` de Matt Pocock.

## Qué es un buen test

Verifica **comportamiento a través de la interfaz pública**, no detalles de implementación. El código puede cambiar entero y el test no debería moverse. Un buen test se lee como una especificación: el nombre dice qué capacidad existe, y sobrevive a un refactor porque no le importa la estructura interna.

## Dónde van: los límites

Un **límite** es la frontera pública donde se observa el comportamiento sin meter la mano adentro. Los tests viven en los límites, nunca contra las tripas.

**Se testea solo en límites acordados de antemano.** Antes de escribir un test, escribí cuáles son los límites bajo prueba y confirmalos. No se testea todo: acordar los límites primero es lo que hace que el esfuerzo caiga en los caminos críticos y en la lógica complicada, y no en cada caso borde imaginable.

## Los tres antipatrones

- **Acoplado a la implementación**: mockea colaboradores internos, prueba métodos privados, o verifica por un canal lateral (consultando la base en vez de usar la interfaz). El síntoma: el test se rompe cuando refactorizás y el comportamiento no cambió.
- **Tautológico**: el valor esperado se calcula igual que lo calcula el código (`assert sumar(a, b) == a + b`), así que pasa por construcción y **nunca puede estar en desacuerdo con el código**. El valor esperado tiene que venir de una fuente independiente: un literal conocido, un ejemplo trabajado a mano, la especificación.
- **Rebanado horizontal**: escribir todos los tests primero y después toda la implementación. Los tests en bloque verifican comportamiento *imaginado*: se prueba la forma de las cosas y no lo que hace el sistema. Se trabaja en **rebanadas verticales**: un test, su implementación, repetir — cada una respondiendo a lo que enseñó la anterior.

## Reglas del bucle

- **Rojo antes que verde.** El test que falla primero, y después solo el código que lo hace pasar. Sin anticipar tests futuros ni agregar de más.
- **Una rebanada por vez.** Un límite, un test, una implementación mínima por ciclo.
- **Refactorizar no es parte del bucle.** Pertenece a la revisión, no al ciclo rojo → verde.

## Después del verde

Un test que pasa prueba que el código de hoy no lo hace fallar; no prueba que sirva. Cuando lo que agregaste es una **protección** —una validación, una guarda, una cota—, cerralo con `mutacion`: rompela a propósito y confirmá que este test se pone en rojo. Las dos disciplinas son complementarias, y ninguna reemplaza a la otra.

## Dos capas, y sólo una es delegable

**Caja negra** — desde el requisito, sin mirar la implementación. Caza "no hace lo
que se pidió". Es delegable a quien no vio el código, y conviene que lo sea: quien
escribe el código escribe tests sesgados por él. Medido: apareció un
`assert post.call_count == 3` donde el 3 salía de conocer la configuración de la
librería de reintentos, no del requisito.

**Caja blanca** — desde el código, sobre un agujero concreto de esta
implementación. "No cuenta el intento si el transporte falla" sólo se puede
escribir sabiendo que existe un contador; desde afuera nadie sabe eso.

No compiten: la primera dice que el producto cumple, la segunda que esta versión
no tiene tal hueco. Escribirlas mezcladas sin distinguirlas es cómo se cuela el
detalle de implementación adentro de un test de requisito.

## Los tests que necesitan algo vivo van marcados, y con fecha de corrida

Un test contra un servicio real no puede distinguir un fallo suyo de un parpadeo
de red. Marcalo (`@pytest.mark.integration` o el equivalente del stack) y sacalo
de la corrida por defecto, para que la suite de todos los días siga siendo
determinista.

**Y esa es la mitad fácil.** Un test excluido por defecto es un test que deja de
correr en silencio: en seis meses tenés doce que nadie ejecutó y que ya no pasan.
Así que marcarlo **no está completo hasta que tiene un momento declarado en el que
se corre** — la lista de verificación de release, el paso previo a taguear, lo que
sea, pero escrito. Sin eso, la exclusión no es una separación: es un cementerio.
