module Polinomio where
--- PUNTO EXTRA, RESOLVER LOS SIGUIENTES EJERCICIOS USANDO O NO, LAS IDEAS DISCUTIDAS EN CLASE

{-- DEFINIMOS las expresiones aritmeticas con UNA sola
    variable con lo siguiente -}
data Exp = Var --x
         | Const Int
         | Add Exp Exp
         | Mult Exp Exp
         deriving (Show)

{-
 - Para resolver estos ejercicios pondremos varias restricciones que seran
 - "teoricas", con esto me refiero que son cosas que daremos por hecho al
 - escribir el codigo, aunque estas no se vean reflejadas por ningun lado.
-}

{--
 -- Definir funcion evaluacion que dado una expresión, y un valor para la variable,
 -- te regresa la evaluacion del polinomio
 -- 1 + x + 3x2 => Add (Const 1) (Add Var (Mult (Const 3) Var)) => [1,1,3]
 -- 1 + 2 + 3(2**2) = 1 + 2 + 12 = 15
 --
 --
 -- Restricción 1: Las expresiones validas (las que seran un polinomio) deben 
 -- estar construidas de la siguiente forma:
 -- Por termino me referire a una Variable (Var) o
 -- Una constante multiplicada por una variable (Mult (Const n) Var) o
 -- Una constante
 --
 -- En el Constuctor Add del lado izquiero debe tener un termino y del lado derecho
 -- debe tener o igual un termino, u otro Add (como en el ejemplo)

 EJERCICIO 1: Definir una función de evaluación para Exp, donde la variable tomara el valor
 de el Int que recibe la función.

 NOTA: Al evaluar esto recuerden que con las restricciones que pusimos tambien se debe contar las apariciones 
 de las variables para saber su exponenete
 --}

eval :: Exp -> Int -> Int
eval x = let exp = aux x in evalaux x exp


{-

nos ayuda a evaluar segun el exponente

-}
evalaux :: Exp -> Int -> Int -> Int
evalaux Var n m = n^m
evalaux (Const x) n m = x
evalaux (Add x y) n m = let i = aux y in evalaux x n (m-i) + evalaux y n m
evalaux (Mult (Const x) Var) n m = x * n^m


{-

nos ayuda a cointar el numero de apariciones de Var en la expresion

-}
aux :: Exp -> Int
aux Var = 1
aux (Const _) = 0
aux (Add x y) = aux x + aux y
aux (Mult x y) = aux x + aux y

{-- 
 -- Representacion polinomios
 -- [1,2,5,-1]  ==> 1+2x+5x2-1x3
 --
 -- Restricción 0: EL exponente de la variable se tomara en orden creciente
 -- Cada vez que aparezca la variable se debe tomar en cuenta que el exponente que
 -- tendra esta sera uno mayor al de la aparicion anterior de esta, si es la primer
 -- aparición que tiene el exponente sera uno.
 --
 -- Los polinomios deben estar escritos de forma que no haya varias sumas de constantes.
 --
 -- Con estas reglas si quiseramos escribir por ejemplo el polinomio 5x3 + 6 + 2x + 4
 -- se deberia representar pensando en el polinomio (10 + 2x + 0x2 + 5x3)
 -- 
 EJERCICIO 2: Definir la función evalp, que recibe una lista de ints, y un int y regresa la evaluación
 del polinomio representado en esa lista
 --}
evalp :: [Int] -> Int -> Int
evalp [] _ = 0
evalp (x:xs) n = let exp = 0 in x*(n^exp) + evalpaux xs n (exp+1)


{-

evalpaux nos ayuda a llevar una cuenta de la potencia que llevamos para evaluar el polinomio

-}
evalpaux :: [Int] -> Int -> Int -> Int
evalpaux [] _ _ = 0
evalpaux (x:xs) n m = x*(n^m) + evalpaux xs n (m+1)



{--
EJERCICIO 3: Pasar una exp a un polinomio (por polinomio nos referimos a la lista de coeficientes)
-- De manera que se cumpla que:
-- eval e n = evalp (coeffs e) n
-}
coeffs :: Exp -> [Int]
coeffs exp = let x=coeffszero exp
                 y=aux exp 
 in [x] ++ coeffsaux exp x

{-

coeffsaux nos ayuda a ir agregando los coeficientes con mismo numnero de exponente Xn

-}
coeffsaux :: Exp -> Int -> [Int]
coeffsaux Var m = [1]
coeffsaux (Const x) m = []
coeffsaux (Add x y) m = let i = aux y in coeffsaux x (m-i) ++ coeffsaux y m
coeffsaux (Mult (Const x) Var) m = [x]

{-

coeffzero nos ayuda a sumar todos los numeros de coeficiente X0 para regresar la suma de estos

-}
coeffszero :: Exp -> Int
coeffszero Var = 0
coeffszero (Const n) = n
coeffszero (Add x y) = coeffszero x + coeffszero y
coeffszero (Mult (Const x) Var) = 0


{-- NOTA
 Las resticciones que mencione en este documento son para resolverlo con la idea que discutimos
 en clase sobre crear una función auxiliar donde tuvieramos un entero que nos permitiera llevar la
 de que exponente deberia tener la variable que se esta evaluando, si ustedes encuentran/piensan 
 resolverlo de una manera distinta esta bien y pueden generar restricciones similares a estas que les
 sean de utilidad.


 Add (Mult (Const 2) Var) (Add (Mult (Const 3) Var) (Mult (Const 3) Var)) 
--}