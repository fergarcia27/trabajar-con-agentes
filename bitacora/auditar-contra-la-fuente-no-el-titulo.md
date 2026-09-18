---
name: auditar-contra-la-fuente-no-el-titulo
description: Cuando haya que juzgar si dos textos tratan del mismo tema, evaluar resultados de clustering o similitud, o cuando una medición dé un número sospechosamente redondo. Ir al dato primario, no al campo derivado.
origen: Sin Ruido
skill: auditar-contra-la-fuente
---

Cuando declaré que dos pares del clustering eran falsos positivos, el usuario
frenó la conclusión: *"¿estás seguro de ello? Habría que leer la noticia en
cuestión y compararla con el foco que tiene el cluster."*

Yo había juzgado **por los títulos**. Al leer los cuerpos el veredicto sobre
los pares no cambió, pero **el diagnóstico sí, y en lo importante**: el
problema no era que los medios nuevos trajeran ruido, sino que los clusters de
destino ya estaban mal armados desde antes (el "blob de economía"). La
conclusión que iba a entregar tenía la causa equivocada.

**Why:** en este proyecto los números de similitud engañan sistemáticamente
cuando no se miran los casos — está documentado dos veces en
`specs/change_logs.md` como lección de método ("no diagnosticar sobre una sola
observación"). El `titulo_evento` de un cluster es apenas el título de su
primera noticia, así que ni siquiera describe el foco del grupo; y la
similitud se calcula sobre título + los primeros `EMBEDDING_CHARS_CUERPO`
caracteres, no sobre el título.

**How to apply:** antes de afirmar que un par es correcto o falso, imprimir el
texto que realmente se vectorizó de los dos lados, y la similitud contra
**cada miembro** del cluster además del centroide. Vale para cualquier
veredicto sobre resultados del motor, no solo clustering: si la afirmación se
apoya en un campo derivado (un título, un contador, un resumen), ir a la
fuente primero. Y sospechar de los resultados demasiado redondos — un
"20/20 rechazadas" el mismo día resultó ser un bug mío, no un dato.

Ver flujo-de-branches-post-1.0 para dónde vive este trabajo.
