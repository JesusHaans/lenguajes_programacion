{-# OPTIONS_GHC -w #-}
module ExpPar where
import Data.Char
import Data.List

import Exp

{-
EJEMPLO DE PARSER ELABORADO CON HAPPY
-- Lenguaje correspondiente a Exp, en el cual vimos como funciona Fix
--Este archivo es muy diferente al que estuve viendo en clase, le quite
  todo lo que no era necesario (que venia en el archivo que copie) y lo modifique
  para poder parsear al lenguaje donde vimos como funciona fix

-- Ademas se agrega el ejemplo visto en clase para hacer el parser de recfun y de
   expresiones tipo 'e+'
-}
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.0

data HappyAbsSyn t4 t5 t6 t7
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,132) ([34688,13316,128,0,0,0,3584,0,0,0,0,0,4638,208,2319,32872,0,49152,579,8218,0,4096,0,0,128,0,128,56832,53267,0,64,28672,1,32704,6658,8672,3329,37104,1664,18552,832,384,0,0,0,64,0,120,0,0,57344,289,61453,32912,30726,16463,3,16384,4096,0,3840,26633,28672,0,0,96,0,0,0,0,1792,16,4992,0,0,0,2319,32872,1159,52,1024,0,0,0,0,0,3072,32768,4099,49152,1,0,0,2048,8,64,0,0,48,0,1,0,2,4,0,0,0,2319,104,112,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","Exp","vars","exps","Type","var","num","bool","'('","')'","'-'","'*'","'=='","if","then","else","letrec","'->'","'::'","'='","Nat","Bool","in","end","'['","']'","recfun","lam","%eof"]
        bit_start = st Prelude.* 31
        bit_end = (st Prelude.+ 1) Prelude.* 31
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..30]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (8) = happyShift action_4
action_0 (9) = happyShift action_2
action_0 (10) = happyShift action_5
action_0 (11) = happyShift action_6
action_0 (16) = happyShift action_7
action_0 (19) = happyShift action_8
action_0 (27) = happyShift action_9
action_0 (29) = happyShift action_10
action_0 (30) = happyShift action_11
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (9) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (13) = happyShift action_18
action_3 (14) = happyShift action_19
action_3 (15) = happyShift action_20
action_3 (31) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_2

action_5 _ = happyReduce_3

action_6 (8) = happyShift action_4
action_6 (9) = happyShift action_2
action_6 (10) = happyShift action_5
action_6 (11) = happyShift action_6
action_6 (16) = happyShift action_7
action_6 (19) = happyShift action_8
action_6 (27) = happyShift action_9
action_6 (29) = happyShift action_10
action_6 (30) = happyShift action_11
action_6 (4) = happyGoto action_17
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (8) = happyShift action_4
action_7 (9) = happyShift action_2
action_7 (10) = happyShift action_5
action_7 (11) = happyShift action_6
action_7 (16) = happyShift action_7
action_7 (19) = happyShift action_8
action_7 (27) = happyShift action_9
action_7 (29) = happyShift action_10
action_7 (30) = happyShift action_11
action_7 (4) = happyGoto action_16
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (8) = happyShift action_15
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (8) = happyShift action_4
action_9 (9) = happyShift action_2
action_9 (10) = happyShift action_5
action_9 (11) = happyShift action_6
action_9 (16) = happyShift action_7
action_9 (19) = happyShift action_8
action_9 (27) = happyShift action_9
action_9 (29) = happyShift action_10
action_9 (30) = happyShift action_11
action_9 (4) = happyGoto action_14
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (8) = happyShift action_13
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (8) = happyShift action_12
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (20) = happyShift action_31
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (21) = happyShift action_30
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (8) = happyShift action_4
action_14 (9) = happyShift action_2
action_14 (10) = happyShift action_5
action_14 (11) = happyShift action_6
action_14 (13) = happyShift action_18
action_14 (14) = happyShift action_19
action_14 (15) = happyShift action_20
action_14 (16) = happyShift action_7
action_14 (19) = happyShift action_8
action_14 (27) = happyShift action_9
action_14 (29) = happyShift action_10
action_14 (30) = happyShift action_11
action_14 (4) = happyGoto action_28
action_14 (6) = happyGoto action_29
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (22) = happyShift action_27
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (13) = happyShift action_18
action_16 (14) = happyShift action_19
action_16 (15) = happyShift action_20
action_16 (17) = happyShift action_26
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (8) = happyShift action_4
action_17 (9) = happyShift action_2
action_17 (10) = happyShift action_5
action_17 (11) = happyShift action_6
action_17 (12) = happyShift action_25
action_17 (13) = happyShift action_18
action_17 (14) = happyShift action_19
action_17 (15) = happyShift action_20
action_17 (16) = happyShift action_7
action_17 (19) = happyShift action_8
action_17 (27) = happyShift action_9
action_17 (29) = happyShift action_10
action_17 (30) = happyShift action_11
action_17 (4) = happyGoto action_24
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (8) = happyShift action_4
action_18 (9) = happyShift action_2
action_18 (10) = happyShift action_5
action_18 (11) = happyShift action_6
action_18 (16) = happyShift action_7
action_18 (19) = happyShift action_8
action_18 (27) = happyShift action_9
action_18 (29) = happyShift action_10
action_18 (30) = happyShift action_11
action_18 (4) = happyGoto action_23
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (8) = happyShift action_4
action_19 (9) = happyShift action_2
action_19 (10) = happyShift action_5
action_19 (11) = happyShift action_6
action_19 (16) = happyShift action_7
action_19 (19) = happyShift action_8
action_19 (27) = happyShift action_9
action_19 (29) = happyShift action_10
action_19 (30) = happyShift action_11
action_19 (4) = happyGoto action_22
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (8) = happyShift action_4
action_20 (9) = happyShift action_2
action_20 (10) = happyShift action_5
action_20 (11) = happyShift action_6
action_20 (16) = happyShift action_7
action_20 (19) = happyShift action_8
action_20 (27) = happyShift action_9
action_20 (29) = happyShift action_10
action_20 (30) = happyShift action_11
action_20 (4) = happyGoto action_21
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (13) = happyShift action_18
action_21 (14) = happyShift action_19
action_21 (15) = happyFail []
action_21 _ = happyReduce_7

action_22 _ = happyReduce_6

action_23 (14) = happyShift action_19
action_23 _ = happyReduce_5

action_24 (12) = happyShift action_38
action_24 (13) = happyShift action_18
action_24 (14) = happyShift action_19
action_24 (15) = happyShift action_20
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_4

action_26 (8) = happyShift action_4
action_26 (9) = happyShift action_2
action_26 (10) = happyShift action_5
action_26 (11) = happyShift action_6
action_26 (16) = happyShift action_7
action_26 (19) = happyShift action_8
action_26 (27) = happyShift action_9
action_26 (29) = happyShift action_10
action_26 (30) = happyShift action_11
action_26 (4) = happyGoto action_37
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (8) = happyShift action_4
action_27 (9) = happyShift action_2
action_27 (10) = happyShift action_5
action_27 (11) = happyShift action_6
action_27 (16) = happyShift action_7
action_27 (19) = happyShift action_8
action_27 (27) = happyShift action_9
action_27 (29) = happyShift action_10
action_27 (30) = happyShift action_11
action_27 (4) = happyGoto action_36
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (8) = happyShift action_4
action_28 (9) = happyShift action_2
action_28 (10) = happyShift action_5
action_28 (11) = happyShift action_6
action_28 (13) = happyShift action_18
action_28 (14) = happyShift action_19
action_28 (15) = happyShift action_20
action_28 (16) = happyShift action_7
action_28 (19) = happyShift action_8
action_28 (27) = happyShift action_9
action_28 (29) = happyShift action_10
action_28 (30) = happyShift action_11
action_28 (4) = happyGoto action_28
action_28 (6) = happyGoto action_35
action_28 _ = happyReduce_16

action_29 (28) = happyShift action_34
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (11) = happyShift action_33
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (8) = happyShift action_4
action_31 (9) = happyShift action_2
action_31 (10) = happyShift action_5
action_31 (11) = happyShift action_6
action_31 (16) = happyShift action_7
action_31 (19) = happyShift action_8
action_31 (27) = happyShift action_9
action_31 (29) = happyShift action_10
action_31 (30) = happyShift action_11
action_31 (4) = happyGoto action_32
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (13) = happyShift action_18
action_32 (14) = happyShift action_19
action_32 (15) = happyShift action_20
action_32 _ = happyReduce_9

action_33 (23) = happyShift action_42
action_33 (24) = happyShift action_43
action_33 (7) = happyGoto action_41
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_13

action_35 _ = happyReduce_17

action_36 (13) = happyShift action_18
action_36 (14) = happyShift action_19
action_36 (15) = happyShift action_20
action_36 (25) = happyShift action_40
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (13) = happyShift action_18
action_37 (14) = happyShift action_19
action_37 (15) = happyShift action_20
action_37 (18) = happyShift action_39
action_37 _ = happyFail (happyExpListPerState 37)

action_38 _ = happyReduce_11

action_39 (8) = happyShift action_4
action_39 (9) = happyShift action_2
action_39 (10) = happyShift action_5
action_39 (11) = happyShift action_6
action_39 (16) = happyShift action_7
action_39 (19) = happyShift action_8
action_39 (27) = happyShift action_9
action_39 (29) = happyShift action_10
action_39 (30) = happyShift action_11
action_39 (4) = happyGoto action_46
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (8) = happyShift action_4
action_40 (9) = happyShift action_2
action_40 (10) = happyShift action_5
action_40 (11) = happyShift action_6
action_40 (16) = happyShift action_7
action_40 (19) = happyShift action_8
action_40 (27) = happyShift action_9
action_40 (29) = happyShift action_10
action_40 (30) = happyShift action_11
action_40 (4) = happyGoto action_45
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (20) = happyShift action_44
action_41 _ = happyFail (happyExpListPerState 41)

action_42 _ = happyReduce_18

action_43 _ = happyReduce_19

action_44 (23) = happyShift action_42
action_44 (24) = happyShift action_43
action_44 (7) = happyGoto action_48
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (13) = happyShift action_18
action_45 (14) = happyShift action_19
action_45 (15) = happyShift action_20
action_45 (26) = happyShift action_47
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (13) = happyShift action_18
action_46 (14) = happyShift action_19
action_46 (15) = happyShift action_20
action_46 _ = happyReduce_8

action_47 _ = happyReduce_10

action_48 (12) = happyShift action_49
action_48 (20) = happyShift action_50
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (8) = happyShift action_53
action_49 (5) = happyGoto action_52
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (23) = happyShift action_42
action_50 (24) = happyShift action_43
action_50 (7) = happyGoto action_51
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (20) = happyShift action_50
action_51 _ = happyReduce_20

action_52 (22) = happyShift action_55
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (8) = happyShift action_53
action_53 (5) = happyGoto action_54
action_53 _ = happyReduce_14

action_54 _ = happyReduce_15

action_55 (8) = happyShift action_4
action_55 (9) = happyShift action_2
action_55 (10) = happyShift action_5
action_55 (11) = happyShift action_6
action_55 (16) = happyShift action_7
action_55 (19) = happyShift action_8
action_55 (27) = happyShift action_9
action_55 (29) = happyShift action_10
action_55 (30) = happyShift action_11
action_55 (4) = happyGoto action_56
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (13) = happyShift action_18
action_56 (14) = happyShift action_19
action_56 (15) = happyShift action_20
action_56 _ = happyReduce_12

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyTerminal (TokenNum happy_var_1))
	 =  HappyAbsSyn4
		 (Num happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn4
		 (Var happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  4 happyReduction_3
happyReduction_3 (HappyTerminal (TokenBool happy_var_1))
	 =  HappyAbsSyn4
		 (B happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_3  4 happyReduction_4
happyReduction_4 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_3  4 happyReduction_5
happyReduction_5 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  4 happyReduction_6
happyReduction_6 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Prod happy_var_1 happy_var_3
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  4 happyReduction_7
happyReduction_7 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Equal happy_var_1 happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happyReduce 6 4 happyReduction_8
happyReduction_8 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (If happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 4 4 happyReduction_9
happyReduction_9 ((HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Lam happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_10 = happyReduce 7 4 happyReduction_10
happyReduction_10 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Letrec happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 4 4 happyReduction_11
happyReduction_11 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (App happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_12 = happyReduce 11 4 happyReduction_12
happyReduction_12 ((HappyAbsSyn4  happy_var_11) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_9) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Recfun happy_var_2 happy_var_5 happy_var_7 happy_var_9 happy_var_11
	) `HappyStk` happyRest

happyReduce_13 = happyReduce 4 4 happyReduction_13
happyReduction_13 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (AppT happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_14 = happySpecReduce_1  5 happyReduction_14
happyReduction_14 (HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_2  5 happyReduction_15
happyReduction_15 (HappyAbsSyn5  happy_var_2)
	(HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn5
		 (happy_var_1:happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  6 happyReduction_16
happyReduction_16 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_2  6 happyReduction_17
happyReduction_17 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1:happy_var_2
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  7 happyReduction_18
happyReduction_18 _
	 =  HappyAbsSyn7
		 (Nat
	)

happyReduce_19 = happySpecReduce_1  7 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn7
		 (Boolean
	)

happyReduce_20 = happySpecReduce_3  7 happyReduction_20
happyReduction_20 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Func happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 31 31 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenVar happy_dollar_dollar -> cont 8;
	TokenNum happy_dollar_dollar -> cont 9;
	TokenBool happy_dollar_dollar -> cont 10;
	TokenOB -> cont 11;
	TokenCB -> cont 12;
	TokenRes -> cont 13;
	TokenMult -> cont 14;
	TokenEquals -> cont 15;
	TokenIf -> cont 16;
	TokenThen -> cont 17;
	TokenElse -> cont 18;
	TokenLetrec -> cont 19;
	TokenArrow -> cont 20;
	TokenDots -> cont 21;
	TokenEq -> cont 22;
	TokenNat -> cont 23;
	TokenBoolean -> cont 24;
	TokenIn -> cont 25;
	TokenEnd -> cont 26;
	TokenOBrack -> cont 27;
	TokenCBrack -> cont 28;
	TokenRecfun -> cont 29;
	TokenLam -> cont 30;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 31 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
parser tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError _ = error "Parse error"
 
data Token
      = TokenVar String
      | TokenNum Int
      | TokenBool Bool
      | TokenOB
      | TokenCB
      | TokenRes
      | TokenMult 
      | TokenEquals
      | TokenIf
      | TokenThen
      | TokenElse 
      | TokenLetrec
      | TokenArrow
      | TokenDots
      | TokenEq
      | TokenNat
      | TokenBoolean
      | TokenIn
      | TokenEnd
      | TokenOBrack
      | TokenCBrack
      | TokenRecfun
      | TokenLam
      deriving Show


lexer :: String -> [Token]
lexer [] = []
lexer (c:cs) 
      | isSpace c = lexer cs
      | isAlpha c = lexVar (c:cs)
      | isDigit c = lexNum (c:cs)
lexer ('-':'>':cs) = TokenArrow : lexer cs
lexer ('-':cs) = TokenRes : lexer cs
lexer ('*':cs) = TokenMult : lexer cs
lexer ('(':cs) = TokenOB : lexer cs
lexer (')':cs) = TokenCB : lexer cs
lexer ('[':cs) = TokenOBrack : lexer cs
lexer (']':cs) = TokenCBrack : lexer cs
lexer ('=':'=':cs) = TokenEquals : lexer cs
lexer ('=':cs) = TokenEq : lexer cs
lexer (':':':':cs) = TokenDots : lexer cs

lexNum cs = TokenNum (read num) : lexer rest
      where (num,rest) = span isDigit cs

lexVar cs =
   case span isAlpha cs of
      ("if", rest) -> TokenIf : lexer rest
      ("then", rest) -> TokenThen : lexer rest
      ("else", rest) -> TokenElse : lexer rest
      ("Nat", rest) -> TokenNat : lexer rest
      ("Bool", rest) -> TokenBoolean : lexer rest
      ("recfun", rest) -> TokenRecfun : lexer rest
      ("letrec", rest) -> TokenLetrec : lexer rest
      ("in", rest) -> TokenIn : lexer rest
      ("end", rest) -> TokenEnd : lexer rest
      ("lam", rest) -> TokenLam : lexer rest
      (var,rest)   -> TokenVar var : lexer rest

main = getContents >>= print . parser . lexer
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
