% PART A
declare
fun {Compute Lower Bigger Accum}
   if Lower == Bigger
   then
      Bigger * Accum
   else
      {Compute Lower Bigger-1 Accum*Bigger}
   end
end


declare
fun {CombA N K}
   if K == 0
   then
      1
   else
      {Compute N-K+1 N 1} div {Compute 1 K 1}
   end
end

{Browse {CombA 10 3}}
{Browse {CombA 10 0}}
{Browse {CombA 10 10}}
{Browse {CombA 10 1}}
{Browse {CombA 0 10}}
{Browse {CombA 0 0}}
{Browse {CombA 10 5}}

% PART B

declare
fun {CombInternal N K Accum}
   if K == 1.0
   then
      Accum*N
   else
      {CombInternal N K-1.0 Accum * (N-K+1.0)/K}
   end
end

declare
fun {CombB N K}
   if K == 0
   then
      1
   else
     {FloatToInt {CombInternal {IntToFloat N} {IntToFloat K} 1.0}}
   end
end

{Browse {CombB 10 3}}
{Browse {CombB 10 0}}
{Browse {CombB 10 10}}
{Browse {CombB 10 1}}
{Browse {CombB 0 10}}
{Browse {CombB 0 0}}
{Browse {CombB 10 5}}