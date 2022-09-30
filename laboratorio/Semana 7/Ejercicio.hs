module MinL where
import Data.Semigroup (Min)


{--
EJERCICIO EXTRA P3

Definir un interprete que nos regrese algo de tipo Int, utilizando 
semantica de paso pequeño y una estrategia de evaluacion ansiosa
para el lenguaje MinL, cuya sintaxis abstracta esta representada por
el siguiente tipo de dato
--}

data MinL = N Int | V String
          | Add MinL MinL
          | Mult MinL MinL
          | If MinL MinL MinL
          | Let String MinL MinL
          | Lam String MinL
          | App MinL MinL

--evaluacion de paso pegueño
eval :: MinL -> Int
eval (N n) = n
eval (V x) = error "variable sin valor"
eval (Add (N n) (N m)) = n + m 
eval (Add e1 e2) = eval e1 + eval e2
eval (Mult e1 e2) = eval e1 * eval e2
eval (If e1 e2 e3) = if eval e1 /= 0 then eval e2 else eval e3
