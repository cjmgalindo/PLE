x <- 7
y <- 3

x %/% y	  #División entera
x %% y    #División módular

1 %% 4
2 %% 4
3 %% 4



a <- 3
b <- 4
d <- 2
e <- 10
f <- 15

(a * b) == (d + e)
(a * b) != (f - b)
a * b == d + e




#Determinar si una persona no estudia Estadística: 
#NO (carrera == "Estadística").
carrera <- "Administración"
!(carrera == "Estadística")




###Leyes de Morgan
#NO (b O c) es equivalente a: NO b Y NO c.
#NO (b Y c) es equivalente a: NO b O NO c.

ancho <- 6.4
!(ancho > 5) && !(ancho < 7)

ancho > 5 && ancho < 7





# PROGRAMA: "Calcular área de un círculo" 
# ---------------------------------------

#pi <- 3.14159265358979
radio <- 5
area <- pi * radio^2
cat("El área del círculo es", area, "m^2")








#Directorio de trabajo
#En primer lugar, generar un archivo llamado objetos.RData con todos los 
#objetos existentes en nuestro ambiente de trabajo y, en segundo lugar, 
#cargar la información que dicho archivo contiene:
save.image("C:/Users/NATHALLY/Documents/PLE/SEMANA 2/PRACTICA R/objetos.RData")
load("C:/Users/NATHALLY/Documents/PLE/SEMANA 2/PRACTICA R/objetos.RData")

 
getwd() #directorio de trabajo


save.image("objetos1.RData") #Tambien lo podemos ejecutar asi
load("objetos1.RData") #


#Podemos cambiar el directorio de trabajo con la función setwd() 
setwd("C:/Users/NATHALLY/Documents/PLE/SEMANA 2/OBJETO")
getwd()


#Sin importar cuál es nuestro directorio de trabajo, hacer referencia a dichos
#archivos con paths completos, por ejemplo:
#load("/home/marcos/documents/introprog/tp1/objetos.RData")



#1

#-------------------------------------------------------------------------------

#2

  
edad <- 71
if (edad < 18){
  cat("Edad =", edad,"años: no puede votar")
} else if (edad >= 70) {
  cat("Edad =", edad,"años: puede votar opcionalmente")
} else {
  cat("Edad =", edad,"años: puede votar obligatoriamente")
}

cat("Hola\nMundo")
#Hola
#Mundo


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

#While
x <- 100
while (x >= 0.01) {
  cat(x, "\n")
  x <- x/2
}


#Repeat
x <- 100
repeat {
  x <- x/2
  cat(x, "\n")
  if (x < 0.01) break
}

#2

#------------------------------------------------------------------------------

#3 y 4

#Funciones predefinidas de R

#Leer la variable
x <- 100

#Raíz cuadrada
sqrt(x)

#Valor absoluto
abs(x)

#Función exponencial
exp(x)

#Logarítmo natural
log(x)

#Logaritmo de 100 en base 10
log(100,10)

#Datos de edad:
edad <- c(22,21,21,21,25)
mean(edad)   #Media aritmética
median(edad) #Mediana
var(edad)    #varianza
summary(edad) #estadísticos descriptivos

#Help
help(log)
?median

#Por ejemplo
#Logaritmo de 100 en base 10
log(x = 100,base = 10)
log(base = 10,x = 100)
#Si no introducimos argumentos
log(100,10)



#Distribución Binomial
# X sigue Bi(n=10,p=0.54)
#P(X = 3)
dbinom(3,10,0.54)
#P(X <= 3)
pbinom(3,10,0.54,lower.tail = TRUE)






#función 1
f1 <- function(x,y){
  resultado <- x^2 + 3*y
  return(resultado)
}
#función 2
max <- function(a,b){
  if (a > b) {
    return(a)
  } else {
    return(b)
  }
}

#Programa principal
resultado1 <- f1(2,5) #19
resultado2 <- f1(3,10) #39
resultado3 <- max(resultado1,resultado2) + 20 #59
cat("El resultado es", resultado3)


###NULL vs NA vs NaN
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
  return(resultado) #ojo con el return
}
g1(4, 5)
a <- g1(4, 5)
a

g2 <- function(x, y) {
  x^2 + 3 * y
}
g2(4, 5)
b <- g2(4, 5)
b


g3 <- function(x, y) {
  resultado <- x^2 + 3 * y
  cat("El resultado de esta cuenta es:", resultado, "\n")
  return(NULL)
}
g3(4, 5)
x <- g3(4, 5)
x #BOTA NULL

g4 <- function(x, y) {
  resultado <- x^2 + 3 * y
  cat("El resultado de esta cuenta es:", resultado)
}
g4(4, 5)
y <- g4(4, 5)
y #BOTA NULL debido al return


