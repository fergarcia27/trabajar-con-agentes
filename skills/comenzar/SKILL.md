---
name: comenzar
description: Preparar un proyecto para trabajar con este método — el CLAUDE.md y la carpeta specs/. Sirve igual para uno nuevo y para uno que ya tiene código: detecta cuál es y toma el camino que corresponde. Se corre una vez por proyecto.
disable-model-invocation: true
---

Deja el proyecto listo para trabajar así: un `CLAUDE.md` que sirve de índice y una
carpeta `specs/` con los cinco documentos. **Se corre una vez por proyecto.**

Hay dos caminos y **no los elige el usuario**: la diferencia es mecánica y se
detecta. Elegir mal tiene un costo real —pisar lo que ya estaba, o codificar
accidentes como si fueran reglas— y no es trabajo de quien recién llega.

## Primero: mirá qué hay

| lo que encontrás | camino |
|---|---|
| Carpeta vacía, o sólo un `README` y un `.gitignore` | **Nuevo** |
| Código con historia: varios commits, módulos propios, tests | **Adoptar** |
| Andamio recién generado y sin tocar | **Nuevo**, aunque haya archivos |

**El tercero es el que se pasa por alto.** Un proyecto recién salido de un generador
—`create-react-app`, `cargo new`, un template— **tiene código pero no tiene
decisiones**. Contar patrones ahí escribiría los defaults del framework como si
fueran convenciones del equipo. Se distingue por el historial: dos commits y uno
dice "initial commit" es andamio, no proyecto.

Si hay `CLAUDE.md`, `AGENTS.md`, `specs/`, `CONTRIBUTING.md` con convenciones, o
configuración de otra herramienta de agentes, **es adoptar**, sin importar lo demás.

**Decí en voz alta cuál elegiste y por qué**, antes de seguir. Si el usuario ve que
te equivocaste, ese es el momento barato de corregirlo.

---

# Camino A — proyecto nuevo

Las convenciones acá son una **decisión** que se toma. No hay dónde leerlas.

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


---

# Camino B — proyecto que ya tiene código

Acá las convenciones **ya están escritas en el código**, así que preguntarlas es
pedirle al usuario que recite lo que el repo puede mostrar.

> La pregunta que importa no es *"¿cómo querés que sea?"* sino **"esto es lo que ya
> hacés, ¿es a propósito o es deriva?"**

## 1. Antes de nada: inventario de lo que ya está

No se escribe una línea hasta tener esto, y **nada de lo que aparezca se pisa**:

- `CLAUDE.md`, `AGENTS.md` o equivalente en la raíz.
- Convenciones ya documentadas: `CONTRIBUTING.md`, `docs/`, una guía de estilo.
- Otra herramienta de agentes: `.cursorrules`, `.github/copilot-instructions.md`,
  un `.claude/` del proyecto.
- Configuración de linter y formateador. **Lo que ya verifica una herramienta no va
  a `conventions.md`**: duplicarlo es pedirle a un revisor que gaste atención en lo
  que una máquina caza siempre.

**Si algo de eso existe, se suma, no se reemplaza.** Un `CLAUDE.md` ajeno se lee y
se propone qué agregarle, mostrando el texto; lo escribe el usuario o lo autoriza
explícitamente. Y si `CONTRIBUTING.md` ya documenta convenciones, `conventions.md`
**apunta a él en vez de copiarlo**: dos copias de una regla derivan, y gana la que
nadie relee.

## 2. Descubrir, no preguntar

Lo que se puede leer, se lee:

| de dónde | qué sale |
|---|---|
| La estructura de carpetas | Las capas, y si algo las cruza |
| Los archivos de tests | Dónde viven, cómo se nombran, contra qué límite prueban |
| El manifiesto de dependencias | Stack y versiones |
| `git log` reciente | Cómo se escriben los commits, cómo fluyen las ramas |
| El código, contado | Manejo de errores, logging, valores fijos, dónde va la config |

## 3. Contar, no ojear — la parte que separa convención de deriva

Este es el corazón de la skill. En cualquier repo con historia conviven **dos clases
de patrón**: los que alguien decidió, y los que simplemente pasaron. Escribir los
segundos en `conventions.md` **convierte cada accidente en ley**, y después el
revisor de convenciones los hace cumplir para siempre citando una regla que nadie
tomó. Es el peor resultado posible de adoptar el método.

La forma de distinguirlos no es la intuición, es el conteo:

- **38 de 40 módulos lo hacen** → es una convención, con dos violaciones. Va escrita,
  y las dos excepciones se nombran.
- **22 de 40** → **no es una convención**: son dos costumbres compitiendo. No se
  escribe ninguna como regla; se lleva a la entrevista.
- **6 de 40** → o es deriva, o es una migración a medias. Hay que preguntar cuál.

Un repo a mitad de una migración tiene patrón viejo y patrón nuevo conviviendo, y
**los dos son reales**. Ahí lo correcto no es elegir por el usuario: es escribir
*"hay dos, éste es el destino y aquél es lo que queda por migrar"*.

## 4. Recién ahora, la entrevista

Corta, y de **confirmación**, no de invención. Usá la disciplina de `grillar`.

Presentá lo que encontraste con su número al lado y preguntá sólo lo que el código
no puede contestar:

- **Los patrones repartidos** del punto anterior: cuál es el destino.
- **Qué NO hace el proyecto.** Nunca está en el código, y es la pregunta que más
  ahorra después.
- **El objetivo real**: entregar, aprender, portfolio, un problema propio.
- **Las restricciones** que no se ven: costos, cuotas, qué máquinas hay, qué
  decisiones ya están cerradas y no se re-litigan.

## 5. Escribir

Las mismas plantillas del camino A, con dos diferencias:

**`conventions.md` sólo lleva lo confirmado.** Lo que quedó en duda va en una
sección aparte —*"patrones observados, sin confirmar"*— y **no** se le entrega al
revisor de convenciones hasta que alguien lo resuelva. Una regla dudosa que se hace
cumplir es peor que una regla faltante.

**`roadmap.md` arranca con lo que ya existe.** El proyecto tiene fases cumplidas
aunque nadie las haya escrito: reconstruilas del código y del historial, marcá dónde
está parado hoy, y recién después el backlog.

`change_logs.md` arranca vacío. Las decisiones viejas no se inventan
retroactivamente: se anotan cuando alguien las recuerde y las confirme.

## 6. Lo que no se adopta

**El `~/.claude/CLAUDE.md` global no es parte de esto.** Aplica a *todos* los
proyectos de esa máquina, incluido el del trabajo. Reglas personales —el idioma,
quién decide el commit— pueden chocar con las de un equipo. Si el proyecto es
compartido, lo que corresponda al equipo va en el `CLAUDE.md` **del proyecto**.

## Al terminar

Decí tres cosas, separadas:

1. **Qué se escribió**, y de dónde salió cada parte.
2. **Qué quedó sin confirmar** y por lo tanto sin efecto.
3. **Qué había antes y se respetó**, con su ubicación. Quien lea después tiene que
   saber que hay convenciones vivas fuera de `specs/`.
