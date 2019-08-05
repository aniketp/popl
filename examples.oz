% Numeric types
{Browse 1}
{Browse ~2.4}

% Variables and Atomic types
% Declare and use without assigning any value to it
declare X Y
X = Y
{Browse X == Y}

{Browse hello} % Cool atom
{Browse 'Hello World'}
{Browse true}
declare X
X = true
{Browse X == true}

% Records and Tuples
declare Captains Tuple1
Captains = worldcup(france:'Hugo Lloris' belgium:'Eden Hazard')
Tuple1 = message(1:'hello' 2:'world')
{Browse Captains.france}
{Browse Tuple1}

% Functions in Oz (first-class values)
% Recursion
local Factorial in
   fun {Factorial N}
      if N == 0 then 1 else N*{Factorial N-1} end
   end
   {Browse {Factorial 4}}
end

% Imitation of Tail recursion
declare Factorial
fun {Factorial N}
   local FactorialAux in
      fun {FactorialAux N Product}
	 if N == 0 then Product
	 else {FactorialAux N-1 N*Product}
	 end
      end
      {FactorialAux N 1}
   end
end
{Browse {Factorial 6}}

% Lists - nil, first, tail

% Length of a list
declare ListLength
fun {ListLength L}
   case L
   of nil then 0
   [] H|T then 1 + {ListLength T}
   end
end
{Browse {ListLength [2 3 4 5 5 6 66]}}

% kth-element of a list, for a fixed k
declare KElt
fun {KElt L K}
   case L
   of nil then 0
   else
      if K == 0 then L.1
      else {KElt L.2 K-1} end
   end
end
{Browse {KElt [1 2 3 4 5 67] 3}}

% Concatenation of two lists
declare ListConcat
fun {ListConcat L M}
   case L
   of nil then M
   [] H|T then H|{ListConcat T M}
   end
end
{Browse {ListConcat [1 2 3 4] [4 5 6 7]}}

% Cross-product of 2 lists
declare PreProc CrossProduct
fun {PreProc E L}
   case L
   of nil then nil
   [] H|T then [E H]|{PreProc E T}
   end
end

fun {CrossProduct L M}
   case L
   of nil then nil
   [] H|T then {ListConcat {PreProc H M} {CrossProduct T M}}
   end
end
{Browse {CrossProduct [1 2 3] [4 5 6]}}

% Reverse a list
declare Append Reverse1 Reverse2
fun {Append X Y}
   case X
   of nil then Y
   [] H|T then H|{Append T Y}
   end
end
% {Browse {Append [1 2 3] [4 5 6]}}

% O(n^2) method to reverse a list
fun {Reverse1 L}
   case L
   of nil then nil
   [] H|T then {Append {Reverse1 T} [H]}
   end
end
{Browse {Reverse1 [1 2 3 4 5]}}

% O(n) method to reverse a list, following tail calls
fun {Reverse2 L}
   local ReverseAux in
      fun {ReverseAux L LRev}
	 case L
	 of nil then LRev
	 [] H|T then {ReverseAux T H|LRev}
	 end
      end
      {ReverseAux L nil}
   end
end
{Browse {Reverse2 [12 13 14 15 156]}}

% Higher order programming
% Assign functions to variables
local X Double in
   fun {Double X} X*2 end
   X = Double
   {Browse {X 2}}
end

% Pass functions as arguments
local Accumulate Product in
   % Function Product will be passed in as argument
   % to the main function Accumulate
   fun {Product X Y}
      X * Y
   end

   fun {Accumulate L BinOp Identity}
      case L
      of nil then Identity
      [] H|T then {BinOp H {Accumulate T BinOp Identity}}
      end
   end
   {Browse {Accumulate [1 2 3] Product 1}}
end

% Return functions from functions
local AddX in
   fun {AddX X}
      fun {$ Y}
	 X + Y
      end
   end
   % Pass in argument to the return value of
   % {AddX 2} as it itself is a function.
   {Browse {{AddX 2} 3}}
end

% Map:: f:[X1 X2 X3] -> [f(X1) f(X2) f(x3)]
local Map in
   fun {Map L F}
      case L
      of nil then nil
      [] H|T then {F H}|{Map T F}
      end
   end
   {Browse {Map [1 2 3] fun {$ X} X*2 end}}
end
