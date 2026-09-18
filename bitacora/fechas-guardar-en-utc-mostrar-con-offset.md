---
name: fechas-guardar-en-utc-mostrar-con-offset
description: Cuando guardes, devuelvas o compares fechas; cuando una hora aparezca corrida; o cuando el front y el back no coincidan en qué día es algo.
origen: Sin Ruido
---

La regla es vieja y conocida: **guardar en UTC, mostrar en la zona del que
mira**. Lo que este caso agrega es *por qué la segunda mitad no es cosmética*, y
qué forma tiene la falla cuando se saltea.

## La cadena de tres, en una tarde

**1. Tres campos de fecha salían sin convertir.** El proyecto tiene la regla
escrita en un módulo dedicado, con tres motivos y un incidente previo. Escribí
dos endpoints nuevos y en los tres campos usé el `isoformat` crudo en vez del
conversor. La pantalla mostraba todo **tres horas adelantado**.

**2. Arreglar eso rompió una comparación escrita veinte minutos antes.** El
contador de una burbuja comparaba `evento.ultima_vez` contra una marca de «ya lo
vi», **como texto**. Andaba mientras los dos lados fueran UTC sin sufijo. Cuando
el motor pasó a mandar `-03:00`, `"17:16:08-03:00" > "21:00:21"` da falso
siempre: ningún evento contaba como nuevo y la burbuja quedaba apagada para
siempre. **Sin ruido, sin excepción, sin test en rojo.**

**3. Y el test del arreglo destapó lo de fondo.** Al comparar con `Date` en vez
de texto, probé también el formato viejo: **JavaScript interpreta un ISO sin
zona como hora local, no como UTC.** `2026-09-12T20:16:08` --que el motor mandaba
pensándolo en UTC-- se leía como las 20:16 de Buenos Aires: 23:16 UTC.

O sea que el formato viejo ya estaba mal para cualquier consumidor. No era feo:
era ambiguo.

## Lo transferible

**El offset explícito es lo que hace que una fecha signifique una sola cosa.**
Sin él, cada consumidor adivina la zona — y el de JavaScript, que es el más
probable, adivina *local*. Una fecha sin zona no es «UTC por convención»: es una
fecha rota esperando a alguien que la lea.

**No compares fechas como texto.** Comparar ISO-8601 lexicográficamente es
válido *sólo* si los dos lados tienen exactamente el mismo formato y la misma
zona — o sea, sólo mientras nadie toque nada. Cuando funciona, funciona de
casualidad, y eso es peor que si fallara: nadie lo mira hasta que algo alrededor
cambia. `Date`/`Instant` y comparar instantes.

**Una convención que se respeta a mano se va a violar.** El módulo estaba
escrito, documentado y con un incidente adentro, y me la salteé en tres campos
el mismo día. Lo que la haría cumplir es un test que recorra el esquema de la
API y verifique que **todo campo de fecha trae offset** — igual que el guardián
que en este proyecto obliga a documentar cada ruta nueva. Anotado y no hecho.

## Los tres motivos del proyecto, que valen para cualquiera

Vale copiarlos porque son concretos y ninguno es teórico:

1. **Las ventanas de tiempo se corren en silencio.** Una fecha que llega en UTC
   comparada contra un «ahora» local desplaza la ventana tres horas sin que
   nada falle a la vista.
2. **Puede haber un contrato.** Acá el payload al back-end promete UTC con `Z`,
   y eso lo firma otro equipo.
3. **Ya había pasado**: una firma HMAC calculada con `datetime.utcnow().timestamp()`
   --que interpreta un naive como local-- salía corrida tres horas y el receptor
   rechazaba todo con 401.

Ver [[la-salida-de-un-modelo-es-una-frontera-de-confianza]]: es la misma familia
de borde mal marcado, con otro tipo de dato.
