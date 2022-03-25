### 1a. Importar los paquetes tidyverse, readxl y lubridate. 
### 1b. Importar el dataframe de PUFEAF.

### 2. Usando tidyverse, ¿cuál fue el mes que tuvo más casos? 

### 3. ¿Cuál de las fuerzas tuvo, en proporción, mayor cantidad de casos fuera de servicio? 
### Usar group_by() y summarise(). 
### Expresar los resultados en una base de datos y guardarla como objeto.

### 4. Darle a la última base generada formato de tabla de frecuencias con valores en proporción.  

### 5. Renombrar las variables de la última base creada, pasándolas a minúscula y convirtiendo los espacios en guiones. 

### 6. Pasar los NA a 0. 

### 7. Agregar a la base una columna que tenga el mes-año-hora. 
### Para esto pueden usar una función que vimos en la primera clase: paste0. 

### 8. Darle a esta última columna el formato de fecha. 

### 9. Crear una estructura condicional que 
###- calcule la cantidad de casos por aglomerado en caso de que la base de datos tenga más de 1.000 registros 
###- calcule la cantidad de casos por provincia en caso de que la base de datos tenga menos de 1.000 registros

### 10. Crear un loop que devuelva los valores de la columna "Provincia" que no son Buenos Aires
