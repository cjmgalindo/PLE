# paquetes a instalar
install.packages("tidyverse")
install.packages("devtools")
install.packages("remotes")

# desde github
remotes::install_version("SDMTools", "1.1-221")
devtools::install_github("statsbomb/StatsBombR")

# llamando a las librerias necesarias
library(tidyverse)
library(StatsBombR)
library(dplyr)

# Toda la BBDD gratuita de StatsBomb
View(FreeCompetitions())

###############################################################################

# FreeCompetitions()
# Trayendo los datos de la competición elegida con su #id
Comp <- FreeCompetitions() %>%
  filter(competition_id==223 & season_name=="2024")


# FreeMatches()
# Con dicha funcion recolecto todas los partidos de la Copa America
# 32obs y 42columns
Matches <- FreeMatches(Comp)
view(Matches) #Informacion General de los partidos


#free_allevents()
#Trayendo los detalles de los eventos producidos en los "partidos" de la copa
DataEvents <- free_allevents(MatchesDF = Matches, Parallel = T)
DataEvents = allclean(DataEvents)

###############################################################################
#Hasta aqui ya tengo mis dos datasets bases "Matches" y "DataEvents" 
###############################################################################

# Extrayendo los datos de los entrenadores(lista) nombre y nacionalidad
df_extraer_managers_info <- function(df) {
  home_managers <- df$home_team.managers #accediendo a la columna (es lista)
  away_managers <- df$away_team.managers
  #vectores para almacenar los datos
  name_away <- character(32)
  country_away <- character(32)
  name_home <- character(32)
  country_home <- character(32)
  # Recorriendo cada elemento de las listas
  for (i in 1:32) {
    # Extrayendo datos de away_managers
    name_away[i] <- away_managers[[i]]$name
    country_away[i] <- away_managers[[i]]$country.name
    
    # Extrayendo datos de home_managers
    name_home[i] <- home_managers[[i]]$name
    country_home[i] <- home_managers[[i]]$country.name
  }
  
  # Dataframe con los datos extraídos
    df_entrenadores_info <- data.frame(
      name_home = name_home,
      country_home = country_home,
      name_away = name_away,
      country_away = country_away
    ) 
    
  return(df_entrenadores_info)
}
df_info_entrenadores <- df_extraer_managers_info(Matches)

#Seleccionando las variables que no sean listas (datos de los entrenadores)
df_matches_sin_entrenadores <- Matches %>%
  select(-home_team.managers, -away_team.managers)

# Juntando los datos DF(df sin inf. entrenadores - df con inf. entrenadores) 
Matches <- cbind(df_matches_sin_entrenadores,df_info_entrenadores)

###############################################################################
# Cree mi nueva Matches basado en Matches y la info de los entrenadores
###############################################################################

#Ejemplo 
#x match_id (por partido) total = 32 obs
# Se consideran penales
df_1 <- DataEvents %>%
  group_by(match_id) %>%
  summarise(
    #shots assists
    shot_assists = sum(!is.na(pass.shot_assist), na.rm = TRUE),
    #shots
    shots = sum(type.name=="Shot", na.rm = TRUE),
    #xG totales
    xg = sum(shot.statsbomb_xg, na.rm = TRUE),
    #goal assists
    goal_assists = sum(!is.na(pass.goal_assist), na.rm = TRUE),
    #Goles
    goals = sum(shot.outcome.name == "Goal", na.rm = TRUE), 
    #autogoles
    ownGoal = sum(type.name == "Own Goal Against", na.rm = TRUE)
  )
view(df_1)

###############################################################################

# df_team <- DataEvents %>%
#   group_by(team.name, match_id) %>%
#   summarise(
#     #shots assists
#     shot_assists = sum(!is.na(pass.shot_assist), na.rm = TRUE),
#     #shots
#     shots = sum(type.name=="Shot", na.rm = TRUE),
#     #xG totales
#     xg = sum(shot.statsbomb_xg, na.rm = TRUE),
#     #goal assists
#     goal_assists = sum(!is.na(pass.goal_assist), na.rm = TRUE),
#     #Goles
#     goals = sum(shot.outcome.name == "Goal", na.rm = TRUE), 
#     #autogoles
#     ownGoal = sum(type.name == "Own Goal Against", na.rm = TRUE),
#     
#   )
# view(df_team)


##################

data_CA <- left_join(Matches, df_1, by = "match_id")
write.csv(data_CA,"C:/Users/John/Downloads/Limpiar_Data.csv", row.names = FALSE)

#Eliminado, ordenado y nombrado, ciertas columnas
#vuelvo a extraer el csv con el nombre Copa_America.csv
data_CA <- read_csv("C:/Users/John/OneDrive/Documentos/UNMSM/25-0/PLE/PROYECTO/Copa_America.csv",locale = locale(encoding = "UTF-8"))


