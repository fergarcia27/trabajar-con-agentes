---
name: elegir-el-caparazon-de-una-app-de-escritorio
description: Cuando haya que elegir con qué construir una app de escritorio (Tauri, Electron, pywebview, Qt), o cuando alguien justifique una elección de stack con una capacidad que todavía no usó. Incluye la revisión, un mes después, de si las razones se sostuvieron.
origen: Sin Ruido
---

Sin Ruido necesitaba una ventana para operar un motor que ya existía: prender y
apagar contenedores, mirar lo que produce, dar de alta medios. Un operador, una
máquina, Windows.

## Lo que se comparó, y lo que decidió

| | por qué se descartó |
|---|---|
| **Electron** | ~150 MB para un shell que sólo lanza `docker compose` |
| **Python + pywebview + PyInstaller** | Unifica el lenguaje con el motor —tentador— pero PyInstaller en Windows no trae updater |
| **Tauri** | Elegido |

Las tres razones que se escribieron para elegirlo:

1. La UI en React, que era terreno conocido.
2. El shell en Rust sería **mínimo** — o sea, no había que aprender Rust.
3. El instalador **y el updater** vienen resueltos.

## Qué pasó con esas razones, medido un mes después

**La primera se sostuvo.** El front fue React y no hubo fricción.

**La segunda es falsa.** El shell en Rust terminó en **3.113 líneas** contra 5.024
del front: el 38% del código de la app. Nueve archivos —el cliente HTTP tipado, el
control de Docker, el llavero de credenciales, la bandeja, los tipos compartidos—
y una *feature flag* de `keyring` que además obligó a que la CI corriera en
Windows. Se aprendió Rust igual, sólo que sin haberlo presupuestado.

**La tercera se cumplió a la mitad.** El instalador vino resuelto y fue central.
**El updater nunca se usó**: más adelante se decidió que motor y app se numeran
juntos, y un updater sólo puede entregar la ventana — el motor lo construye Docker
desde el repo. Entregaría medio producto.

**La decisión fue correcta igual.** Pero por la razón 1 y por el instalador, no
por las tres que se alegaron.

## Lo transferible

**Una capacidad que todavía no usaste no es una razón: es una esperanza.** El
updater pesó en la comparación y nunca se ejecutó. Al comparar stacks, poné en la
balanza **sólo lo que vas a usar en la primera versión**; lo demás anotalo como
"puede servir después" y que no compita.

**"El shell va a ser mínimo" es una predicción sobre tu código, no una propiedad
del framework.** Es la que más se equivoca, porque se hace antes de saber qué va a
necesitar la app. Si podés, medila contra un proyecto parecido en vez de
estimarla; si no, asumí que vas a escribir el lenguaje del shell de verdad.

**Y la buena noticia: una decisión puede estar bien fundada por accidente.** Que
dos de tres razones se caigan no la invalida — lo que invalida es no volver nunca
a mirar. Revisar las razones después es barato y es lo único que convierte el
registro en conocimiento.

### Cuándo replicarlo, y cuándo no

**Tauri conviene** cuando la UI es lo grueso y el shell es de verdad accesorio,
cuando el peso del binario importa, y cuando ya sabés la parte web.

**No lo replicaría** si el shell va a tener lógica sustancial y nadie del equipo
escribe Rust —el 38% de arriba deja de ser una anécdota—, si tenés que soportar
tres sistemas operativos con un solo desarrollador, o si el lenguaje del back-end
ya es el que todos manejan y el empaquetado no es un objetivo de aprendizaje sino
un trámite.

Ver [[una-decision-escrita-se-puede-revertir]], que es por qué esta revisión costó
un rato y no una discusión entera, y [[medir-tumba-el-propio-diseno]].
