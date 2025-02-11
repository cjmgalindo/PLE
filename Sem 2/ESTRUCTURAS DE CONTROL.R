##############################################################################
########## PROGRAMACION EN LENGUAJE ESTADISTICO
########## FACULTAD DE CIENCIAS MATEMATICA
########## ESCUELA DE ESTADISTICA
########## TEMA: ESTRUCTURAS DE CONTROL - SEMANA 2
#############################################################################

##II.	Estructuras de control condicionales

#2.1.	Estructuras condicionales simples
#Programa: "Analizar edad para votar
edad <- 18
if (edad >= 18){
  cat("Edad =", edad,"años: puede votar")
}



#2.2.	Estructuras condicionales dobles
#Programa: "Analizar edad para votar
edad <- 17
if (edad >= 18){
  cat("Edad =", edad,"años: puede votar")
} else {
  cat("Edad =", edad,"años: no puede votar")
}

#2.3.	Estructuras condicionales múltiples o anidadas

edad <- 71
if (edad < 18){
  cat("Edad =", edad,"años: no puede votar")
} else if (edad >= 70) {
  cat("Edad =", edad,"años: puede votar opcionalmente")
} else {
  cat("Edad =", edad,"años: puede votar obligatoriamente")
}



##III.	Estructuras de control iterativas

#3.1.	Estructuras de control iterativas con un número fijo de iteraciones

#Programa: Calcular la quinta potencia
x <- 4
resultado <- 1
for (i in 1:5) {
  resultado <- resultado * x
}
cat(x, "elevado a la quinta es igual a", resultado)



#Programa: Calcular x elevado al valor i
x <- 4
for (i in 1:5) {
  resultado <- x ** i
}
cat(x, "elevado al valor", i, "=", resultado, "\n")


#Programa: Mostrar tabla del 8
for (i in 0:10) {
  resultado <- 8 * i
  cat("8 x", i, "=", resultado, "\n")
}

#3.2.	Estructuras de control iterativas con un número indeterminado de iteraciones

#i.	Mientras que

#Programa: Dividir u número por 2 hasta encontrar un valor menor que 0.01

x <- 100
while (x >= 0.01) {
  cat(x, "\n")
  x <- x/2
}

#ii.	Hasta que

x <- 100
repeat {
  x <- x/2
  cat(x, "\n")
  if (x < 0.01) break
}

#iii.	Loops infinitos

var <- 9
while (var < 10) {
  cat("var =", var, "No puedo parar!!!", "\n")
  if (var == -3) break
  var <- var - 1
}

#Ejem 1

for (r in 1:7){
  print(r)
}

for (r in 1:7){
  cat(r, "\n")
}
