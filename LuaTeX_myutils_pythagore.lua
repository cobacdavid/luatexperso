-- --
-- --
-- -- exemple d'utilisation :
-- \luaexec{pyth.redac("B","D","C")}
-- \luaexec{pyth.calculHyp("DC",2.8,3.5)}
-- \luaexec{pyth.calculCote("DC",2.8,1.5)}
-- --
-- --

pyth = {}

function pyth.redac ( A, B, C )
   tex.sprint("Le triangle $" .. A .. B .. C .. "$ est rectangle en $" .. A .. "$\\\\")
   tex.sprint(" donc, d'après le théorème de Pythagore~: \\\\")
   tex.sprint(" $" .. B .. C .."^2=" .. A .. B .. "^2+" .. A .. C .. "^2$ \\\\")
end

function pyth.calculHyp ( hyp , a , b)
   tex.sprint( " $" .. hyp .. "^2=\\nombre{" .. a .. "}^2+\\nombre{" .. b .. "}^2$\\\\" )
   tex.sprint( " $" .. hyp .. "^2=\\nombre{" .. a*a .. "}+\\nombre{" .. b*b .. "}$\\\\")
   tex.sprint( " $" .. hyp .. "^2=\\nombre{" .. a*a+b*b .. "}$\\\\")
   tex.sprint( " $" .. hyp .. "=" .. "\\sqrt{\\nombre{" .. a*a+b*b .. "}}$\\\\")
end

function pyth.calculCote ( a , hyp , b)
   tex.sprint( " $\\nombre{" .. hyp .. "}^2=" .. a .. "^2+\\nombre{" .. b .. "}^2$\\\\" )
   tex.sprint( " $" .. a .. "^2=\\nombre{" .. hyp .. "}^2-\\nombre{" .. b .. "}^2$\\\\" )
   tex.sprint( " $" .. a .. "^2=\\nombre{" .. hyp*hyp .. "}-\\nombre{" .. b*b .. "}$\\\\")
   tex.sprint( " $" .. a .. "^2=\\nombre{" .. hyp*hyp-b*b .. "}$\\\\")
   tex.sprint( " $" .. a .. "=" .. "\\sqrt{\\nombre{" .. hyp*hyp-b*b .. "}}$\\\\")
end

return pyth
