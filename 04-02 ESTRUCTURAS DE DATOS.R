##############################################################################
########## PROGRAMACION EN LENGUAJE ESTADISTICO
########## FACULTAD DE CIENCIAS MATEMATICA
########## ESCUELA DE ESTADISTICA
########## TEMA: ESTRUCTURAS DE DATOS
#############################################################################

####### Arreglos

### Arreglos unidimensionales o vectores

#VARIABLE numérica x(5)
#x[1] <- -4.5
#x[2] <- 12
#x[3] <- 2.71
#x[4] <- -6
#x[5] <- 25

x <- c(-4.5, 12, 2.71, -6, 25)
x
y <- c("ARG", "correo@gmail.com", "Ok", "chau")
y
z <- c(TRUE, TRUE, FALSE)
z
#-----------------------------------------------------------------------------

#PARA i DESDE 1 HASTA 5 HACER
#    ESCRIBIR "La posición " i "de x está ocupada por el valor " x[i]
#FIN PARA

for (i in 1:5) {
  cat("La posición", i, "de x está ocupada por el valor", x[i], "\n")
}

#------------------------------------------------------------------------------

#ESCRIBIR "El vector x tiene " LARGO(x) " elementos."
#ESCRIBIR "El vector y tiene " LARGO(y) " elementos."
#ESCRIBIR "El vector z tiene " LARGO(z) " elementos."

cat("El vector x tiene", length(x), "elementos.")
cat("El vector y tiene", length(y), "elementos.")
cat("El vector z tiene", length(z), "elementos.")

#-----------------------------------------------------------------------------

#PARA i DESDE 1 HASTA LARGO(x) HACER
#    ESCRIBIR "La posición " i "de x está ocupada por el valor " x[i]
#FIN PARA

# Definir el vector x
x <- c(-4.5, 12, 2.71, -6, 25)  # Puedes cambiar los valores según necesites

# Iterar sobre el vector x
for (i in 1:length(x)) {
  cat("La posición", i, "de x está ocupada por el valor", x[i], "\n")
}

#-----------------------------------------------------------------------------

#tam <- LARGO(x)
#PARA i DESDE 1 HASTA tam HACER
#     ESCRIBIR "La posición " i "de x está ocupada por el valor " x[i]
#FIN PARA

# Definir el vector x
x <- c(-4.5, 12, 2.71, -6, 25)  # Puedes cambiar los valores según necesites

# Obtener el tamaño del vector
tam <- length(x)

# Iterar sobre el vector x
for (i in 1:tam) {
  cat("La posición", i, "de x está ocupada por el valor", x[i], "\n")
}

#-----------------------------------------------------------------------------

# el siguiente código crea un vector tipo numérico con 10 posiciones, 
# uno carácter con 7 y otro lógico con 2. En cada caso, R rellena todas
# las posiciones con el mismo valor: ceros en el vector numérico, 
# caracteres vacíos "" en el vector de tipo carácter y valores FALSE 
# en el vector lógico

a <- numeric(10)
a
b <- character(7)
b
d <- logical(2)
d

#-----------------------------------------------------------------------------

#VARIABLE numérica a(10)
#PARA i DESDE 1 HASTA LARGO(a) HACER
#   SI i MOD 3 == 0 ENTONCES  
#       a[i] <- i * 100
#   FIN SI
#FIN PARA
#MOSTRAR a

a <- numeric(10)
for (i in 1:length(a)) {
  if (i %% 3 == 0) {
    a[i] <- i * 100
  }
}
a

#-----------------------------------------------------------------------------

# En el siguiente ejemplo se deja que el usuario determine la dimensión
# del vector y que provea cada uno de los valores para el mismo

#VARIABLE numérica tam
#LEER tam
#VARIABLE numérica mi_vector(tam)
#PARA i DESDE 1 HASTA tam HACER
#    LEER mi_vector[i]
#FIN PARA

# Leer el tamaño del vector
tam <- as.integer(readline("Ingrese el tamaño del vector: "))

# Crear un vector numérico de longitud 'tam'
mi_vector <- numeric(tam)

