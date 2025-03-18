---
title: "TRABAJO DE APLICACION"
author: "John Michuy Galindo - Marcelo Pereyra Ruiz"
date: "2025-03-03"
output: 
  html_document:
    toc: true
    toc_depth: 3
    toc_float: true
    collapsed: true
    smooth_scroll: true
    theme: journal
    highlight: kate
    df_print: paged
    code_folding: show
---

# BASE DE DATOS: COPA AMÉRICA 2024

Para el trabajo final, se utilizará un archivo llamado "Copa_America.csv" que contiene información detallada sobre los partidos de la Copa América 2024. Cada fila de este conjunto de datos representa un partido disputado en el torneo, y cada columna hace referencia a diferentes variables relacionadas con el encuentro, los equipos, el arbitraje y el rendimiento en el juego.

Las principales columnas del archivo son:

-ID_Partido: Identificador único de cada partido, tipo numeric

-Fecha: Fecha en la que se disputó el partido, tipo character

-Equipo_Local: Nombre del equipo local, tipo character 

-Goles_Local: Goles anotados por el equipo local, tipo numeric

-Goles_Visitante: Goles anotados por el equipo visitante, tipo numeric

-Equipo_Visitante: Nombre del equipo visitante, tipo character

-Jornada: Semana del torneo en la que se jugó el partido, tipo numeric

-Fase_Torneo: Etapa del torneo, tipo character

-Estadio: Estadio donde se disputó el encuentro, tipo character

-Arbitro: Nombre del árbitro principal del partido, tipo character

-Pais_Arbitro: País de origen del árbitro, tipo character

-Entrenador_Local: Nombre del director técnico del equipo local, tipo character

-Pais_Entrenador_Local: País de origen del director técnico local, tipo character

-Entrenador_Visitante: Nombre del director técnico del equipo visitante, tipo character

-Pais_Entrenador_Visitante: País de origen del director técnico visitante, tipo character

-Asistencias_Disparos_Totales: Asistencias de tiro realizadas durante el partido, tipo numeric

-Disparos_Totales: Número total de disparos realizados, tipo numeric

-xG_Total: Goles esperados, tipo numeric

-Asistencias_Gol_Totales: Asistencias de gol concretadas, tipo numeric

-Goles_Totales: Goles anotados contando el de los penales, tipo numeric

-Autogoles: Goles en contra, tipo numeric

Este archivo tiene 32 registros, ya que son 32 partidos los que se disputaron en la Copa América 2024. Los primeros registros lucen así:

```{r}
library(tidyverse)
library(tibble)
library(scales)
library(ggplot2)
datos <- read_delim("C:/Users/John/OneDrive/Documentos/UNMSM/25-0/PLE/PROYECTO/Copa_America.csv",delim=",")
datos
```
## **Estructura de datos**

```{r}
# Muestra la estructura interna del dataset
str(datos)
```

### **Creación y Renombre de variables**

Juntaremos las variables Equipo_Local y Equipo_Visitante, para saber que selecciones participaron en el partido.

```{r}
datos <- datos %>%
  mutate(Partido = paste(Equipo_Local, '-', Equipo_Visitante))
head(datos[c('Equipo_Local', 'Equipo_Visitante', 'Partido')], 32)
```

Vamos a calcular la cantitad total de goles que cada partido tuvo sin tomar en cuenta la tanda de penales (Goles_SinPenales), sumando la cantidad de goles anotados por el local con la cantidad de goles anotados por el visitante:

```{r}
datos <- mutate(datos, Goles_SinPenales = Goles_Local + Goles_Visitante)
head(datos[c('Partido', 'Goles_Local', 'Goles_Visitante', 'Goles_SinPenales')], 32)
```

Crearemos una nueva columna que se llame Ganador y tenga el valor “Victorial Local” cuando Goles_Local > Goles_Visitante y “Victoria Visitante” en caso contrario. Si ocurre el caso de que Goles_Local = Goles_Visitante, se obtendrá el valor "Sin Ganador"

