##############################################################################
########## PROGRAMACION EN LENGUAJE ESTADISTICO
########## FACULTAD DE CIENCIAS MATEMATICA
########## ESCUELA DE ESTADISTICA
########## TEMA: USO DE ARCHIVO DE DATOS
#############################################################################

#Lectura de los registros del archivo
install.packages("tidyverse")
library(tidyverse)
datos <- read_delim("C:/Users/John/OneDrive - Universidad Nacional Mayor de San Marcos/25-0/P. Lenguaje Estadistico/Sem 5 - Mund/mundiales.csv", delim = ",")
class(datos)


# Leer el archivo CSV con delimitador automático
datos <- read_csv("C:/Users/John/OneDrive - Universidad Nacional Mayor de San Marcos/25-0/P. Lenguaje Estadistico/Sem 5 - Mund/mundiales.csv",locale = locale(encoding = "UTF-8"))

datos <- read.delim("clipboard")
View(datos)


# Muestra los nombres de las columnas (campos del archivo)
names(datos)
# Muestra la "estructura" interna del dataset
str(datos)
# Muestra la cantidad de filas y columnas
dim(datos)
# Muestra la cantidad de filas
nrow(datos)
# Muestra la cantidad de columnas
ncol(datos)
# Muestra los primeros registros
head(datos)
# Muestra los últimos registros
tail(datos)
# Muestra un resumen de cada campo
summary(datos)
# Mostrar las filas 3 y 4, columnas 1 y 3
datos[3:4, c(1, 3)]
# Mostrar las filas 3 y 4, columnas "seleccion" y "participaciones"
datos[3:4, c("seleccion", "participaciones")]
datos$titulos
max(datos$titulos)

#Manejo de datos
#Editar o crear nuevas variables
datos <- mutate(datos, pj = pg + pe + pp)

# Sentencia (a)
datos <- mutate(datos, pj = pg + pe + pp)

# Sentencia (b)
datos_modif <- mutate(datos, pj = pg + pe + pp)

# Sentencia (c)
datos <- mutate(datos, pg = pg + pe + pp)

datos <- mutate(datos, campeon = ifelse(titulos > 0, "campeón", "no campeón"))

count(datos, campeon)

count(datos, continente)

datos <- mutate(datos, continente = recode(continente, "Europe" = "Europa", "asia" = "Asia"))
count(datos, continente)

datos <- mutate(
  datos, 
  continente = case_when(
    continente == "Europe" ~ "Europa",
    continente == "asia" ~ "Asia",
    TRUE ~ continente # opción por defecto
  )
)

#Renombrar atributos
datos

datos <- rename(datos, goles_favor = gf, goles_contra = gc)
datos

#Unir o separar columnas
datos <- unite(datos, col = "pais_continente", seleccion, continente, sep = " - ", remove = FALSE)
datos

separate(datos, col = pais_continente, into = c("seleccion", "continente"), sep = " - ")

###Filtrar y ordenar registros

# Una condición
datos_america <- filter(datos, continente == "América")
nrow(datos_america)

# Dos condiciones
datos_campeones_america <- filter(datos, continente == "América", campeon == "campeón")
nrow(datos_campeones_america)

# Alternativa equivalente: filter(datos, continente == "América" & campeon == "si")

# Al menos una de las primeras condiciones ("o") y la segunda
datos_filtro <- filter(datos, continente == "América" | campeon == "campeón", participaciones > 10)
nrow(datos_filtro)

# Orden creciente:
arrange(datos, puntos)

# Orden decreciente:
arrange(datos, desc(puntos))

# Ordenar según más de una variable:
arrange(datos, america, desc(titulos))

###Seleccionar y reordenar columnas

# Elegir cuáles quedan
select(datos, seleccion, participaciones)

# Elegir cuáles se van
select(datos, -goles_favor, -goles_contra)

