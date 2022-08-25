module Records where

data PaisNorm = PaisNorm String String Int Int String

data PaisRecord = PaisRecord
                  {nombre     :: String
                  ,capital    :: String
                  ,poblacion  :: Int
                  ,tamaño     :: Int
                  ,continente :: String}

-- Se puede acceder a los campos directamente
getNombre :: PaisRecord -> String
getNombre p = nombre p

-- Se puede realizar pattern matchig sobre records, y NO es necesario poner todos los campos
isOurCountry :: PaisRecord -> Bool
isOurCountry PaisRecord {nombre = "Mexico", continente = "America"} = True
isOurCountry _ = False
-- en este caso solo nos importaba el nombre y el continente, asi que solo ponemos esos en 
-- el pattern matching

-- Se puede 'modificar' el valor de los campos
changeCapital :: PaisRecord -> String -> PaisRecord
changeCapital p s = p{capital = s}

-- Se pueden crear tipos records 'incompletos' pero estos provocaran un warning y el valor
p = PaisRecord {nombre = "Mexico", capital = "CDMX", poblacion = 128, tamaño = 1964}
pCont = continente p 


