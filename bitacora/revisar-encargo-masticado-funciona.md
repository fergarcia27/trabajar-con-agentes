---
name: revisar-encargo-masticado-funciona
description: Al preparar el encargo de una revisión con subagentes: qué pasarle masticado para que no gaste el triple y no invente hallazgos.
origen: Sin Ruido
skill: revisar
---

El 08/09/2026 se corrió `/revisar` sobre los bloques A1 y A2 (punto 11) antes de
commitear: dos ejes más el tercer par de ojos. **Nueve hallazgos, ninguno falso**,
contra los 2 de 10 que no resistieron en la revisión de referencia.

**Why:** la diferencia no fue el modelo — fue el encargo. El diff ya capturado en
un archivo, la lista explícita de archivos fuera del diff, los tres bloques
(exclusiones, cortes, aristas entrantes) y la prohibición de correr código.

**How to apply:** dos maniobras que no están en la skill y hay que repetir.

1. **Sacar del diff el archivo que arma la revisión.** Contenía las sospechas de
   quien escribió el código; pasárselas ancla a los revisores justo en los puntos
   ciegos que el tercer par de ojos existe para no heredar. Y declarar esa
   exclusión en los tres encargos.

2. **Si el diff reescribe el spec, extraer el spec como estaba antes**
   (`git show <base>:specs/roadmap.md`). Si no, el revisor compara el trabajo
   contra una descripción del trabajo — medir el propio mock, a nivel spec.

También sirvió darle al revisor de spec el dato que no vivía en ningún archivo:
que una desviación del plan había sido aprobada explícitamente, para que juzgara
si estaba bien fundada en vez de reportarla como incumplimiento.

Los dos defectos reales que trajo eran invisibles desde adentro: un `GET /` que
devolvía 500 en vez de 503 con la base caída —cubierto por un test que mockeaba
el síntoma— y un borrado accidental por una puerta lateral.
