classdef KeyDef_adj < handle & KeyDef
methods
     function obj=KeyDef_adj();
          obj@key_set();

          obj.n('\U')  = 'up_map';
          obj.n('\D')  = 'down_map';
          obj.n('\US') = 'in_mod';
          obj.n('\DS') = 'out_mod';
          obj.n('\R')  = 'next';
          obj.n('\L')  = 'previous';
          obj.n('\RS') = 'next_mod';
          obj.n('\LS') = 'previous_mod';

          obj.e('\U')  = 'up_map';
          obj.e('\D')  = 'down_map';
          obj.e('\US') = 'in_mod';
          obj.e('\DS') = 'out_mod';
     end
end
end
