declare
fun {AbsVal X Zero}
   if X >= Zero
   then
      X
   else
      ~X
   end
end

declare
fun {Abs X}
   if {Int.is X}
   then
      {AbsVal X 0}
   else
      {AbsVal X 0.0}
   end
end

{Browse {Abs 22}}
{Browse {Abs ~23}}
{Browse {Abs 2.2}}
{Browse {Abs ~2.34}}

% ex 2
declare
fun {Pow N M}
   if M == 0
   then
      1
   else
      N * {Pow N M-1}
   end
end

{Browse {Pow 2 0}}
{Browse {Pow 2 3}}

% ex 3
declare
fun {Pow N M}
   if M == 0
   then
      1
   else
      N * {Pow N M-1}
   end
end

{Browse {Pow 2 0}}
{Browse {Pow 2 3}}
    