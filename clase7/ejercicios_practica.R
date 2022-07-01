#1. Cargue la base de datos de delitos en CABA que está en la carpeta data. 
# Ojo: está en formato .rda. Recuerden (clase 2) que para importar este tipo 
# de archivos usamos la función load(). 

load('./data/delitos.rda')

#2. Realice un gráfico interactivo mostrando dónde sucedieron homicidios dolosos en 2020. 
library(tidyverse)
library(leaflet)
library(ggplot2)
library(plotly)


table(delitos$tipo)
table(delitos$subtipo)

delitos <- delitos %>% filter(tipo == "Homicidio" & subtipo == "Doloso") 

leaflet(delitos) %>%
        addTiles()%>%
        addMarkers(lat = ~latitud,lng = ~longitud, popup = ~barrio)

#3. Realice un gráfico interactivo mostrando cómo se distribuyen los distintos tipos de delitos entre los barrios.}

delitos <- delitos %>% mutate(victimas = case_when(
        is.na(cantidad) ~ 0,
        TRUE ~ as.numeric(cantidad)
))

delitos_barrios <- delitos %>% group_by(tipo, subtipo, comuna, barrio) %>%
        summarise(n=n())

grafico_barrios <- ggplot(delitos_barrios, aes(x = barrio, y = n, fill=tipo))+
        geom_col(position = 'fill')+
        theme(axis.text.x = element_text(angle = 90))


ggplotly(grafico_barrios)

# 4. Realice un gráfico interactivo mostrando cómo evoluciona la cantidad de 
# crímenes por barrio a lo largo del año.
library(lubridate)

delitos <- delitos %>% mutate(fecha = ymd(fecha))

delito_mes_agrup_2 <- delitos_mes %>% group_by(mes, comuna) %>%
        summarise(n=n()) 

delitos_mes_2 <- ggplot(delito_mes_agrup_2, aes(x=mes, y=n, color = as.character(comuna)))+
        geom_line()

ggplotly(delitos_mes_2)

# Otra forma de hacerlo:


delitos_mes %>% group_by(tipo, mes, comuna) %>%
        summarise(n=n()) 

delitos_mes <- ggplot(delito_mes_agrup, aes(x=mes, y=n, fill = tipo))+
        geom_col()+
        facet_wrap(vars(comuna))

ggplotly(delitos_mes)
