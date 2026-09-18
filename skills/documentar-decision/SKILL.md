---
name: documentar-decision
description: Antes de tomar una decisión de diseño no trivial, debatirla; después dejarla escrita en change_logs.md con lo que se evaluó y lo que se descartó. Usar ante cualquier elección estructural, un cambio de esquema, una constante que fija comportamiento, o cuando se elige entre dos enfoques.
---

Una decisión de diseño que se toma en silencio adentro del código se pierde: queda el resultado y se va el motivo. Seis meses después alguien ve la línea rara, la "arregla", y vuelve el problema que esa línea evitaba.

La regla tiene dos mitades, y las dos son obligatorias: **debatirla antes, escribirla después.**

## Antes: no la tomes solo

Una decisión es no trivial cuando cambia la forma del sistema, no solo su contenido: un esquema, un contrato, un límite que fija comportamiento, una dependencia nueva, el orden de dos pasos que se podían invertir. Ahí se propone y se espera, no se implementa y se avisa.

Cuando hay más de un camino razonable, presentalos con la disciplina de `dos-caminos`.

## Después: escribila con lo descartado

La entrada va en `specs/change_logs.md`, al final, con fecha. Lo que la vuelve útil no es el qué sino **el resto**:

- **Qué se evaluó y no se eligió, con su contra concreto.** Esta es la parte que casi nadie escribe y la única que evita que alguien vuelva a proponer lo mismo dentro de un año. Un callejón sin salida documentado ahorra la segunda recorrida.
- **El número que respalda la elección**, si lo hay. "Se eligió 20" no dice nada; "20 porque el sondeo consulta cada feed con 10 s de timeout, así que veinte que no respondan ocupan un worker 200 s" sí.
- **Lo que la decisión deja abierto**, dicho con todas las letras. Un límite conocido y anotado es una decisión; el mismo límite sin anotar es una sorpresa.
- **Cómo se verificó**, cuando corresponde: qué se corrió, sobre qué datos, con qué resultado.

## El formato

Prosa, no bullets sueltos. Una entrada se lee como la explicación que le darías a alguien que llega mañana, no como un acta. Título con la decisión y la fecha, y adentro: qué problema la motivó, qué se evaluó, qué se eligió y por qué, qué queda afuera.

Si la decisión nace de un hallazgo —algo que se rompió, algo que se midió y sorprendió— **contá el hallazgo primero**. El motivo es más fácil de entender desde el síntoma que desde la conclusión.

## Cuándo NO hace falta

Un rename, un formato, una corrección de tipeo, un test más de un caso ya cubierto. Si dentro de un año nadie va a preguntar "¿por qué está así?", no hay decisión que documentar. Escribir entradas para todo diluye las que importan.
