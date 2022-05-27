### 1a. Importar tidyverse

library(tidyverse)

### 1b. Importar la base de datos de PUFEAF.

base_pufeaf <- read.csv("./data/Base_PUFEAF.csv")

### 2. Crear un objeto que contenga únicamente 4 variables a elección de la base de datos. 
select_4elementos <- base_pufeaf %>% 
        select(Provincia, Aglomerado, Partido_Municipio, HORA)

### 3. Crear un objeto que contenga unicamente un tipo de fuerza de eleccion y 3 provincias a eleccion. 
nombre_fuerza_provincia <- base_pufeaf %>% 
        filter(Provincia %in% c("Chubut","Rio Negro","Cordoba") 
               & Tipo_fuerza == "PFA")
### 4. Crear una nueva columna llamada "hubo_fallecidos" que indique si hubo algún fallecido
###(sea civil interviniente, tercero, víctima o
###policial).

base_pufeaf <- base_pufeaf %>% mutate(hubo_fallecidos = case_when(
        Personal_Fallecido > 0 | Civil_Interviniente_Fallecido > 0 |
        Civil_Tercero_Fallecido > 0 | Civil_Victima_Fallecido > 0 ~ "Si",
        TRUE ~ "No"
))
table(base_pufeaf$hubo_fallecidos)
### 5. Crear una nueva columna llamada "tipo_fallecidos" que indique si 
###el fallecido fue civil interviniente, tercero, víctima o policial.

base_pufeaf <- base_pufeaf %>% mutate(tipo_fallecidos = case_when(
        Civil_Tercero_Fallecido > 0 | Civil_Interviniente_Fallecido > 0 |
                Civil_Victima_Fallecido > 0 ~ "Civiles",
        Personal_Fallecido > 0 & Civil_Tercero_Fallecido > 0 & Civil_Interviniente_Fallecido
        > 0 & Civil_Victima_Fallecido > 0 ~ "Personal y civiles fallecidos",
        Personal_Fallecido > 0 ~ "Personal fallecido",
        TRUE ~ "No"
))
table(base_pufeaf$tipo_fallecidos)

### 6. Eliminar las últimas dos columnas del dataframe. 
ncol(base_pufeaf)

base_pufeaf_2 <- base_pufeaf %>% select(1:25)

base_pufeaf_3 <- base_pufeaf %>% select(-c(tipo_fallecidos, hubo_fallecidos))

x <- base_pufeaf %>% ncol()-2

ncol(base_pufeaf_3)
rm(base_pufeaf$hubo_fallecidos)
### 7. Convertir los NA (que son un "") de las columnas "Aglomerado" y "Partido_municipio" 
## en un "Sin información" 

base_pufeaf <- base_pufeaf %>% mutate(Aglomerado = case_when(
        Aglomerado == "" ~ "Sin información",
        TRUE ~ Aglomerado),
        Partido_Municipio = case_when(
                Partido_Municipio == "" ~ "Sin información",
                TRUE ~ Partido_Municipio))

table(base_pufeaf$Partido_Municipio)

## Cómo modificar varias variables de una:
base_pufeaf <- base_pufeaf %>% mutate_at(vars(Partido_Municipio, Aglomerado), #Dentro de vars() pongo las variables a modificar
                       ~case_when(. == "" ~ "Sin información", 
                                  TRUE ~ .)) #Asigno un puntito para referirme a cada variable  

### 8. Pasar los valores de Partido_Municipio 
## a minúscula con ayuda de 
## la función str_to_lower(). 

base_pufeaf <- base_pufeaf %>% 
        mutate(Partido_Municipio = str_to_lower(Partido_Municipio))

table(base_pufeaf$Partido_Municipio)
### 9. Guardar como .csv la última base generada. 

write_csv(base_pufeaf, "./base_pufeaf_trabajada.csv")

### 10. Instalar un paquete que vamos a usar la próxima clase: lubridate. 
install.packages("lubridate")