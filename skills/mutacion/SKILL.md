---
name: mutacion
description: Romper a propósito cada protección nueva y confirmar que un test la caza. Usar después de agregar una validación, una guarda, una condición de seguridad o un filtro, antes de dar el trabajo por terminado.
---

Un test que pasa no prueba que sirva: prueba que el código de hoy no lo hace fallar. La mutación cierra esa brecha. Por cada protección nueva, se la rompe a propósito y se confirma que **algún test se pone en rojo**. Una mutación que nadie caza es un test que no está.

## El bucle

Por cada protección que agregaste:

1. **Aplicar** la mutación: revertir esa protección a como estaba antes de existir.
2. **Correr** los tests que la cubren.
3. **Restaurar** el archivo a su contenido original.
4. **Anotar** si quedó cazada, y **por cuál test**.

El resultado se reporta como una fracción —`12/12 detectadas`— junto con el resto de la verificación.

## Qué mutar

Todo lo que decide **si algo pasa o no pasa**. Una condición de un `WHERE`, una validación de entrada, una cota, un `if` de seguridad, el orden de dos operaciones, una llamada a `commit()`. La prueba de que vale la pena mutarlo: si esa línea desapareciera, ¿alguien lo notaría?

Lo que **no** se muta: refactors, nombres, comentarios, formato. Ahí no hay comportamiento que romper.

## Leer el resultado

**Cazada.** Lo esperado. Pero mirá *qué* test la cazó: si corriste con `-x`, el runner corta en el primer fallo y podés estar viendo un test distinto del que escribiste para esa protección. Cuando el test que la caza no es el suyo, volvé a correr esa mutación **dirigida contra su propio test**, para confirmar que no fue casualidad.

**No se detecta.** Es un hallazgo, y hay que decidir cuál de dos cosas es:

- **Falta un test.** Lo normal. Se escribe y se vuelve a mutar.
- **La protección es una capa redundante.** Otra defensa ya cubre ese caso, así que romperla no reabre nada. Es legítimo dejarla, pero **etiquetada como tal** en el comentario, para que el próximo que lea no crea que está desprotegido.

Una mutación que no se detecta y se deja sin explicación es la peor de las tres salidas: parece cobertura y no lo es.

## El harness

Un script descartable en el scratchpad, con una lista de `(etiqueta, archivo, viejo, nuevo)`. Cuatro cosas que no son opcionales:

**Capturá el contenido original ANTES de la primera mutación, y restaurá desde esa copia** —no desde el archivo en disco— para que una mutación no se apile sobre otra.

**Verificá que el patrón matchea exactamente una vez** antes de aplicarlo. Si matchea cero, la mutación no corrió y el `CAZADA` que reportes es mentira; si matchea dos, rompiste algo que no querías.

**Corrélo en segundo plano.** Cada arranque de la suite cuesta varios segundos, así que doce mutaciones se pasan del timeout de dos minutos del primer plano. Si el proceso muere a mitad de ciclo, **queda una mutación aplicada y sin restaurar**, y todo lo que corras después está apoyado en un archivo corrupto sin que nada avise.

**Confirmá que el árbol quedó limpio al terminar**, con `git diff` o `git status`, antes de creerle a los resultados.

## Después

La mutación no reemplaza correr la suite: la completa. El reporte final dice las dos cosas —cuántos tests pasan y cuántas mutaciones se detectaron— porque responden preguntas distintas: si el código hace lo que se espera, y si los tests se darían cuenta cuando deje de hacerlo.
