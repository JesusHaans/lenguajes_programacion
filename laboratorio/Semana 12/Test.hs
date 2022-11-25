module Test where

import Parser
import MachineH (evalVH, Value (Num))
import MachineJ (evalVJ, Value (Num))


pgm = "let x = 3 in " ++
        "let f = lam y = x + y in " ++
            "let x = 5 in (f 4) end " ++
        "end " ++
      "end"

{-
Eval MtS [] let x = 3...
Eval (Top LetF x let f....) 3
Eval MtS [x = 3] let f = lam ....
Eval (Top LetF f let x = ...) [x=3] lam y = x + y
Return (Top LetF f let x = ...) [x=3] (Cl [x=3]  y , x + y)
Eval MtS [f=Cl, x=3] let x=5 in ...
Eval (Top letF x (f 4)) [f=cl, x=3] 5
Eval Mts [x= 5, f=cl, x=3] (f 4)
...
Return (Top AppR (Cl [x=3] x e)) [x= 5, f=cl, x=3] 4
Eval (TopE [x= 5, f=cl, x=3]) [y=4,x=3] x + y
...
Return (TopE [x= 5, f=cl, x=3]) [y=4,x=3] 7
Return MtS [x= 5, f=cl, x=3] 7



---- caso sin closures
....

Eval MtS [x= 5, f=lam y -> x + y, x=3]  (f 4)
...
Eval Mts [y= 4 ,x= 5, f=lam y -> x + y, x=3] x + y
Return Mts Env... 9
-}

asa = parser $ lexer pgm

t1 = evalVH asa == MachineH.Num 7

t2 = evalVJ asa == MachineJ.Num 7

