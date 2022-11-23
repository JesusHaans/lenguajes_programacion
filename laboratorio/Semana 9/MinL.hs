module MinL where

{--
EJERCICIO EXTRA P4

Implementar el algoritmo de inferencia de tipos para el
lenguaje MinL que utilizamos en el ejercicio extra de la 
practica 3. Su sintaxis abstracta esta implementada con
el siguiente tipo de dato

Además deben implementar un parser-lexer en happy para este lenguaje

Fecha limite: 08 de noviembre de 2022 23:59
--}

data MinL = N Int | V Var | B Bool
          | Add MinL MinL
          | Mult MinL MinL
          | If MinL MinL MinL
          | Let Var MinL MinL
          | Lam Var MinL
          | App MinL MinL

{-
EJEMPLO IMPLEMENTACION DE ALGORITMO DE VERIFICACIÓN DE TIPOS

A continuación se muestra la implementación del algoritmo de
verificación de tipos, para el lenguaje MinLT, que es una
extensión del lenguaje MinL, agregandole anotaciones explicitas de tipo
-}

data MinLT = Num Int | Var Var | BT Bool
            | AddT MinLT MinLT
            | MultT MinLT MinLT
            | IfT MinLT MinLT MinLT
            | LetT Var MinLT MinLT
            | LamT Var Type MinLT -- Anotación de tipo para las funciones
            | AppT MinLT MinLT
            deriving (Eq, Show)

data Type = Nat | Boolean | Arrow Type Type -- Arrow es tipo Función
             deriving (Eq, Show)
type Var = String
{-
Sinonimo para definir contexto de algoritmo de verificación de tipos
como una lista de duplas variable-tipo
-}
type Ctx = [(Var, Type)] 

-- Función auxiliar para encontrar una variable en el contexto
find :: Ctx -> Var -> Type
find [] _       = error "Free Variable"
find ((x,t):cs) i | x == i = t | otherwise = find cs i

verify :: MinLT -> Ctx -> Type
-- Num y BT son para números y booleanos, tipo obtenido directamente
verify (Num _) _ = Nat
verify (BT _) _ = Boolean
-- Los tipos de las variables deben estar declarados en el contexto
verify (Var x) c = find c x
{- AddT y MultT, corresponden a la suma y multiplicación, se verifica que ambos
   operandos sean del tipo necesario (Nat) y por lo tanto el tipo completo de
   la expresión tambien sería Nat -}
verify (AddT n m) c
 | verify n c == Nat && verify m c == Nat = Nat
verify (MultT n m) c
 | verify n c == Nat && verify m c == Nat = Nat
{- IfT, la flag del if se verifica que sea de tipo Boolean, y se verifica que las
    dos expresiones sean del mismo tipo, entonces la expresión sera de ese tipo -}
verify (IfT f n m) c
 | verify f c == Boolean && verify n c == r = r
  where r = verify m c
{- Se verifica el tipo de la expresión a la que será asiganada la variable, una vez hecho eso
   se procede a verificar el tipo de la expresión con la variable ligada, agregando el tipo
   de la variable al contexto, el tipo obtenido sera el de la expresión completa -}
verify (LetT x m n) c = verify n ((x,t):c)
                             where t = verify m c
{- Sabemos gracias a las anotaciones explicitas de tipo, el tipo del cual se supone será 
   la variable, por lo que podemos verificar el tipo de la expresión agregando el que 
   la variable es del tipo anotado al contexto. Ya que es una función, el tipo resultante será 
   de tipo función, recibiendo el tipo de la variable y regresando el tipo de la expresión -}
verify (LamT x t e) c = Arrow t $ verify e ((x,t):c)
{- Se verifica que el tipo de la expresión que va a ser aplicada sea función (t1 -> t2), 
   siendo t1 el tipo de lo que recibe esta función y t2 el tipo que regresa, y posteriormente
   se verifica que la expresión recibida sea de tipo t1, de ser el caso el tipo de la expresión
   completa será t2
-}
verify (AppT m n) c = case verify m c of
                        (Arrow t1 t2) -> if tn == t1
                                         then t2
                                         else error ""
                                         where tn = verify n c
                        t -> error ""
{- Todo lo que no cumpla esas reglas será un error de tipos -}
verify _ _ = error ""
