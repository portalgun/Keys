classdef KeyDef_basic < handle & KeyDef
methods(Static)
    function E=getEx();
        E=[E;  ...
           D_ex_str();...
           D_ex_go();...
        ];
    end
    function [D,Trdef]=get()

    end
end
end
