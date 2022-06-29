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
            ...
            'alt','\A';
            'altL','\AL';
            'altR','\AR';
            'shift','\S';
            'shiftL','\SL';
            'shiftR','\SR';
            'ctl','\C';
            'ctlL','\CL';
            'ctlR','\CR';
            'gui','\M';
            'guiL','\ML';
            'guiR','\MR' ...
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
