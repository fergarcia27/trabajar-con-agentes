---
name: un-test-que-lee-la-constante-no-la-protege
description: Cuando escribas un test sobre un umbral, un límite o una constante de configuración.
origen: Sin Ruido
skill: mutacion
---

Pasó **dos veces el mismo día**, con dos constantes distintas, y las dos se
descubrieron por mutación y no leyendo el test.

## El patrón

    def test_el_corte_esta_donde_dice_la_constante():
        minimo = settings.LARGO_MINIMO
        assert parsear("x" * (minimo - 1)) is None
        assert parsear("x" * minimo) is not None

Se lee razonable. Comprueba el borde. **Y no protege nada**: si alguien baja
`LARGO_MINIMO` de 1500 a 100, el test se mueve con la constante y sigue en
verde. Lo único que verifica es que la función use la constante — coherencia
interna, no el valor.

Los dos casos, medidos:

- **Umbral de largo** (¿esta `<description>` es un cuerpo o una bajada?).
  Bajarlo de 1500 a 100 no rompía nada. Con 100, las bajadas reales de 496
  caracteres entrarían como cuerpo y el motor vectorizaría resúmenes.
- **Días de retención** de un registro de eventos. Bajarlo de 90 a 1 no rompía
  nada, porque todos los casos usaban filas de 120 días: pasaban con cualquier
  retención.

## El arreglo: anclar a un caso real

Un segundo test con un valor **medido del mundo**, no derivado de la constante:

    def test_la_bajada_mas_larga_que_existe_de_verdad_no_es_un_cuerpo():
        # 496 = la description más larga de los ocho feeds cargados, 11/09/2026
        assert parsear("x" * 496) is None

    def test_lo_de_hace_dos_meses_sobrevive():
        # 60 días: el caso que distingue 90 de casi cualquier otro número
        ...

Ahora bajar la constante rompe. Y el test explica **de dónde sale el número**,
que es la mitad del valor: dentro de seis meses, «496» sin contexto es magia.

## Lo transferible

**Un test sobre una constante tiene que fijar su valor, no su uso.** Si el
número aparece en los dos lados, sólo comprueba que la función lo lea.

**La pregunta que lo detecta en un segundo**: *si alguien cambia esta constante
a la mitad, ¿este test se pone rojo?* Si la respuesta es no, el test no la
protege.

**Y el ancla tiene que venir de una medición**, no de un número inventado más
chico. La bajada más larga que existe de verdad, el evento de hace dos meses:
esos números explican por qué el umbral está donde está, y sobreviven a que
alguien quiera "limpiar" el test.

Ver [[la-mutacion-tiene-que-llegar-a-lo-que-el-test-lee]] — misma disciplina,
otra forma de que la mutación no pruebe lo que parece.
