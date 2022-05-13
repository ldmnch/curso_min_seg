### EJERCICIOS DE PRÁCTICA

# 1. Crear un objeto llamado "primer_objeto" que defina el resultado de la multiplicación 6*4

primer_objeto <- (6*4)

# 2. Crear un vector llamado "ingresos" que contenga los valores: 45000, 70000, 90000, 25000

ingresos <- c(45000, 70000, 90000, 25000)

# 3. Modificar el valor del tercer elemento del vector ingresos por otro número

ingresos[3] <- 100000

# 4. Crear un vector de tipo character que tenga la misma cantidad de valores que el vector "ingresos"

nombres <- c("Marta", "Carla", "Juan", "Pedro", "Nadia")

# 5. Crear un factor que se llame "nivel_educativo", que contenga los valores: "Hasta primario completo", "Hasta secundario completo" y "Hasta terciario/universitario completo" y tenga la misma cantidad de registros que el vector "ingresos".
# Asígnele los niveles que le parezcan correspondientes. 

nivel_educativo <- factor(c("Hasta primario completo", "Hasta secundario completo", "Hasta universitario completo", 
                            "Hasta universitario completo"), levels=c("Hasta primario completo", 
                                                                       "Hasta secundario completo",
                                                                       "Hasta universitario completo"))

nivel_educativo
# 6a. Cree un objeto dataframe combinando los vectores creados previamente. 

data <- data.frame(nombres, nivel_educativo, ingresos)

data
cbind(nombres, nivel_educativo, ingresos)
# 6b. ¿Qué funciones puedo usar para explorar brevemente el dataframe? Úselas y describa que realizan.
summary(data)

# 7. Calcule la media de ingresos para el dataframe y almacénela en un objeto llamado "media_ingresos". 
media_ingresos <- mean(ingresos)

media_ingresos <- mean(data$ingresos)

# 8. ¿Cómo puedo acceder al valor que está en la primera fila de la segunda columna del dataframe? 

data[[1]][2]

data[2,1]


# 9. Cree una tabla de frecuencias para la columna "nivel_educativo". 

prop.table(table(data$nivel_educativo))*100
# 10. Borre todos los objetos creados. 