# Leer los valores del usuario y almacenarlos en el vector
for (i in 1:tam) {
  mi_vector[i] <- as.numeric(readline(paste("Ingrese el valor para la posición", i, ": ")))
}

# Mostrar el vector resultante
cat("El vector ingresado es:", mi_vector, "\n")

#-----------------------------------------------------------------------------

# En R todos los objetos que hemos considerado como “variable” y que
# guardan un único valor (como tam en el ejemplo anterior), son 
# también considerados como vectores, cuyo largo es 1

x <- 25
length(x)
is.vector(x) # Esta función lógica le pregunta a R si el objeto x es un vector

#-----------------------------------------------------------------------------
##Ejemplo: invertir los elementos de un vector

#ALGORITMO: "Invertir (dar vuelta) los elementos de un vector"
#COMENZAR

# Declarar variables
#VARIABLE numérica n
#VARIABLE carácter tmp
#LEER n
#VARIABLE carácter v(n)

# Asignar valores al vector
#PARA i DESDE 1 HASTA n HACER
#   LEER v[i]
#FIN PARA

# Reordenar
#PARA i DESDE 1 HASTA n DIV 2 HACER
#    tmp <- v[i]                 # Paso 1
#    v[i] <- v[n - i + 1]        # Paso 2
#    v[n - i + 1] <- tmp         # Paso 3
#FIN PARA

# Mostrar el vector reodenado
#MOSTRAR v

#FIN

v <- c("Estadística", "en", "Licenciatura", "la", "Aguante")
n <- length(v)
for (i in 1:(n%/%2)) {
  tmp <- v[i]
  v[i] <- v[n - i + 1]
  v[n - i + 1] <- tmp
}
v


# Invertir el vector directamente
v <- rev(v)  
v

#-----------------------------------------------------------------------------

### Arreglos bidimensionales o matrices

#VARIABLE numérica x(3, 4)
#x[1, 1] <- 8
#x[1, 2] <- 13
#x[1, 3] <- 18
#x[1, 4] <- 23
#x[2, 1] <- 11
#x[2, 2] <- 16
#x[2, 3] <- 21
#x[2, 4] <- 26
#x[3, 1] <- 14
#x[3, 2] <- 19
#x[3, 3] <- 24
#x[3, 4] <- 29

x <- matrix(data = c(8, 11, 14, 13, 16, 19, 18, 21, 24, 23, 26, 29),
            nrow = 3, ncol = 4)
x

#----------------------------------------------------------------------------

x <- matrix(c( 8, 13, 18, 23, 
               11, 16, 21, 26, 
               14, 19, 24, 29), 
            nrow = 3, byrow = TRUE)

x <- matrix(c( 8, 13, 18, 23, 
               11, 16, 21, 26, 
               14, 19, 24, 29), 
            ncol = 4, byrow = TRUE)

#-----------------------------------------------------------------------------

y <- matrix(0, nrow = 2, ncol = 5)
y

#-----------------------------------------------------------------------------

#En R tenemos las siguientes funciones para analizar el tamaño de las matrices:

dim(x)
nrow(x)
ncol(x)
dim(y)
nrow(y)
ncol(y)

#-----------------------------------------------------------------------------

#la matriz x del ejemplo puede ser generada así, donde los índices i y j
#no sólo señalan una posición en particular dentro de la matriz, sino 
#que además se usan para hacer el cálculo del valor a asignar

#VARIABLE numérica x(3, 4)
#PARA i DESDE 1 HASTA NFILA(x) HACER
#     PARA j DESDE 1 HASTA NCOL(x) HACER
#           x[i, j] <- 3 * i + 5 * j
#     FIN PARA
#FIN PARA
#MOSTRAR x

x <- matrix(0, nrow = 3, ncol = 4)
for (i in 1:nrow(x)) {
  for (j in 1:ncol(x)) {
    x[i, j] <- 3 * i + 5 * j
  }
}
x

#----------------------------------------------------------------------------

#Si queremos dejar que el valor en cada posición sea determinado por una
#fuente de información externa a la hora de correr el programa, empleamos
#la sentencia LEER en el pseudocódigo

