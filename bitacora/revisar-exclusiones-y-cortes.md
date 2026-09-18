---
name: revisar-exclusiones-y-cortes
description: Al preparar el encargo de la próxima /revisar: qué sumarle además del diff, y qué conviene no pedirle.
origen: Sin Ruido
skill: revisar
---

Decidido el 07/09/2026. En la próxima `/revisar`, además de la lista explícita de archivos que ya pide la skill, el encargo de **cada** subagente lleva:

1. **Las exclusiones, escritas adentro del encargo.** Qué se sacó del diff y por qué, con el mismo texto para todos los revisores.
2. **Los cortes marcados.** Dónde el flujo cruza algo que ningún analizador estático ve —`invoke()`, `REGISTRO.get()`, SQL crudo, `getattr`— con un "acá me quedé ciego" explícito.
3. **Las aristas entrantes.** Quién llama a lo que se tocó, no sólo a quién llama lo que se tocó.

**Se evaluó y NO se hace todavía:** un script que genere un mapa del flujo (archivos, rangos de línea, llamadas con parámetros y retorno) desde el diff. Se descartó por ahora porque sería construir un compilador a medias para tres lenguajes, y sobre todo porque **acotaría el perímetro**: el hallazgo más valioso de la revisión anterior vivía fuera del diff.

**Why:** en la revisión de la fase 3 excluí los lockfiles del diff y se lo dije sólo a dos de los tres agentes. El tercero observó bien y concluyó mal —"faltan los lockfiles"—: un hallazgo falso causado por mi encargo, no por él. Y un mapa redactado por mí le pasaría al revisor mis puntos ciegos, que es lo único que el tercer par de ojos existe para no heredar. Ver [[correr-la-verificacion-no-argumentar-equivalencia]].

**How to apply:** al armar los encargos de `/revisar`, agregar los tres bloques antes de lanzar. Después de esa revisión, comparar: ¿algún hallazgo habría cambiado con un mapa generado? Si la respuesta es sí y hay un caso concreto, recién ahí discutir el script — con el número al lado, como pide [[pedir-caminos-alternativos]].
