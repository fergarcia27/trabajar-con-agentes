---
name: la-salida-de-un-modelo-es-una-frontera-de-confianza
description: Cuando persistas o muestres lo que devuelve un LLM, cuando aparezcan caracteres corrompidos o texto ilegible, o al desescapar HTML.
origen: Sin Ruido
---

La respuesta del modelo entra por un esquema Pydantic: campos tipados, listas
con tope, enums cerrados. Todo validado. Y aun así se publicó *"clasificaci&#243;n
del Gran Premio de Espa&#241;a"*, porque **`str` es `str`**: acepta
`"Colapinto"`, `"logr3"` y `"clasificaci&#243;n"` exactamente igual.

Un esquema tipado valida **la forma**, no **el contenido**. Es un borde de
confianza sin guardia, y es fácil no verlo justamente porque hay un esquema —
tener validación se siente como estar validado.

## Lo que se observó en tres semanas

Un mismo modelo, un mismo prompt, tres esquemas de escape distintos:

    entidades HTML         clasificaci&#243;n
    percent-encoding       respald%f3, qu%f3rum
    acentos ausentes       presento, actualizacion

Y **conviviendo en la misma oración**: `logr3` roto al lado de `qued&#243;` y
`largar&#225;` intactos. Frecuencia: **4 de 338**, o sea 1,2%. Intermitente, que
es lo peor — no se reproduce cuando lo buscás y sale publicado cuando no mirás.

Un cuarto caso, `logr3`, no encaja en ningún esquema conocido y quedó sin
explicar. Vale anotarlo así en vez de inventarle una causa.

## La lista de antemano, para el próximo proyecto

Cualquier sistema que **persista o publique** lo que un modelo devuelve:

1. **Normalizá los escapes en el borde, al parsear.** No antes de persistir: si
   algo río abajo cuenta caracteres o matchea strings, tiene que ver el texto ya
   limpio. Acá había dos — el peso de un tuit (`&#243;` pesa 6, `ó` pesa 1) y el
   match de nombres de medios, que **descartaba enfoques en silencio**.
2. **Logueá cuando corrijas.** Arreglar callado es cómo un proveedor empeora sin
   que nadie se entere. El log es lo único que después deja medir si crece.
3. **Guardá una muestra cruda de la salida**, aunque sea rotada. Sin eso, cuando
   aparece un caso raro no hay con qué comparar.
4. **No confíes en que el escape sea consistente.** El mismo modelo puede usar
   tres esquemas el mismo día. Cubrí varios, no el que viste primero.
5. **Chequeá lo publicado, no lo ingerido.** Una consulta periódica sobre la
   salida final buscando escapes es barata y es la única que ve el problema
   entero. Ver [[medir-donde-se-ve-no-donde-dice-el-ticket]].
6. **Preguntate qué de la salida es identidad ya publicada.** Acá el título y el
   tópico **no se tocan** en una resíntesis, a propósito — renombrar algo que
   otro sistema ya publicó es peor que dejarlo. Eso significa que **una
   corrección posterior no puede llegar por el camino normal**: hubo que
   corregir por script. Vale saberlo antes de diseñar el reintento, no después.

## El cuidado al desescapar, que es un bug propio esperando

`urllib.parse.unquote` transforma **cualquier** `%` seguido de dos dígitos hex:
`"Subió 50%ed más"` se convierte en `"50í"`. Un mapa acotado de acentos **no
alcanza** — probado, el mapa igual matchea adentro de `50%ed`.

Lo que sí separa los casos es mirar **qué precede a cada cosa**: un porcentaje va
siempre después de un dígito, un acento escapado va después de una letra o abre
la frase. Un `(?<![0-9])`.

Lo cazó un test escrito para esa hipótesis, no el razonamiento. Es la forma
general: **cuando escribas una salvaguarda, escribí también el caso que la
salvaguarda promete proteger** — es la única manera de descubrir que no protege.

Ver [[el-test-va-antes-que-el-arreglo]].
