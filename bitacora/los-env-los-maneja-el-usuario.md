---
name: los-env-los-maneja-el-usuario
description: Antes de leer, editar, copiar o respaldar un `.env` o cualquier archivo con secretos reales.
origen: Sin Ruido
---

Regla puesta por el usuario el 09/09/2026: **los `.env` y cualquier archivo con
información sensible los maneja él.** Yo puedo leer la *forma* de un valor
(esquema, host, si está definido), nunca editarlos ni copiarlos.

**Why:** durante una prueba manual hizo falta sacar `API_TOKEN` un rato. Hice
`cp .env .env.respaldo-prueba5` antes de tocarlo. El `.gitignore` sólo cubría
`.env` **exacto**, así que ese respaldo —con todas las credenciales reales—
quedó como archivo sin rastrear en un repo **público**, mientras la sesión venía
corriendo `git add -A` para preparar commits. No llegó a commitearse, pero el
riesgo lo creé yo y por una comodidad mía.

**How to apply:** si una prueba necesita cambiar una variable de entorno, se lo
pido al usuario y le digo exactamente qué línea tocar y cómo dejarla después.
Yo hago la parte que no toca secretos: reconstruir el contenedor, medir el
resultado, restaurar el estado del servicio.

Estructural, ya hecho: el `.gitignore` pasó a `.env.*` con `!.env.example`, así
que la regla no depende de que alguien se acuerde. Ver
restriccion-costos-proyecto-propio para la otra restricción dura del
proyecto.
