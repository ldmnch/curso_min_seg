### 1a. Importar los paquetes tidyverse, readxl y lubridate. 
library(tidyverse)
library(readxl)
library(lubridate)
### 1b. Importar el dataframe de PUFEAF.

df <- read_csv("./data/Base_PUFEAF.csv")

### 2. Usando tidyverse, ¿cuál fue el mes que tuvo más casos? 

df %>% group_by(Mes)%>%
        summarise(n=n()) %>%
        arrange(desc(n))

### 4. Agregar a la base una columna que tenga en formato string: año-hora. 
### Pista: en la primera clase hay una función útil para concatenar string. (paste0)

df <- df %>% mutate(aniohora = paste0(Anio," ", HORA))
table(df$aniohora)

### 5. Darle a esta última columna el formato de fecha. 

df <- df %>% mutate(aniohora = parse_date_time(aniohora, orders = "YHMS"))

### 6. ¿Cuál de las fuerzas tuvo mayor cantidad de casos fuera de servicio? 
### Expresar los resultados en una tibble y guardarla como objeto.

df %>% group_by(Tipo_fuerza, Situacion_de_Servicio) %>%
        summarize(n=n()) %>%
        filter(Situacion_de_Servicio == "Fuera de Servicio") %>%
        arrange(desc(n))

### 7. Crear una estructura condicional que 
###- calcule la cantidad de casos por aglomerado en caso de que la base de datos tenga más de 1.000 registros 

if(nrow(df) > 1000){
        print(df %>% group_by(Aglomerado)%>%
                summarise(n=n()))
} else {
        print("Menor a 1000")
}

###- calcule la cantidad de casos por provincia en caso de que la base de datos tenga menos de 1.000 registros
if(nrow(df)<1000){
        print(df %>% group_by(Provincia) %>%
                summarise(n=n()))
}

### 8. Crear un loop que devuelva los valores de la columna "Provincia" que no son Buenos Aires
vector_valores <- c()

for (i in seq(nrow(df))){
        if (df$Provincia[i] != "Buenos Aires"){
                vector_valores <- c(vector_valores, df$Provincia[i])
                #print(df$Provincia[i])
        }
}

unique(vector_valores)
