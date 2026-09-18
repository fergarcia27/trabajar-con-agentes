---
name: como-elegir-un-agrupamiento
description: Cuando haya que elegir cómo agrupar elementos parecidos sin saber cuántos grupos hay, o cuando alguien proponga k-means. Las cuatro preguntas del dominio que eligen la familia.
origen: Sin Ruido
---

Escrito el 12/09/2026 repasando por qué Sin Ruido agrupa como agrupa. La
elección casi nunca la decide el algoritmo: la decide **una pregunta del
dominio**, y si esa pregunta se contesta primero, la familia sale sola.

## Las cuatro preguntas que eligen por vos

1. **¿Sabés cuántos grupos hay?** Si no, quedan afuera los que piden *k*.
2. **¿Los datos llegan todos juntos o de a poco?** Si llegan de a poco y hay que
   responder ya, quedan afuera los que necesitan el conjunto entero.
3. **¿Un elemento puede no pertenecer a ningún grupo?** Si sí, quedan afuera los
   que reparten todo por obligación.
4. **¿Los grupos se cierran alguna vez?** Si el tiempo importa, la ventana es
   parte del algoritmo, no un detalle.

## Las familias, y cuándo conviene cada una

**Particional (k-means y parientes).** Rápido, simple, escala bien. **Pide *k*
de antemano** y reparte *todo*: no existe el "esto no va con nada". Conviene
cuando el número de grupos es una decisión tuya y no un hallazgo — segmentar
clientes en tres niveles, comprimir colores de una imagen a 16.

**Jerárquico.** No pide *k*: construye el árbol entero y vos cortás donde
quieras. La contra es que **necesita todos los datos a la vez** y cuesta O(n²) o
peor. Conviene con pocos elementos y cuando la estructura de anidamiento es en
sí misma el producto — taxonomías, dendrogramas, análisis exploratorio.

**Por densidad (DBSCAN, HDBSCAN).** No pide *k*, encuentra formas raras, y
—clave— **tiene el concepto de ruido**: un punto puede no pertenecer a nada.
Conviene cuando los grupos tienen densidades parecidas y hay outliers legítimos
que no querés forzar adentro de un grupo.

**Incremental / online por umbral.** Cada elemento nuevo se compara contra los
grupos existentes y entra al primero que supera un umbral, o funda uno. No pide
*k*, procesa de a uno, y admite que algo no matchee. La contra es que **el
resultado depende del orden de llegada** y todo cuelga de un número —el umbral—
que hay que calibrar con casos reales.

## El caso: por qué Sin Ruido usa el último

Las cuatro preguntas, contestadas para "agrupar noticias que cubren el mismo
hecho":

1. **¿Cuántos grupos hay?** No se sabe — *cuántos hechos ocurrieron hoy* es
   justamente lo que el motor averigua. **Mata a k-means de entrada.**
2. **¿Llegan juntas?** No: entran cada 15 minutos, y una nota que hoy no matchea
   con nada puede matchear en dos horas cuando otro medio cubra el hecho. **Mata
   al jerárquico.**
3. **¿Puede no pertenecer a nada?** Sí, y es el caso más común: hoy **369
   evaluadas, 369 sin match**. Un medio que cubre algo que nadie más cubrió es
   normal, no un outlier a forzar.
4. **¿Se cierran?** Sí, a las 12 h. La ventana no es una optimización: es lo que
   define qué significa "el mismo hecho" — dos notas del mismo tema a cinco días
   de distancia son dos hechos.

Resultado: incremental por umbral (0,75 de similitud coseno) sobre una ventana
de 12 h.

## Lo que el caso enseñó y no sale en ningún manual

Que **el desempate entre candidatos importa más que el umbral**: cambiar sólo cuál
gana —un cluster que pasa el umbral, antes que una suelta más parecida— llevó de
50 clusters con 19 pares para fusionar a 26 sin ninguno, el mismo día, con el
mismo algoritmo. Tiene nota propia porque aplica a cualquier asignación
incremental — [[el-desempate-importa-mas-que-el-umbral]].

## Lo transferible

La familia no se elige por el algoritmo sino por las cuatro preguntas. Y la que
más descarta es la primera: **si no sabés cuántos grupos hay, y no saberlo es el
punto, todo lo que pide *k* está afuera** por más popular que sea.

Ver [[un-cuadratico-acotado-no-es-un-problema]] para el costo de este esquema.
