##############################################################################
########## PROGRAMACION EN LENGUAJE ESTADISTICO
########## FACULTAD DE CIENCIAS MATEMATICA
########## ESCUELA DE ESTADISTICA
########## TEMA: DESCOMPOSICIÓN ALGORÍTMICA - CONTINUACIÓN
#############################################################################

###NULL vs NA vs NaN

g <- function(x, y) {
  resultado <- x^2 + 3 * y
  cat("El resultado de esta cuenta es:", resultado, "\n")
  return(NULL)
}
g(4, 5)

a <- NULL
b <- NA
d <- NaN
e <- Inf
f <- "NULL"

class(a)
class(b)
class(d)
class(e)
class(f)

##Función return()

g1 <- function(x, y) {
  resultado <- x^2 + 3 * y
  return(resultado)
}
g1(4, 5)

g2 <- function(x, y) {
  x^2 + 3 * y
}
g2(4, 5)

g3 <- function(x, y) {
  resultado <- x^2 + 3 * y
  cat("El resultado de esta cuenta es:", resultado, "\n")
  return(NULL)
}
g3(4, 5)

g4 <- function(x, y) {
  resultado <- x^2 + 3 * y
  cat("El resultado de esta cuenta es:", resultado)
}
g4(4, 5)

x <- g3(4, 5)
x

y <- g4(4, 5)
y

##Documentación de los subalgoritmos

# ---------------------------------------------------------------
# DEFINICIÓN DE FUNCIONES
# ---------------------------------------------------------------

#-----------------------------------------------------
# Función fact
# Calcula el factorial de números enteros no negativos
# Entrada:
#       - n, entero no negativo
# Salida:
#       - el factorial de n
#-----------------------------------------------------
fact <- function(n) {
  resultado <- 1
  if (n > 0) {
    for (i in 1:n) {
      resultado <- resultado * i
    }
  }
  return(resultado)
}

# ---------------------------------------------------------------
# PROGRAMA PRINCIPAL: Mostrar los factoriales de los 10 primeros naturales
# ---------------------------------------------------------------
for (j in 1:10) {
  cat("El factorial de", j, "es igual a", fact(j), "\n")
}

### Pasaje de parámetros

##Pasaje por valor

# ---------------------------------------------------------------
# DEFINICIÓN DE FUNCIONES
# ---------------------------------------------------------------
fun <- function(x, y) {
  x <- x + 1
  y <- y * 2
  return(x + y)
}

# ---------------------------------------------------------------
# PROGRAMA PRINCIPAL
# ---------------------------------------------------------------
a <- 3
b <- 5
d <- fun(a, b)
cat(a, b, d)


### Ámbito de las variables

##Variables locales

# ---------------------------------------------------------------
# DEFINICIÓN DE FUNCIONES
# ---------------------------------------------------------------
f1 <- function(x) {
  a <- x - 10
  b <- x + 10
  return(a + b)
}

# ---------------------------------------------------------------
# PROGRAMA PRINCIPAL
# ---------------------------------------------------------------
z <- f1(50)
z

z + a


## Variables globales
# ---------------------------------------------------------------
# DEFINICIÓN DE FUNCIONES
# ---------------------------------------------------------------
f2 <- function(x) {
  a <- x * y
  return(a)
}

# ---------------------------------------------------------------
# PROGRAMA PRINCIPAL
# ---------------------------------------------------------------
y <- 20
f2(2)

y <- 18
f2(2)


# ---------------------------------------------------------------
# DEFINICIÓN DE FUNCIONES
# ---------------------------------------------------------------
f3 <- function(x) {
  a <- x - 10
  b <- x + 10
  cat("Acá, dentro de la f3, el valor de a es", a)
  return(a + b)
}

# ---------------------------------------------------------------
# PROGRAMA PRINCIPAL
# ---------------------------------------------------------------
a <- 70
z <- f3(50)
z
cat("Acá, en el programa principal, el valor de a es", a)
a + z


#Otras nociones importantes en R

#La función source()
# ---------------------------------------------------------------
# PROGRAMA PRINCIPAL: Mostrar los factoriales de los 10 primeros naturales
# ---------------------------------------------------------------

source("C:/Documentos/Facultad/IALP/funciones.R")

for (j in 1:10) {
  cat("El factorial de", j, "es igual a", fact(j), "\n")
}


#Argumentos con valores asignados por defecto

f <- function(x, y) {
  resultado <- x^2 + 3 * y
  return(resultado)
}
f(4, 5)


nueva_f <- function(x, y = 100) {
  resultado <- x^2 + 3 * y
  return(resultado)
}

nueva_f(4)

nueva_f(4, 5)

nueva_f()

nueva_f(y = 5)

###Otros tópicos de lectura opcional

##Modificar una variable global desde el cuerpo de una función en R

# ---------------------------------------------------------------
# DEFINICIÓN DE FUNCIONES
# ---------------------------------------------------------------
g1 <- function(x) {
  y <- y + 100
  return(x / y)
}

g2 <- function(x) {
  y <<- y + 100
  return(x / y)
}

# ---------------------------------------------------------------
# PROGRAMA PRINCIPAL
# ---------------------------------------------------------------
# Caso 1: el valor de y en el ambiente global no es modificado por g1
x <- 500
y <- 50
z <- g1(x)
cat(x, y, z)

# Caso 2: el valor de y en el ambiente global es modificado por g2
x <- 500
y <- 50
z <- g2(x)
cat(x, y, z)




