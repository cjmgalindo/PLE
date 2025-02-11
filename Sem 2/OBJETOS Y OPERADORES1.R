##############################################################################
########## PROGRAMACION EN LENGUAJE ESTADISTICO
########## FACULTAD DE CIENCIAS MATEMATICA
########## ESCUELA DE ESTADISTICA
########## TEMA: OBJETOS Y OPERADORES
#############################################################################

##### Objetos
#############

#Acción de asignación
#####################

#Para hacer que una variable guarde un determinado valor se recurre a una 
#acción de asignación
#Por ejemplo, la siguiente secuencia de acciones en un algoritmo:
var1 <- 2
var2 <- var1  # 2
var1 <- 7
var3 <- var1

var2 + var3

#Un caso particular se da cuando a una variable se le asigna el 
#valor de una
#operación de la que forma parte la misma variable. 
# Por ejemplo:
stock.inicial <- 43
ventas <- 29
compras <- 12
stock.final <- stock.inicial - ventas + compras
stock.final








# Creación y manejo de objetos en R
###################################

#En R también se usa el operador “flechita” para asignar valores a variables.
#Por ejemplo, si necesitamos registrar el peso y lugar de nacimiento de una
#persona, solamente tenemos que hacer:

lugar_nacimiento <- "Bombal"
peso_nacimiento <- 3.423





#Las FUNCIONES 
 
var1 <- 2
var2 <- "Hola Mundo"
var3 <- TRUE

class(var1)
class(var2)
class(var3)

is.numeric(var1)
is.character(var2)
is.logical(var3)

#Listado de todos los nombres de los objetos que existen en el ambiente:
ls()

#Si queremos eliminar sólo un objeto debemos ejecutar la función rm(), 
rm(var1)








#Ejercicios

#Ejemplo 1: Clase de un número
#Crea un objeto llamado mi_numero que contenga el valor 25.5. 
#Usa la función class() para determinar a qué clase pertenece este objeto.
mi_numero <- 25.5
class(mi_numero)

#Ejemplo 2: Clase de un texto
#Asigna la frase "Programación en Lenguaje Estadístico"
#a un objeto llamado mi_texto. 
#Verifica su clase utilizando la función class().

mi_texto <- "Programación en Lenguaje Estadístico"
class(mi_texto)

#Si nos interesa guardar de forma permanente en la computadora una copia 
#de todo lo que se encuentra en el ambiente en un archivo dentro de alguna
#carpeta. 
#Los archivos que contienen los objetos creados en R tienen extensión .RData.
# Estos archivos se generan con el ícono de guardar en la pestaña Environment 
#o usando la función save.image()

save.image("C:/Users/NATHALLY/Documents/PLE/SEMANA 2/PRACTICA R/objetos.RData")
#Es una forma práctica de guardar tu trabajo para recuperarlo después sin tener 
#que ejecutar nuevamente el código que generó esos objetos.


#Si por el contrario necesitamos importar al ambiente objetos que estén 
#guardados en algún lugar de nuestra compu en un archivo .RData
load("C:/Users/NATHALLY/Documents/PLE1/OBJETOS OPERADORES/objetos.RData")

#####Operadores
###############

#Operadores aritméticos
#######################

x <- 7
y <- 3
x + y     #Suma
x - y     #Resta
x * y     #Multiplicación
x / y     #División
x ^ y	    #Potenciación: ^: ALT y 94
x ** y    #Potenciación
x %/% y	  #División entera
x %% y    #División módular
7/3



#Veamos algunos ejemplos:
4 + 2 * 4
23 * 2 / 5
3 + 5 * (10 - (2 + 4))
2.1 * 1.5 + 12.3
2.1 * (1.5 + 12.3)
1 %% 4 #1
4 %% 1

8 * (7 - 6 + 5) %% (1 + 8 / 2) - 1

#Operadores relacionales o de comparación
#########################################

x <- 7
y <- 3

x > y
x < y
x >= y
x <= y
x == y
x != y

a <- 3
b <- 4
d <- 2
e <- 10
f <- 15
(a * b) == (d + e)

(a * b) != (f - b)
a * b == d + e
a * b != f - b

#Operadores lógicos
###################

x <- T
y <- F
x && y
x || y
!x