#VARIABLE numérica x(3, 4)
#PARA i DESDE 1 HASTA NFILA(x) HACER
#     PARA j DESDE 1 HASTA NCOL(x) HACER
#        LEER x[i, j]
#     FIN PARA
#FIN PARA

# Definir una matriz numérica de tamaño 3x4
x <- matrix(0, nrow = 3, ncol = 4)

# Iterar sobre las filas y columnas para leer los valores
for (i in 1:nrow(x)) {
  for (j in 1:ncol(x)) {
    x[i, j] <- as.numeric(readline(paste("Ingrese el valor para x[", i, ",", j, "]: ")))
  }
}

# Mostrar la matriz ingresada
cat("Matriz ingresada:\n")
print(x)

#------------------------------------------------------------------------------

#Ejemplo: trasponer una matriz

#ALGORITMO: Trasponer matriz
#COMENZAR

# Declarar objetos
#VARIABLE numérica nf, nc
#LEER nf, nc
#VARIABLE numérica x(nf, nc), traspuesta(nc, nf)

# Leer los valores de la matriz
#PARA i DESDE 1 HASTA nf HACER
#   PARA j DESDE 1 HASTA nc HACER
#       LEER x[i, j]
#   FIN PARA
#FIN PARA

# Trasponer
#PARA i DESDE 1 HASTA nf HACER
#   PARA j DESDE 1 HASTA nc HACER
#       traspuesta[j, i] <- x[i, j]
#   FIN PARA
#FIN PARA

# Mostrar ambas matrices
#ESCRIBIR "Matriz original"
#MOSTRAR x
#ESCRIBIR "Matriz traspuesta"
#MOSTRAR traspuesta

#FIN

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

#-----------------------------------------------------------------------------

####### Características particulares de las estructuras de datos en R

### Elementos con nombre

#------------------------------------------------------------------------------

# Vectores

#Opción 1: después de crear el vector
# El vector se llama "frutas" y tiene 4 elementos
frutas <- c(3, 7, 2, 1)
frutas

# Cada uno de estos elementos no tienen nombres
names(frutas)

# Le doy un nombre a cada elemento
names(frutas) <- c("manzanas", "naranjas", "bananas", "peras")
frutas

#Opción 2: en el momento de crear el vector
frutas <- c(manzanas = 3, naranjas = 7, bananas = 2, peras = 1)
frutas

#Los nombres son útiles porque permiten indexar al vector, 
#sin necesidad de usar como índice la posición del elemento:

frutas[2]
frutas["naranjas"]

#No todos los elementos de un vector deben tener nombre:
frutas <- c(manzanas = 3, 7, bananas = 2, 1)
frutas

names(frutas)

#-----------------------------------------------------------------------------

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

#Al igual que con los vectores, podemos usar los nombres de filas y
#columnas para indexar:

x["B", "grupo2"]

#------------------------------------------------------------------------------

### Operaciones vectorizadas

# Vectores

#supongamos que queremos sumar dos vectores. Gracias a que la suma en R 
#está vectorizada, esto se logra haciendo sencillamente:

u <- c(5, 8, 2)
v <- c(2, 3, -1)
suma <- u + v
suma

#Sin vectorización, deberíamos diseñar y programar un algoritmo como
#el siguiente:

suma <- numeric(length(u))
for (i in 1:length(u)) { 
  suma[i] <- u[i] + v[i]
}
suma

#Esto también sucede con los otros operadores aritméticos:

u - v
u * v
u / v
u %% v

#------------------------------------------------------------------------------

#Estas operaciones también funcionan con vectores de distinto largo. 
#En este caso, R aplica la regla del reciclaje: el vector más corto se
#recicla (se repiten sus elementos) hasta alcanzar la longitud del más 
#largo y luego se opera elemento a elemento.

z <- c(1, 2)
u + z

#Si hacemos operaciones que involucran a una constante y a un vector,
#R repetirá tal operación con cada elemento del vector:

u + 5
1 / v
10 * z
(u + v) / 100

#Si le aplicamos funciones matemáticas como log() o sqrt() a un vector,
#obtendremos como resultado el valor de dicha función en cada uno de los
#elementos del vector:

log(u)
sqrt(z)

