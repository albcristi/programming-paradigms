
declare
fun lazy {Sieve L}
   case L
   of nil then nil
   [] H|T then H|{Sieve {Filter T H}}
   end
end

declare
fun lazy {Filter L H}
   case L
   of nil then nil
   [] A|As then
      if A mod H == 0
      then
	 {Filter As H}
      else
	 A|{Filter As H}
      end
   end
end

declare
fun lazy {Gen N}
   N|{Gen N+1}
end

declare
fun lazy {Prime}
   {Sieve {Gen 2}}
end

declare
fun {GetAfterInternal N L}
   case L
   of H|T
   then
      if H > N
      then
	 H
      else
	 {GetAfterInternal N T}
      end
   end
end

declare
fun {GetAfter N}
   {GetAfterInternal N {Prime}}
end