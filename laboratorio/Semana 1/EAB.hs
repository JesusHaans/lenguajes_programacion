-- Módulo para definir las
-- Expresiones Artimeticas y Booleanas
module EAB where
    
--utilizar data para contruir nuestros propios tipos de datos
    data Exp = I Int
             | Verdadero
             | Falso
             | Suma Exp Exp
             | Mult Exp Exp
             | Gt Exp Exp
             | Not Exp
             | IsZero Exp
             deriving (Eq) -- == igualdad, != diferente

    --instance show para que nuestro nuevo tipo de dato se muestre bien en terminal
    instance Show Exp where
        show e = case e of
            (I n) -> (show n)
            (Verdadero) -> "Verdadero"
            (Falso) -> "Falso"
            (Suma m n) -> (show m) ++ " + " ++ (show n)
            (Mult m n) -> (show m) ++ " * " ++ (show n)
            (Gt m n) -> (show m) ++ " > " ++ (show n)
            (Not n) -> "¬" ++ (show n)
            (IsZero m) -> "isZero " ++ (show m)

    {- eval :: Exp -> Int or Bool
       Funcionamiento de EITHER, Right y Left
       Recuerden que en este caso utilizamos let para suponer algo, queda como
       tarea moral el completar la función para dar mensajes de error personalizados

       data Either a b = Left a | Right b
       -}
    eval :: Exp -> Either Int Bool
    eval (I n) = Left n
    eval Verdadero = Right True
    eval Falso =  Right False
    eval (Suma e1 e2) = let Left x = eval e1; Left y = eval e2 in Left (x + y)
    eval (Mult e1 e2) = Left (x * y) where Left x = eval e1; Left y = eval e2 
    eval (Gt e1 e2) = let Left x = eval e1; Left y = eval e2 in Right (x > y)
    eval (Not e) = let Right x = eval e in Right (not x)
    eval (IsZero e) = let Left x = eval e in Right (0 == x)

    {-
    Tip: Buscar el tipo Maybe de Haskell
    -}