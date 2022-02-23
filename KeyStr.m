classdef KeyStr < handle
properties

    histpos=1;
    histtmp;
    history

    strMode='str'
    set %valid or not specified by strMOde

    pos=1;
    str
    OUT
    bDiff

    count
    lastcount
    flag=0

    % -2 clear
    % -1 cancel
    % 0 nothing
    % 1 return
end
properties(Constant)
    modes={'str','numext','intpos','int','alpha','numreal'};
end
methods
    function obj=KeyStr(initialMode,initialStr,initialPos)
        obj.history=struct('str',cell(1,1), ...
                           'numext',cell(1,1), ...
                           'intpos',cell(1,1), ...
                           'int',cell(1,1), ...
                           'alpha',cell(1,1), ...
                           'numreal',cell(1,1));
        flds=fieldnames(obj.history);
        for i = 1:length(flds)
            fld=flds{i};
            obj.history.(fld)=cell(1,1);
            obj.history.(fld){1}=' ';
        end

        if ~exist('initialMode','var') || isempty(initialMode)
            initialMode=obj.strMode;
        end
        obj.change_mode(initialMode);

        if exist('initialStr','var') && ~isempty(initialStr) && ischar(initialStr)
            obj.str=initialStr;
        elseif exist('initialStr','var') && ~isempty(initialStr) && ~ischar(initialStr)
            error('invalid initialstr specified');
        end
        if ~isempty(obj.str) &&  exist('initialPose','var') && ~isempty(initialPos) && isint(initialPos)
            obj.pos=initialPos;
        elseif ~isempty(obj.str) &&  exist('initialPose','var') && ~isempty(initialPos) && ~isint(initialPos)
            error('Invalid initial position specified');
        elseif ~isempty(obj.str)
            obj.pos=length(obj.str);
        end

    end
    function [cmd,bSuccess,flag,bDiff]=read(obj,command)
        obj.flag=0;
        bSuccess=true;
        if length(command) > 1
            val=command(2:end);
        elseif ~isempty(obj.count) && ischar(obj.count)
            obj.return_count;
            val={obj.count};
        else
            val={};
        end
        if ismethod('KeyStr',command{1})
            lastStr=obj.str;
            lastPos=obj.pos;
            obj.(command{1})(val{:});
            obj.bDiff = ~strcmp(lastStr,obj.str) || ~isequal(lastPos,obj.pos);
            cmd=command{1};
        else
            bDiff=0;
            bSuccess=false;
            cmd={};
        end
        flag=obj.flag;
    end
    function change_mode(obj,strMode)
        switch strMode
            case 'str'
                obj.set=Str.AlphNum.A();
            case 'numext'
                obj.set=Str.Num.matSet();
            case 'intpos'
                obj.set=Numstr.intSet();
            case 'int'
                obj.set=Str.Num.negSet();
            case 'alpha'
                obj.set=Str.Alph.set();
            case 'numreal'
                obj.set=Str.Alph.realSet();
            otherwise
                error(['Invalid Mode: ' strMode ]);
        end
        obj.strMode=strMode; % ADD TO PARENT
    end
%% CAPS CHANGE
    function obj=up_case(obj,~)
        obj.str = Str.Alph.Upper(obj.str);
    end
    function obj=down_case(obj,~)
        obj.str = Str.Alph.Lower(obj.str);
    end
    function obj=change_pos(obj,newpos)
        if isnan(newpos)
            newpos=length(obj.str);
        end
        if newpos > length(obj.str)+1
            newpos=length(obj.str)+1;
        end
        if newpos < 1
            newpos=1;
        end
        obj.pos=newpos;
    end
