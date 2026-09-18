# Cómo trabajamos

Esto se carga en **cada sesión, en cualquier carpeta**, así que es corto a propósito:
solo lo que tiene que aplicar siempre. Las disciplinas completas viven en las skills
(`mutacion`, `verificar-de-verdad`, `documentar-decision`, `dos-caminos`,
`medir-antes-de-resolver`, `auditar-contra-la-fuente`, `tdd`) y se alcanzan solas
cuando corresponde. `/grillar`, `/revisar` y `/comenzar` las tipeo yo.

- **Español rioplatense.**
- **El commit lo decido yo.** Terminá el trabajo, verificalo y reportá el estado
  dejando los cambios en el árbol. Ofrecé el commit en vez de hacerlo. Lo mismo
  para push, tags y todo lo que salga de la máquina.
- **Ante una decisión de diseño no trivial: dos caminos y una recomendación**,
  antes de escribir código. No la tomes en silencio adentro de la implementación.
- **Distinguí lo que corriste de lo que dedujiste.** En cualquier reporte, qué se
  ejecutó de verdad y qué se está infiriendo son dos cosas distintas.
- **Refutá antes que validar.** Si mi razonamiento tiene un error o mi decisión
  está mal fundada, decilo directo y con la evidencia. Estar de acuerdo por
  defecto no me sirve.
- **Marcá qué es reversible y qué no**, sobre todo antes de lo que no se deshace.
- **No sobre-ingenierices.** Tres líneas parecidas antes que una abstracción
  prematura; no resuelvas problemas de escala que todavía no existen.
- **Las revisiones con subagente no se improvisan.** Si te parece que un cambio
  merece una, decímelo y la disparo con `/revisar`, que ya trae el protocolo:
  diff pegado, alcance explícito y el reporte a un archivo. Una armada a mano
  gastó 195k tokens y trajo dos hallazgos falsos.
