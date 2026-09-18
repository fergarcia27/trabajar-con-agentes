# Reglas de este repo

Este repo es el método: cómo se trabaja, no qué se construye. Lo que se construye
vive en los otros proyectos.

## Estructura

- `skills/<nombre>/SKILL.md` — una carpeta por skill, **plano, sin buckets**. Matt
  Pocock agrupa en `engineering/` y `productivity/` porque tiene 38; con diez los
  buckets son ceremonia. Si algún día pasa de ~15, ahí se agrupan.
- `global/CLAUDE.md` — lo que se copia a `~/.claude/CLAUDE.md`. Aplica en cada
  sesión de cada carpeta, así que **cada línea que se agregue ahí se paga en cada
  turno**. Solo reglas de comportamiento, nunca disciplina completa.
- `scripts/instalar.ps1` — junctions a `~/.claude/skills/`.

Los archivos auxiliares de una skill (plantillas, referencias) van **adentro de su
carpeta**, no en el nivel superior: la junction enlaza `skills/<nombre>/`, así que
una carpeta hermana queda fuera del alcance de la skill instalada.

## Al escribir una skill

- **El `description` del frontmatter es lo que decide cuándo se dispara**, así que
  nombra los casos concretos que la activan, no lo que la skill es. Es lo único
  que está cargado siempre: se paga en cada turno, aunque nunca dispare.
- **`disable-model-invocation: true`** en las que solo se invocan tipeándolas.
  Sin eso, se dispara sola.
- **Prompteá en positivo.** Prohibir una conducta la trae al contexto y la vuelve
  más disponible, no menos: decí cuál es la conducta buscada en vez de cuál está
  prohibida.
- **Nada de no-ops.** Una instrucción que el modelo ya cumple por default paga
  tokens para no decir nada. La prueba es si cambia el comportamiento respecto del
  default, y se resuelve corriéndola, no discutiéndola.
- **Un ejemplo medido vale más que un adjetivo.** "500 copias de la misma URL
  daban 501 pedidos reales" ancla mejor que "puede ser costoso".

## Al agregar o renombrar una skill

Volvé a correr `scripts/instalar.ps1` y actualizá el `README.md`. Una skill que
existe pero no está enlazada no se dispara nunca; una que está en el README y ya
no existe es un índice que miente.
