module MinL where

import Data.List

data MinL = N Int | V Var | B Bool
          | Add MinL MinL
          | Mult MinL MinL
          | If MinL MinL MinL
          | Let Var MinL MinL
          | Lam Var MinL
          | App MinL MinL
          deriving (Eq, Show)

type Var = String
type Sust = (Var,MinL)

sust :: MinL -> Sust -> MinL
sust e@(V x) (i, v) | x == i = v | otherwise = e
sust e@(N n) _ = e
sust e@(B b) _ = e
sust (Add a b ) s  = Add (sust a s) (sust b s)
sust (Mult a b ) s = Mult (sust a s) (sust b s)
sust (If g t e) s = If (sust g s) (sust t s) (sust e s)
sust e@(Let x a b) s@(i, v)
 | x `notElem` fv v && (i /= x) = Let x (sust a s) (sust b s)
 | otherwise = e
sust e@(Lam x b) s@(i, v)
 | x `notElem` fv v && (i /= x) = Lam x (sust b s)
 | otherwise = e
sust (App f p) s = App (sust f s) (sust p s)

fv :: MinL -> [Var]
fv (V x) = [x]
fv (Add a b) = fv a ++ fv b
fv (Mult a b) = fv a ++ fv b
fv (If a b c) = fv a ++ fv b ++ fv c
fv (Lam x a) = filter (/= x) (fv a)
fv (Let x a b) = fv a ++ filter (/= x) (fv b)
fv (App a b) = fv a ++ fv b
fv e = []