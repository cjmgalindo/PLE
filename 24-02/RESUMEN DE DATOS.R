##############################################################################
########## PROGRAMACION EN LENGUAJE ESTADISTICO
########## FACULTAD DE CIENCIAS MATEMATICA
########## ESCUELA DE ESTADISTICA
########## TEMA: USO DE ARCHIVO DE DATOS
#############################################################################

#Lectura de los registros del archivo
#install.packages("tidyverse")
library(tidyverse)

# Leer el archivo CSV con delimitador ","
datos <- read_delim("C:/Users/John/Downloads/mundiales_procesados.csv",delim=",")
View(datos)

###Resumen de datos

##Cálculo de estadísticas

mean(datos$participaciones)
summarise(datos, promedio = mean(participaciones))

median(datos$participaciones)
summarise(datos, mediana = median(participaciones))

library(DescTools)
Mode(datos$participaciones)
summarise(datos, Moda = Mode(participaciones))

#Group_by

datos %>% 
  group_by(continente) %>% 
  summarise(prom_puntos = mean(puntos),
            mediana_puntos = median(puntos),
            var_puntos = var(puntos))

datos %>% 
  group_by(continente) %>% 
  summarise(prom_puntos = mean(puntos)) %>% 
  arrange(desc(prom_puntos))

datos %>% 
  group_by(continente) %>% 
  summarise(
    prom_puntos = mean(puntos),              # promedio de los puntos de los países
    min_puntos = min(puntos),                # mínimo puntaje en ese continente
    max_puntos = max(puntos),                # máximo puntaje en ese continente
    total_titulos = sum(titulos),            # mundiales ganados por países del continente
    total_pj = sum(pj),                      # cantidad total de partidos jugados
    prom_dg = mean(dg),                      # promedio de la diferencia de goles
    de_puntos = sd(puntos),                  # desviación estándar de puntos
    cv_puntos = de_puntos/prom_puntos*100,   #coeficiente de variación
    n = n()                                # cantidad de registros en cada continente
 ) 

#Group by por Campeón para puntos y agrega el calculo del coeficiente de variación

###Distribuciones de frecuencias para variables categóricas
##Tablas de frecuencias
##fi = frecuencias absolutas = cantidad (conteo los elementos de c/cat)
##hi = fi/n frecuencias relativas = proporción 
##hi*100% = hi% = pi = frecuencias porcentuales = %

#count(): contar
count(datos, continente)

#table(): tabla
table(datos$continente)
fi <- table(datos$continente)
hi <- prop.table(fi)
pi <- hi*100
cbind(fi,hi,pi)

#Tabla con totales
tabla <- cbind(fi,hi,pi)
total <- colSums(tabla)
tabla_completa <- rbind(tabla,Total = total)
tabla_completa


# install.packages("janitor")
library(janitor)

frecuencias <- tabyl(datos, continente)
frecuencias

minimo <- filter(frecuencias, n == min(n))
minimo

maximo <- filter(frecuencias, n == max(n))
maximo

cat("El continente con la mayor cantidad de países que han participado de mundiales es", 
    maximo$continente, "con", maximo$n, "selecciones, mientras que el de menor participación es", 
    minimo$continente, "con", minimo$n, "selecciones.")

frecuencias <- 
  frecuencias %>% 
  adorn_totals()
frecuencias

frecuencias <- 
  frecuencias %>% 
  rename(Continente = continente, `Frec. Absoluta` = n, `Frec. Relativa` = percent)
frecuencias

frecuencias <- 
  datos %>% 
  tabyl(continente) %>% 
  adorn_totals() %>% 
  rename(Continente = continente, `Frec. Absoluta` = n, `Frec. Relativa` = percent)
frecuencias

#Count() para dos variables categóricas
#Tablas de contingencia / Tabla de doble entrada

count(datos, continente, campeon, sort = TRUE)

tabla_cont_campeon <- tabyl(datos, continente, campeon)
tabla_cont_campeon

filter(tabla_cont_campeon, campeón == max(campeón))

datos %>% 
  tabyl(continente, campeon) %>% 
  adorn_totals(where = c("row", "col"))

#Función de Crosstab
library(descr)
crosstab(datos$continente,datos$campeon,
         prop.c = TRUE,   #dist. 
         prop.r = TRUE,
         prop.t = TRUE,
         percent = TRUE)

table(datos$continente,datos$campeon)


##Distribución conjunta de las variables

datos %>% 
  tabyl(continente, campeon) %>% 
  adorn_totals(where = c("row", "col")) %>% 
  adorn_percentages(denominator = "all") #%>%  # cálculo de proporciones
  #adorn_pct_formatting(digits = 1)            # mostrarlas como porcentaje (opcional)









