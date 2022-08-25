--Instalación de Haskell
    -- https://www.haskell.org/platform/

--Empezar un modulo
module Intro where

--Tipos
    --Int, Integer, Float, Double, Bool, Char
    --Funcion Par
    espar :: Int -> Bool
    espar n = (mod n 2) == 0

    --Función Suma Triple
    sumtriple :: Int -> Int -> Int -> Int
    sumtriple a b c = a+b+c

-- Listas Y tuplas
    -- Listas Homgeneas
    -- Tuplas Heterogeneas
    -- Lista por comprensión
    elementosMayores :: Int -> [Int] -> [Int]
    elementosMayores a xs = [x | x <- xs, x>a]
    -- elementosMayores 3 [1,2,3,4,5] = [4,5]

    -- (x:xs) ===== x es la cabeza, xs es la cola. [1,2,3,4,5] => x = 1, xs = [2,3,4,5]
    reversa :: [a] -> [a]
    reversa [] = []
    reversa (x:xs) = (reversa xs) ++ [x]
    

--Variables de tipo
    -- Listas, tuplas
    -- Función ejemplo
    first :: (a,b) -> a
    first (e1,e2) = e1

--Clases de tipo
    -- Eq, Ord, Show, Enum, Bounded, Num, Fractional
    -- Funcion ejemplo
    areaTriangulo :: (Fractional a) => a -> a -> a
    areaTriangulo b h = b * h / 2

--Recursion
    --Naturales
    -- 0 es natural
    -- Si n es un natural, el sucesor de n es natural

--Funciones de orden superior
    -- Explicación de currificación
    -- Ejemplos de como funciona currificación
    sumaCuadruple :: Int -> Int -> Int -> Int -> Int
    sumaCuadruple a b c d = a + b + c + d

    -- Función como parametro
    aplicarDoble :: (a->a) -> a -> a
    aplicarDoble f e = f (f e)

    -- Map
    --map :: (a -> b) -> [a] -> [b]
    --map _ [] = []
    --map f (x:xs) = f x : map f xs
    menoresCinco :: [Int] -> [Bool]
    menoresCinco xs = map (<5) xs  

    -- Filter
    --filter :: (a -> Bool) -> [a] -> [a]
    --filter _ [] = []
    --filter p (x:xs)
    --    | p x       = x : filter p xs
    --    | otherwise = filter p xs
    menoresCincoE :: [Int] -> [Int]
    menoresCincoE xs = filter (<5) xs  

--Asignaciones locales
--Alcance
    --Let
    cel2fahrLet :: Float -> Float
    cel2fahrLet x = let scalingfactor = 9.0/5.0
                        freezingpoint = 32
                    in (x*scalingfactor) + freezingpoint 
    --Where
    cel2fahrWhere :: Float -> Float
    cel2fahrWhere x = (x*scalingfactor) + freezingpoint
     where scalingfactor = 9.0/5.0
           freezingpoint = 32

--Links útiles
    -- https://www.haskell.org/documentation/
    -- http://aprendehaskell.es/
    -- http://learnyouahaskell.com/

{-
Hola
soy
un comentario
-}