```{r}
datos <- mutate(datos, Ganador = case_when(
  Goles_Local > Goles_Visitante ~ 'Victoria Local',
  Goles_Local < Goles_Visitante ~ 'Victoria Visitante',
  TRUE ~ 'Sin Ganador'
))
head(datos[c('Partido', 'Goles_Local', 'Goles_Visitante', 'Ganador')], 32)
```

Finalmente crearemos la variable Efectividad_Goles, la cual indicará la precisión de los equipos, calculada como relación entre Goles_SinPenales y Disparos_Totales.
Además, renombraremos la variable Fecha por Fecha_Partido.

```{r}
datos <- datos %>% 
  mutate(Efectividad = Goles_SinPenales / Disparos_Totales) %>% 
  rename(Fecha_Partido = Fecha)

head(datos[c('Fecha_Partido', 'Partido', 'Goles_SinPenales', 'Disparos_Totales', 'Efectividad')], 32)
```



### **Recodificación de categorías**

Aquellos registros con “United States”, "Brazil", "Canada", "Peru", "Mexico" y "Panama" en Equipo_Local y Equipo Visitante son reemplazados por “Estados Unidos”, "Brasil", "Canadá", "Perú", "México" y "Panamá" respectivamente. Los otros valores quedan como estaban:

```{r}
datos <- datos %>%
  mutate(
    Equipo_Local = case_when(
      Equipo_Local == 'United States' ~ 'Estados Unidos',
      Equipo_Local == 'Brazil' ~ 'Brasil',
      Equipo_Local == 'Canada' ~ 'Canadá',
      Equipo_Local == 'Peru' ~ 'Perú',
      Equipo_Local == 'Mexico' ~ 'México',
      Equipo_Local == 'Panama' ~ 'Panamá',
      TRUE ~ Equipo_Local
    ),
    Equipo_Visitante = case_when(
      Equipo_Visitante == 'United States' ~ 'Estados Unidos',
      Equipo_Visitante == 'Brazil' ~ 'Brasil',
      Equipo_Visitante == 'Canada' ~ 'Canadá',
      Equipo_Visitante == 'Peru' ~ 'Perú',
      Equipo_Visitante == 'Mexico' ~ 'México',
      Equipo_Visitante == 'Panama' ~ 'Panamá',
      TRUE ~ Equipo_Visitante
    )
  )

head(datos[, c('Equipo_Local', 'Equipo_Visitante')], 32)
```

A continuación, los registros con “United States of America”, "Spain", "Brazil", "Mexico" y "Iceland" en Pais_Entrenador_Local y Pais_Entrenador_Visitante son reemplazados respectivamente por “Estados Unidos”, "España", "Brasil", "México" e "Islandia".

```{r}
datos <- datos %>%
  mutate(
    Pais_Entrenador_Local = case_when(
      Pais_Entrenador_Local == 'United States of America' ~ 'Estados Unidos',
      Pais_Entrenador_Local == 'Spain' ~ 'España',
      Pais_Entrenador_Local == 'Brazil' ~ 'Brasil',
      Pais_Entrenador_Local == 'Mexico' ~ 'México',
      Pais_Entrenador_Local == 'Iceland' ~ 'Islandia',
      TRUE ~Pais_Entrenador_Local
    ),
    Pais_Entrenador_Visitante = case_when(
      Pais_Entrenador_Visitante == 'United States of America' ~ 'Estados Unidos',
      Pais_Entrenador_Visitante == 'Spain' ~ 'España',
      Pais_Entrenador_Visitante == 'Brazil' ~ 'Brasil',
      Pais_Entrenador_Visitante == 'Mexico' ~ 'México',
      Pais_Entrenador_Visitante == 'Iceland' ~ 'Islandia',
      TRUE ~ Pais_Entrenador_Visitante
    )
  )

head(datos[, c('Equipo_Local', 'Pais_Entrenador_Local', 'Equipo_Visitante', 'Pais_Entrenador_Visitante')], 32)
```

Finalmente, cambiaremos los registros de Pais_Arbitro donde “United States of America”, "Venezuela (Bolivarian Republic)", "Brazil", "Mexico", "Italy" y "Peru" se volverán “Estados Unidos”, "Venezuela", "Brasil", "México", "Italia" y "Perú" de manera respectiva.

