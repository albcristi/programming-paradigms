declare
fun {CreateTree Root Element}
   case Element =< Root of
      true then tree(root: Root left: Element right: nil)
   [] false then tree(root: Root left: nil right: Element)
   end
end

declare
fun {Insert BST Element}
   if BST == nil then tree(root: Element left: nil right: nil)
   elseif {Number.is BST} then {CreateTree BST Element}
   else case BST.root >= Element of
           true then tree(root: BST.root left: {Insert BST.left Element} right: BST.right)
        else tree(root: BST.root left: BST.left right: {Insert BST.right Element})
      end
   end
end

declare
fun {Smallest BST}
   if BST == nil then nil
   elseif {Number.is BST} then BST
   else case BST.left of nil then BST.root
        else {Smallest BST.left} end
   end
end

declare
fun {Biggest BST}
   if BST == nil then nill
   elseif {Number.is BST} then BST
   else case BST.right of nill then BST.root else {Biggest BST.right} end
   end
end

declare
fun {IsSorted BST}
   if BST == nil then false
   elseif {Number.is BST} then true
   else {And {And {Biggest BST.left} < BST.root
            {Smallest BST.right} >= BST.root}
         {And {IsSorted BST.left} {IsSorted BST.right}}}
   end
end

{Browse {IsSorted tree(root: 6
                       left: tree(root: 1 left: 0 right: 2)
		                 right: tree(root: 10 left: 9 right: 122))}}
