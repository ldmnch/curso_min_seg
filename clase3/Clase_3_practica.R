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



### 5. Eliminar las últimas dos columnas del dataframe. 

### 6. Convertir los NA de las columnas "Aglomerado" y "Partido_municipio" en un "Sin información" 

### 7. Pasar los valores de todas las columnas a minúscula con ayuda de la función str_to_lower(). 

### 8. Guardar como .csv la última base generada. 

### 9.. Instalar un paquete que vamos a usar la próxima clase: lubridate. 