```{r}
datos <- mutate(datos,
    Pais_Arbitro = case_when(
      Pais_Arbitro == 'United States of America' ~ 'Estados Unidos',
      str_detect(Pais_Arbitro, "Venezuela") ~ 'Venezuela',
      Pais_Arbitro == 'Brazil' ~ 'Brasil',
      Pais_Arbitro == 'Mexico' ~ 'México',
      Pais_Arbitro == 'Italy' ~ 'Italia',
      Pais_Arbitro == 'Peru' ~ 'Perú',
      TRUE ~ Pais_Arbitro
      )
    )

head(datos[, c('Arbitro', 'Pais_Arbitro')], 32)
```
# ORGANIZACIÓN DE DATOS: Tablas de frecuencias y Gráficos Estadísticos

## **Tablas de frecuencias y Gráficos Estadísticos para variables cualitativas**

**Tabla de frecuencias**
```{r}
frecuencias <- datos %>%
  group_by(Estadio) %>%
  summarise(Frecuencia = n()) %>%
  mutate(Frecuencia_Relativa = Frecuencia / sum(Frecuencia),
         Frecuencia_Porcentual = Frecuencia_Relativa * 100)

frecuencias
```

**Gráficos de Barras y Sector Circular**

```{r}
# **Gráfico de barras**
grafico_barras <- ggplot(frecuencias, aes(x = Estadio, y = Frecuencia, fill = Estadio)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Distribución de Partidos por Estadio", x = "Estadio", y = "Cantidad de Partidos") +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()
  )

print(grafico_barras)
```

# **Gráfico de sectores (pastel)**

```{r}
grafico_pie <- ggplot(frecuencias, aes(x = "", y = Frecuencia, fill = Estadio)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(title = "Proporción de Partidos por Estadio")

print(grafico_pie)
```

## **Tablas de frecuencias y Gráficos Estadísticos para variable cuantitativa discreta**

**Tabla de frecuencias**

```{r}
frecuencias <- datos %>%
  group_by(Goles_SinPenales) %>%
  summarise(Frecuencia = n()) %>%
  mutate(Frecuencia_Relativa = Frecuencia / sum(Frecuencia),
         Frecuencia_Porcentual = Frecuencia_Relativa * 100) %>%
  arrange(desc(Frecuencia)) %>%  # Ordenar de mayor a menor frecuencia
  mutate(Frecuencia_Acumulada = cumsum(Frecuencia),
         Frecuencia_Relativa_Acumulada = cumsum(Frecuencia_Relativa),
         Frecuencia_Porcentual_Acumulada = cumsum(Frecuencia_Porcentual))

print(frecuencias)
```

**Gráfico de líneas o bastones**

```{r}

ggplot(frecuencias, aes(x = reorder(Goles_SinPenales, Frecuencia), y = Frecuencia, fill = Goles_SinPenales)) +
  geom_col() + 
  coord_flip() +
  labs(title = "Distribución de Goles anotados por Partido",
       x = "Goles anotados en Tiempo de Juego",
       y = "Cantidad de Partidos") +
  theme_minimal() +
  theme(legend.position = "none") +
  geom_text(aes(label = Frecuencia), hjust = -0.2, color = "black")
```

## **Tablas de frecuencias y Gráficos Estadísticos para variable cuantitativa continua**

**Cálculo del rango, número de intervalos y amplitud**

```{r}
rango <- max(datos$xG_Total)-min(datos$xG_Total)
k <- round(1 + 3.3*log10(32),0)
A <- ceiling(rango/k) 
cbind(rango,k,A)
```

Creación de la variable xG Total por intervalos (k = 6 intervalos) con una amplitud igual a 2, la cual se llamará xG_intervalos

```{r}
datos <- mutate(datos, xG_intervalos = cut(xG_Total, breaks = seq(min(datos$xG_Total), max(datos$xG_Total) + A, A), right = FALSE))
head(datos)
```

# **Tabla de frecuencias**

