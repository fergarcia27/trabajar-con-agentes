---
name: revisar
description: Revisar los cambios desde un punto fijo, repartidos en ejes que no se mezclan, con un agente revisor por eje en paralelo.
disable-model-invocation: true
---

Revisión del diff entre `HEAD` y un punto fijo, **repartida en ejes que no se
mezclan**. Un eje, un agente, una pregunta.

| agente | compara contra | su pregunta |
|---|---|---|
| `hermes` | el documento de convenciones | ¿está construido como se construye acá? |
| `velma` | el código contra sí mismo | ¿dice la verdad sobre lo que hace? |
| `perry` | el legajo de incidentes del proyecto | ¿qué se escapa o se cuela? |

*Los nombres son de dibujos animados con el mismo oficio, y no es capricho: Velma
desenmascara lo que se presenta como otra cosa, Hermes es el burócrata que sólo
mira el formulario, y el nemesis de Perry vuelve cada capítulo a abrir la misma
puerta con un aparato nuevo. `dexter` es el cuarto, del lado productor: escribe los
tests desde su laboratorio sellado, sin ver la implementación.*

**Esta skill no contiene los encargos: los orquesta.** Cada agente lleva su eje
escrito en su propia definición, así que acá va lo que es común —de dónde a dónde
se compara, qué recibe cada uno, y cómo se agrega lo que vuelve.

Adaptada de la skill `code-review` de Matt Pocock.

## Por qué ejes separados

Un cambio puede aprobar uno y reprobar otro. Cumple todas las convenciones pero el
comentario miente; está impecable y deja salir una credencial. **Reportarlos por
separado evita que un eje tape al otro**, y por eso los hallazgos no se mezclan ni
se rankean juntos al final.

La prueba de que ninguno sobra: **cada uno compara contra un documento distinto.**
Si dos compararan contra lo mismo, uno estaría de más.

## Dónde encaja esto en el trabajo

La revisión es el paso 6, no el 1:

```
1. Requerimientos escritos, CON los números medidos
2. ¿El spec ya está fijo (un contrato, un acuerdo con otro equipo)?
      sí → `dexter` escribe los tests antes. No imagina nada: transcribe
      no → el bucle vertical se queda con quien implementa
3. Implementación
4. Mutación   ← el árbitro. Barata, automática
5. `dexter` a ciegas sobre lo construido, si no corrió antes
6. Revisores
```

**La mutación va antes de los revisores.** Contesta lo único que los tests verdes no
contestan solos —si protegen algo—, y mandar a revisar un diff cuyos tests no
protegen nada es gastar agentes en el lugar equivocado.

**Verde es el permiso para revisar, no un adelanto del resultado.** Las clases de
`velma` y `perry` son justamente las que ningún test ve: un comentario que
miente, una guarda que no guarda, un arreglo que no llegó a los archivos hermanos,
una credencial que sale. Todo eso ocurre con la suite entera en verde.

## Proceso

### 1. Fijar el punto de comparación

Lo que diga el usuario: un SHA, una rama, un tag, `main`, `HEAD~5`. Si no dijo nada, preguntalo.

Antes de seguir, confirmá que la referencia resuelve (`git rev-parse`) y que el diff no está vacío. Una referencia mala tiene que fallar acá y no adentro de dos subagentes.

Capturá una sola vez: `git diff <punto>...HEAD` (tres puntos, o sea contra la base común) y `git log <punto>..HEAD --oneline`.

### 2. Encontrar las fuentes

- **Las convenciones**: `specs/conventions.md`, y lo que el repo documente sobre cómo se escribe código acá.
- **El requisito**: el punto del backlog que este trabajo cierra, el issue, o el archivo de spec. `velma` lo necesita para juzgar si hay comportamiento que nadie pidió.
- **El legajo de seguridad**: el documento del proyecto con sus incidentes cerrados, los campos que no salen y los endpoints con autenticación obligatoria. Si no existe, `perry` corre igual pero **lo declara**: sin historial no puede ver una reapertura.

Si alguna falta, se dice en el reporte en vez de simularla.

### 3. Lanzar los revisores en paralelo

Van **en paralelo y aislados** para que ninguno contamine el contexto del otro. Un solo agente con varias listas lee el código una vez y con una sola cabeza: la pregunta que empieza a contestar se come a las demás.

