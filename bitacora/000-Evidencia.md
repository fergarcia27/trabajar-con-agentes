---
name: 000-Evidencia
description: Para ver qué caso medido respalda a cada disciplina del método, y cuáles se siguen afirmando sin evidencia. Es el índice de la bitácora, no una lección.
---

# Qué sostiene a cada disciplina

Una skill sin un caso es una preferencia. Esta tabla es la que dice cuáles se
ganaron y cuáles todavía se afirman.

| Skill | El número o el caso | Dónde |
|---|---|---|
| `revisar` | Una revisión improvisada gastó **195.355 tokens en 47 llamadas** contra ~101.000 de leer todo una vez, y **2 de 10 hallazgos eran falsos** porque el agente montó una sonda que mockeaba lo que estaba probando. Con el encargo masticado: **9 hallazgos, ninguno falso**. | [[revisar-encargo-masticado-funciona]], [[revisar-exclusiones-y-cortes]] |
| `medir-antes-de-resolver` | El panel escondido por caro medía **13–335 ms contra 3 ms**. La regla de dominio «obvia» tenía **un contraejemplo entre ocho filas**. El panel refutó la premisa con la que se lo pidió. | [[medir-tumba-el-propio-diseno]] |
| `medir-antes-de-resolver` (2) | Un cuadrático anotado como deuda medía **1,33 s** después de sumar cuatro medios: evalúa **369** de **6.980** sueltas, porque la ventana lo acota. La proyección original nunca iba a cumplirse. | [[un-cuadratico-acotado-no-es-un-problema]] |
| `medir-antes-de-resolver` (3) | En un bucle con salida temprana el costo lo predice **la tasa de fallo, no el tamaño de la entrada**: 369 evaluadas, 369 sin match, ninguna salió por el camino barato. | [[el-driver-del-costo-es-la-salida-temprana]] |
| `mutacion` | Tres fallas de la comprobación, no de la mutación. La última: mutar la fuente sin regenerar los bindings que el test lee. | [[la-mutacion-tiene-que-llegar-a-lo-que-el-test-lee]] |
| `mutacion` (2) | **Dos veces el mismo día**: un test que lee la misma constante que prueba se mueve con ella. Bajar el umbral de 1500 a 100, y la retención de 90 días a 1, no rompían nada. | [[un-test-que-lee-la-constante-no-la-protege]] |
| `verificar-de-verdad` | Dos correcciones el mismo día en direcciones opuestas: un `alembic check` que se colgó y quise sustituir por un razonamiento de equivalencia, y una suite que quise re-correr sobre contenido idéntico. | [[correr-la-verificacion-no-argumentar-equivalencia]] |
| `auditar-contra-la-fuente` | Juzgué pares de clustering **por los títulos**; al leer los cuerpos el veredicto no cambió pero **la causa sí**. Y un «20/20 rechazadas» demasiado redondo resultó ser un bug propio. | [[auditar-contra-la-fuente-no-el-titulo]] |
| `auditar-contra-la-fuente` (2) | Un bug anotado hacía tres semanas culpaba a la ingesta; **las nueve noticias fuente estaban limpias**. Y mi medición para descartarlo dio **0 de 4.766** porque buscaba una de las tres formas que resultaron existir. | [[medir-donde-se-ve-no-donde-dice-el-ticket]] |
| `dos-caminos` | Tres veces en una sola sesión la exploración **cambió la decisión para mejor**. | [[pedir-caminos-alternativos]] |
| `documentar-decision` | Revertir una recomendación propia costó un párrafo, porque las premisas estaban escritas aparte del resultado. | [[una-decision-escrita-se-puede-revertir]] |
| `tdd` | Escribir el arreglo antes que el test dejó **escapar una mutación**. | [[el-test-va-antes-que-el-arreglo]] |
| `grillar` | — | sin evidencia medida todavía |
| `comenzar` | — | sin evidencia medida todavía |

Las dos últimas filas no son un pendiente: son información. Una disciplina que
todavía no se ganó su caso se sigue usando, pero se revisa con más ganas.

## Conocimiento de oficio

No respalda una skill: es material que sirve en el próximo proyecto por sí solo.

- **[[fechas-guardar-en-utc-mostrar-con-offset]]** — el offset explícito no es
  cosmética: es lo que hace que una fecha signifique una sola cosa. JavaScript
  lee un ISO sin zona como hora **local**. Con la cadena de tres fallas que lo
  destapó en una tarde.
- **[[la-salida-de-un-modelo-es-una-frontera-de-confianza]]** — un esquema tipado
  valida la forma de lo que devuelve un LLM, no el contenido: `str` acepta
  `"logr3"` igual que `"logró"`. Con la lista de seis chequeos para el próximo
  proyecto que persista salida de un modelo.
- **[[elegir-el-caparazon-de-una-app-de-escritorio]]** — por qué Tauri sobre
  Electron y PyInstaller, y **la revisión un mes después**: el shell "mínimo" en
  Rust terminó siendo **3.113 líneas, el 38% del código**, y el updater —una de
  las tres razones— nunca se usó. Una capacidad que todavía no usaste no es una
  razón: es una esperanza.
- **[[el-desempate-importa-mas-que-el-umbral]]** — cambiar sólo cuál candidato
  gana, sin tocar el umbral ni el algoritmo, llevó de **50 clusters con 19 pares
  para fusionar a 26 sin ninguno**. El umbral es el número visible; el desempate
  es el que decide la forma del resultado.
- **[[un-indice-aproximado-cambia-exactitud-por-velocidad]]** — un índice
  vectorial aproximado cambia exactitud por velocidad, y **un match perdido no
  produce ningún error**: se ve igual que un verdadero negativo. Las tres
  preguntas antes de aceptar cualquier estructura que acelere buscando menos.
- **[[como-elegir-un-agrupamiento]]** — las cuatro preguntas del dominio que
  eligen la familia de clustering, y por qué acá k-means estaba descartado desde
  la primera. Con el caso donde cambiar **el desempate** (no el umbral) llevó de
  50 clusters con 19 pares para fusionar a 26 sin ninguno.
- [[como-realizar-apunte-metodo-zettelkasten]] — una manera de realizar los apuntes estableciendo relaciones entre los archivos de diferentes contextos y así poder relacionas temas de una mejor manera.

## Reglas que no son skills

- **Los `.env` y los archivos con secretos los maneja el usuario.** Salió de un
  incidente propio, y el arreglo estructural fue del `.gitignore`, no de la
  disciplina. [[los-env-los-maneja-el-usuario]]
- **El commit lo decide el usuario.** [[no-commitear-sin-que-lo-pidan]]
