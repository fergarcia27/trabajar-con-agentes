---
name: medir-tumba-el-propio-diseno
description: Cuando estés por descartar una opción por cara, lenta o compleja sin haberla medido — sobre todo si la estimación es tuya.
origen: Sin Ruido
skill: medir-antes-de-resolver
---

La skill dice no resolver preventivamente lo que todavía no pasó. El corolario
que este proyecto agregó es más incómodo: **medir suele dar vuelta la decisión
que ya tomaste**, no confirmarla.

**El panel que escondí por caro, y no lo era (11/09/2026).** Diseñé el panel de
composición detrás de un botón «Calcular», suponiendo que recorrer todas las
noticias agrupadas sería lento. Medido: **13–335 ms**, contra 3 ms de listar los
medios. Diez veces más y aun así imperceptible. Estaba escondiendo un dato útil
por una suposición de costo que nunca comprobé. Pasó a cargarse solo.

**La regla de dominio que habría roto un medio que funciona.** Para impedir que
se apunte un medio al feed de otra redacción, la regla natural era «el feed vive
en el dominio del medio». La medí contra los ocho cargados antes de escribirla:
**Revista Gente declara `revistagente.com` y sirve su RSS desde `gente.com.ar`**.
La regla dura habría rechazado un medio que anda. Quedó una guarda que pregunta
en vez de bloquear.

**El panel refutó la premisa con la que se lo pidió.** Se construyó para
confirmar que el material huérfano lo generaban los medios de nicho. Su primera
corrida mostró lo contrario: las tres revistas de espectáculos son las que menos
generan (2-3,5%), y los huérfanos salen de los generalistas por amplitud — La
Nación sola aporta 65 de 130. La decisión de qué medio sumar cambió de signo.

**How to apply:** antes de esconder algo detrás de un botón, de cachearlo o de
optimizarlo, medilo una vez. Y cuando una regla parece obvia, corré la contra los
datos que ya tenés **antes** de escribirla: en este proyecto, dos de dos reglas
«obvias» tenían un contraejemplo entre ocho filas.

El caso simétrico también cuenta: `agrupar_pendientes` es cuadrático y está
medido (3,6 s con ~200 sueltas, ~14 s proyectado con 400) y **no se optimizó**,
porque el número todavía no compite con el ciclo de 15 minutos.