#Hay funciones que cuando se aplican a un vector, logran resumirlo 
#siguiendo algún criterio:

#Sumar todos los elementos de un vector:
sum(u)

#Multiplicar todos los elementos de un vector:
prod(u)

#Calcular el promedio de los elementos de un vector:
mean(u)

#Encontrar el valor mínimo y su ubicación en el vector
x <- c(40, 70, 20, 90, 20)
min(x)

which.min(x) # si el mínimo se repite, esta es la posición del primero

which(x == min(x)) # si el mínimo se repite, esto muestra todas sus posiciones

#Encontrar el valor máximo y su ubicación en el vector:

max(x)

which.max(x) # si el mínimo se repite, esta es la posición del primero

which(x == max(x)) # si el mínimo se repite, esto muestra todas sus posiciones

#calcular el producto escalar entre dos vectores

u
v
sum(u * v)

#u * v hace la multiplicación elemento a elemento entre los vectores u y v
#y luego sumamos esos valores con sum(). Sin las operaciones vectorizadas, 
#deberíamos hacer algo como lo siguiente:

rtdo <- 0
for (i in 1:length(u)) { 
  rtdo <- rtdo + u[i] * v[i]
}
rtdo

#------------------------------------------------------------------------------

#creamos las funciones ordenar_asc() y ordenar_des() para ordenar los 
#elementos de un vector. Con las funciones disponibles en R, 
#esto se puede hacer así:

x
sort(x)
sort(x, decreasing = TRUE)

#-----------------------------------------------------------------------------

# Matrices

#Suma entre dos matrices. Sin vectorización, 
#esto involucra pasos como los siguientes:

a <- matrix(c(5, 8, 2, 2, 3, 1), nrow = 3)
b <- matrix(c(0, -1, 3, 1, 2, 4), nrow = 3)
a
b
suma <- matrix(NA, nrow(a), ncol(a))
for (i in 1:nrow(a)) {
  for (j in 1:ncol(a)) {
    suma[i, j] <- a[i, j] + b[i, j]
  }
}
suma

#Gracias a las operaciones vectorizadas de R, esto se puede resumir en:
a + b

#A continuación, otros ejemplos de operaciones realizadas elemento 
#a elemento con matrices:

a - b
a * b
a / b
a^2
sqrt(a)

#También podemos resumir la información contenida en una matriz a:

#Matriz a
a

#Suma de todos los elementos:
sum(a)

#Promedio de todos los elementos:
mean(a)

#Suma de los elementos por fila:
rowSums(a)

#Suma de los elementos por columna:
colSums(a)

#Promedio de los elementos por fila:
rowMeans(a)

#Promedio de los elementos por columna:
colMeans(a)

#-----------------------------------------------------------------------------

#Búsqueda de mínimos y máximos en una matriz:

d <- matrix(sample(100, 20), nrow = 5)

# Valor máximo
max(d)

# Posición (arr.ind = TRUE para que nos indique fila y columna)
which(d == max(d), arr.ind = TRUE)

# Valor mínimo
min(d)

# Posición
which(d == min(d), arr.ind = TRUE)

#------------------------------------------------------------------------------

#las matrices numéricas son muy útiles en diversos campos y por eso existen
#distintas operaciones que se pueden realizar con las mismas.

#Transpuesta de una matriz:
a  #matriz a
t(a)

#Producto entre dos matrices:
e <- matrix(1:4, nrow = 2)
e

a %*% e  #multiplicacion de las matrices a y e

#Inversa de la matriz:
solve(e)

#Obtener los elementos de la diagonal principal:
diag(d)

#-----------------------------------------------------------------------------

### Operaciones lógicas vectorizadas

#Cuando dos vectores o matrices se vinculan a través de una comparación, 
#se opera elemento a elemento obteniendo un vector o matriz de valores lógicos:

x <- c(40, 70, 20, 90, 20)
y <- c(10, 70, 30, 15, 21)
x > y

x < y * 5

a <- matrix(c(5, 8, 2, 2, 3, 1), nrow = 3)
b <- matrix(c(0, -1, 3, 1, 2, 4), nrow = 3)
a
b

a != b
a > b

