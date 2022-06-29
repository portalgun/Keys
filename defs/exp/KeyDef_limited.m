classdef KeyDef_limited < handle & KeyDef
properties(Constant)
    DEFMODE='l'
end
methods(Static)
    function E=getEx();
        E=[D_ex_str();...
           D_ex_go(); ...
           D_ex_lmited() ...
        ];
    end
    function [D,T,def]=get()
    end
end
end

