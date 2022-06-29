
classdef KeyStr < handle
properties

    histpos=1;
    histtmp;
    history

    strMode='str'
    set %valid or not specified by strMOde

    width=inf % width of text box
    pos=1;
    str
    strBoxed  % str as viewed in box
    posBox=1;
    lastBoxPos
    boxShift=0
    OUT
    bDiff
    preTxt
    postTxt

    count
    lastcount
    flag=0

    initialStr
    % -2 clear
    % -1 cancel
    % 0 nothing
    % 1 return
    keystrmethods
end
properties(Constant)
    modes={'str','numext','intpos','int','alpha','numreal'};
end
methods
    function obj=KeyStr(initialMode,initialStr,initialPos,width,preTxt,postTxt)
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
            obj.initialStr=initialStr;
        elseif exist('initialStr','var') && ~isempty(initialStr) && ~ischar(initialStr)
            error('invalid initialstr specified');
        end
        if ~isempty(obj.str) &&  exist('initialPos','var') && ~isempty(initialPos) && Num.isInt(initialPos)
            ;
        elseif ~isempty(obj.str) &&  exist('initialPose','var') && ~isempty(initialPos) && ~Num.isInt(initialPos)
            error('Invalid initial position specified');
        elseif ~isempty(obj.str)
            initialPos=length(obj.str);
        end
        if nargin < 4 || isempty(width)
            width=inf;
        end
        obj.width=width;
        obj.change_pos(initialPos,true);
        if nargin < 5 || isempty(preTxt)
            preTxt='';
        end
        obj.preTxt=preTxt;
        if nargin < 6 || isempty(postTxt)
            postTxt='';
        end
        obj.postTxt=postTxt;
        %obj.posBox=obj.pos;
        %if obj.posBox > obj.width+1
        %    obj.posBox=obj.width+1;
        %end
        obj.strBoxed;


        obj.keystrmethods=methods(obj);
    end
    function [cmd,bSuccess,flag,bDiff]=read(obj,command)
        command(cellfun(@isempty,command))=[];
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
        if ismember_cell(command{1},obj.keystrmethods)
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
    function str=change_pos(obj,newpos,bInit)
        if nargin < 3 || isempty(bInit)
            bInit=false;
        end
        if isnan(newpos)
            newpos=length(obj.str);
        end
        if newpos > length(obj.str)+1
            newpos=length(obj.str)+1;
        end
        if newpos < 1
            newpos=1;
        end
        d=newpos-obj.pos;
        obj.pos=newpos;

        if ((d==0 && ~bInit) || isinf(obj.width))
            if isinf(obj.width)
                obj.posBox=obj.pos;
                obj.boxShift=0;
                obj.lastBoxPos=obj.pos;
            end
            if nargout > 0
                str=obj.strBoxed;
            end
            return
        end

        obj.lastBoxPos=obj.posBox;
        obj.posBox=d+obj.posBox;
        if obj.posBox > obj.width+1
            obj.posBox=obj.width+1;
        elseif obj.posBox < 1
            obj.posBox=1;
        end
        db=obj.posBox-obj.lastBoxPos;
        obj.boxShift=obj.boxShift+d-db;
        if obj.boxShift < 0
            obj.boxShift=0;
        end
        if nargout > 0
            str=obj.strBoxed;
        end
    end
    function out=get.strBoxed(obj)
        c=' ';
        if isinf(obj.width)
            out=obj.str;
            return
        elseif isempty(obj.str)
            out=repmat(c,1,obj.width);
            return
        end
        s=obj.boxShift+1;
        d=length(obj.str)-obj.width;
        if d < 0
            %try
                out=obj.str(s:end);
            %catch ME
                %disp('-----')
                %obj.lastBoxPos
                %obj.posBox
                %obj.boxShift
                %length(obj.str)
                %s
                %rethrow(ME)
            %end
        else
            e=s+obj.width-1;
            if e > length(obj.str)
                e=length(obj.str);
            end
            out=obj.str(s:e);
        end
        d=length(out) - obj.width;
        if d < 0
            out=[out repmat(c,1,abs(d))];
        end
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
            obj.inc_pos_right(1);
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
    function append_char(obj,newChar)
        obj.str=[obj.str char(newChar)];
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
    function [out,pos]=get_str(obj,bBox,bCurs)
        if nargin < 2 || isempty(bBox)
            bBox=false;
        end
        if nargin < 3 || isempty(bCurs)
            bCurs=false;
        end
        if ~bBox
            out=obj.str;
            pos=obj.pos;
        else
            out=obj.strBoxed;
            pos=obj.posBox;
        end
        if bCurs
            if isempty(out)
                out='|';
            elseif pos==1
                out=['|' out];
            elseif pos==length(out)+1
                out=[out '|'];
            else
                out=[out(1:pos-1) '|' out(pos:end)];
            end
        end
        out=[obj.preTxt out obj.postTxt];
    end
    function [out,outBox,outCursBox]=return_str(obj)
        out=obj.get_str();
        obj.OUT=out;
        if nargout >= 2
            outBox=obj.get_str(true,false);
        end
        if nargout >=3
            outCursBox=obj.get_str(true,true);
        end
        obj.append_history();
        obj.str=[];
        obj.strBoxed=[];
        obj.pos=1;
        obj.posBox=1;
        obj.boxShift=0;

        obj.histpos=obj.histpos+1;
        obj.flag=1;
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
    function reset_str(obj,str,width)
        obj.initialStr=str;
        obj.str=str;
        if nargin < 3 || isempty(width)
            obj.width=inf;
        else
            obj.width=width;
        end

        pos=obj.pos;
        if pos > length(str)
            pos=length(str);
        end
        obj.boxShift=0;
        obj.posBox=1;
        obj.pos=1;
        obj.change_pos(pos);
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
          };
    end
    function out=test()
        out='';

        obj=KeyStr('str','1234567890ABCEDFGHIJKL',1,5,'preTxt: ',' postTxt');
        strreal=obj.get_str();
        str=obj.get_str(true,true);
        fprintf('\n\n');
        fprintf(str);
        nBS=length(str)+1;
        while true
            waitforbuttonpress;
            KEY = double(get(gcf,'CurrentCharacter'));
            num=num2str(KEY);
            if isempty(KEY)
                continue
            end
            for i=1:length(KEY)
                key=KEY(i);
                switch key
                    case 8  % BS
                        obj.backspace_char();
                    case 13 % \n
                        out=obj.return_str;
                    case 27 % esc
                        if isempty(strreal)
                            return
                        else
                            obj.cancel_str;
                        end
                    case 28 %left
                        obj.inc_pos_left();
                    case 29 %right
                        obj.inc_pos_right();
                    case 30 %up
                        obj.up_history();
                    case 31 %down
                        obj.down_history();
                    case 127 %Del
                        obj.delete_char();
                    otherwise
                        if key >= 32 && key < 127
                            obj.insert_char(key);
                        end
                end
            end
            strreal=obj.get_str();
            str=obj.get_str(true,true);
            fprintf([repmat(8,1,nBS) num newline str]);
            nBS=length(str)+length(num)+1;
        end

    end
end
end