#Si un vector o matriz de valores lógicos y queremos saber si todos o al 
#menos uno de los elementos es igual a TRUE, podemos usar las funciones 
#all() y any(), respectivamente:

all(a != b)
any(a != b)
all(a > b)
any(a > b)

#Las operaciones de comparación pueden hacerse entre cada elemento de un 
#vector o matriz y un único valor:

x < 50
a == 3
b > 0

#Los operadores lógicos que se utilizan para realizar cálculos elemento
#a elemento con vectores y matrices son &, \ y !. 
#Ellos nos permiten crear expresiones aún más complejas:

x < 50 & y > 50
a < 0 | b > 0
!(x <= 50)

#------------------------------------------------------------------------------

#Uso de vectores para indexar vectores y matrices

x <- c(10.4, 5.6, 3.1, 6.4, 21.7)
x[3]

#Y que para indexar matrices, son necesarios dos índices:

a <- matrix(c(4,-2, 1, 20, -7, 12, -8, 13, 17), nrow = 3)
a

a[2, 3]

#------------------------------------------------------------------------------

#Pero también podemos indexar a múltiples elementos de un vector o una
#matriz a la vez:

#Vectores
#########

# Mostrar los primeros tres elementos del vector x
x[1:3]

# Mostrar los elementos en las posiciones 2 y 4
x[c(2, 4)]

# Mostrar el último elemento
x[length(x)]

# Indexar con valores lógicos. Obtenemos sólo las posiciones indicadas con TRUE:
x[c(F, F, T, T, F)]

# Sabiendo que la siguiente operación devuelve TRUE o FALSE para cada posición de x:
x > 10

# ...la podemos usar para quedarnos con aquellos elementos de x mayores a 10:
x[x > 10]

#Mostrar todos los elementos menos el cuarto
x[-4]

#Matrices
#########

# Toda la fila 3
a[3, ]

# Toda la columna 2
a[, 2]

# Submatriz con las columnas 1 y 2
a[, 1:2]

# Submatriz con las columnas 1 y 3
a[, c(1, 3)]

# Asignar el mismo valor en toda la fila 3
a[3, ] <- 10
a

#-----------------------------------------------------------------------------

### La función apply()

#Supongamos que queremos encontrar el máximo valor en cada fila de una matriz.
#Creamos un vector maximos con lugar para guardar el máximo de cada fila. 
#Luego, iteramos para recorrer cada fila de la matriz, buscar el mínimo y 
#guardarlo en el vector maximos:

a #Matriz a

maximos <- numeric(nrow(a))
for (i in 1:nrow(a)) {
  maximos[i] <- max(a[i, ])
}
maximos

#En R existe una forma más práctica y eficiente de conseguir el mismo resultado:

apply(a, 1, max)

#De manera similar, podemos encontrar el mínimo valor de cada columna:
apply(a, 2, min)

#-------------------------------------------------------------------------------

### Generación de vectores con secuencias numéricas

# Enteros de 1 a 5
1:5

# Números de 1 a 10 cada 2
seq(1, 10, 2)

# Números de 0 a -1 cada -0.1
seq(0, -1, -0.1)

# Siete números equiespaciados entre 0 y 1
seq(0, 1, length.out = 7)

# Repetir el 1 tres veces
rep(1, 3)

# Repetir (1, 2, 3) tres veces
rep(1:3, 3)

# Repetir cada número tres veces
rep(1:3, each = 3)

# Generar una matriz diagonal
diag(c(3, 7, 1, 5))

# Generar una matriz identidad
diag(rep(1, 5))

#------------------------------------------------------------------------------

### Concatenación de vectores y matrices

#Los vectores pueden combinarse entre sí para crear nuevos vectores con c():

x <- 1:5
y <- c(10, 90, 87)
z <- c(x, y, x)
z

#Matrices que tienen la misma cantidad de filas pueden concatenarse una al 
#lado de la otra con cbind():

a <- matrix(c(5, 8, 2, 2, 3, 1), nrow = 3)
b <- matrix(c(0, -1, 3, 1, 2, 4), nrow = 3)
a
b
d <- cbind(a, b)
d