```{r}
frecuencias <- datos %>%
  group_by(xG_intervalos) %>%
  summarise(Frecuencia = n()) %>%
  mutate(Frecuencia_Relativa = Frecuencia / sum(Frecuencia),
         Frecuencia_Porcentual = Frecuencia_Relativa * 100,
         Frecuencia_Relativa_Acumulada = cumsum(Frecuencia_Relativa),
         Frecuencia_Porcentual_Acumulada = cumsum(Frecuencia_Porcentual))

frecuencias
```

**Histograma**

```{r}
histograma_xG <- ggplot(datos, aes(x = xG_Total)) +
  geom_histogram(binwidth = A, fill = "steelblue", color = "black", alpha = 0.7) +
  theme_minimal() +
  scale_x_continuous(breaks = seq(min(datos$xG_Total), max(datos$xG_Total) + A, A)) +
  labs(title = "Distribución de xG en Total", x = "xG en Total", y = "Frecuencia")

# Mostrar histograma
print(histograma_xG)
```

### **Tabla de Contingencia**

```{r}
##Distribución conjunta de las variables

library(janitor)

tabla_contingencia <- datos %>%
  tabyl(Goles_SinPenales, Fase_Torneo) %>%
  adorn_totals(where = c("row", "col")) %>%
  adorn_percentages(denominator = "all") %>%
  adorn_pct_formatting(digits = 1) %>%
  adorn_ns() %>%
  adorn_title(placement = "top", "Fase del Torneo", "Goles Sin Penales")

tabla_contingencia
```


# **MEDIDAS DE TENDENCIA CENTRAL, DISPERSIÓN, POSICIÓN, ASIMETRÍA Y CURTOSIS**




## **Medidas de resumen para una variable cuantitativa**

### Tendencia central: media, mediana, moda.

Este fragmento calcula las **medidas de tendencia central** de los goles totales, generados en cada partido de la copa america, 
considerando los goles producidos en los 90 minutos, tiempo extras y penales. 
Con la variable `Goles_Totales` en el dataset `datos`, se uso la función `summarise()` de `dplyr`, para resumir los datos.  
```{r warning=FALSE, message=FALSE}
library(dplyr)
library(DescTools)

TCentral <- datos %>%
  summarise(media = mean(Goles_Totales),
            mediana = median(Goles_Totales),
            Moda1 = Mode(Goles_Totales)[1],
            Moda2 = Mode(Goles_Totales)[2],
            )

TCentral
```

### Dispersión: varianza, desviación estándar, coeficiente de variación.
Este código calcula las **medidas de dispersión** de la variable `Asistencias_Disparos_Totales` 
en el dataset `datos`, utilizando `summarise()` de `dplyr`. Obtiene la 
**media, mínimo, máximo, rango, varianza, desviación estándar y coeficiente de variación**, 
lo que permite analizar la variabilidad de los datos.
```{r}
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

Dispersion
```

###	Asimetría y curtosis: interpretación de la forma de distribución.
Este código evalúa la asimetría y curtosis de los goles totales en los partidos de la Copa América, 
ayudando a comprender la forma de su distribución.

Asimetría (skewness()): 
Permite identificar si los partidos con muchos goles 
son atípicos o si los datos están equilibrados en torno a la media.

Curtosis (kurtosis()): 
Indica si hay una alta concentración de partidos con un 
número de goles cercano a la media o si existen valores extremos 
(goleadas inusuales). 

Esta información es clave para entender la 
tendencia de los marcadores y su variabilidad en el torneo.

```{r}
library(dplyr)
library(moments)  # Para skewness() y kurtosis()

Asimetria_Curtosis <- datos %>%
  summarise(
    Asimetria_Goles = skewness(Goles_Totales),
    Curtosis_Goles = kurtosis(Goles_Totales),
    n = n()
  )
Asimetria_Curtosis
```

### Calcular cuartiles y percentiles
Este código calcula los **cuartiles y percentiles** de los goles totales en los 
de la Copa América, usando `quantile()` dentro de `summarise()`.  

- **Cuartiles (Q1, Q2, Q3)**: 
Dividen los datos en cuatro partes,
mostrando la dispersión de los goles.  
- **Percentiles (P10, P35, P68, P90)**: 
Ayudan a identificar puntos de referencia en la distribución, 
útil para analizar tendencias y valores atípicos.  

