luatexperso = {}

-- --
-- -- ARITH SECTION -- --
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

luatexperso.arith = {}

function luatexperso.arith.pgcd ( a , b )
   if b > a then a,b = b,a end
   if b == 0 then return a end
   return luatexperso.arith.pgcd ( b, a % b )
end

function luatexperso.arith.algoEuclide ( a , b )
   if b > a then a,b = b,a end
   tex.print("$\\begin{array}{c@{=}c@{\\times}c@{+}c}")
   while b ~=0 do
     tex.print( a .. "&" .. math.floor(a/b) .. "&" .. b .. "&" .. a%b .."\\\\")
     a,b=b,a%b
   end
   tex.print("\\end{array}$")
end

function luatexperso.arith.premiersEntreEux ( a , b )
   local s =  "les nombres" .. a .. " et " .. b 
   if luatexperso.arith.pgcd(a,b) == 1 then
      s = s .. " sont premiers entre eux."
   else
      s = s .. " ne sont pas premiers entre eux."
   end
   tex.print( s )
end

function luatexperso.arith.ssSucc ( a , b )
   if b > a then a,b = b,a end
   tex.print("$\\begin{array}{c@{-}c@{=}c}")
   while b ~=0 do
      tex.print( a .. "&" .. b .. "&" .. a-b .."\\\\")
      a,b=b,a-b
      if b > a then a,b = b,a end
   end
   tex.print("\\end{array}$")
end

function luatexperso.arith.listeDiviseurs ( n )
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

-- --
-- -- ProgCal SECTION
-- --
-- --
-- -- exemple d'utilisation :
-- p = Pc:new({valeurs ={5}})
-- q = Pc:new({valeurs ={0.5}})
-- t = {"ajoute(8)", "soustrait(4)", "multiplie(2)", "ajoute('VI')", "carre()"}
-- Pc.applique("p",t)
-- Pc.applique("q",t)
-- p:sortieLaTeX()
-- tex.print("\\par")
-- q:sortieLaTeX()
-- --
-- --
luatexperso.Pc   = { valeurs = {0},
	 sortieLaTeX = function (self)
	    local s = "$\\nombre{" .. self.valeurs[1]
	    for i=2,#self.valeurs do
	       s = s .. "}\\longmapsto\\nombre{" .. self.valeurs[i]
	    end
	    tex.sprint( s .."}$" )
	 end,
	 ajoute = function (self,nb)
	    if nb == "VI" then
	       nb = self.valeurs[1]
	    end
	    table.insert(self.valeurs, self.valeurs[#self.valeurs] + nb)
	 end,
	 ajouteVI = function (self)
	    luatexperso.Pc.ajoute(self,self.valeurs[1])
	 end,
	 soustraitVI = function (self)
	    luatexperso.Pc.soustrait(self,self.valeurs[1])
	 end,
	 soustrait = function (self,nb)
	    if nb == "VI" then
	       nb = self.valeurs[1]
	    end
	    table.insert(self.valeurs, self.valeurs[#self.valeurs] -  nb)
	 end,
	 multiplie = function (self,nb)
	    if nb == "VI" then
	       nb = self.valeurs[1]
	    end
	    table.insert(self.valeurs, self.valeurs[#self.valeurs] *  nb)
	 end,
	 divise = function (self,nb)
	    if nb == "VI" then
	       nb = self.valeurs[1]
	    end
	    table.insert(self.valeurs, self.valeurs[#self.valeurs] /  nb)
	 end,
	 carre = function (self)
	    table.insert(self.valeurs, self.valeurs[#self.valeurs] ^ 2 )
	 end,
	 soustraitcarreVI = function (self)
	    local c = self.valeurs[1] * self.valeurs[1]
	    luatexperso.Pc.soustrait(self,c)
	 end,
	 racinecarree = function (self)
	    table.insert(self.valeurs, math.sqrt( self.valeurs[#self.valeurs] ) )
	 end,
	 oppose = function (self)
	    table.insert(self.valeurs, - self.valeurs[#self.valeurs] )
	 end,
	 inverse = function (self)
	    table.insert(self.valeurs, 1 / self.valeurs[#self.valeurs] )
	 end,
	 applique = function (self, nom, t)
	    for i, operation in ipairs(t) do
	       assert(loadstring(  nom .. ":" .. operation ))()
	    end
	 end,
	 new = function (self, o)
	    o = o or {}
	    setmetatable( o , self )
	    self.__index = self
	    return o
	 end
       }

luatexperso.Pc.applique = function (nom, t)
   for i, operation in ipairs(t) do
      assert(loadstring( nom .. ":" .. operation ))()
   end
end


-- --
-- --
-- -- exemple d'utilisation :
-- \luaexec{pyth.redac("B","D","C")}
-- \luaexec{pyth.calculHyp("DC",2.8,3.5)}
-- \luaexec{pyth.calculCote("DC",2.8,1.5)}
-- --
-- --

luatexperso.pyth = {}

function luatexperso.pyth.redac ( A, B, C )
   tex.sprint("Le triangle $" .. A .. B .. C .. "$ est rectangle en $" .. A .. "$\\\\")
   tex.sprint(" donc, d'après le théorème de Pythagore~: \\\\")
   tex.sprint(" $" .. B .. C .."^2=" .. A .. B .. "^2+" .. A .. C .. "^2$ \\\\")
end

function luatexperso.pyth.calculHyp ( hyp , a , b)
   tex.sprint( " $" .. hyp .. "^2=\\nombre{" .. a .. "}^2+\\nombre{" .. b .. "}^2$\\\\" )
   tex.sprint( " $" .. hyp .. "^2=\\nombre{" .. a*a .. "}+\\nombre{" .. b*b .. "}$\\\\")
   tex.sprint( " $" .. hyp .. "^2=\\nombre{" .. a*a+b*b .. "}$\\\\")
   tex.sprint( " $" .. hyp .. "=" .. "\\sqrt{\\nombre{" .. a*a+b*b .. "}}$\\\\")
end

function luatexperso.pyth.calculCote ( a , hyp , b)
   tex.sprint( " $\\nombre{" .. hyp .. "}^2=" .. a .. "^2+\\nombre{" .. b .. "}^2$\\\\" )
   tex.sprint( " $" .. a .. "^2=\\nombre{" .. hyp .. "}^2-\\nombre{" .. b .. "}^2$\\\\" )
   tex.sprint( " $" .. a .. "^2=\\nombre{" .. hyp*hyp .. "}-\\nombre{" .. b*b .. "}$\\\\")
   tex.sprint( " $" .. a .. "^2=\\nombre{" .. hyp*hyp-b*b .. "}$\\\\")
   tex.sprint( " $" .. a .. "=" .. "\\sqrt{\\nombre{" .. hyp*hyp-b*b .. "}}$\\\\")
end


return luatexperso
