---
name: iniciar-proyecto
description: Preparar un proyecto nuevo con su CLAUDE.md y su carpeta specs/, a partir de una entrevista sobre qué es el proyecto.
disable-model-invocation: true
---

Deja el proyecto listo para trabajar con este método: un `CLAUDE.md` que sirve de índice y una carpeta `specs/` con los cinco documentos. Se corre **una vez por proyecto**.

## Antes de escribir nada, entrevistá

Las plantillas se llenan con lo que salga de la entrevista, no con marcadores para que alguien complete después. Un `specs/` lleno de `<TODO>` es peor que no tenerlo: parece contexto y no lo es.

Usá la disciplina de `grillar` —rondas, con tu recomendación en cada pregunta— sobre estas ramas:

1. **Qué es y para quién.** En una o dos oraciones. Si no sale corto, todavía no está claro.
2. **Qué NO hace**, explícito. Es la pregunta que más ahorra después: marca el borde que evita que el proyecto se vaya de tema.
3. **Cuál es el objetivo real**: ¿entregar algo que funcione, aprender una tecnología, un portfolio, resolverte un problema propio? Cambia todas las decisiones que siguen.
4. **Stack y versiones**, y qué es fijo y qué es negociable.
5. **Restricciones**: costos, servicios pagos, límites de cuota, qué máquinas hay.
6. **Fases**: qué es lo primero que tiene que existir para que esto sirva de algo.

Los hechos que puedas averiguar solo —qué hay en la carpeta, qué versiones están instaladas, si ya hay un repo git— buscalos, no los preguntes.

## Después, escribí

Copiá desde `plantillas/` de esta misma skill, reemplazando con lo que salió de la entrevista:

| Plantilla | Va a | Qué lleva |
|---|---|---|
| `CLAUDE.md` | raíz del proyecto | El índice. Corto: se carga en cada sesión |
| `mission.md` | `specs/` | Identidad: qué es, para quién, qué NO hace, el objetivo real |
| `conventions.md` | `specs/` | Cómo se escribe código **en este stack** |
| `tech_stack.md` | `specs/` | Versiones, comandos, puntos de quiebre a vigilar |
| `roadmap.md` | `specs/` | Fases, estado, y el backlog priorizado |
| `change_logs.md` | `specs/` | Arranca casi vacío, con el formato explicado |

**El método no se copia.** Cómo trabajamos vive en las skills y aplica solo, así que las plantillas no lo repiten: si `mission.md` volviera a listar las reglas de trabajo, empezaría a derivar de las skills al día siguiente. Lo que va en `specs/` es lo que **cambia entre proyectos**.

## Al terminar

Decí qué quedó escrito y qué quedó flojo. Un `specs/` recién creado siempre tiene alguna sección que la entrevista no alcanzó a llenar bien: nombrala, en vez de dejarla pasar como completa.
