# 2. BASE DE DATOS Y PREPROCESAMIENTO
# Fuente de los datos (Ejemplo: Datos oficiales de la FIFA, Kaggle, etc.)
# 	Descripción de variables
# •	puntos: cantidad de puntos obtenidos.
# •	goles_favor: cantidad de goles anotados.
# •	continente: continente al que pertenece cada equipo.
# •	titulos: cantidad de mundiales ganados.
# 	Creación de variables (como mínimo 2, usando mutate)


# 3. ANÁLISIS EXPLORATORIO DE DATOS (EDA)
# 3.1 Tablas de frecuencias y gráficos para variables cualitativas
# 	Tablas de frecuencia para la variable "continente"
# 	Gráficos
# •	Gráfico de barras.
# •	Gráfico de sectores (pastel).
# 3.2 Análisis de una variable cuantitativa discreta ("puntos")
# 	Tabla de frecuencias absolutas, relativas, porcentuales y acumuladas.
# 	Gráfico de listones.
# 3.3 Análisis de una variable cuantitativa continua ("goles_favor")
# 	Histograma de la variable "goles_favor".
# 3.4 Tabla de Contingencia
# 	Análisis conjunto entre variables cualitativas y cuantitativas.




library(tidyverse)
datos <- read_delim(file = "../OneDrive/Documentos/UNMSM/25-0/PLE/PROYECTO/Copa_America.csv", delim=",")
head(datos)
######################################################################
# 4. MEDIDAS ESTADÍSTICAS
######################################################################

# 4.1 Medidas de resumen para una variable cuantitativa

# Tendencia central: media, mediana, moda.

library(dplyr)
library(DescTools)

mean(datos$Goles_Totales)
summarise(datos, promedio = mean(Goles_Totales))

median(datos$Goles_Totales)
summarise(datos, mediana = median(Goles_Totales))

Mode(datos$Goles_Totales)
summarise(datos, Moda1 = Mode(Goles_Totales)[1])
summarise(datos, Moda2 = Mode(Goles_Totales)[2])
reframe(datos, Moda_Goles = Mode(Goles_Totales))


TCentral <- datos %>%
  summarise(media = mean(Goles_Totales),
            mediana = median(Goles_Totales),
            Moda1 = Mode(Goles_Totales)[1],
            Moda2 = Mode(Goles_Totales)[2],
            )

print(TCentral)
















# 	Dispersión: varianza, desviación estándar, coeficiente de variación.
Dispersion <- datos %>%
  summarise(
    media = mean(Asistencias_Disparos_Totales),              # media aritmética
    minimo = min(Asistencias_Disparos_Totales),              # valor mínimo
    maximo = max(Asistencias_Disparos_Totales),              # valor máximo
    rango = maximo - minimo,                  # rango
    Varianza = var(Asistencias_Disparos_Totales),            # varianza
    Desviacion = sd(Asistencias_Disparos_Totales),           # desviacion_estandar
    Coef_Variacion = (sd(Asistencias_Disparos_Totales) / media) * 100 # coeficiente de variacion
  )

print(Dispersion)



# 	Asimetría y curtosis: interpretación de la forma de distribución.
library(dplyr)
library(moments)  # Para skewness() y kurtosis()

Asimetria_Curtosis <- datos %>%
  summarise(
    Asimetria_Goles = skewness(Goles_Totales),
    Curtosis_Goles = kurtosis(Goles_Totales),
    n = n()
  )
print(Asimetria_Curtosis)

#ASIMETRIA  
#También conocido como el coeficiente de asimetría de Fisher-Pearson, se basa en momentos centrales:
#   asimetría=m3S3
# Donde S3
# es la desviación típica elevada al cubo y m3
# es lo que se conoce como el Momento central de orden r, donde r puede ser cualquier entero positivo y se calcula se la siguiente manera.
# mr=1n∑i=1n(xi−X¯¯¯¯)r
# Recordatorio:
#   
#   S2=∑ni=1(xi−X¯¯¯¯)2n
# 
# Interpretacion:
#   
#   Distribución simétrica
# asimetría=0
# Distribución asimétrica a la derecha
# asimetría>0
# Distribución asimétrica a la izquierda
# asimetría<0

# El coeficiente de apuntamiento muestras, tambien conocido como curtosis, 
# es una medida estadística que se utiliza para evaluar la forma de la 
# distribución de un conjunto de datos y, específicamente, para medir 
# cuán “afilada” o “achatada” es la distribución en comparación con una distribución normal. 
# Indica la concentración de valores alrededor de la media y la presencia de valores extremos 
# en la distribución de datos.
# 
# Se definen 3 tipos de distribuciones según su grado de curtosis:
#   
# Distribución mesocúrtica: 
# Presenta un grado de concentración medio alrededor 
# de los valores centrales de la variable (el mismo que presenta una 
# distribución normal).Los valores extremos o atípicos son menos comunes en este 
# tipo de distribución.La curtosis se aproxima a cero para una 
# distribución mesocúrtica.
# 
# Distribución leptocúrtica: El coeficiente de curtosis es positivo 
# para una distribución leptocúrtica. 
# Presenta un elevado grado de concentración alrededor de los valores centrales 
# de la variable.Las colas de la distribución son más pesadas, 
# lo que significa que los valores extremos son más probables.
# 
# Distribución platicúrtica: Presenta un reducido grado de concentración 
# alrededor de los valores centrales de la variable y sus valores están más dispersos. 
# Tienen una forma achatada con un pico más bajo en el centro 
# y colas menos pronunciadas. El coeficiente de curtosis es negativo 
# para una distribución platicúrtica.






