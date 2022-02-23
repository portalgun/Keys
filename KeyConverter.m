classdef KeyConverter < handle
properties
    keyCodes
    literal

    LiteralCoder=LiteralMap
    CapsCoder=CapsMap
    KeyCoder

    modList
    modFlags
end
properties(Hidden)
    IndFlds
end
methods

    function obj=KeyConverter(modList,keyCoderName,bPTB)
        if nargin < 1
            obj.modList=KeyConverter.getDefaultModList();
        else
            obj.modList=modList;
        end
        obj.KeyCoder=eval([keyCoderName ';']);
    end
    function [exitflag,outLiteral,outKeyCodes]=read(obj,scanInd)
        exitflag=1;
        outKeyCodes=[];
        outLiteral=[];

        obj.keyCodes=obj.KeyCoder.fromScan(scanInd);
        if isequal(obj.keyCodes,-1)
            obj.keycode=[];
            return
        end

        % MODIFIER KEYS
        obj.literal=obj.LiteralCoder.fromKeyCode(obj.keyCodes);
        if obj.getFlags('shift');
            obj.literal=obj.CapsMap(obj.literal);
            obj.rm_literal('\S');
        end
        app={};
        if obj.getFlags('ctl')
            obj.rm_literal('\C');
            app{end+1}='\C';
        end
        if obj.getFlags('alt')
            obj.rm_literal('\A');
            app{end+1}='\A';
        end
        if obj.getFlags('gui')
            obj.rm_literal('\M');
            app{end+1}='\M';
        end

        outKeyCodes=obj.keyCodes;
        outLiteral=obj.literal;

        exitflag=0;
    end
    function scan=keyCodeToScanCode(obj,keyCode);
        scan=obj.KeyCoder.toScan(keyCode);
    end
end
methods(Access=private)
    function rm_literal(obj,name)
        obj.literal(ismember(obj.literal,name))=[];
    end
    function add_literal(obj,name)
        obj.literal=[name; obj.literal]
    end
    function out=getFlags(obj,name)
        %if isempty(obj.modList)
        %    obj.modFlags=any(ismember(obj.modList,obj.KeyCodes),2);
        %end

        if isempty(obj.modList) || ~ismember(name,obj.modList(:,1))
            out=false;
            return
        end
        out=obj.modFlags(ismember(obj.modList(:,1),name));
    end
end
methods(Static,Hidden)
    function E=getDefaultModList()
        E={ ...
            'shift', 'shiftL','shiftR';
            'ctl','ctlL','ctlR';
            'alt','altL','altR';
            'gui','guiL','guiR';
        };
    end
end
end