#Distribución condicional de “campeon” dado “continente”:

datos %>% 
  tabyl(continente, campeon) %>% 
  adorn_totals(where = c("row", "col")) %>% 
  adorn_percentages(denominator = "row") %>%
  adorn_pct_formatting(digits = 1)






#Distribución condicional de “continente” dado “campeón”

datos %>% 
  tabyl(continente, campeon) %>% 
  adorn_totals(where = "row") %>% 
  adorn_percentages(denominator = "col") %>%
  adorn_pct_formatting(digits = 1)

datos %>% 
  tabyl(continente, campeon) %>% 
  adorn_totals(where = c("row", "col")) %>% 
  adorn_percentages(denominator = "all") %>% 
  adorn_pct_formatting(digits = 1) %>% 
  adorn_ns() %>% 
  adorn_title(placement = "top", "Continente", "Campeones del mundo")









##Distribuciones de frecuencias para variables cuantitativas------------------------------------------------------------------------------------------------------

datos <- mutate(datos, intervalos = cut(goles_favor, breaks = seq(0, 250, 50), right = FALSE))
################################
datos <- mutate(datos, intervalos = cut(goles_favor, breaks = seq(0, 150, 50), right = FALSE))

datos %>% 
  tabyl(intervalos) %>% 
  adorn_totals()

datos <- mutate(datos, intervalos1 = cut(goles_favor, breaks = seq(0, 133, 19), right = FALSE))

datos %>% 
  tabyl(intervalos1) %>% 
  adorn_totals()
###########





select(datos, seleccion, goles_favor, intervalos)

tabla_gf <- tabyl(datos, intervalos)
tabla_gf

maximo <- filter(tabla_gf, n == max(n))
maximo

cat("El intervalo de cantidad de goles a favor con la mayor cantidad de observaciones es",
    as.character(maximo$intervalos), "con", maximo$n, "países.")

tabla_gf <- 
  tabla_gf %>% 
  mutate(
    `Frec. Abs. Acumulada` = cumsum(n),
    `Frec. Rel. Acumulada` = cumsum(percent)
  ) %>% 
  rename(
    `Goles a favor` = intervalos,
    `Frec. Absoluta` = n, 
    `Frec. Relativa` = percent
  )
tabla_gf








###Escritura de resultados en archivos

# Crear conexión al archivo de salida y poner un encabezado
sink(file = "salida.txt", append = TRUE, split = TRUE)
cat("==========================================\n")
cat("            ARCHIVO DE RESULTADOS         \n")
cat("==========================================\n\n")

cat("=============== ESTADÍSTICAS ===============\n\n")

datos %>% 
  group_by(continente) %>% 
  summarise(
    `Países participantes` = n(),
    `Promedio de puntos` = mean(puntos),
    `Títulos obtenidos` = sum(titulos),
    `Total de partidos jugados` = sum(pj),
    `Promedio de diferencia de goles` = mean(dg)
  )

cat("\n=============== DISTRIBUCIÓN DE SELECCIONES SEGÚN CONTINENTE ===============\n\n")









# Tabla básica
frecuencias <- tabyl(datos, continente)

# Detectar máximo y mínimo
maximo <- filter(frecuencias, n == max(n))
minimo <- filter(frecuencias, n == min(n))

# Completar la tabla con totales y cambiar nombres
frecuencias <- 
  frecuencias %>% 
  adorn_totals() %>% 
  rename(Continente = continente, `Frec. Absoluta` = n, `Frec. Relativa` = percent)
frecuencias

# Emitir mensaje
cat("\nEl continente con la mayor cantidad de países que han participado de mundiales es", 
    maximo$continente, "con", maximo$n, "selecciones, mientras que el de menor participación es", 
    minimo$continente, "con", minimo$n, "selecciones.\n")

cat("\n=============== DISTRIBUCIÓN CONJUNTA DE CONTINENTES Y CAMPEONES ===============\n\n")

datos %>% 
  tabyl(continente, campeon) %>% 
  adorn_totals(where = c("row", "col")) %>% 
  adorn_percentages(denominator = "all") %>% 
  adorn_pct_formatting(digits = 1) %>% 
  adorn_ns() %>% 
  adorn_title(placement = "top", "Continente", "Campeones del mundo")

cat("\n=============== DISTRIBUCIÓN CONDICIONAL DE CAMPEONES EN CADA CONTINENTE ===============\n\n")

datos %>% 
  tabyl(continente, campeon) %>% 
  adorn_totals(where = c("row", "col")) %>% 
  adorn_percentages(denominator = "row") %>%
  adorn_pct_formatting(digits = 1) %>% 
  adorn_ns() %>% 
  adorn_title(placement = "top", "Continente", "Campeones del mundo")