# 	Cuartiles y percentiles: distribución de la variable en diferentes rangos.



library(dplyr)

# Calcular cuartiles y percentiles
Cuartiles_Percentiles <- datos %>%
  summarise(
    Q1 = quantile(Goles_Totales, 0.25),  # Primer cuartil (25%)
    Q2 = quantile(Goles_Totales, 0.50),  # Segundo cuartil (Mediana, 50%)
    Q3 = quantile(Goles_Totales, 0.75),  # Tercer cuartil (75%)
    P10 = quantile(Goles_Totales, 0.10), # Percentil 10
    P35 = quantile(Goles_Totales, 0.35),  # Percentil 35
    P68 = quantile(Goles_Totales, 0.68),  # Percentil 68
    P90 = quantile(Goles_Totales, 0.90)  # Percentil 90
  )
# Mostrar resultados
print(Cuartiles_Percentiles)


# 4.2 Medidas de resumen para una variable cuantitativa agrupada por una cualitativa
# 	Medidas de tendencia central y dispersión por continente.


##Para la variable cuantitativa puntos y para la variable cualitativa continente

# Cargar librerías necesarias
library(dplyr)
library(moments)  # Para calcular asimetría y curtosis



# Calcular medidas de tendencia central para una variable ("puntos")
medidas <- datos %>%
  group_by(Fase_Torneo) %>%
  summarise(
    media = mean(xG_Total),                   # Media aritmética
    mediana = median(xG_Total),               # Mediana
    moda = as.numeric(names(sort(table(xG_Total), decreasing = TRUE)[1])),  # Moda
  )

#df 
head(datos[c('Jornada', 'Fase_Torneo', 'Equipo_Local', 'Goles_Local', 'Goles_Visitante', 'Equipo_Visitante')], 32)

data <- datos %>%
  group_by(Fase_Torneo)%>%
  select(Jornada, Equipo_Local,	Goles_Local,	Goles_Visitante,	Equipo_Visitante)%>%
  arrange(desc(Jornada))
  








# 	Asimetría y curtosis

datos %>%
  group_by(Jornada) %>%
  summarise(
    asimetria = skewness(Disparos_Totales),           # Coeficiente de asimetría
    curtosis = kurtosis(Disparos_Totales),            # Curtosis
    n = n()                                 # Número de registros
  )


# 	Cuartiles y percentiles por continente.

library(dplyr)

# Calcular cuartiles y percentiles
datos %>%
  group_by(Estadio) %>%
  summarise(
    Q1 = quantile(Asistencias_Disparos_Totales, 0.25),  # Primer cuartil (25%)
    Q2 = quantile(Asistencias_Disparos_Totales, 0.50),  # Segundo cuartil (Mediana, 50%)
    Q3 = quantile(Asistencias_Disparos_Totales, 0.75),  # Tercer cuartil (75%)
    P10 = quantile(Asistencias_Disparos_Totales, 0.10), # Percentil 10
    P35 = quantile(Asistencias_Disparos_Totales, 0.35),  # Percentil 35
    P68 = quantile(Asistencias_Disparos_Totales, 0.68),  # Percentil 68
    P90 = quantile(Asistencias_Disparos_Totales, 0.90)  # Percentil 90
  )




# 4.3 Representación gráfica
# 	Diagrama de cajas agrupado para visualizar la dispersión de "puntos" por continente.

# Cargar librerías necesarias
library(ggplot2)

# Crear el diagrama de cajas agrupado
ggplot(datos, aes(x = Fase_Torneo, y = Goles_Totales, fill = Goles_Totales)) +
  geom_boxplot() +
  labs(title = "Diagrama de Cajas de Puntos por Continente",
       x = "Continente",
       y = "Puntos") +
  theme_minimal()
# Oculta la leyenda, ya que los colores son por continente)# Oculta lGoles_Totalesa leyenda, ya que los colores son por continente

# Cargar librerías necesarias
library(ggplot2)

# Crear el diagrama de cajas agrupado por Fase del Torneo

ggplot(datos, aes(x = Fase_Torneo, y = Goles_Totales, fill = Fase_Torneo)) +
  geom_boxplot(alpha = 0.7) +  # Boxplot con transparencia
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "red") + # Agregar media
  labs(title = "Distribución de Goles Totales por Fase del Torneo",
       x = "Fase del Torneo",
       y = "Goles Totales") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Rotar etiquetas del eje X

# Cargar librerías necesarias
library(ggplot2)

ggplot(datos, aes(x = Fase_Torneo, y = Goles_Totales, fill = Fase_Torneo)) +
  geom_boxplot(alpha = 0.7) +
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "red") +
  labs(title = "Distribución de Goles Totales por Fase del Torneo",
       x = "Fase del Torneo",
       y = "Goles Totales") +
  theme_minimal() +
  coord_flip()  # Voltea el gráfico para mejor lectura

