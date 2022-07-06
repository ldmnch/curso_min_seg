## 1. Importe las librerías ggplot y tidyverse. 
library(tidyverse)
library(ggplot2)
## 2. Importe la base PUFEAF. 
df <- read_csv('./data/Base_PUFEAF.csv')
## 3. ¿En qué provincia hubieron más casos de uso de armas de fuego? 

hechos_provincia <- df %>% #Llamo al df 
        group_by(Provincia) %>% #Agrupo por pcias
        summarize(n = n_distinct(ID_hecho)) #Cuento la cantidad de id de hechos

ggplot(hechos_provincia, aes(x=reorder(Provincia, n), y =n))+ #Selecciono dataframe, en x pongo provincias ordenadas por n y en y provincias
        geom_bar(stat = "identity")+ #Gráfico de barras
        coord_flip()+ #Roto ejes para que no se pisen las provs
        labs(x = "Provincia") #Cambio nombre eje x
        
## 4. En esta provincia, ¿qué fuerza las usó más veces?

pcia_fuerza <- df %>% group_by(Provincia, Tipo_fuerza) %>%
        summarize(n=n_distinct(ID_hecho)) #Agrupar por tipo fuerza y provincia

bsas <- pcia_fuerza %>% filter(Provincia == "Buenos Aires") #filtramos por buenos aires

ggplot(bsas, aes(x=Tipo_fuerza, y=n))+ #Tipo fuerza eje x y cantidad en y
        geom_col() #Gráfico de barras

#Todas las pcias por tipo de fuerza
ggplot(pcia_fuerza, aes(x = Provincia, y = n, fill = Tipo_fuerza))+ #Relleno el color x tipo fza
        geom_col(position = 'dodge')+ #Pongo los colores de relleno al lado del otro
        coord_flip() #Roto ejes de coordenadas

## 5. Grafique cómo evolucionaron a lo largo del tiempo los 
## casos según la situación de servicio (Situacion_de_Servicio).

df <- df %>% mutate(Mes_num= case_when(
        Mes == "Enero" ~ 1,
        Mes == "Febrero" ~ 2, 
        Mes == "Marzo" ~ 3,
        Mes == "Abril" ~ 4,
        Mes == "Mayo" ~ 5,
        Mes == "Junio" ~ 6,
        Mes == "Julio" ~ 7,
        Mes == "Agosto" ~ 8,
        Mes == "Septiembre" ~ 9,
        Mes == "Octubre" ~ 10,
        Mes == "Noviembre" ~ 11,
        Mes == "Diciembre" ~ 12
))

servicio_mes <- df %>% group_by(Mes_num, Situacion_de_Servicio) %>%
        summarize(n=n_distinct(ID_hecho))

ggplot(servicio_mes, aes(x= Mes_num, y = n, color = Situacion_de_Servicio))+
        geom_line()+ #Hago gráfico de líneas
        scale_x_continuous(labels = unique(df$Mes), #Con esta función cambio las etiquetas eje x
                           #Con labels pongo las etiquetas de valores de la columna "Mes"
                           breaks = 1:12) #Con breaks le indico que a cada valor de mes le de un num del 1 al 12

## 6. Grafique la evolución temporal de la cantidad de personas 
## heridas para cada provincia. 
df <- df %>% mutate(heridos = 
                            Civil_Interviniente_Herido+Civil_Tercero_Herido+Civil_Victima_Herido)

heridos <- df %>% select(ID_hecho,Provincia, Mes, Mes_num, Civil_Interviniente_Herido:Civil_Victima_Herido, heridos) #selecciono columnas que voy a usar

heridos_group <- heridos %>% group_by(Mes_num, Mes, Provincia) %>% #Agrupamos por mes y prov
        summarize(cant_heridos=sum(heridos),#Cuento cantidad de heridos de manera agrupada
                  tasa_heridos_caso = cant_heridos/n_distinct(ID_hecho)) #Tasa heridos/hechos

ggplot(heridos_group, aes(x=Mes_num, y = cant_heridos, color = Provincia))+ 
        geom_point()

## Realice lo mismo para la cantidad de fallecidos. 
