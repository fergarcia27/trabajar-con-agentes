---
name: el-test-va-antes-que-el-arreglo
description: Cuando tengas el arreglo claro y escribir el test antes parezca ceremonia.
origen: Sin Ruido
skill: tdd
---

Un cuerpo `{"url": ""}` borraba el destino de entrega y contestaba 200, mientras
`{}` daba 422 — o sea que la forma más fácil de equivocarse era la que no
avisaba.

Escribí el arreglo primero y la mutación después. **La mutación escapó.** El
arreglo estaba bien; lo que no existía era el test que lo respaldara, así que al
romper la guarda no había nada que se pusiera rojo.

**Why:** el test escrito después de ver el código verde tiende a describir lo que
el código hace, no lo que tiene que hacer. Escrito antes, el rojo inicial es la
prueba de que el test mira el lugar correcto — y ese rojo es exactamente lo que
la mutación intenta reproducir más tarde.

**How to apply:** cuando aparece un bug, el primer commit del arreglo empieza por
el test que lo reproduce. Si ya escribiste el arreglo, revertilo mentalmente:
rompé la guarda y confirmá el rojo antes de darla por buena.

Ver [[la-mutacion-tiene-que-llegar-a-lo-que-el-test-lee]].
