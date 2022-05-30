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

### 4. Agregar a la base una columna que tenga en formato string: mes-año-hora. 
### Pista: en la primera clase hay una función útil para concatenar string. 

### 5. Darle a esta última columna el formato de fecha. 

### 6. ¿Cuál de las fuerzas tuvo mayor cantidad de casos fuera de servicio? 
### Expresar los resultados en una tibble y guardarla como objeto.

### 7. Crear una estructura condicional que 
###- calcule la cantidad de casos por aglomerado en caso de que la base de datos tenga más de 1.000 registros 
###- calcule la cantidad de casos por provincia en caso de que la base de datos tenga menos de 1.000 registros

### 8. Crear un loop que devuelva los valores de la columna "Provincia" que no son Buenos Aires

for (i in 1:nrow(Base_PUFEAF)){
        if 
}
