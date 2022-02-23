classdef KeyDef_z < handle & KeyDef
methods
    function obj=KeyDefs_z();
        obj@key_set();
        obj.n('\U')  = 'choose_greater'
        obj.n('\D')  = 'choose_closer'
        obj.n('\R')  = 'next';
        obj.n('\L')  = 'previous';

        obj.e('\U')    = 'choose_less';
        obj.e('\D')    = 'choose_closer';
    end
end
end
