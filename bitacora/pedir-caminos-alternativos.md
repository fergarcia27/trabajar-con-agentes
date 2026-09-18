---
name: pedir-caminos-alternativos
description: Antes de comprometerte con un plan único en una decisión de diseño no trivial.
origen: Sin Ruido
skill: dos-caminos
---

Cuando le propongo una solución a un problema de diseño, el usuario pregunta seguido *"¿existe alguna alternativa?"* o pide directamente **dos caminos con pros y contras** en vez de un plan único. El 20/08/2026 lo hizo tres veces en una sesión, y **las tres veces la exploración cambió la decisión para mejor**:

- Caché de `robots.txt`: mi propuesta era un TTL por reloj; la alternativa —atarla a la corrida— resultó mejor y eliminaba un acoplamiento en vez de crearlo.
- Punto 2 del backlog: comparar "protocolo nativo por proveedor" contra "un solo protocolo" reencuadró todo el diseño.
- Etapa 1: elegir entre construir por capas o una rebanada vertical cambió el orden de todo el trabajo.

**Why:** no es indecisión sino método. Mi primera propuesta suele ser la más obvia, no la mejor, y ponerla al lado de otra obliga a explicitar los supuestos. También le sirve a él para entender el espacio de decisión, no solo mi conclusión.

**How to apply:** ante una decisión de diseño no trivial, presentar **dos caminos genuinamente distintos** —no dos variantes del mismo— con sus contras honestos, y **cerrar con una recomendación propia**, no dejarlo abierto. Si mientras las comparo descubro que mi primera opción era peor, decirlo explícitamente. Encaja con la regla de oro de `CLAUDE.md`: debatir la decisión antes de tomarla en silencio dentro del código.
