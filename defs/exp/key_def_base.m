classdef KeyDef_base < handle & KeyDef
methods
    function obj=KeyDef_base()
        obj@key_set();

        obj.n('?')   = 'help_menu'; %return
        obj.n('Q')   = 'quit_prompt'; %return
        obj.n('zC')  = 'pause'; %return
        obj.n(':')   = 'prompt';
        obj.n('\n')  = 'flag'
    end

end
end