**Lo que va en todos los encargos, además del material.** Tres bloques idénticos para cada revisor, sin excepción:

- **Las exclusiones.** Si algo se sacó del diff —lockfiles, generados, un archivo enorme— va escrito adentro del encargo, con el motivo. Que un revisor no lo tenga y los otros sí es lo que produce hallazgos falsos.
- **Los cortes.** Dónde el flujo cruza algo que ningún analizador estático ve: un comando invocado por su nombre en un string, un despacho por diccionario, SQL crudo, `getattr`. Un "acá me quedé ciego" explícito, porque un alcance que se corta en silencio se lee como completo.
- **Las aristas entrantes.** Quién llama a lo que se tocó. Es donde rompe, y es lo que no se ve leyendo el diff. **Va con el perímetro declarado**: en qué lenguajes y carpetas se buscó. El cómputo se hace a mano y elige su propio alcance, así que una búsqueda que sólo miró `*.py` se lee igual que una completa. Mismo principio que los cortes, un nivel más afuera.

### Qué recibe cada uno, además de los tres bloques

- **`hermes`** — el diff, los commits y **el documento de convenciones pegado**.
  No tiene otro acceso a él, a propósito.
- **`velma`** — el diff, los commits y **el requisito** de esta tanda, que necesita
  para juzgar si hay comportamiento que nadie pidió.
- **`perry`** — el diff, los commits y **el legajo de seguridad del proyecto**.
  Sin el legajo no puede ver una reapertura; si no lo hay, que lo diga en el reporte.

### Cuáles corren

No corren los tres siempre: cuatro agentes en cada cambio es caro y además diluye.

| | cuándo |
|---|---|
| `hermes` | siempre que el diff toque código |
| `velma` | siempre que el diff sea sustancial. Es el de propósito general, el que ocupa el lugar de *"nadie más va a mirar esto"* |
| `perry` | por disparador: credenciales, destinos de salida, entrada de terceros, permisos de endpoints, o una superficie que figure en el legajo |

Un cambio de documentación no necesita ninguno.

### 4. Agregar

Cada reporte bajo su propio encabezado, tal como llegó. **No se fusionan ni se re-rankean.**

Al final, una línea: cuántos hallazgos por eje y el peor **dentro de cada eje**. Sin elegir un ganador entre ejes: esa es justamente la mezcla que la separación existe para evitar.

## El tercer par de ojos, y por qué ya no existe

Durante un tiempo hubo un revisor extra —**un modelo distinto y sin el contexto de
la sesión**— que se traía en tres casos: un cambio irreversible o que toca datos,
una superficie que ya tuvo un incidente de seguridad, o *"nadie más va a mirar esto"*.

**Tenía el cómo completamente especificado y el qué vacío.** Los seis puntos de
abajo decían cómo alimentarlo y cómo entregar; ninguno decía qué buscar. Y el tercer
disparador —el que se cumple casi siempre en un proyecto de una persona— no traía
ninguna pregunta, así que el encargo se improvisaba en el momento: una entrada no
reproducible en un método que existe para no improvisar.

**Se disolvió en dos agentes con responsabilidad fija.** Sus disparadores no se
perdieron: los dos primeros son ahora los de `perry` —incluido el caso real que
los originó, una tanda de multimodelo que reabrió por la puerta de al lado una
exfiltración que una auditoría ya había cerrado— y el tercero es la razón de que
`velma` corra por defecto.

Lo que sobrevive entero es el protocolo, que aplica a los tres revisores.

### El protocolo, y por qué es así

Sin protocolo esta revisión se improvisa, y sale carísima. **Medido**: una armada a mano gastó **195.355 tokens en 47 llamadas**, contra ~101.000 de leer todo el alcance una sola vez. La diferencia no fue leer — fue descubrir el alcance, y las vueltas.

**1. Se le pasa el material masticado, no la tarea de juntarlo.** El diff ya capturado va pegado en el encargo. Quien llama lo tiene en la mano: mandarlo a re-derivarlo es pagar dos veces.

**2. Y con él, la lista explícita de archivos que puede leer.** Solo el diff no alcanza, y esto también está medido: en aquella revisión, uno de los hallazgos más valiosos —comentarios de seguridad que el código había vuelto mentira— vivía en archivos **fuera del diff**. La lista se arma con criterio: los que declaran invariantes que el diff podría haber invalidado. Un presupuesto de lecturas libres, en cambio, es justo lo que produce las 47 llamadas.

