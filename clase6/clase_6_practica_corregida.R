# 1. Importe los paquetes ggplot, tidyverse y sf
library(ggplot2)
library(tidyverse)
library(sf)
library(readxl)
# 2. Importe la base de homicidios dolosos. 
df <- read_xlsx('./data/Integrado_HD_base_usuaria_2017-2020.xlsx')

#Filtro por valores únicos de homicidos, para que no me aparezcan duplicados
df <- df %>% distinct(Id_hecho, .keep_all = TRUE) 
#A distinct primero le paso la columna de los valores únicos
#.keep_all para que me quede con todas las columnas

# 3. Grafique en un mapa la cantidad de víctimas de homicidio/cantidad de habitantes para 
# los años 2017-2020 en la región del NOA (Tucumán, Jujuy, Salta, Catamarca, Santiago del Estero, La Rioja). 

#Primero: importo DF de polígonos prov

geo <- read_sf('./data/provincias.geojson')

#Segundo: filtro provincias y renombrar región

#Hago los filtros de provincias
geo <- geo %>% filter(nomprov %in% c("TUCUMAN", "JUJUY", "SALTA", "CATAMARCA",
                                     "SANTIAGO DEL ESTERO", "LA RIOJA"))
df <- df %>% filter(provincia %in% c("TUCUMÁN", "JUJUY", "SALTA", "CATAMARCA",
                                      "SANTIAGO DEL ESTERO", "LA RIOJA"))
#Uno los dataframes 

geo_df <- geo %>% left_join(df, by=c("prov" = "Cod_INDEC_Prov"))

head(geo_df)

#Tercero: Mapa de esa región

ggplot(geo)+
        geom_sf()

#Cuarto: agrego toda la info que quiero para hacer el mapa

#Importar proyecciones provinciales

proyecciones <- read_csv('./data/proyecciones_prov.csv')

# Uno por provincia y año, para que no se dupliquen las filas
geo_df <- geo_df %>% left_join(proyecciones, by = c("nomprov" = "Provincia", "anio"))

vict_agrup <- geo_df %>% group_by(nomprov, anio, proy) %>%
                summarise(vic = sum(cant_vic)) %>%
                mutate(tasa = (vic/proy)*100000) #Creo columna tasa de HD cada 100.000 habitantes
#Grafico

ggplot(vict_agrup)+
        geom_sf(aes(fill = tasa), color = NA)+
        scale_fill_viridis_c()+ #Agrego paleta viridis 
        facet_grid(cols = vars(anio))+
        labs(title = "Tasa de HD en NOA",
             subtitle = "2017-2020",
             caption = "Fuente: Ministerio de Seguridad de la Nación")+
        theme_minimal() #Con esto dejo coordenadas
        #theme_void() #Con esto saco las coordenadas