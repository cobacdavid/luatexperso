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
Pc   = { valeurs = {0},
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
	    ProgCal.ajoute(self,self.valeurs[1])
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

Pc.applique = function (nom, t)
   for i, operation in ipairs(t) do
      assert(loadstring(  nom .. ":" .. operation ))()
   end
end