%%
    function obj=change_char(obj,newChar)
        obj.str(obj.pos)=newChar;
    end
    function obj=insert_str(obj,newStr)
        if obj.pos==1
            s=[];
        else
            s=obj.str(1:obj.pos-1);
        end
        e=obj.str(obj.pos:end);
        obj.str=[s newStr e];
        obj.pos=obj.pos+length(newStr);
    end
    function obj=insert_char(obj,newChar)
        if obj.pos==1
            s=[];
        else
            s=obj.str(1:obj.pos-1);
        end
        e=obj.str(obj.pos:end);
        obj.str=[s newChar e];
        if ~isempty(newChar)
            obj.pos=obj.pos+1;
        end
    end
    function obj=insert_forward_char(obj,newChar)
        s=obj.str(1:obj.pos);
        if obj.pos==length(obj.str)
            e=[];
        else
            e=obj.str(obj.pos+1:end);
        end
        obj.str=[s newChar e];
    end
    function obj=append_char(obj,newChar)
        obj.str=[obj.str newChar];
    end
    function obj=backspace_char(obj,n)
        if ~exist('n','var') || isempty(n)
            n=1;
        end
        for i=1:n
            if isempty(obj.str) || obj.pos==1
                return
            elseif obj.pos == length(obj.str)+1
                obj.str=obj.str(1:end-1);
            else
                obj.str=[obj.str(1:obj.pos-2) obj.str(obj.pos:end)];
            end
            obj.change_pos(obj.pos-1);
        end
    end
    function obj=delete_char(obj,n)
        if ~exist('n','var') || isempty(n)
            n=1;
        end
        for i = 1:n
            if obj.pos==length(obj.str)+1
                return
            else
                e=obj.str(obj.pos+1:end);
            end
            if obj.pos==1
                s=[];
            else
                s=obj.str(1:obj.pos-1);
            end
            obj.str=[s e];
        end
    end
%% special keys
    function clear_str(obj)
        obj.str='';
        obj.pos=1;
        obj.flag=-2;
    end
    function cancel_str(obj)
        obj.str='';
        obj.pos=1;
        obj.flag=-1;
    end
    function out=return_str(obj)
        obj.OUT=obj.str;
        obj.append_history();
        obj.str=[];
        obj.pos=1;
        obj.histpos=obj.histpos+1;
        obj.flag=1;
        if nargout > 0
            out=obj.OUT;
        end
    end
    function append_history(obj)
        obj.history.(obj.strMode)=[obj.str; obj.history.(obj.strMode)];
    end
    function inc_pos_left(obj,n)
        if ~exist('n','var') || isempty(n)
            n=1;
        end
        for i = 1:n
            obj.change_pos(obj.pos-1);
        end
    end
    function obj=inc_pos_right(obj,n)
        if ~exist('n','var') || isempty(n)
            n=1;
        end
        for i = 1:n
            obj.change_pos(obj.pos+1);
        end
    end
    function obj=up_history(obj,n)
        if ~exist('n','var') || isempty(n)
            n=1;
        end
        for i = 1:n
            if obj.histpos==1 % AT TOP
                return
            % svae non-returned text
            elseif obj.histpos == length(obj.history.(obj.strMode))
                obj.histtmp=obj.str;
            end
            obj.histpos=obj.histpos-1;
            obj.str=obj.history.(obj.strMode){obj.histpos};
            obj.change_pos(obj.pos);
        end
    end
    function obj=down_history(obj,n)
        if ~exist('n','var') || isempty(n)
            n=1;
        end
        for i = 1:n
            if obj.histpos+1>length(obj.history.(obj.strMode))
                obj.histpos=length(obj.history.(obj.strMode));
                return
            % Rrestore non-returned text
            elseif obj.histpos==length(obj.history.(obj.strMode))-1
                obj.histpos=obj.histpos+1;
                obj.str=obj.histtmp;
            else
                obj.histpos=obj.histpos+1;
                obj.str=obj.history.(obj.strMode){obj.histpos};
            end
            obj.change_pos(obj.pos);
        end
    end
%%
    function obj=append_count(obj,count)
        if isnumeric(obj.count)
            obj.clear_count;
        end
        obj.count=[obj.count count];
    end
    function obj=clear_count(obj)
        obj.count=[];
    end
    function obj=return_count(obj)
        obj.lastcount=obj.count;
        obj.count=str2double(obj.count);
    end
    function obj=repeat_count(obj)
        obj.count=obj.lastcount;
    end
end
methods(Static,Hidden)
    function P=getP()
        P={...
            'initialStr' ,'','ischar';...
            'initialPos' ,1,'Num.isInt';...
            'initialStrMode' ,'str','ischar';...
            'initialMode','n','ischar';...
          };
    end
end
end