Estos valores permiten interpretar la distribución de los goles y entender 
qué tan comunes son ciertos rangos de anotaciones en el torneo.
```{r}
library(dplyr)

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
Cuartiles_Percentiles
```


## **Medidas de resumen de una variable cuantitativa agrupada por una cualitativa**

###	Medidas de tendencia central y dispersión por `Fase_Torneo`
Este código calcula **medidas de tendencia central** del `xG_Total` 
(goles esperados) agrupadas por `Fase_Torneo`, utilizando `group_by()` y `summarise()`.  

- **Agrupación por `Fase_Torneo`**: Permite analizar cómo varían los valores según la etapa del torneo.  
- **Media, mediana y moda**: Ayudan a entender la distribución del `xG_Total` en cada fase.  

**Ejemplo:** Si la media de `xG_Total` en la fase de grupos es mayor que en las eliminatorias, 
podría indicar que en la primera etapa se generan más oportunidades de gol.
```{r}

# Calcular medidas de tendencia central para una variable ("puntos")
medidas <- datos %>%
  group_by(Fase_Torneo) %>%
  summarise(
    media = mean(xG_Total),                   # Media aritmética
    mediana = median(xG_Total),               # Mediana
    moda = as.numeric(names(sort(table(xG_Total), decreasing = TRUE)[1])),  # Moda
  )
```



```{r}
data <- datos %>%
  group_by(Fase_Torneo)%>%
  select(Jornada, Equipo_Local,	Goles_Local,	Goles_Visitante,	Equipo_Visitante)%>%
  arrange(desc(Jornada))
```


### Asimetría y curtosis por `Disparos_Totales`
Este código calcula **asimetría y curtosis** de los `Disparos_Totales`, agrupados por `Jornada`, usando `group_by()` y `summarise()`.  

- **Asimetría (`skewness()`)**: Indica si la distribución de disparos por jornada está sesgada.  
- **Curtosis (`kurtosis()`)**: Mide si los disparos están concentrados alrededor de la media o si hay valores extremos.  
- **`n`**: Cantidad de registros por jornada.  

**Ejemplo:** Si una jornada tiene alta curtosis, significa que hubo partidos con muchos disparos atípicos, como encuentros muy ofensivos o dominados por un solo equipo.

```{r}
datos %>%
  group_by(Jornada) %>%
  summarise(
    asimetria = skewness(Disparos_Totales),      # Coeficiente de asimetría
    curtosis = kurtosis(Disparos_Totales),       # Curtosis
    n = n()                                      # Número de registros
  )

```

### Cuartiles y percentiles por `Asistencias_Disparos_Totales`
Este código calcula **cuartiles y percentiles** de `Asistencias_Disparos_Totales`, agrupados por `Estadio`, utilizando `group_by()` y `summarise()`.  

- **Cuartiles (Q1, Q2, Q3)**: Muestran la distribución de los valores en cada estadio.  
- **Percentiles (P10, P35, P68, P90)**: Identifican puntos clave en la dispersión de los datos.  

**Ejemplo:** Si en un estadio el `P90` es alto, indica que en el 10% de los partidos ahí disputados hubo muchas asistencias de disparo, lo que podría sugerir que el campo o las condiciones favorecen el juego ofensivo.
```{r}
library(dplyr)

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
```




### **Diagrama de cajas de una variable cuantitativa agrupada por `Fase_Torneo`**


```{r}
# Cargar librerías necesarias
library(ggplot2)
library(dplyr)

# Definir el orden deseado de las fases del torneo
datos <- datos %>%
  mutate(Fase_Torneo = factor(Fase_Torneo, 
                              levels = c("Group Stage","Quarter-finals","Semi-finals", "3rd Place Final","Final")))

# Gráfico de cajas ordenado
ggplot(datos, aes(x = Fase_Torneo, y = Goles_Totales, fill = Fase_Torneo)) +
  geom_boxplot(alpha = 0.7) +
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "red") +
  labs(title = "Distribución de Goles Totales por Fase del Torneo",
       x = "Fase del Torneo",
       y = "Goles Totales") +
  theme_minimal() +
  coord_flip()  # Voltea el gráfico para mejor lectura

```


