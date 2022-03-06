declare
fun {GetPosIntern Y L Pos}
   case L of
      nil then Pos
   [] H|T then
      if H == Y
      then
	 Pos
      else
	 {GetPosIntern Y T Pos+1}
      end
   end
end

declare
fun {PositionSimple Y Xs}
   {GetPosIntern Y Xs 1}
end

{Browse {PositionSimple 3 [1 2 3 4 5]}}

declare
fun {GetPosInternZero Y L Pos}
   case L of
      nil then 0
   [] H|T then
      if H == Y
      then
	 Pos
      else
	 {GetPosInternZero Y T Pos+1}
      end
   end
end

declare
fun {PositionZero Y Xs}
   {GetPosInternZero Y Xs 1}
end

{Browse {PositionZero 10 [1 2 3 4 5]}}