#Evaluar si el valor de ancho está entre 5 y 7: (ancho > 5) Y (ancho < 7).
ancho <- 6.4
(ancho > 5) && (ancho < 7)

#Establecer si una persona estudia Estadística o Economía: 
#(carrera == "Estadística") O (carrera == "Economía").
carrera <- "Estadística"
(carrera == "Estadística") || (carrera == "Economía")

#Determinar si una persona no estudia Estadística: 
#NO (carrera == "Estadística").
carrera <- "Administración"
!(carrera == "Estadística")



#Verificar que el valor guardado en x no sea igual a 2 ni a 3:

#Opción correcta 1: (x != 2) Y (x != 3)
# Da verdadero porque x no es ni 2 ni 3
x <- 10
(x != 2) && (x != 3)

# Da falso porque x es igual a 3
x <- 3
x != 2 && x != 3

#Opción correcta 2: NO ((x == 2) O (x == 3))
# Da verdadero porque x no es ni 2 ni 3
x <- 10
!(x == 2 || x == 3)

# Da falso porque x es igual a 3
x <- 3
!(x == 2 || x == 3)

#Opción incorrecta: (x != 2) O (x != 3)

x <- 3
x != 2 || x != 3

#Ejercicios:

#1. Crea un objeto llamado temperatura con el valor 22.5 y verifica si 
#está entre 20 y 25 grados (inclusive)
temperatura <- 22.5
temperatura > 20 && temperatura <25

#2.Crea un objeto llamado fruta con el valor "Manzana" y evalúa si 
#pertenece al conjunto de frutas "Manzana" o "Plátano"


temperatura <- 22.5
(temperatura >= 20) && (temperatura <= 25)

fruta <- "Manzana"
(fruta == "Manzana") || (fruta == "Plátano")

###Leyes de Morgan
#NO (b O c) es equivalente a: NO b Y NO c.
#NO (b Y c) es equivalente a: NO b O NO c.

ancho <- 6.4
!(ancho > 5) && !(ancho < 7)

ancho > 5 && ancho < 7

#Para pensar: predecir el resultado de las siguientes operaciones y 
#luego verificar:
x <- 2
y <- -2
x > 0 && y < 0
x > 0 || y < 0
!(x > 0 && y < 0)

###Evaluación en cortocircuito
x <- 1
y <- 2

# La primera parte da TRUE, se continúa con la segunda, pero da error porque no
# existe un objeto llamado z
(y > x) && (x > z)

# La primera parte da FALSE, entonces toda la operación será FALSE, no se
# continúa con la segunda parte, con lo cual no se intenta usar el objeto
# inexistente z y no hay error
(y < x) && (x > z)

# Es TRUE porque la primera parte es TRUE, sin evaluar la segunda, que daría
# error
(y > x) || (x > z)
(x > z) || (y > x)

# Como la primera parte es FALSE, debe evaluar la segunda, no encuentra a z y da
# error
(x > y) || (x > z)







#Entrada y salida de información
################################

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

#Por ejemplo, en este momento R está posando su atención
getwd()

#Esto quiere decir que R puede ver y acceder de manera directa a todos los 
#archivos que hay allí, sin necesidad de escribir la ruta completa. 
#Por ejemplo, si en lugar de ejecutar:

save.image("C:/Users/Marcos/Documentos/Facultad/objetos.RData")

#ejecuto sencillamente:
save.image("objetos1.RData")

#lo que ocurre es que el nuevo archivo se generará en mi directorio de trabajo
#(carpeta introprog) y no en la carpeta Facultad. Del mismo modo, si ejecuto:
load("objetos1.RData")

#Podemos cambiar el directorio de trabajo con la función setwd() 
setwd("C:/Users/NATHALLY/Documents/PLE/SEMANA 2/OBJETO")
getwd()


#Sin importar cuál es nuestro directorio de trabajo, hacer referencia a dichos
#archivos con paths completos, por ejemplo:
load("/home/marcos/documents/introprog/tp1/objetos.RData")

#Setear como directorio de trabajo a la carpeta del trabajo práctico y hacer
#un uso directo de los archivos que se encuentren allí:
setwd("/home/marcos/documents/introprog/tp1")
load("objetos.RData")