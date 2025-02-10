#Pregunta 2.
# Crea dos variables x e y, luego, asígnale valores a cada una de ellas.
# Calcula:   
# Suma, resta, multiplicación, división, potenciación, división entera y división modular.

x <- 13
y <- 6

cat("La suma de x con y es", x + y )
cat("La resta de x con y es", x - y )
cat("La multiplicacion de x con y es", x * y )
cat("La división de x con y es", x / y )
cat("La potencia de x con y es", x ^ y )
cat("La division entera de x con y es", x %/% y )
cat("La division modular de x con y es", x %% y )








# Pregunta 3.
# Sean los siguientes enunciados:
# Verificar si una ciudad es "Lima"
# Comprobar si temperatura no es 0 ni 100

ciudad <- "Lima"
temperatura <- "29"

c <- ciudad == "Lima"
c
cat("¿La ciudad es Lima?", c,"\n")

t <- temperatura != 0 & temperatura != 100
t
cat("¿La temperatura es diferente de 0 y 100?", t,"\n" )









# Pregunta 4
# Muestre el directorio de trabajo (por defecto).
getwd()
# Cambie el directorio de trabajo a una carpeta llamada Laboratorio2.
setwd("C:/Users/John/OneDrive - Universidad Nacional Mayor de San Marcos/25-0/P. Lenguaje Estadistico/Laboratorio2")
# Muestre el nuevo directorio de trabajo.
getwd()












