---
name: medir-donde-se-ve-no-donde-dice-el-ticket
description: Cuando un ticket o una nota vieja ya traiga escrita la causa del bug, o cuando una búsqueda para descartar un problema dé cero resultados.
origen: Sin Ruido
skill: auditar-contra-la-fuente
---

Una síntesis salió publicada con *"Franco Colapinto logr3 el noveno puesto en la
clasificaci&#243;n del Gran Premio de Espa&#241;a"*. El bug estaba anotado en el
backlog hacía tres semanas, con la causa ya escrita:

> *"Vale medir primero cuál de las dos vías (el `content:encoded` del feed o
> `trafilatura`) lo deja pasar, antes de agregar un `html.unescape` a ciegas."*

**Las dos vías estaban limpias.** Las nueve noticias fuente del cluster no tenían
una sola entidad. Quien escapaba los acentos era **el modelo**, en su respuesta.
Arreglar la ingesta no habría cambiado nada.

## Los cuatro pasos que llevaron ahí

**1. Se atribuyó la causa sin verla.** El ticket nombra dos culpables y pide
elegir entre ellos. Los dos eran inocentes, y no había forma de descubrirlo
mientras la pregunta fuera "¿cuál de estos dos?".

**2. La hipótesis se escribió como hallazgo.** No dice "sospechamos que es la
ingesta": dice *medí cuál de las dos*. Un ticket con la causa adentro deja de
ser una observación y pasa a ser una instrucción — y las instrucciones se
siguen.

**3. Yo confirmé el error en la misma dirección.** Medí `contenido_limpio` de las
noticias, dio cero, y reporté "el síntoma no se reproduce". **Medí donde el
ticket decía que estaba el problema**, no donde el problema se ve. El usuario
encontró un caso vivo en cuatro minutos mirando el producto.

**4. La red era más angosta que el fenómeno.** Busqué `&[a-z]+;` — una de las
tres formas que resultaron existir. El percent-encoding (`respald%f3`) y los
acentos directamente ausentes no matcheaban, y un campo entero
(`comparativa_enfoques`) ni lo miré. El "cero" no era falso: era incompleto.

## Las reglas que salen

**Medí donde el síntoma se ve, no donde el ticket dice que está la causa.** Si el
bug se ve en lo publicado, la primera consulta va contra lo publicado. La
atribución de causa es una hipótesis para refutar, no un punto de partida.

**Escribí los tickets separando lo observado de lo sospechado.** *"38 de 5.390
cuerpos tienen entidades"* es un hecho. *"medí cuál de las dos vías lo deja
pasar"* es una conclusión disfrazada de tarea. La segunda contamina a quien lo
retome tres semanas después — incluido vos.

**Cuando midas para descartar, usá una red más ancha que tu hipótesis.** Buscá el
síntoma en su forma más general (*"¿hay algo raro en este texto?"*) antes de
buscarlo en la forma que suponés. Un cero con la red angosta se lee igual que un
cero de verdad.

**Y desconfiá del cero redondo.** Es la misma regla que ya dejó
[[auditar-contra-la-fuente-no-el-titulo]] con un "20/20 rechazadas" que resultó
ser un bug propio. Acá el redondo fue un **0 de 4.766** que resultó ser la
pregunta equivocada.

Ver [[la-salida-de-un-modelo-es-una-frontera-de-confianza]] para el hueco
estructural que lo dejó pasar.
