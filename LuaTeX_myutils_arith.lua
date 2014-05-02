-- --
-- --
-- -- exemple d'utilisation :
-- \newcommand{\algoEuclide}[2]{\luaexec{arith.algoEuclide(#1,#2)}}
-- \newcommand{\algoSSS}[2]{\luaexec{arith.ssSucc(#1,#2)}}
-- \newcommand{\pgcd}[2]{\luaexec{tex.print(arith.pgcd(#1,#2))}}
-- \newcommand{\premiersEntreEux}[2]{\luaexec{arith.premiersEntreEux(#1,#2)}}
-- \newcommand{\listeDiviseurs}[1]{\luaexec{arith.listeDiviseurs(#1)}}
-- %%
-- \begin{document}
-- L'algorithme d'Euclide appliqué à 124 et 72~:\par\algoEuclide{124}{72}
-- Ainsi le PGCD de 124 et 72 est le dernier reste non nul~: \pgcd{124}{72}. Donc \premiersEntreEux{124}{72}
-- \par
-- \algoSSS{124}{72}
-- \par
-- \listeDiviseurs{72}
-- --
-- --

arith = {}

function arith.pgcd ( a , b )
   if b > a then a,b = b,a end
   if b == 0 then return a end
   return arith.pgcd ( b, a % b )
end

function arith.algoEuclide ( a , b )
   if b > a then a,b = b,a end
   tex.print("$\\begin{array}{c@{=}c@{\\times}c@{+}c}")
   while b ~=0 do
     tex.print( a .. "&" .. math.floor(a/b) .. "&" .. b .. "&" .. a%b .."\\\\")
     a,b=b,a%b
   end
   tex.print("\\end{array}$")
end

function arith.premiersEntreEux ( a , b )
   local s =  "les nombres" .. a .. " et " .. b 
   if arith.pgcd(a,b) == 1 then
      return s .. " sont premiers entre eux."
   else
      return s .. " ne sont pas premiers entre eux."
   end
end

function arith.ssSucc ( a , b )
   if b > a then a,b = b,a end
   tex.print("$\\begin{array}{c@{-}c@{=}c}")
   while b ~=0 do
      tex.print( a .. "&" .. b .. "&" .. a-b .."\\\\")
      a,b=b,a-b
      if b > a then a,b = b,a end
   end
   tex.print("\\end{array}$")
end

function arith.listeDiviseurs ( n )
   local liste  = {1}
   local listee = {n}
   for i=2,math.floor(math.sqrt(n)) do
      if n%i == 0 then
	 table.insert(liste,i)
	 table.insert(listee,1,n/i)
      end
   end
   local s = "Diviseurs de " .. n .. " : "
   for i=1,#liste do
      s = s .. liste[i] .. ", " 
   end
   for i=1,#listee-2 do
      s = s .. listee[i] .. ", " 
   end
   s = s .. listee[#listee-1] .. " et " .. n
   tex.print(s)
end

return arith
