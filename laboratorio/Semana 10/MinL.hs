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
data Type = Nat | Boolean | Arrow Type Type | TVar Var | TypeOf MinL deriving (Show, Eq)

-- | Sinonimo para una restricción como una dupla de tipos (T1,T2) que representa T1 = T2
type Rest = (Type,Type)

-- | Sinonimo para un unificador representando una serie de substituciones
type Unifier = [Substitution]
type Substitution = (Type, Type)

rest :: MinL -> [Rest]
rest e@(V x) = [(TypeOf e, TVar x)]
rest e@(N _) = [(TypeOf e, Nat)]
rest e@(B _) = [(TypeOf e, Boolean)]
rest e@(Add e1 e2) = (r1 `union` r2) `union` [(TypeOf e1, Nat),(TypeOf e2, Nat),(TypeOf e, Nat)]
                        where r1 = rest e1; r2 = rest e2
rest e@(Mult e1 e2) = (r1 `union` r2) `union` [(TypeOf e1, Nat),(TypeOf e2, Nat),(TypeOf e, Nat)]
                        where r1 = rest e1; r2 = rest e2
rest e@(If f e1 e2) = union rf (r1 `union` r2) `union` [(TypeOf f, Boolean),(TypeOf e1, TypeOf e2),(TypeOf e, TypeOf e1),(TypeOf e, TypeOf e2)]
                        where rf = rest f; r1 = rest e1; r2 = rest e2
rest e@(Let x e1 e2) = (r1 `union` r2) `union` [(TVar x, TypeOf e1),(TypeOf e, TypeOf e2)]
                        where r1 = rest e1; r2 = rest e2
rest e@(Lam x e1) = r `union` [(TypeOf e, Arrow (TVar x) (TypeOf e1))]
                    where r = rest e1
rest e@(App e1 e2) = (r1 `union` r2) `union` [(TypeOf e1, Arrow (TypeOf e2) (TypeOf e))]
                        where r1 = rest e1; r2 = rest e2

----------------------------- FUNCIONES AUXILIARES --------------------------------

tvars :: Type -> [Var]
tvars (TVar s) = [s]
tvars Nat = []
tvars Boolean = []
tvars (TypeOf e) = []
tvars (Arrow a b) = tvars a `union` tvars b

subst :: Type -> Substitution -> Type
subst v@(TVar s) (x,t)
 | v == x = t
 | otherwise = v
subst Nat _ = Nat
subst Boolean _ = Boolean
subst e@(TypeOf a) (x,t)
 | e == x = t
 | otherwise = e
subst (Arrow a b) s = Arrow (subst a s) (subst b s)

comp :: Unifier -> Substitution -> Unifier
comp u s = map (\(x,t) -> (x, subst t s)) u ++ [s]
