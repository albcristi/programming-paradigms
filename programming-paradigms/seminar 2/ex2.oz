declare
fun {ReverseInternal L Accum}
   case L of
      nil then Accum
   [] H|T then {ReverseInternal T H|Accum}
   end
end

declare
fun {ReverseFun L}
   {ReverseInternal L nil}
end

{Browse {ReverseFun [1 2 3 4]}}
{Browse {ReverseFun ['a' 'b' 'c' 'd' 'e']}}