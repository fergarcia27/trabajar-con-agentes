---
name: correr-la-verificacion-no-argumentar-equivalencia
description: Cuando estés por dar por buena una verificación que nunca corrió en este estado, o por re-correr una que ya corrió sobre el mismo contenido.
origen: Sin Ruido
skill: verificar-de-verdad
---

Dos correcciones del mismo día, en direcciones opuestas, que juntas dan la
regla.

**Primero, de menos:** antes de empujar `main`, `alembic check` se colgó porque
Docker estaba caído. Argumenté que no hacía falta re-correrlo —el árbol de
`main` era byte-idéntico al de la rama, donde el check ya había pasado—. El
usuario frenó el push: *"corre el alembic ahora que la db esta levantada"*.

**Después, de más:** tras el commit de README + versión, quise re-correr toda
la verificación sobre `main`. El usuario lo cortó: *"corrimos los test despues
de hacer los commits previos en main y ahora no cambiamos nada del producto.
Para mi anda derecho al tag"*.

**Why:** la distinción no es "el árbol es igual" sino **si el check llegó a
correr en ese estado**. En el primer caso `alembic check` nunca había corrido
—se colgó— y además no compara archivos sino el esquema vivo de Postgres, que
el árbol idéntico no prueba. En el segundo la suite sí había corrido sobre ese
mismo contenido, y lo único agregado después era README, docs y un string de
versión: nada que un test pudiera tocar. Re-correr ahí es ceremonia.

**How to apply:** si un paso de verificación falló, se colgó o se salteó,
levantar la infraestructura y correrlo — nunca sustituirlo por un razonamiento
de equivalencia. Si ya corrió y lo único que cambió desde entonces es
documentación o metadatos, decirlo y seguir. En el reporte previo a un push,
distinguir siempre qué se corrió de qué se dedujo, y dejar que el usuario
decida cuando sea discutible.

Ver [[no-commitear-sin-que-lo-pidan]] y flujo-de-branches-post-1.0.
