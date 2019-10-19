% Homework 3 :: CS350A 2019-20 I
% Author: Aniket Pandey (160113)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Declarative Concurrent Model %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%=========== Problem 1.3 ===========

declare WaitBoth WaitBothAux Thread
fun {WaitBothAux X Y}
   proc {$} {Wait X} {Wait Y} end
end
proc {WaitBoth X Y}
   {{WaitBothAux X Y}}
end
proc {Thread P1 P2}
   local X Y in
      thread X = {P1} end
      thread Y = {P2} end
      {WaitBoth X Y}
   end
end
declare A B
thread {Delay 3000} A=3 end
thread {Delay 6000} B=6 end
thread {WaitBoth A B} {Browse worked} end

%=========== Problem 1.4 ===========

declare MergeThunk
fun {MergeThunk X Y}
   case X
   of nil then fun {$} Y end
   else
      case Y
      of nil then fun {$} X end
      [] H|T then
	 if H > X.1
	 then fun {$}
		 X.1|{{MergeThunk X.2 Y}}
	      end
	 else fun {$}
		 H|{{MergeThunk X T}}
	      end
	 end
      end
   end
end
declare X = {MergeThunk [1 3 7] [2 4 6]}
{Browse {X}}    % Thunked Sorting

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Message Passing Model %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%=========== Problem 2.1 ===========

declare X Y
thread {Delay {Int.'mod' {OS.rand} 10}} X = apple end
thread {Delay {Int.'mod' {OS.rand} 10}} Y = mango end
thread
   {Delay {Int.'mod' {OS.rand} 10}}
   if {IsDet X} then {Browse banana}
   else {Browse X} end
end
thread
   {Delay {Int.'mod' {OS.rand} 10}}
   if {IsDet Y} then {Browse tomato}
   else {Browse Y} end
end

%=========== Problem 2.2 ===========

