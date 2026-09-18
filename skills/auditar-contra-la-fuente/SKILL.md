---
name: auditar-contra-la-fuente
description: Antes de dictaminar sobre un resultado, ir al dato primario en vez de al campo derivado que lo resume, y desconfiar de los resultados demasiado redondos. Usar al evaluar salidas de un algoritmo, al validar una métrica, o antes de afirmar que algo es un falso positivo o un acierto.
---

Un veredicto sobre un resultado vale lo que valga el dato en el que se apoya. Si te apoyaste en un campo **derivado** —un título, un contador, un resumen, una etiqueta— todavía no miraste el resultado: miraste su etiqueta.

## El caso que fija la regla

Al declarar que dos pares de un clustering eran falsos positivos, el juicio se había hecho **por los títulos**. Al leer los cuerpos, el veredicto sobre los pares no cambió, pero **el diagnóstico sí, y en lo que importaba**: el problema no era que las fuentes nuevas trajeran ruido, sino que los grupos de destino ya estaban mal armados desde antes. La conclusión que estaba por entregarse tenía la causa equivocada.

Ese es el daño típico: no que el veredicto se invierta, sino que la **causa** que se le adjudica sea otra, y con ella el arreglo.

## Cómo se hace

**Imprimí el dato que el sistema realmente usó.** No el que lo representa en la interfaz. Si la similitud se calcula sobre el título más los primeros N caracteres del cuerpo, eso es lo que hay que mirar: ni el título solo, ni el cuerpo entero.

**Mirá los casos, no solo el agregado.** Un promedio, una tasa o un total esconden exactamente la distribución que necesitás para juzgar. Traé los ejemplos concretos de los dos lados: los que el sistema aceptó y los que rechazó.

**Comprobá contra cada miembro, no solo contra el resumen.** Si comparás algo contra un grupo, compará contra sus miembros además de contra su centroide o su representante: el representante puede no describir al grupo.

## Sospechá de lo redondo

Un `20 de 20`, un `0 de 500`, un `100%` merecen una segunda mirada antes de festejarlos o alarmarse. En la práctica, un resultado perfecto es más seguido un bug propio que un dato: un filtro que rechaza todo porque la condición está invertida da `0 de 500` con la misma cara que uno que funciona.

Ante un número redondo, la pregunta es "¿qué haría que esto diera exactamente esto sin que el sistema funcione?", y se responde mirando un caso.

## Vale para cualquier veredicto

No es solo para clustering ni para similitud. Cualquier afirmación sobre resultados —"esto se filtró bien", "estas quedaron afuera", "el cambio no las tocó"— se apoya en la fuente primaria o no se hace.
