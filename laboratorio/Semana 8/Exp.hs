module Exp where

----- EJEMPLO FIX ---------------

data Exp = Var String | Num Int | B Bool 
         | Sub Exp Exp | Equal Exp Exp | Prod Exp Exp
         | Lam String Exp | If Exp Exp Exp
         | Letrec String Exp Exp | App Exp Exp | Fix String Exp
         | Recfun String Type Type [String] Exp --- no utilzado (es parte del ejemplo parser recfun)
         | AppT Exp [Exp] --- no utilzado (es parte del ejemplo parser recfun)
         deriving Show

data Type = Nat | Boolean | Func Type Type deriving Show --- no utilzado (es parte del ejemplo parser recfun)

eval :: Exp -> Exp
eval (Sub e1 e2) = case (eval e1, eval e2) of
                    (Num n1, Num n2) -> Num (n1 - n2)
                    (v1, v2) -> Sub v1 v2
eval (Prod e1 e2) = case (eval e1, eval e2) of
                    (Num n1, Num n2) -> Num (n1 * n2)
                    (v1, v2) -> Prod v1 v2
eval (Equal e1 e2) = case (eval e1, eval e2) of
                    (Num n1, Num n2) -> B (n1 == n2)
                    (v1, v2) -> Equal v1 v2
eval (If e e1 e2) = case eval e of
                    (B True) -> eval e1
                    (B False) -> eval e2
                    n -> If n e1 e2
eval (App e1 e2) = case eval e1 of
                    (Lam x e) -> eval (subs e (x,e2))
                    e -> App e e2
eval (Letrec id e1 e2) = eval $ subs e2 (id, Fix id e1) --- letrec fact = fun...  in fact 3 => (Fix fact fun...) 3
eval e@(Fix id f) = eval $ subs f (id,e)  --- F fact => fact (F fact)
eval e = e


---- EJEMPLO DE COMO ES UNA EVALUACION DE UNA FUNCION RECURSIVA--------
--- letrec fact = lam x -> if x == 0 then 1 else x * (fact x-1) in fact 2
-- => (Fix fact lam x -> if x == 0 then 1 else x * (fact x-1)) 2
-- => (lam x -> if x == 0 then 1 else x * ((Fix fact ...) x-1)) 2
-- => if 2 == 0 then 1 else 2 * ((Fix fact lam x -> if x == 0 then 1 else x * (fact x-1)) 1)
-- => 2 * ((Fix fact lam x -> if x == 0 then 1 else x * (fact x-1)) 1)
-- => 2 * (lam x -> if x == 0 then 1 else x * ((Fix fact ...) x-1) 1)
-- => 2 * 1 * ((Fix fact lam x -> if x == 0 then 1 else x * (fact x-1)) 0)
-- => 2 * 1 * (lam x -> if x == 0 then 1 else x * ((Fix fact ...) x-1) 0)
-- 2 * 1 * 1 => 2  

--- EJEMPLO DE ERROR SI NO SE IMPLEMENTA FIX -----
--- let fact = lam x -> if x == 0 then 1 else x * (fact x-1) in fact 2
--- (lam x -> if x == 0 then 1 else x * (fact x-1) 2)
--- if 2 == 0 then 1 else 2 * (fact 2-1)
--- 2 * (fact 2-1)
--- 2 * (fact 1) ¡¡¡VARIABLE LIBRE!!!

{-- Nota
El error que pasaba en clase era en la funcion de substitucion,
es necesario verificar las condiciones de abajo para poder
utilizar operadores de punto fijo
--}
subs :: Exp -> (String, Exp) -> Exp
subs (Var x) (s,e)
 | x == s = e
subs (Sub e1 e2) s = Sub (subs e1 s) (subs e2 s)
subs (Prod e1 e2) s = Prod (subs e1 s) (subs e2 s)
subs (Equal e1 e2) s = Equal (subs e1 s) (subs e2 s)
subs (If e1 e2 e3) s = If (subs e1 s) (subs e2 s) (subs e3 s)
subs e@(Lam x b) s@(i, v) -- Aqui habia error
 | x `notElem` fv v && (i /= x) = Lam x (subs b s)
 | otherwise = e
subs e@(Letrec id a b) s@(i, v) -- Aqui habia error
 | id `notElem` fv v && (i /= id) = Letrec id (subs a s) (subs b s)
 | otherwise = e
subs (App e1 e2) s = App (subs e1 s) (subs e2 s)
subs (Fix id e) s = Fix id (subs e s)
subs e _ = e 

fv :: Exp -> [String]
fv (Var x) = [x]
fv (Prod a b) = fv a ++ fv b
fv (Sub a b) = fv a ++ fv b
fv (Equal a b) = fv a ++ fv b
fv (If a b c) = fv a ++ fv b ++ fv c
fv (Lam x a) = filter (/= x) (fv a)
fv (Letrec x a b) = filter (/= x) (fv a) ++ filter (/= x) (fv b)
fv (App a b) = fv a ++ fv b
fv (Fix x a) = filter (/= x) (fv a)
fv e = []


---- Duda curry ----------

{--

Sintaxis concreta
recfun factTail :: (Nat -> Nat -> Nat) x t =
            if (x == 0)
            then t
            else (factTail (x -1) (t*x))


letrec factTail = lam x :: Nat -> lam t :: Nat -> if (x == 0)
                                               then t
                                               else (factTail (x -1) (t*x))


Sintaxis abstacta
Recfun "facTail" (Arrow Nat Nat) Nat ["x","t"] (If...)

LetRec "factail" (Lam "x" Nat (Lam "t" Nat (If...)))



Ejemplo curry
curry (Suma e1 e2) = Suma (curry e1) (curry e2)
curry (Recfun id t1 _ vl e) = Letrec id (auxcurry t1 vl e)

auxcurry = t [x] e = Lam x t e
auxcurry = (Arrow t1 t2) (x:xs) e = Lam x t1 (auxcurry t2 xs e)

-}




---------- DUDA PRECEDENCIA ------------------

-- if e1 then e2 else e3 * e4
-- (if e1 then e2 else e3) * e4
-- if e1 * e5 then e2 else (e3 * e4)

--- NOTA: Los tipos y funciones, asocian a la derecha!!!
--- T1 -> (T2 -> T3)
--- factTail :: Nat -> (Nat -> Nat)
--- factTail 3 => Nat -> Nat



------ DUDA ESTRATEGIAS DE EVALUACION ------
--- Ansionsa
--- (fun= x + 3) (4*6)
--- =>(fun= 24 + 3)

--- Perezosa
--- (fun= x + 3) (4*6)
--- =>(fun= (4*6) + 3)

--- en la aplicacion es lo principal, en el let 
--  tambien hay que contemplar la estaretegia de evaluacion
-- let x = 3 in x + 3  === (fun=x +3) 3
