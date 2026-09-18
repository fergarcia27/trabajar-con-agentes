---
name: no-commitear-sin-que-lo-pidan
description: Cuando el trabajo esté terminado y verificado y el commit parezca el paso obvio.
origen: Sin Ruido
---

El 20/08/2026 el usuario frenó un commit ya redactado de un cambio a `specs/roadmap.md`: *"No hagamos el commit todavía. No es necesario, ya quedó en el roadmap."*

Venía de commitear cinco veces seguidas por iniciativa propia en la misma sesión (etapas 2, 3, 4, el guardia de N+1 y el baseline). Ninguno molestó, pero eran unidades de trabajo cerradas con código y tests. El que frenó era una edición de documentación.

**Why:** el estado del árbol es del usuario, y con flujo-de-branches-post-1.0 ya establecido —a `main` solo pasa lo pulido y lo decide él— la misma lógica aplica a cuándo se corta un commit. Un cambio de docs no necesita el suyo propio; puede viajar con el trabajo que lo motive.

**How to apply:** terminar el trabajo, verificarlo y **reportar el estado**, dejando los cambios en el árbol. Ofrecer el commit en vez de hacerlo. Si el usuario dice "commiteá" o encadena tareas con un "seguí", ahí sí. No asumir que trabajo terminado equivale a permiso para commitear.
