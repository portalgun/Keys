classdef key_defs_x < handle & key_def
methods
    function obj=key_defs_x();
        obj@key_set();

        obj.n('\R')  = 'choose_right';
        obj.n('\L')  = 'choose_left';
        obj.n('\U')  = 'next';
        obj.n('\D')  = 'previous';

        obj.e('\R')  = 'choose_right';
        obj.e('\L')  = 'choose_left';
    end
end
end
