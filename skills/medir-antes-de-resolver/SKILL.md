---
name: medir-antes-de-resolver
description: No resolver preventivamente un problema que todavía no apareció con datos reales, dejar el número medido escrito donde justifica la decisión, y estimar lo que cuesta el arreglo antes de aceptarlo. Usar ante cualquier optimización, límite, caché, índice o refactor motivado por un problema previsto y no observado, y ante cualquier mejora que se vea cara o compleja de construir.
---

Un problema de escala que todavía no existe no se resuelve: se **vigila**. La regla es que ningún punto se ataca preventivamente; se retoma cuando el síntoma aparece con datos reales.

## Vigilar es una acción, no una excusa

"No lo hacemos todavía" solo vale si viene con las tres cosas que lo vuelven una decisión y no una postergación:

- **El síntoma concreto** que lo dispararía. No "cuando escale", sino "cuando el agrupamiento se acerque a los segundos que compiten con el ciclo de 15 minutos".
- **El número de hoy**, medido. Es contra ese número que se va a comparar el de mañana.
- **Dónde se ve.** Si el disparador no está a la vista en un log o una métrica, nadie lo va a notar cuando llegue.

Sin las tres, no es vigilancia: es una tarea que se olvidó con estilo.

## Cuando medís, el número se queda

Una constante sin su medición al lado es un número mágico, aunque haya salido de una medición real. El número va **en el comentario que justifica la constante**, no en un chat que se pierde:

- Flojo: `MAX_FEEDS = 20  # un límite razonable`
- Firme: `MAX_FEEDS = 20  # el sondeo consulta cada feed con 10 s de timeout, así que veinte que no respondan ocupan un worker 200 s. Los 7 medios del roster usan un feed cada uno; el experimento más grande llegó a 8.`

El segundo se puede discutir y ajustar; el primero solo se puede respetar por miedo.

## Medir antes de elegir, también

Vale para adelante y no solo para atrás. Cuando hay dos formas de resolver algo y la diferencia entre ellas **se puede medir**, se mide primero y se elige con el número a la vista, en vez de discutirlo en abstracto. A veces el resultado es que ninguna gana por nada, y ahí gana la más simple — pero eso también es un hallazgo, no una corazonada.

## El costo de resolverlo antes de tiempo

No es solo el trabajo de más. Una abstracción puesta para un caso que no llegó **hay que mantenerla igual**, complica el código para todos los casos que sí existen, y suele estar mal orientada porque se diseñó contra un problema imaginado. Preferí tres líneas parecidas antes que una abstracción prematura.

## Estimá también lo que cuesta el arreglo

Todo lo de arriba mide **el problema**: si el síntoma es real, si el número justifica moverse. Falta la otra mitad, que se saltea seguido: **cuánto cuesta la solución que se está por aceptar**, estimado antes de empezarla y no descubierto a mitad de camino.

La estimación no es ceremonia: es un dato que **realimenta si la mejora vale la pena**. Una mejora chica con un beneficio chico se hace sin pensar. Una mejora cara con un beneficio chico no es una mejora, es una tarea que va a competir con otras mejores — y esa comparación no se puede hacer sin el número.

Cuando el arreglo se ve caro, la pregunta no es "¿cómo lo hago?" sino, en este orden:

1. **¿Hace falta de verdad?** Muchas veces el costo alto es la señal de que se está atacando un problema que todavía no existe, y ahí vuelve a aplicar todo lo de arriba: se vigila, no se resuelve.
2. **¿Hay una alternativa simple que cubra el 80%?** Casi siempre existe y casi siempre alcanza. Una guarda de tres líneas en el lugar correcto suele valer más que el rediseño que la haría innecesaria.
3. **¿Se puede diferir la parte cara y hacer la barata ahora?** Partir una mejora en la mitad que rinde y la mitad que cuesta es un resultado legítimo, y a veces la mitad cara nunca hace falta.

**La excepción, y es angosta a propósito**: cuando la mejora es innegociable —corrige una pérdida de datos, cierra un agujero de seguridad, arregla algo que ya rompió en producción— el costo se paga y no se discute. Lo que sigue teniendo sentido ahí es estimarlo igual, pero para planificarlo, no para decidirlo.

Lo que **no** es esta sección: una excusa para no hacer lo difícil. La diferencia entre "esto es caro, busquemos la alternativa simple" y "esto es caro, no lo hagamos" es que la primera termina con algo hecho.
