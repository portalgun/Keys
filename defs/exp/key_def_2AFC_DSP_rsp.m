classdef KeyDef_2AFC_DSP_rsp < KeyDef
methods
     function obj=KeyDefs_2AFC_DSP_rsp();
          obj@KeyDef();

          obj.n('\U')  = {'Rsp','respond',2};
          obj.n('\D')  = {'Rsp','respond',1};
          obj.n('\]')  = {'run','exp','exit'};
     end
end
end