# Reordenar las columnas - everything() hace referencia al resto
select(datos, seleccion, campeon, puntos, everything())

###Tuberías o pipes

# Lectura del archivo
datos <- read_delim("mundiales.txt")

# Calcular la cantidad total de partidos jugados en mundiales
datos <- mutate(datos, pj = pg + pe + pp)

# Indicar si cada país es o no campeón del mundo
datos <- mutate(datos, campeon = ifelse(titulos > 0, "campeón", "no campeón"))

# Corregir los nombres de los continentes
datos <- mutate(datos, continente = recode(continente, "Europe" = "Europa", "asia" = "Asia"))

# Calcular los puntos ganados por cada país y la diferencia de goles
datos <- mutate(datos, puntos = 3 * pg + pe, dg = gf - gc)

# Cambiar los nombres de algunas columnas
datos <- rename(datos, goles_favor = gf, goles_contra = gc)

# Crear una nueva variable con el nombre del país y del continente
datos <- unite(datos, col = "pais_continente", seleccion, continente, sep = " - ", remove = FALSE)

datos <- 
  read_delim("mundiales.txt") %>% 
  mutate(
    pj = pg + pe + pp,
    campeon = ifelse(titulos > 0, "campeón", "no campeón"),
    continente = recode(continente, "Europe" = "Europa", "asia" = "Asia"),
    puntos = 3 * pg + pe, 
    dg = gf - gc
  ) %>% 
  rename(goles_favor = gf, goles_contra = gc) %>% 
  unite(col = "pais_continente", seleccion, continente, sep = " - ", remove = FALSE)

###Escritura de conjuntos de datos en archivos

# Guardarlo en un archivo de texto separado por tabulaciones
write_delim(datos, file = "mundiales_procesados.txt", delim = "\t")

# Guardarlo en un archivo de texto separado por comas
write_csv(datos, file = "mundiales_procesados.csv")

# Guardarlo en un archivo de Excel
# install.packages("writexl")
library(writexl)
write_xlsx(datos, "mundiales_procesado.xlsx")

###Resumen de datos

##Cálculo de estadísticas

mean(datos$participaciones)
summarise(datos, promedio = mean(participaciones))

datos %>% 
  group_by(continente) %>% 
  summarise(prom_puntos = mean(puntos))

datos %>% 
  group_by(continente) %>% 
  summarise(prom_puntos = mean(puntos)) %>% 
  arrange(desc(prom_puntos))

datos %>% 
  group_by(continente) %>% 
  summarise(
    prom_puntos = mean(puntos),      # promedio de los puntos de los países
    min_puntos = min(puntos),        # mínimo puntaje en ese continente
    max_puntos = max(puntos),        # máximo puntaje en ese continente
    total_titulos = sum(titulos),    # mundiales ganados por países del continente
    total_pj = sum(pj),              # cantidad total de partidos jugados
    prom_dg = mean(dg),              # promedio de la diferencia de goles
    n = n()                          # cantidad de registros en cada continente
  ) 

###Distribuciones de frecuencias para variables categóricas

count(datos, continente)

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

count(datos, continente, campeon, sort = TRUE)

tabla_cont_campeon <- tabyl(datos, continente, campeon)
tabla_cont_campeon

filter(tabla_cont_campeon, campeón == max(campeón))

datos %>% 
  tabyl(continente, campeon) %>% 
  adorn_totals(where = c("row", "col"))

##Distribución conjunta de las variables

datos %>% 
  tabyl(continente, campeon) %>% 
  adorn_totals(where = c("row", "col")) %>% 
  adorn_percentages(denominator = "all") %>%  # cálculo de proporciones
  adorn_pct_formatting(digits = 1)            # mostrarlas como porcentaje (opcional)

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

##Distribuciones de frecuencias para variables cuantitativas

datos <- mutate(datos, intervalos = cut(goles_favor, breaks = seq(0, 250, 50), right = FALSE))

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