#Matrices que tienen la misma cantidad de columnas pueden concatenarse una
#debajo de la otra con cbind():

e <- rbind(a, b)
e

#Estas funciones también permiten unir matrices con vectores:

x <- 1:6
cbind(e, x)

#------------------------------------------------------------------------------

### Listas

#La creación de esta lista se realiza mediante la función list(), 
#cuyos argumentos son los elementos que queremos guardar en la lista, 
#separados por comas:

mi_lista <- list(
  c(-4.5, 12, 2.71),
  c("hola", "chau"),
  matrix(c(8, 11, 13, 16), nrow = 2),
  TRUE
)
mi_lista

#Usamos dobles corchetes [[ ]] para referenciar a cada objeto que forma 
#parte de la lista. Además, si queremos indicar un elemento dentro de un 
#objeto que forma parte de la lista, agregamos otro conjunto de corchetes 
#como hacemos con vectores y matrices. Por ejemplo:

mi_lista[[1]]
mi_lista[[1]][3]
mi_lista[[2]]
mi_lista[[2]][2]
mi_lista[[3]]
mi_lista[[3]][2, 1]
mi_lista[[4]]
mi_lista[[4]][1]

#Podemos asignar valor a algún elemento usando los índices de esa misma forma:

mi_lista[[1]][3] <- 0
mi_lista

#Cada uno de los elementos de una lista puede tener un nombre propio. 
#Podemos asignarle un nombre a uno, algunos o todos los integrantes en 
#una lista:

mi_lista <- list(
  w = c(-4.5, 12, 2.71),
  x = c("hola", "chau"),
  y = matrix(c(8, 11, 13, 16), nrow = 2),
  z = TRUE
)
mi_lista

#Las siguientes sentencias son todas equivalentes y sirven para acceder al 
#tercer elemento de la lista, cuyo nombre es y:

mi_lista[[3]]
mi_lista[["y"]]
mi_lista$y

#Por ejemplo, tenemos una lista con varios vectores y queremos saber el 
#largo de cada uno de ellos:

mi_lista <- list(x = c(1, 8, 9, -1), y = c("uno", "dos", "tres"), z = c(3, 2))
mi_lista

#Podemos ver el largo de cada elemento de la lista, uno por uno:

length(mi_lista$x)
length(mi_lista$y)
length(mi_lista$z)

#O podemos usar lapply() o sapply(), parientes de la función apply() 
#que vimos antes.

lapply(mi_lista, length)

sapply(mi_lista, length)

#Ejemplo: función que devuelve una lista

#-----------------------------------------------------
# Función triangulos
# Clasifica un triángulo según la longitud de sus lados
# Entrada:
#       - a, b, d, números reales positivos
# Salida:
#       - una lista cuyo primer elemento es un carácter que indica el tipo de
#       triángulo y cuyo segundo elemento es el perímetro del triángulo o el valor 0
#       si los lados provistos no corresponden a un triángulo
#-----------------------------------------------------
triangulos <- function(a, b, d) {
  perimetro <- a + b + d
  if (a > b + d || b > a + d || d > a + b) {
    tipo <- "no es triángulo"
    perimetro <- 0
  } else if (a == b & a == d) {
    tipo <- "equilátero"
  } else if (a == b || a == d || b == d) {
    tipo <- "isósceles"
  } else {
    tipo <- "escaleno"
  }
  return(list(tipo = tipo, perimetro = perimetro))
  # atención con tipo = tipo: la primera vez es el nombre que le estamos dando
  # al elemento de la lista, la segunda vez es la variable que guardamos en la lista
}

#Ejemplos del uso de esta función:

# Guardamos el resultado devuelto (una lista) en el objeto resultado
resultado <- triangulos(2, 3, 4)
# Miramos el primer elemento de la lista (carácter que indica el tipo)
resultado[[1]]

resultado$tipo

# Miramos el primer elemento de la lista (perímetro)
resultado[[2]]

resultado$perimetro

# Miramos todo junto
resultado

# Otro ejemplo:
resultado2 <- triangulos(2, 3, 10)
resultado2[[1]]

resultado2[[2]]

#-----------------------------------------------------------------------------












































































































































































