classdef LiteralMap < handle
properties
    map
    modList
end
methods
    function obj=LiteralMap()
        d={ ...
            'escape', '\]';
            'enter', '\n';
            'tab', '\t';
            'Uarrow', '\U';
            'Darrow', '\D';
            'Larrow', '\L';
            'Rarrow', '\R';
            'space', '\s';
            'backspace', '\B';
            'delete', '\d';
            'altL','\A';
            'altR','\A';
            'shiftL','\S';
            'shiftR','\S';
            'ctlL','\C';
            'ctlR','\C';
            'guiL','\M';
            'guiR','\M' ...
          };
        obj.map=containers.Map(d(:,1),d(:,2));
    end
    function literal=fromKeyCode(obj,keycode)
        if ~iscell(keycode)
            literal=obj.map(keycode);
            return
        end
        ind=ismember(keycode,keys(obj.map));
        literal=cell(size(keycode));
        if any(ind)
            literal(ind)=cellfun(@(x) obj.map(x),keycode(ind),'UniformOutput',false);
        end
        literal(~ind)=keycode(~ind);
    end
end
methods(Access=private)
    function [out]=literalFun(obj,x)
        out=obj.map(x);
    end

end
end
