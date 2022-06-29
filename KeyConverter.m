classdef KeyConverter < handle
% SCAN TO KEY
% KEY TO LITERAL (CAPS AND MODIFIERS)
properties
    keyCodes
    literal

    LiteralCoder=LiteralMap
    CapsCoder=CapsMap
    KeyCoder
    bCaps

    modList
end
properties(Hidden)
    IndFlds
end
methods

    function obj=KeyConverter(modList,keyCoderName,bPTB,bCaps)
        if nargin < 4
            bCaps=true;
        end
        obj.bCaps=bCaps;

        if nargin < 1 || isempty(modList)
            obj.modList=obj.getDefaultModList();
            if ~obj.bCaps
                obj.modList=[obj.getShiftModList; obj.modList];
            end
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
        obj.modify();
        outKeyCodes=obj.keyCodes;
        outLiteral=obj.literal;
        exitflag=0;
    end
    function modify(obj)
        % MODIFIER KEYS
        obj.literal=obj.LiteralCoder.fromKeyCode(obj.keyCodes);
        if obj.bCaps
            obj.capsConvert();
        end
        for i = 1:size(obj.modList,1)
            obj.modConvert(i);
        end
    end
    function scan=keyCodeToScanCode(obj,keyCode);
        scan=obj.KeyCoder.toScan(keyCode);
    end
end
methods(Hidden,Static)
    function K=test()
        obj=KeyConverter([],'PtbMap',true);
        ScanInd=[39 48 106 93]; %a ; /CR /AR
        obj.read(ScanInd);
        obj.keyCodes
        obj.literal
    end
end
methods(Access=private)
    function rm_literal(obj,name)
        obj.literal(ismember(obj.literal,name))=[];
    end
    function add_literal(obj,name)
        obj.literal=[name; obj.literal]
    end
    function out=capsConvert(obj)
        flags=obj.getShiftModList();
        out=obj.flag_fun(flags);
        if out
            obj.literal=obj.CapsCoder.fromKeyCode(obj.literal);
        end
    end
    function out=modConvert(obj,ind)
        flags=obj.modList(ind,2:end);
        out=obj.flag_fun(flags);
        if out
            ind=~ismember(obj.literal,obj.modList);
            obj.literal(ind)=strcat(flags{1},'-',obj.literal(ind));
        end
    end
    function out=flag_fun(obj,flags)
        ind=ismember(obj.literal,flags);
        out=any(ind);
        if out
            obj.literal(ind)=[];
        end
    end
end
methods(Static,Hidden)
    function E=getShiftModList()
        E={'shift','\S', '\SL','\SR'};
    end
    function E=getDefaultModList()
        E={ ...
            'ctl','\C','\CL','\CR';
            'alt','\A','\AL','\AR';
            'gui','\M','\ML','\MR';
        };
    end
end
end
