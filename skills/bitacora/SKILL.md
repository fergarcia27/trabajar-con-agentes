---
name: bitacora
description: Consultar las lecciones medidas de proyectos anteriores antes de decidir, y anotar las nuevas. Usar antes de optimizar algo por lento o cuadrático, elegir o calibrar un agrupamiento, escribir un test sobre una constante o un umbral, guardar o mostrar fechas y zonas horarias, persistir o desescapar la salida de un modelo, montar una sonda para diagnosticar, decidir qué es público y qué privado en un repo, o cerrar una tanda de trabajo.
---

Las lecciones que sobrevivieron al proyecto donde se aprendieron viven en
`~/.claude/metodo/bitacora`, que el instalador deja enlazado. Cada archivo es **una
lección con su caso medido**. Ninguna se carga sola: hay que ir a buscarlas.

## Cómo encontrar la que sirve

Un solo comando lista todo el vault con la situación que activa cada nota:

```bash
cd ~/.claude/metodo/bitacora && \
  grep -rH "^description:" --include="*.md" . | sed 's|^\./||; s/\.md:description:/  ->/'
```

**No hay índice escrito acá a propósito.** Un listado en este archivo sería una
segunda copia de las descripciones, y las dos copias derivan. La fuente es el
frontmatter.

Leé la nota entera sólo cuando su descripción coincide con lo que estás por
decidir. Traen el número medido, que es lo que distingue una conclusión de una
preferencia.

## Lo general y lo de un proyecto

- **`bitacora/`** — sirve en un repo que todavía no existe.
- **`bitacora/proyectos/<proyecto>/`** — restricciones y decisiones cerradas de
  **ese** proyecto, para no re-litigarlas. **Una carpeta por proyecto.** Sólo
  aplican si estás trabajando ahí; desde otro repo son ruido.

Una nota de proyecto lleva `origen: <Proyecto>` en el frontmatter y su
`description` **arranca nombrando el proyecto** —`Sólo en Sin Ruido: …`— para que
al listar el vault se vea de una si aplica o no.

## Al escribir una nota nueva

Al cerrar una tanda: *¿qué aprendimos que no sea sobre este proyecto?* Casi
siempre la respuesta es nada, y está bien.

Si hay algo, se escribe con estas tres reglas:

**Una lección por archivo.** La prueba es: *¿alguien buscaría esto por su cuenta,
sin saber que la otra nota existe?* Si sí, y está enterrado en la sección 4 de un
documento sobre otra cosa, es inencontrable. La contraprueba, para no astillar el
vault: *¿tiene su propio caso medido?* Si no, es una sección, no una nota.

**El `description` es la llave de búsqueda, así que nombra la situación que
activa la nota, no lo que la nota contiene.** Es lo mismo que vale para el
`description` de una skill. Un resumen no se encuentra:

- Resumen, no sirve: *«Las familias de clustering y qué pregunta decide cuál usar»*
- Disparador, sirve: *«Cuando haya que elegir cómo agrupar elementos parecidos, o
  un clustering esté fragmentando el mismo hecho en varios grupos»*

**El número va adentro.** Una disciplina sin su caso es una preferencia; con el
número medido al lado es una conclusión.

### Si la nota es una elección de tecnología

Ahí la forma atómica no alcanza: una elección de stack tiene alternativas, una
restricción que decidió, y consecuencias con las que después se convive. Se
escribe como un ADR **más tres campos que un ADR no tiene**:

- **Qué lo decidió de verdad.** Una sola restricción, no la tabla comparativa.
  Casi siempre es una.
- **Cuándo NO replicarlo.** Las condiciones que darían vuelta la elección. Es lo
  que hace que sirva en otro proyecto en vez de ser un recuerdo.
- **Qué pasó con las razones**, revisado después con un número. Este es el que
  más rinde: en [[elegir-el-caparazon-de-una-app-de-escritorio]], dos de las tres
  razones para elegir Tauri no se sostuvieron —el shell "mínimo" terminó siendo
  el 38% del código, y el updater nunca se usó— y la decisión fue correcta igual.
  Sin esa revisión, la nota habría repetido un argumento falso a los próximos
  proyectos.

Enlazá a las notas relacionadas con doble corchete — sirve para el grafo de
Obsidian y, sobre todo, para llegar de una lección a la de al lado.
