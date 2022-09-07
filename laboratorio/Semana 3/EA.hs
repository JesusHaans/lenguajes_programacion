module EA where

type Var = String

data EA = Num Int
        | V Var
        | Add EA EA
        | Prod EA EA
        | Let Var EA EA
        deriving(Show)

eval :: EA -> Int
eval (Num n) = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Prod e1 e2) = eval e1 * eval e2
eval (Let x e1 e2) = eval (subs e2 (x,Num (eval e1)))--- let x = e1 in e2
--eval (Let x e1 e2) = eval  (subs e2 (x,e1))

--- let x = 3+2 in x * 7.
eval _ = error "Variables libres presentes"


type Subs = (Var,EA) --- [x:=e]  -> (x,e)

subs :: EA -> Subs -> EA
subs n@(Num _) _ = n
subs v@(V v1) (v2,e) = if v1 == v2
                       then e
                       else v
subs (Add e1 e2) s = Add (subs e1 s) (subs e2 s)
subs (Prod e1 e2) s = Prod (subs e1 s) (subs e2 s)
subs (Let x v e1) s@(y,e2)
 | x == y = error "No se puede reemplarzar variable ligada por el let"
 | x `elem` (frvars e2) = error "Se esta ligando una variable libre"
 | otherwise = Let x (subs v s) (subs e1 s)

frvars :: EA -> [Var]
frvars (Num _) = []
frvars (V v) = [v]
frvars (Add e1 e2) = (++) (frvars e1) (frvars e2)
frvars (Prod e1 e2) = (++) (frvars e1) (frvars e2)
frvars (Let x e1 e2) = filter (/= x) ((++) (frvars e1) (frvars e2))

{--
subs (x,e) v@(V u) = if x == u
                   then e
                   else v
subs s (Add e1 e2) = Add (subs s e1) (subs s e2)
subs s (Prod e1 e2) = Prod (subs s e1) (subs s e2)
subs s@(x,e) (Let y e1 e2)
 | x == y = error "Se quiere susbtituir la variable del Let"
 | elem y (frvars e) = error "bla bla"
 | otherwise = Let y (subs s e1) (subs s e2)
subs _ e@(Num n) = e  -}