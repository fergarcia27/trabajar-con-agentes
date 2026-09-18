---
name: grillar
description: Interrogar al usuario sobre un plan o un diseño hasta que no quede ninguna rama sin resolver, en rondas de preguntas con recomendación.
disable-model-invocation: true
---

El modo de falla más común no es el código malo: es haber entendido otra cosa. Esta sesión existe para cerrar esa brecha **antes** de escribir nada.

Adaptada de la skill `grilling` de Matt Pocock.

## El árbol y la frontera

Modelá la conversación como un **árbol de decisiones**: cada decisión abre las que cuelgan de ella. La **frontera** son las decisiones cuyos prerrequisitos ya están resueltos, o sea las preguntas que se pueden hacer *ahora* sin adivinar respuestas que todavía no escuchaste.

Se trabaja en **rondas**: se pregunta toda la frontera junta, se espera, y las respuestas empujan la frontera hacia afuera. Una pregunta cuya respuesta depende de otra que está abierta **en esta misma ronda** pertenece a una ronda posterior, no a esta.

## Formato de una ronda

```
❓ **Q1 — <título de la pregunta>**: <el cuerpo; puede ser varios párrafos y puede ofrecer opciones>

➡️ <tu respuesta recomendada>

---

❓ **Q2 — <título>**: <cuerpo>

➡️ <tu respuesta recomendada>
```

Cada pregunta va **numerada y con tu recomendación**. Una pregunta sin recomendación traslada el trabajo en vez de hacerlo. Cuando la pregunta es entre dos enfoques de fondo, presentala con la disciplina de `dos-caminos`.

## Los hechos los buscás vos

Encontrar **hechos** es tu trabajo, nunca del usuario. Si una pregunta de la frontera necesita un dato del entorno —qué hay en un archivo, qué versión está instalada, cuántas filas tiene una tabla— andá a buscarlo, no lo preguntes.

Y no bloquees: una búsqueda en curso es un prerrequisito sin resolver, así que **solo las preguntas que dependen de ella esperan**. El resto de la frontera se pregunta igual, ahora.

Las **decisiones** sí son del usuario. Cada una se le pone adelante y se espera.

## Cuándo termina

Cuando la frontera queda vacía: todas las ramas visitadas, nada asumido en silencio. **No empieces a implementar hasta que el usuario confirme** que llegaron a un entendimiento común.

Si de la sesión sale una decisión estructural, cerrala escribiéndola con `documentar-decision`.
