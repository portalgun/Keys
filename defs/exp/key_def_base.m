classdef key_def_base < handle & key_def
methods
    function obj=key_def_base()
        obj@key_set();

        obj.n('?')   = 'help_menu'; %return
        obj.n('Q')   = 'quit_prompt'; %return
        obj.n('zC')  = 'pause'; %return
        obj.n(':')   = 'prompt';
        obj.n('\n')  = 'flag'
    end

end
end
