---
name: la-mutacion-tiene-que-llegar-a-lo-que-el-test-lee
description: Cuando una mutación escape y el test no la cace. Antes de culpar al test, confirmar que la mutación llegó al artefacto que el test realmente lee: bindings, build, fixture.
origen: Sin Ruido
skill: mutacion
---

La skill pide romper cada guarda y confirmar que un test la caza. Tres veces
falló **la comprobación de que la mutación se aplicó**, no la mutación.

**1. La mutación que escapó porque el arreglo no tenía test.** Un `{"url": ""}`
borraba el destino de entrega con 200 mientras `{}` daba 422. Escribí el arreglo
y después la mutación: escapó. El arreglo estaba bien; lo que faltaba era el
test, y sin él la mutación no tenía quién la cazara. Ver [[el-test-va-antes-que-el-arreglo]].

**2. La mutación que se reportó como no aplicada, y la comprobación estaba mal.**
El script decía `aplicada: False` porque el patrón que buscaba para verificarlo
no matcheaba, no porque la edición hubiera fallado.

**3. La que escapó por mutar el archivo equivocado (11/09/2026).** Saqué un campo
de un `struct` de Rust y el test de contrato pasó igual. No era un agujero del
test: **el test lee los bindings de TypeScript generados desde ese struct**, y yo
no los había regenerado. Estaba comparando contra un artefacto viejo.

**Why:** una mutación sólo prueba algo si llega hasta donde el test mira. Cuando
hay un paso de generación en el medio —bindings, esquemas, migraciones, un
bundle— editar la fuente no cambia lo que el test lee, y el verde que devuelve no
significa nada. Es la misma familia que medir el propio mock.

**How to apply:** en el script de mutación, después de escribir el archivo,
**correr el paso de generación** y comprobar el cambio en el artefacto final, no
en la fuente. Y cuando una mutación escapa, la primera hipótesis es que no llegó
— no que el test sea malo.

Rehecha regenerando los bindings, la cazó. Ocho mutaciones más sobre las guardas
del mismo bloque, ocho cazadas. Commit `0ffc067`.