##Variables locales
# ---------------------------------------------------------------
f1 <- function(x) {
  a <- x - 10
  b <- x + 10
  return(a + b)
}

# PROGRAMA PRINCIPAL
# ---------------------------------------------------------------
z <- f1(50)
z

z + a





#FUNCION SOURCE()
#Archivo A (funciones.R)
mi_suma <- function(a, b) {
  return(a + b)
}

#Archivo B (script_principal.R)
# Importa las funciones del archivo "funciones.R"
source("funciones.R")

# Llama a la función declarada en el archivo funciones.R
resultado <- mi_suma(5, 3)
print(resultado)




#Parametros Definidos
nueva_f <- function(x, y = 100) {
  resultado <- x^2 + 3 * y
  return(resultado)
}

nueva_f(4)

nueva_f(4, 5)




##Modificar una variable global desde el cuerpo de una función en R
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
z <- g1(x) #500/150
cat(x, y, z) #500 50 3.333

# Caso 2: el valor de y en el ambiente global es modificado por g2
x <- 500
y <- 50
z <- g2(x) #500/150
cat(x, y, z) #500 150 3.333



#3 y 4

#------------------------------------------------------------------------------

#5

a <- numeric(10)
a
b <- character(7)
b
d <- logical(2)
d



# Invertir el vector 

v <- c("Estadística", "en", "Licenciatura", "la", "Aguante")
n <- length(v)
for (i in 1:(n%/%2)) {
  tmp <- v[i] #estadistica
  v[i] <- v[n - i + 1] 
  v[n - i + 1] <- tmp
}
v
5%/%2
#directamente
v <- rev(v)
v




# Leer el tamaño del vector
tam <- as.integer(readline("Ingrese el tamaño del vector: "))

# Crear un vector numérico de longitud 'tam'
mi_vector <- numeric(tam)

# Leer los valores del usuario y almacenarlos en el vector
for (i in 1:tam) {
  mi_vector[i] <- as.numeric(readline(paste("Ingrese el valor para la posición", i, ": ")))
}




## MATRICES
#matrix(data, nrow, ncol, byrow=F)


x <- matrix(data = c(8, 11, 14, 13, 
                     16, 19, 18, 21, 
                     24, 23, 26, 29),
            nrow = 3, ncol = 4)
x
#----------------------------------------------------------------------------
x <- matrix(c( 8, 13, 18, 23, 
               11, 16, 21, 26, 
               14, 19, 24, 29), 
            nrow = 3, byrow = TRUE)
x
x <- matrix(c( 8, 13, 18, 23, 
               11, 16, 21, 26, 
               14, 19, 24, 29), 
            ncol = 4, byrow = TRUE)
#-----------------------------------------------------------------------------
y <- matrix(0, nrow = 2, ncol = 5)
y

dim(x)
nrow(x)
ncol(x)
dim(y)
nrow(y)
ncol(y)


# Trasponer una matriz

x <- matrix(c( 8, 13, 18, 23, 
               11, 16, 21, 26, 
               14, 19, 24, 29), 
            nrow = 3, byrow = TRUE)
nf <- nrow(x)
nc <- ncol(x)
traspuesta <- matrix(NA, nc, nf)
for (i in 1:nf) {
  for (j in 1:nc) {
    traspuesta[j, i] <- x[i, j]
  }
}
cat("Matriz original\n")
x
cat("Matriz traspuesta\n")
traspuesta

#Opción 1: después de crear el vector
# El vector se llama "frutas" y tiene 4 elementos
frutas <- c(3, 7, 2, 1)
frutas

# Cada uno de estos elementos no tienen nombres
names(frutas)

# Le doy un nombre a cada elemento
names(frutas) <- c("manzanas", "naranjas", "bananas", "peras")
frutas








# Matrices

#Opción 1: después de crear la matriz
x <- matrix(c( 8, 13, 18, 23, 
               11, 16, 21, 26, 
               14, 19, 24, 29), 
            nrow = 3, byrow = TRUE)
rownames(x) <- c("A", "B", "C")
colnames(x) <- c("grupo1", "grupo2", "grupo3", "grupo4")
x

#Opción 2: al crear la matriz
x <- matrix(c( 8, 13, 18, 23, 
               11, 16, 21, 26, 
               14, 19, 24, 29), 
            nrow = 3, byrow = TRUE,
            dimnames = list(Categorias = c("A", "B", "C"), 
                            Grupos = c("grupo1", "grupo2", "grupo3", "grupo4")))
x
x["B", "grupo2"]


#Sumar todos los elementos de un vector:
sum(u)

#Multiplicar todos los elementos de un vector:
prod(u)

#Calcular el promedio de los elementos de un vector:
mean(u)

#Encontrar el valor mínimo y su ubicación en el vector
x <- c(40, 70, 20, 90, 20)
min(x)
