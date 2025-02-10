# Pregunta 1.
# Contar cuántos números impares hay en un rango (use for)
n <- 59
contador <- 0
for (i in 1:n) {
  if(i %% 2 != 0){
    contador <- contador + 1
  }
}
cat("En los", n, "primeros numeros hay", contador, "numeros impares")


# Calcular la suma de todos los números pares entre 1 y 20 (use for)
suma <- 0
for (i in 1:2) {
  print(suma <- suma + i)
}
cat("La suma de los 20 primeros numeros es", suma)


# Restar números consecutivos desde 100 hasta que el valor sea menor que 20 (use while)
# Sumar los dígitos de un número hasta que la suma supere 50



# Verificar si un número es par o impar (use if y else)
# Determinar si un estudiante aprobó un examen (nota ≥ 11) o reprobó (use if y else)

# Determinar si un número es negativo, cero o positivo (use if, else if y else)
# Determinar si la temperatura es fría, templada o calurosa (use if, else if y else)
# Determinar si la velocidad de un vehículo es baja, normal o alta (use if, else if y else)







# Pregunta 2.
# Crear una función area_rectangulo(base, altura) que devuelva el área.
# Comparar el área de dos rectángulos y mostrar el mayor.

rectangulo <- function(b,a){
  return(b*a)
}

r1 <- rectangulo(2,3)
r2 <- rectangulo(4,6)

cat("El rectangulo con mayor area es el r2, con un area de", max(r1, r2))



# Crear una función calcular_media(datos) que reciba un vector numérico
# y devuelva la media aritmética.
datos <- c(1, 2, 3, 4, 5)

calcular_media <- function(d){
  return(mean(d))
}

cat("La media de", datos, "es", calcular_media(datos))


# Se pide:
# Crear una función calcular_mediana(datos) que reciba un vector 
# y devuelva la mediana.
datos <- c(1, 2, 6, 4, 5)

calcular_mediana <- function(d){
  return(median(d))
}

cat("La mediana de", datos, "es", calcular_mediana(datos))








# Pregunta 3.
# Muestre el directorio de trabajo (por defecto).
getwd()
# Cambie el directorio de trabajo a una carpeta llamada Laboratorio3.
setwd("C:/Users/John/OneDrive - Universidad Nacional Mayor de San Marcos/25-0/P. Lenguaje Estadistico/Laboratorio3")
# Muestre el nuevo directorio de trabajo.
getwd()

