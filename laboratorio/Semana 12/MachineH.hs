module MachineH where
import MinL

data State = Eval Stack MinL | Return Stack Value  deriving (Show,Eq)

data Value = Num Int | Bool Bool | Fn Var MinL deriving (Show,Eq)

data Frame = AddL MinL | AddR MinL
          | MultL MinL | MultR MinL
          | IfF MinL MinL
          | LetF Var MinL
          | AppL MinL | AppR MinL deriving (Show,Eq)

data Stack = MtS | Top Frame Stack deriving (Show,Eq)

trans :: State -> State
trans (Eval p ml) = case ml of
  V x -> error "Variable libre"
  N n -> Return p (Num n)
  B b -> Return p (Bool b)
  Lam x e -> Return p (Fn x e)
  Add e1 e2 -> Eval (Top (AddL e2) p) e1
  Mult e1 e2 -> Eval (Top (MultL e2) p) e1
  If f e1 e2 -> Eval (Top (IfF e1 e2) p) f
  Let x e1 e2 -> Eval (Top (LetF x e2) p) e1
  App e1 e2 -> Eval (Top (AppL e2) p) e1

trans s@(Return (Top f p) v) = case (f,v) of
  (AddL e2, v) -> Eval (Top (AddR $ valToexp v) p) e2
  (AddR (N n),Num m) -> Return p (Num $ n + m)
  (AddR _,_) -> s -- Blocked

  (MultL e2, v) -> Eval (Top (MultR $ valToexp v) p) e2
  (MultR (N n),Num m) -> Return p (Num $ n * m)
  (MultR _,_) -> s -- Blocked

  (IfF e1 e2, Bool True) -> Eval p e1
  (IfF e1 e2, Bool False) -> Eval p e2
  (IfF e1 e2, _) -> s -- Blocked

  (LetF x e2, v) -> Eval p (sust e2 (x, valToexp v))

  (AppL e2, f) -> Eval (Top (AppR $ valToexp f) p) e2
  (AppR (Lam x e), v) -> Eval p (sust e (x, valToexp v))
  (AppR _, _) -> s -- Blocked

trans s@(Return MtS v) = s -- Blocked. Complete evaluation

--- 3 + 4 ==>  Add 3 4
--- Eval MtS (Add 3 4)
-- Eval (Top AddL 4) 3
-- Return (Topp AddL 4) 3
--- Eval (Top AddR 3) 4
-- Return (Top AddR 3) 4
-- Return Mts 7

--- 3 + True ==>  Add 3 True
--- Eval MtS (Add 3 True)
-- Eval (Top AddL 4) True
-- Return (Topp AddL 4) True
--- Eval (Top AddR True) 4
-- Return (Top AddR True) 4

--- if true the 4 else 5
--- Eval Mts (If True 4 5)
-- Eval (Top (IfF 4 5)) True
-- Return (Top (IfF 4 5)) True
-- Eval Mts 4
-- Return Mts 4

-- let x = 3 in 3 + x
-- Eval Mts (Let x 3 (Add x 3))
-- Eval (Top LetF x (Add x 3)) 3
-- Return (Top LetF x (Add x 3)) 3
-- Eval Mts (Add 3 3)
-- Eval (AddL 3) 3
--- ...
-- Return Mts 6

--- ((lam x -> x) 3)
-- Eval Mts (App (Lam x x) (3))
-- Eval (Top AppL 3) (Lam x x)
-- .. Eval (Top AppR (Lam x x)) 3
-- .. Evall Mts 3
-- Return Mts 3


evalH :: State -> State
evalH s = if s == s'
          then s
          else evalH s'
          where s' = trans s

evalVH :: MinL -> Value
evalVH ml = let Return st va = evalH (Eval MtS ml) in
          if st == MtS
          then va
          else error "Block state."

valToexp :: Value -> MinL
valToexp (Num n) = N n
valToexp (Bool b) = B b
valToexp (Fn x e) = Lam x e
