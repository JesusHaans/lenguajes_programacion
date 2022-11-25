module MachineJ where
import MinL
import Data.Maybe

{-
Ejercicio extra P5
Implementar la máquina J para el lenguaje MinL con el que hemos venido trabajando
en el laboratorio

Este debe tener estartegia de evaluación ansiosa, utilizar ambientes y tener
un alcance estatico de variables

Fecha de entrega: 22/11/2022 11:59 pm
-}

-- AMBIENTES 
data Env = MtE | Asi Var Value Env deriving (Show, Eq)
-- type Env = [(Var,Value)]

look :: Var -> Env -> Maybe Value
look x MtE = Nothing
look x (Asi y v e)
 | x == y    = Just v
 | otherwise = look x e

-- VALORES 
data Value = Num Int -- Numeros
           | Bv Bool -- Booleanos
           | Cl Env Var MinL -- closures para funciones
           deriving (Show, Eq)

-- MARCOS Y PILAS 
data Frame =  SumL MinL | SumR Value
            | MultL MinL | MultR Value
            | IfF MinL MinL
            | LetF Var MinL
            | AppL MinL | AppR Value
            deriving (Show, Eq)

data Stack = MtS | Top Frame Stack | TopE Env Stack deriving (Show, Eq)

pop :: Stack -> Frame
pop (Top m s) = m
pop s         = error "no hay suficientes elementos"

push :: Frame -> Stack -> Stack
push = Top

-- ESTADOS 
data State = Eval Stack Env MinL | Return Stack Env Value deriving (Show, Eq)

-- FUNCION DE TRANSICIÓN
trans :: State -> State

trans (Eval p env ml) = case ml of
  V x -> if isNothing v
           then error ""
           else Return p env  (fromJust v)
           where v = look x env
  N n -> Return p env (Num n)
  B b -> Return p env (Bv b)
  Lam x e -> Return p env (Cl env x e)
  Add e1 e2 -> Eval (push (SumL e2) p) env e1
  Mult e1 e2 -> Eval (push (MultL e2) p) env e1
  If f e1 e2 -> Eval (push (IfF e1 e2) p) env f
  Let x e1 e2 -> Eval (push (LetF x e2) p) env e1
  App e1 e2 -> Eval (push (AppL e2) p) env e1

trans s@(Return (Top f p) env v) = case (f,v) of
  (SumL e2, v) -> Eval (push (SumR v) p) env e2
  (SumR (Num n),Num m) -> Return p env (Num $ n + m)
  (SumR _,_) -> s -- Blocked

  (MultL e2, v) -> Eval (push (MultR v) p) env e2
  (MultR (Num n),Num m) -> Return p env (Num $ n * m)
  (MultR _,_) -> s -- Blocked

  (IfF e1 e2, Bv True) -> Eval p env e1
  (IfF e1 e2, Bv False) -> Eval p env e2
  (IfF e1 e2, _) -> s -- Blocked

  (LetF x e2, v) -> Eval (TopE env p) (Asi x v env) e2

  (AppL e2, f) -> Eval (push (AppR f) p) env e2
  (AppR (Cl envF x e), v) -> Eval (TopE env p) (Asi x v envF) e
  (AppR _, v) -> s -- Blocked


trans (Return (TopE env p) env1 v) = Return p env v
trans s@(Return MtS env v) = s -- Blocked. Complete evaluation

evalJ :: State -> State
evalJ s = if s' == s
                 then s
                 else evalJ s'
                 where s' = trans s

evalVJ :: MinL -> Value
evalVJ ml = let Return st env va = evalJ (Eval MtS MtE ml) in
          if st == MtS
          then va
          else error "Block state."

