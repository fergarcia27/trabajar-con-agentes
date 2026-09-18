# Método

Una forma de trabajar con agentes de código, en un solo lugar y viva en todos tus
proyectos. No es un framework ni una librería: son **instrucciones** que el agente
lee, más **plantillas** para arrancar un proyecto con el pie derecho.

Si recién empezás a trabajar con agentes, el problema que esto resuelve es este: el
agente es bueno escribiendo código y malo adivinando qué querés. Todo lo que hay acá
apunta a cerrar esa brecha antes de que escriba una línea, y a que lo que sale se
pueda verificar.

Las skills de ingeniería están adaptadas de [mattpocock/skills](https://github.com/mattpocock/skills).

---

## Qué hay adentro

**`skills/` — disciplinas.** Cada una es un archivo con instrucciones sobre cómo
hacer una cosa bien. La mayoría **se disparan solas**: cada skill declara en qué
situaciones aplica, y el agente la carga cuando esa situación aparece. No hay que
acordarse de pedirlas.

Las que hay:

| se disparan solas | |
|---|---|
| `documentar-decision` | Debatir la decisión antes; después dejarla escrita con lo que se descartó |
| `dos-caminos` | Dos caminos genuinamente distintos, contras honestos, y una recomendación |
| `verificar-de-verdad` | Correr lo que nunca corrió; no re-correr lo que ya corrió; separar lo corrido de lo deducido |
| `medir-antes-de-resolver` | No resolver lo que todavía no pasó; y cuando medís, el número queda escrito |
| `mutacion` | Romper cada protección a propósito y confirmar que un test la caza |
| `tdd` | Rojo → verde, con los límites acordados antes |
| `auditar-contra-la-fuente` | Ir al dato primario, no al campo derivado. Desconfiar de lo redondo |
| `bitacora` | Consultar las lecciones de proyectos anteriores antes de decidir |

| las tipeás vos | |
|---|---|
| `/iniciar-proyecto` | Entrevista y arma el `CLAUDE.md` y el `specs/` de un proyecto nuevo |
| `/grillar` | Interrogatorio por rondas hasta que no quede rama sin resolver |
| `/revisar` | Revisión en varios ejes, con un agente por eje en paralelo |

**`agents/` — un equipo.** Cuatro ayudantes que se invocan por nombre y trabajan
aislados, cada uno con una sola responsabilidad. Los nombres son de dibujos animados
con el mismo oficio, que es más fácil de recordar que "revisor-de-convenciones":

| | qué hace |
|---|---|
| **dexter** | Escribe los tests desde los requisitos, **sin ver tu código**, para que no hereden tus suposiciones |
| **hermes** | Revisa que esté construido como tu proyecto dice que se construye. No sabe nada del negocio |
| **velma** | Busca dónde lo que el código *afirma* y lo que *hace* dejaron de coincidir |
| **perry** | Busca qué puede salir hacia donde no debe, y qué puede entrar sin control |

**`bitacora/` — el porqué.** Las skills dicen qué hacer; acá está el caso medido que
hizo que cada regla exista. Más abajo hay una advertencia importante sobre esto.

**`skills/iniciar-proyecto/plantillas/` — los documentos** que todo proyecto nuevo
recibe, ya escritos, para llenar con una entrevista y no a mano.

---

## Instalación

```powershell
git clone <este-repo> metodo
cd metodo
.\scripts\instalar.ps1
```

Eso crea enlaces desde `~/.claude/` hacia este repo, así que **editás el repo y el
cambio está vivo en todos tus proyectos**, sin copiar nada a ninguno. Volvé a
correrlo cuando agregues o renombres una skill o un agente.

Una vez más, a mano: copiá `global/CLAUDE.md` a `~/.claude/CLAUDE.md`. Ese archivo
se carga en **cada** sesión de **cada** proyecto, así que conviene que sea corto y
que diga sólo cómo querés que te traten: idioma, si el commit lo decidís vos, ese
tipo de cosas. Tomá el de acá como ejemplo y escribí el tuyo.

> **El instalador es de Windows.** Usa *junctions* y no *symlinks* porque en Windows
> un symlink pide permisos de administrador, y `ln -s` desde Git Bash sin ellos hace
> una **copia silenciosa** — que es justo la deriva que esto viene a eliminar. En
> Mac o Linux el equivalente es un `ln -s` por skill hacia `~/.claude/skills/`, más
> uno para `agents/` y otro para la raíz del repo hacia `~/.claude/metodo`.

---

## Empezar un proyecto

Esta es la parte que más rinde y la que más se saltea.

**1. Abrí tu proyecto y corré `/iniciar-proyecto`.**

Se corre **una vez por proyecto**. Lo primero que hace no es escribir: es
**entrevistarte**. Te va a preguntar qué es el proyecto y para quién, qué **no**
hace, cuál es el objetivo real —entregar algo, aprender una tecnología, un
portfolio— y con qué stack, qué es fijo y qué es negociable.

Contestá con calma. De esas respuestas salen tu `CLAUDE.md` y tu carpeta `specs/`,
que son el contexto que el agente va a leer en cada sesión de ahí en adelante. Un
`specs/` lleno de `<TODO>` es peor que no tenerlo: **parece contexto y no lo es.**

**2. Cuando tengas algo que construir, corré `/grillar` antes de escribir código.**

Es un interrogatorio por rondas sobre tu plan. Existe por un motivo concreto:

> El modo de falla más común no es el código malo: es **haber entendido otra cosa**.

Te pregunta todo lo que se puede preguntar ahora, esperá, y tus respuestas abren la
siguiente ronda. Termina cuando no queda ninguna rama sin resolver. Es incómodo las
primeras veces y ahorra tardes enteras.

**3. Construí.** Las skills se van disparando solas según lo que estés haciendo.

**4. Cuando cierres una tanda, corré `/revisar`.** Lanza a los revisores —hermes,
velma, perry— cada uno sobre su eje, en paralelo y aislados, y te devuelve los
hallazgos separados por eje para que uno no tape al otro.

---

## La bitácora, y una advertencia

`skills/` dice **qué hacer**. `bitacora/` guarda **por qué**: el caso medido que hizo
que cada regla exista. La idea que la sostiene:

> Una disciplina sin su caso es una preferencia. Con el número medido al lado es una
> conclusión.

**Y acá va la advertencia, porque es importante y es fácil de pasar por alto:** las
notas que estás recibiendo son mediciones **de otro proyecto**. Los números son
reales, pero no son tuyos.

Úsalas como **ejemplos trabajados**: sirven para ver qué forma tiene una lección que
vale la pena guardar, y varias son de oficio general —cómo elegir un agrupamiento,
por qué guardar fechas en UTC, qué chequear cuando persistís la salida de un
modelo—. Lo que **no** hay que hacer es tratarlas como si fueran evidencia de tu
sistema.

[`bitacora/000-Evidencia.md`](bitacora/000-Evidencia.md) es la tabla de qué caso
sostiene a cada disciplina — **incluidas las que todavía no tienen ninguno**, que
figuran así a propósito: una disciplina que no se ganó su caso se sigue usando, pero
se revisa con más ganas.

Lo que sigue es empezar la tuya. El hábito es uno solo, al cerrar una tanda de
trabajo:

> **¿Qué aprendimos que no sea sobre este proyecto?**

Casi siempre la respuesta es «nada», y está bien. Cuando no lo sea, escribila. Las
reglas de cómo se escribe una nota están en `skills/bitacora/`.

---

## Esto es tuyo ahora

Nada de acá es sagrado. Fue calibrado con los errores de un proyecto concreto, y los
tuyos van a ser otros.

Lo que sí sugeriría conservar, porque es lo que hace que el resto funcione:

- **Que las decisiones de diseño se debatan antes y queden escritas después**, con
  lo que se descartó y por qué. Una decisión anotada sólo como resultado no se
  revisa: se re-discute desde cero.
- **Que lo medido gane sobre lo supuesto.** La mayoría de las notas de la bitácora
  existen porque una medición dio vuelta una decisión que ya estaba tomada.
- **Que quien escribe los tests no sea quien escribió el código**, cuando se pueda.

El resto —los nombres, el idioma, qué skills tenés, cuántos revisores corren—
cambialo sin culpa.