cat("\n=============== DISTRIBUCIÓN CONDICIONAL DE CONTINENTES DADO CAMPEONES ===============\n\n")

datos %>% 
  tabyl(continente, campeon) %>% 
  adorn_totals(where = "row") %>% 
  adorn_percentages(denominator = "col") %>%
  adorn_pct_formatting(digits = 1) %>% 
  adorn_ns() %>% 
  adorn_title(placement = "top", "Continente", "Campeones del mundo")

cat("\n==================== DISTRIBUCIÓN DE LA CANTIDAD DE GOLES A FAVOR ====================\n\n")

# Crear intervalos y tabla
datos <- mutate(datos, intervalos = cut(goles_favor, breaks = seq(0, 250, 50), right = FALSE))
tabla_gf <- tabyl(datos, intervalos)

# Detectar el intervalo con la mayor frecuencia
maximo <- filter(tabla_gf, n == max(n))

# Agregar columnas acumuladas, mejorar la apariencia y calcular totales
tabla_gf %>% 
  mutate(
    `Frec. Abs. Acumulada` = cumsum(n),
    `Frec. Rel. Acumulada` = cumsum(percent)
  ) %>% 
  rename(
    `Goles a favor` = intervalos,
    `Frec. Absoluta` = n, 
    `Frec. Relativa` = percent
  ) %>% 
  # Agregar totales sólo para Frec Absoluta y Frec Rel (sí o sí hay que escribir todos los argumentos de la función) 
  adorn_totals(where = "row", fill = "-", na.rm = TRUE, name = "Total", `Frec. Absoluta`, `Frec. Relativa`)



















# Emitir mensaje
cat("\nEl intervalo de cantidad de goles a favor con la mayor cantidad de observaciones es", 
    as.character(maximo$intervalos), "con", maximo$n, "países.\n")

# Cerrar conexión al archivo
sink()

###Fusionar dos data.frames

Datos1 <- data.frame(X1 = c("A", "B", "C"), X2 = c(1, 2, 3))
Datos2 <- data.frame(X1 = c("D", "B", "A"), X3 = c(9, 7, 5))

#left_join()
DatosUnidos <- left_join(Datos1, Datos2, by = "X1")

#right_join()
DatosUnidos <- right_join(Datos1, Datos2, by = "X1")

#inner_join()
DatosUnidos <- inner_join(Datos1, Datos2, by = "X1")

#full_join()
DatosUnidos <- full_join(Datos1, Datos2, by = "X1")

##Filtering Joins

#semi_join()
DatosFiltrados <- semi_join(Datos1, Datos2, by = "X1")

#anti_join()
DatosFiltrados <- anti_join(Datos1, Datos2, by = "X1")

##Otros detalles sobre las keys
d1 <- data.frame(
  val_x = c("x1", "x2", "x3", "x4"), 
  key = c(1, 2, 2, 1)
)

d2 <- data.frame(
  key = c(1, 2), 
  val_y = c("y1", "y2")
)

full_join(d1, d2)

d1 <- data.frame(
  val_x = c("x1", "x2", "x3", "x4"),
  key = c(1, 2, 2, 3)
)

d2 <- data.frame(
  key = c(1, 2, 2, 3),
  val_y = c("y1", "y2", "y3", "y4")
)

full_join(d1, d2)


##Otros ejemplos para obtener resúmenes

datos %>% 
  group_by(continente) %>% 
  summarise(across(c(goles_favor, goles_contra), mean))

datos %>% 
  group_by(continente) %>% 
  summarise(across(where(is.numeric), mean))

# Frecuencias absolutas
tabla1 <- table(datos$continente)
tabla1

# Frencuencias relativas
prop.table(tabla1)

# Tabla de contingencia para dos variables
tabla2 <- table(datos$continente, datos$campeon)
tabla2

# Distribución conjunta
prop.table(tabla2)

# Distribución condicional de campeon dado continente
prop.table(tabla2, margin = 1)

# Distribución condicional de continente dado campeon
prop.table(tabla2, margin = 2)


##Cambiar el formato de un data.frame

#Formato ancho a largo

ejemplo1 <- data.frame(
  producto = 1:3,
  septiembre = c(234, 657, 989),
  octubre = c(841, 621, 589),
  noviembre = c(521, 147, 258)
)
ejemplo1

ejemplo2 <- pivot_longer(
  data = ejemplo1, 
  cols = c(septiembre, octubre, noviembre), 
  names_to = "mes", 
  values_to = "ventas"
)
ejemplo2

##Formato largo a ancho

pivot_wider(
  data = ejemplo2, 
  names_from = mes, 
  values_from = ventas
)


