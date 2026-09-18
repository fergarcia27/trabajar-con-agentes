---
name: una-decision-escrita-se-puede-revertir
description: Al documentar una decisión de diseño: qué anotar para que mañana se pueda revisar en vez de re-discutir desde cero.
origen: Sin Ruido
skill: documentar-decision
---

El 09/09/2026 recomendé meter un updater en la app de escritorio, con dos
premisas escritas: que habría una población de instalaciones inalcanzable a
mano, y que agregarlo tarde es caro porque la clave pública se compila dentro
del binario.

El 10/09 el usuario declaró que motor y app son **una unidad con un solo número
de versión**. Con eso la primera premisa se cayó (la población es el equipo) y la
segunda quedó cierta pero sin efecto: bajo ese modelo **no hay nada coherente que
el updater pueda entregar**, porque cualquier versión nueva incluye al motor y el
updater sólo entrega la ventana.

**Why:** la reversión costó un párrafo, y sólo porque las premisas estaban
escritas por separado del resultado. Se pudo señalar cuál cayó y por qué. Una
decisión anotada como «decidimos usar updater» no se revisa: se vuelve a discutir
desde cero, y esta vez con el sesgo de que ya está construida.

**How to apply:** al documentar una decisión, escribir **de qué depende**, no sólo
qué se eligió. Cuando algo la da vuelta, dejar la reversión en el mismo lugar con
el motivo, en vez de reescribir la historia — el commit `bbd8108` dice
explícitamente que revierte la recomendación de dos días antes y cuál de sus dos
premisas se cayó.

Corolario barato: el que descarta también se escribe. Este proyecto guarda lo
evaluado y descartado en `specs/change_logs.md` — 3.673 líneas — y eso es lo que
evita re-proponer lo mismo dos veces. Ver gemini-tier-gratuito-decidido.
