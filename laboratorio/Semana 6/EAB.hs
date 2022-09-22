module EAB where

data EAB = Num Int | B Bool 
         | Add EAB EAB | Mult EAB EAB
         | And EAB EAB | Or EAB EAB | Not EAB
         | Lt EAB EAB | Gt EAB EAB  | Eq EAB EAB
         | If EAB EAB EAB deriving (Eq)

instance Show EAB where
    show e = case e of
            (Num n) -> show n
            (B b) -> show b
            (Add e1 e2) -> "(" ++ show e1 ++ " + " ++ show e2 ++ ")" 
            (Mult e1 e2) -> "(" ++ show e1 ++ " * " ++ show e2 ++ ")" 
            (And e1 e2) -> "(" ++ show e1 ++ " and " ++ show e2 ++ ")"
            (Or e1 e2) -> "(" ++ show e1 ++ " or " ++ show e2 ++ ")"  
            (Not e1) -> "" ++ show e1
            (Lt e1 e2) -> "(" ++ show e1 ++ " < " ++ show e2 ++ ")"  
            (Gt e1 e2) -> "(" ++ show e1 ++ " > " ++ show e2 ++ ")"
            (Eq e1 e2) -> "(" ++ show e1 ++ " == " ++ show e2 ++ ")" 
            (If f e1 e2) -> "if " ++ show f ++ " then " ++ show e1 ++ " else " ++ show e2 ++ " end" 

-- Paso pequeño
eval1 :: EAB -> EAB
eval1 (Add (Num n) (Num m)) = Num  (n+m)
eval1 (Add (Num n) e2) = Add (Num n) (eval1 e2)
eval1 (Add e1 e2) = Add (eval1 e1) e2
eval1 (Mult (Num n) (Num m)) = Num  (n*m)
eval1 (Mult (Num n) e2) = Mult (Num n) (eval1 e2)
eval1 (Mult e1 e2) = Mult (eval1 e1) e2
eval1 (And (B n) (B m)) = B (n&&m)
eval1 (And (B n) e2) = And (B n) (eval1 e2)
eval1 (And e1 e2) = And (eval1 e1) e2
eval1 (Or (B n) (B m)) = B (n||m)
eval1 (Or (B n) e2) = Or (B n) (eval1 e2)
eval1 (Or e1 e2) = Or (eval1 e1) e2
eval1 (Lt (Num n) (Num m)) = B (n<m)
eval1 (Lt (Num n) e2) = Lt (Num n) (eval1 e2)
eval1 (Lt e1 e2) = Lt (eval1 e1) e2
eval1 (Gt (Num n) (Num m)) = B (n>m)
eval1 (Gt (Num n) e2) = Gt (Num n) (eval1 e2)
eval1 (Gt e1 e2) = Gt (eval1 e1) e2
eval1 (Eq (Num n) (Num m)) = B (n==m)
eval1 (Eq (Num n) e2) = Eq (Num n) (eval1 e2)
eval1 (Eq e1 e2) = Eq (eval1 e1) e2
eval1 (Not (B b)) = B (not b)
eval1 (Not e) = Not (eval1 e)
eval1 (If (B b) e1 e2) = if b
                         then e1
                         else e2
eval1 (If f e1 e2) = If (eval1 f) e1 e2
eval1 e = e

evaln :: EAB -> EAB
evaln e = if e == e'
          then e
          else evaln e'
        where e' = eval1 e

eval :: EAB -> Either Int Bool
eval e = case evaln e of
            (Num n) -> Left n
            (B b) -> Right b
            e' -> error "Expresión bloqueada"

--- ((3+4)+2) + (5 + 2)
--- (7+2) + (5 + 2)
--- 9 + (5 + 2)
--- 9 + 7
--- 16

{--
Paso grande
eval :: EAB -> Either Int Bool
eval (Add e1 e2) = let Left x = eval e1; Left y = eval e2 in Left (x + y)
--}

