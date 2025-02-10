##############################################################################
########## PROGRAMACION EN LENGUAJE ESTADISTICO
########## FACULTAD DE CIENCIAS MATEMATICA
########## ESCUELA DE ESTADISTICA
########## TEMA: DESCOMPOSICIÓN ALGORÍTMICA
#############################################################################

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

# En Estadística:
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
log(10,100)


#Distribución Binomial
# X sigue Bi(n=10,p=0.54)
#P(X = 3)
dbinom(3,10,0.54)
#P(X <= 3)
pbinom(3,10,0.54,lower.tail = TRUE)

#Otro ejemplo
x <- 100
y <- x/2
z <- 4
log(x - y, z)  #z representa base 4


#Definición de nuevas funciones en R
#Ejemplo 1. f(x,y) = x^2 + 3*y
f <- function(x,y){
  resultado <- x^2 + 3*y
  return(resultado)
}

#Invocando la función f
#Para x = 4 y y = 5
f(4,5)
f(6,-5) #x = 6 y y = -5
f(0,0)  #x = y = 0

#También
f(x = 4, y = 5)
f(y = 5, x = 4)

#Sin argumento, ah tener cuidado!
f(4,5)
f(5,4)

#Errores
#Error por omitir un argumento de uso obligatorio
f(4)
#Error por proveer más argumentos de los declarados
f(4,5,6)


#Ejemplo 3

#Definición de funciones

#función 1
f <- function(x,y){
  resultado <- x^2 + 3*y
  return(resultado)
}

#función 2
maximo <- function(num1,num2){
  if (num1 > num2) {
    return(num1)
  } else {
    return(num2)
  }
}

#Programa principal
resultado1 <- f(2,5)
resultado2 <- f(3,10)
resultado3 <- maximo(resultado1,resultado2) + 20
cat("El resultado es", resultado3)

#Otra forma
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
resultado1 <- f1(2,5)
resultado2 <- f1(3,10)
resultado3 <- max(resultado1,resultado2) + 20
cat("El resultado es", resultado3)