**3. No corre código.** Señala dónde mirar; correr, corremos nosotros. Dos motivos, los dos medidos en el mismo caso: de diez hallazgos, **dos eran falsos porque el agente montó una sonda que mockeaba justo la cosa bajo prueba** y después reportó lo que su propio mock devolvía. Y de los ocho restantes ninguno sobrevivió como "ya verificado": después de esos dos falsos hubo que comprobarlos todos otra vez desde cero. Se pagó la sonda del agente **y** la verificación de nuevo. Que señale y que verifiquemos juntos elimina la duplicación y deja la discusión donde sirve.

**4. Cada hallazgo lleva las dos cosas: dónde y cómo comprobarlo.** El `archivo:línea` con por qué sospecha, **y la verificación concreta** que lo confirmaría o lo tiraría abajo: el comando, el test, la consulta. Sin eso, cada hallazgo obliga a diseñar su verificación desde cero — trabajo que el revisor tenía el contexto para hacer. Y tiene un efecto de calidad: obligarlo a escribir *cómo se comprobaría* lo fuerza a preguntarse si es comprobable, que es la pregunta que un hallazgo inventado no sobrevive.

**5. El reporte largo va a un archivo; de vuelta viene un resumen corto.** Títulos, severidad y dónde está el detalle. El reporte entero se lee **una vez**, cuando se decide qué atacar, en vez de ocupar contexto hasta el final de la sesión — y queda como artefacto que sobrevive a la compactación. En aquel caso hubo que ir a desenterrar el reporte del transcript, justamente porque se había perdido.

**6. Si excluís algo del diff, se lo decís a todos.** También medido, y en una revisión distinta: se sacaron los lockfiles del diff y se le avisó **solo a dos de los tres** agentes. El tercero observó bien y concluyó mal —"faltan los lockfiles"—, un hallazgo falso causado por el encargo y no por él. La regla vale para cualquier recorte del alcance, no solo para archivos: si el revisor no puede ver algo, tiene que saber que no lo está viendo.

A diferencia de los dos ejes de arriba, acá **no va techo de palabras**: ese reporte largo era bueno —nueve hallazgos con evidencia— y truncarlo habría costado el de la fuga. El techo se pone en lo que vuelve al contexto, no en lo que se piensa.

### Lo que se evaluó y todavía no se hace

**Un mapa del flujo generado desde el diff** —archivos, rangos de línea, llamadas con sus parámetros y su retorno— en lugar de la lista de archivos del punto 2. Se discutió el 07/09/2026 y quedó esperando un número, por tres motivos:

- Para emitir "a quién llama y con qué parámetros" hay que resolver nombres de verdad. Grepear se equivoca; resolver es un compilador a medias, y en este repo serían **tres lenguajes**.
- **Acotaría el perímetro.** El hallazgo más valioso de la revisión de referencia vivía fuera del diff: un mapa derivado del diff no solo no lo traería, le daría al revisor una razón para no mirar ahí.
- Un mapa con un bug **miente con autoridad**, y al generador no lo audita nadie.

**Medido el 17/09/2026: el cómputo a mano cuesta ~2 llamadas y 227 ms**, sobre un diff de seis símbolos. Eso **cierra la motivación de ahorro**: no hay tiempo ni tokens que recuperar, así que un generador no se justifica por costo. Queda abierta sólo la de completitud —que el cálculo no dependa de qué símbolos elija mirar quien lo hace—, y contra eso pesan las tres objeciones de arriba.

**Cómo se decide.** Después de la próxima revisión hecha con el punto 6 y los tres bloques del paso 3, la pregunta es si algún hallazgo habría cambiado con un mapa generado. Con un caso concreto que diga que sí, se escribe el script. Sin él, no.

### Lo que sigue siendo nuestro

Los hallazgos llegan como **sospechas fundadas**, no como verdades. Se corren las verificaciones que el propio reporte propone, se discute lo que aparezca, y recién ahí se decide qué se arregla. Un hallazgo que no resiste su verificación se descarta y se dice: que dos de diez no resistieran es información sobre el método, no un accidente que convenga olvidar.
