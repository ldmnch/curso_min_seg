### 1. Instalen los paquetes haven y openxlsx

### 2. Abran el .RProj de la carpeta 
library(haven)
library(openxlsx)
### 3. Importen la base de homicidios dolosos que está en la carpeta "data" detallando la ruta desde el punto de partida del proyecto:
### a. En formato .dta

base_dta <- read_dta("./data/Integrado_HD_base_usuaria_2017-2020.dta")
### b. En formato .xlsx
base_xlsx <- read.xlsx("./data/Integrado_HD_base_usuaria_2017-2020.xlsx")

### 4. ¿Cómo es la distribución de frecuencias del sexo de las víctimas?

sexo <- table(base_xlsx$sexo_victima)
sexo
#¿Y de la identidad de género? 
table(base_xlsx$identidad_genero_victima)

### 5. Creen un objeto que contenga las primeras 500 filas de la base de datos. 

base_filtrada <- base_xlsx[1:500,]

### 6. Cree un objeto donde estén únicamente aquellas
##filas que provincia == "BUENOS AIRES"

segundo_objeto <- base_xlsx[base_xlsx$provincia == "BUENOS AIRES",]

### 7. Guardar esta última base de datos en formato .RDS

saveRDS(segundo_objeto, "./data/ejemplo.RDS")

### 8. Instalen los paquetes tidyverse,
##stringr y lubridate.

