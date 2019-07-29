{Browse 12}
{Show 'Hello World'}

%Scoping of variables
local I F C in
   I = 5
   F = 5.5
   C = &t
   {Browse [I F C]}
end

% Immutable names (NewName)
local X Y B in
   X = foo
   {NewName Y}
   B = true
   {Browse [X Y B]}
end

% Records and tuples
declare T I Y LT RT W in
T = tree(key:I value:Y left:LT right:RT)
I = apple
Y = 43
LT = nil
RT = 39
W = tree(I Y LT RT)
{Browse [T W]}

% Accessing individual elements
{Browse T.key}
{Browse W.3}

% Arity of the records
local X in {Arity T X} {Browse X} end
local X in {Arity W X} {Browse X} end


