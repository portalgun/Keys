classdef key_defs_2AFC_DSP_rsp < key_def
methods
     function obj=key_defs_2AFC_DSP_rsp();
          obj@key_def();

          obj.n('\U')  = {'run','rsp',1};
          obj.n('\D')  = {'run','rsp',0};
          obj.n('\]')  = {'run','exp','exit'};
     end
end
end
