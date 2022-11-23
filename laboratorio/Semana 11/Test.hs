module Test where

import Parser
import MachineH (evalVH, Value (Num))
import MachineJ (evalVJ, Value (Num))


pgm = "let x = 3 in " ++
        "let f = lam y = x + y in " ++
            "let x = 5 in (f 4) end " ++
        "end " ++
      "end"

asa = parser $ lexer pgm

t1 = evalVH asa == MachineH.Num 7

t2 = evalVJ asa == MachineJ.Num 7

