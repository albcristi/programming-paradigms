%function that computes max(n,m) based on the following relations:
% max(n,m) = n , if m=0
% max(n,m) = m , if n=0
% max(n,m) = 1+max(n-1,m-1)
% m,n are natural numbers
declare
fun {Max N M}
   if N == 0
   then
      M
   else
      if M == 0
      then
	 N
      else
	 1+{Max N-1 M-1}
      end
   end
end

{Browse {Max 0 23}}
{Browse {Max 34 0}}
{Browse {Max 32 12}}
{Browse {Max 23 32}}