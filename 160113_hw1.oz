% Homework 1 :: CS350A 2019-20 I
% Author: Aniket Pandey (160113)

%============ Problem 1 (a) ============
declare Drop
fun {Drop N Xs}
   case Xs
   of nil then nil
   else
      if N == 0 then Xs
      else {Drop N-1 Xs.2} end
   end
end
{Browse {Drop 1 [1 2 3 4 5 6 7 8 9]}}

%============ Problem 1 (b) ============
declare Zip
fun {Zip Xs Ys}
   case Xs
   of nil then nil
   [] H|T then [H Ys.1]|{Zip T Ys.2}
   end
end
{Browse {Zip [1 2 3] [4 5 6]}}

%============ Problem 1 (c) ============
declare DeDup DeDupAux
fun {DeDupAux X L}
   case L
   of nil then X|nil
   else
      if X == L.1 then {DeDupAux L.1 L.2}
      else X|{DeDupAux L.1 L.2} end
   end
end

fun {DeDup Xs}
   case Xs
   of nil then nil
   [] H|T then {DeDupAux H T}
   end
end
{Browse {DeDup [0 1 1 2 2 2 3 3 4 5 5 5]}}

%============ Problem 1 (d) ============
declare Length FoldR Map
fun {Map L F}
   case L
   of nil then nil
   [] H|T then {F H}|{Map T F}
   end
end
fun {FoldR L B I}
   case L
   of nil then I
   [] H|T then {B H {FoldR T B I}}
   end
end

fun {Length Xs}
   {FoldR {Map Xs fun {$ X} 1 end}
    fun {$ X Y} X + Y end
    0}
end
{Browse {Length [1 2 3 4 5 6 7]}}

%============ Problem 1 (e) ============
% Redefine Map using FoldR
declare MapX
fun {MapX L F}
   case L
   of nil then nil
   [] H|T then {FoldR [H] fun {$ X Y} {F X} end 1}
      |{MapX T F}
   end
end
{Browse {MapX [1 2 3] fun {$ X} X*X end}}

%============ Problem 1 (f) ============
declare InOrder MapTree
fun {MapTree Fun BinTree}
   case BinTree
   of nil then nil
   else tree(root:{Fun BinTree.root}
	     right:{MapTree Fun BinTree.right}
	     left:{MapTree Fun BinTree.left})
   end
end

% Sample procedure to do an in-order traversal
% of the Binary Tree.
proc {InOrder BinTree}
   case BinTree
   of nil then skip
   else
      {InOrder BinTree.left}
      {Browse BinTree.root}
      {InOrder BinTree.right}
   end
end

T = tree(root:3 
         left:tree(root:2 
                   left:tree(root:1 
                             left:nil right:nil) 
                   right:nil)
         right:tree(root:4 
                    left:nil 
                    right:tree(root:5 
                               left:nil right:nil)))

{InOrder {MapTree fun {$ X} X*X end T}}

%============ Problem 2 ================
declare Subsets LAppend Prepend
fun {LAppend Xs Ys}
   case Xs
   of nil then Ys
   [] H|T then H|{LAppend T Ys}
   end
end

fun {Prepend X L}
   case L
   of nil then nil
   [] H|T then {LAppend [X|H] {Prepend X T}}
   end
end

fun {Subsets Xs}
   case Xs
   of nil then [nil]
   [] H|T then {LAppend {Prepend H {Subsets T}}
		{Subsets T}}
   end
end
{Browse {Subsets [1 2 3 4]}}

%============ Problem 3 (a) ============
declare LFilter
fun lazy {LFilter Predicate Xs}
   case Xs
   of nil then nil
   else
      if {Predicate Xs.1} then Xs.1|
	 {LFilter Predicate Xs.2}
      else {LFilter Predicate Xs.2} end
   end
end
X = {LFilter fun {$ X} X > 0 end [2 ~3 0 ~7 4 8]}
{Browse X.2.1}

% Problem 3 (b)
% NOTE: LFilter defined above is used here
declare Sieve Prime Nums
fun lazy {Nums N}
   N|{Nums N+1}
end

fun lazy {Sieve Xs}
   case Xs
   of nil then nil
   [] H|T then
      H|{Sieve
	 {LFilter fun {$ X} X mod H \= 0
		  end T}}
   end
end

fun lazy {Prime}
   {Sieve {Nums 2}}
end
{Browse {Prime}.2.2.1} % 5
