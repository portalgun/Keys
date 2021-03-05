classdef key_def < handle
% set/run target value/params
properties
    n
    e
    i
    g
    k
    v
    c
    
    mode
    OUT
end
methods
    function obj=key_def()
        obj.mode='n';
        obj.n=containers.Map;
        obj.e=containers.Map;
        obj.i=containers.Map;
        obj.g=containers.Map;
        obj.k=containers.Map;
        obj.v=containers.Map;
        obj.c=containers.Map;
    end
    function obj=update_mode(obj,mode)
        if ismember(mode, {'n','e','i','g','k','v','c'});
            obj.mode=mode;
        else
            error(['Undefined mode ' mode ]);
        end
    end
    function CMD=get(obj,key,mode)
        if exist('mode','var') && ~isempty(mode)
            obj.update_mode(mode);
        end
        try
            CMD=obj.(obj.mode)(key);
        catch
            CMD=[];
        end
    end
end
methods(Static=true)
    function obj=get_def(name)
        if ~startsWith(name,'key_def')
            name=['key_def_' name]; 
        end
        if issubclass(name,'key_def')
            obj=eval([name ';']);
        else
            error(['Invalid key_def ' name '.']);
        end
    end
end
end
