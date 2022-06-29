classdef Key < handle %& trlInt
properties
    bPTB

    key
    literal
    keyTime
    lastKeyTime
    cmd
    name
    status

    ScanGrabber
    KeyConverter
    KeyStr
    KEYSTR=struct
    aKeyStr
    KeyDef

    lastMode=cell(0,1);
    lastDef
    bKeyChange=false
    bListen=true
end
properties(Hidden=true)
    scanBinds
    scanInds
end
methods
    function obj=Key(varargin)
        Opts=obj.parse(varargin{:});
        obj.KeyConverter=KeyConverter(Opts.modList,Opts.KeyCoderName,obj.bPTB);
        if isempty(Opts.repWhiteListInd)
            Opts.repWhiteListInd=obj.getDefaultRepWhiteListInd(Opts.nKeys);
        end
        obj.KeyDef=KeyDef.change([],Opts.keyDefName,Opts.initialMode);
        obj.KeyStr=KeyStr(Opts.initialStrMode,Opts.initialStr,Opts.initialPos);
        obj.KEYSTR.(Opts.initialKeyStr)=obj.KeyStr;
        obj.aKeyStr=Opts.initialKeyStr;
        obj.ScanGrabber= ScanGrabber('nKeys',Opts.nKeys,...
                                     'holdCrit',Opts.holdCrit, ...
                                     'repCrit',Opts.repCrit, ...
                                     'blackListInd',Opts.blackListInd, ...
                                     'repWhiteListInd',Opts.repWhiteListInd ...
                                    );
    end
    function append_keyStr(obj,name,KS,bChange)
        if nargin < 4 || isempty(bChange)
            bChange=false;
        end
        obj.KEYSTR.(name)=KS;
        if bChange
            obj.changeKeyStr(name);
        end
    end
    function append_newKeyStr(obj,name,initMode,initStr,initPos)
        if nargin < 3 || isempty(initMode)
            initMode='str';
        end
        if nargin < 4
            initStr=[];
        end
        if nargin < 5 || isempty(initPos)
            initPos=1;
        end
        obj.KEYSTR.(name)=KeyStr(initMode,initStr,initPos);
    end
    function changeKeyStr(obj,name)
        if isa(name,'KeyStr')
            obj.KEYSTR.ANON=name;
            obj.KeyStr=name;
            obj.aKeyStr='ANON';
        else
            if ~isfield(obj.KEYSTR,name)
                error('KeyStr does not exist')
            end
            obj.KeyStr=obj.KEYSTR.(name);
            obj.aKeyStr=name;
        end
    end
    function Opts=parse(obj,varargin)
        if numel(varargin) == 1 && (isstruct(varargin{1}) || isa(varargin{1},'dict'))
            Opts=varargin{1};
            Opts=Args.parse(struct(), Key.getP, Opts);
        else
            Opts=Args.parse(struct(), Key.getP, varargin{:});
        end
        if isempty(which('KbName'))
            Opts.KeyCoderName='BasicMap';
            obj.bPTB=false;
        else
            Opts.KeyCoderName='PtbMap';
            obj.bPTB=true;
        end
    end
%%
    function read_meta(obj,cmd)
        obj.status='k';
        switch cmd{1}
        case 'last_mode'
            obj.change_def([],obj.KeyDef.defMode);
        case 'mode'
            obj.change_def([],cmd{2});
            obj.bKeyChange=true;
        case 'def'
            obj.change_def(cmd{2});
            obj.bKeyChange=true;
        case 'any'
            obj.any();
        case 'on'  % ptb
            obj.bListen=true;
        case 'off' % no ptb, except to turn on
            obj.bListen=off;
        case 'toggle'
            if obj.bListen
                obj.bListen=false;
            else
                obj.bListen=true;
            end
        otherwise
            obj.status='';
        end
    end
    function any(obj)
        % LEAVE EMPTY
    end
    function exitflag=read(obj)
        obj.bKeyChange=false;
        if obj.bPTB
            [exitflag,scanBinds,keyTime]=obj.ScanGrabber.read(); %KeyPressed
            if exitflag
                return
            end
            % APPEND UNTIL NEXT READ
            obj.keyTime(end+1,1)=keyTime;
            obj.scanBinds=[obj.scanBinds; scanBinds];
        else
            exitflag=false;
            waitforbuttonpress;
            obj.scanInds = double(get(gcf,'CurrentCharacter'));
        end
    end
    function [key,literal,exitflag,msg]=convertInd(obj,scanInds)
        n=size(scanInds,2);
        exitflag=false(n,1);
        literal=cell(n,1);
        key=cell(n,1);
        msg={};
        [exitflag,literal,key]=obj.KeyConverter.read(scanInds);
    end
    function [literal,exitflag,msg]=convertBind(obj,scanBinds)
        m=size(scanBinds,1);
        exitflag=false(m,1);
        literal=cell(m,1);
        key=cell(m,1);
        for j = 1:m
            scanInds=find(scanBinds(j,:));
            [key{j},literal{j},exitflag(j),msg{j}]=obj.convertInd(scanInds);
        end
        msg=vertcat(msg{:});
        if all(exitflag)
            obj.literal={};
            obj.key={};
            return
        end
        obj.literal=literal;
        obj.key=key;

    end
    function reset(obj)
        obj.lastKeyTime=obj.keyTime;
        obj.keyTime=[];
        obj.scanInds=[];
        obj.scanBinds=[];
        obj.key=[];
        obj.cmd=[];
        obj.status=[];
    end
    function [exitflag,CMD,NAME,LITERAL,STATUS,msg]=convert(obj,varargin)
        if nargin >= 2
            obj.change_def(varargin{:});
        end

        scanInds=obj.scanInds;
        scanBinds=obj.scanBinds;
        obj.reset();
        CMD=[]; STATUS=[]; NAME=[]; LITERAL=[];

        if ~isempty(scanBinds)
            obj.convertBind(scanBinds);
        elseif ~isempty(scanInds)
            [obj.key,obj.literal,exitflag,msg]=obj.convertInd(scanInds);
            obj.key={obj.key};
            obj.literal={obj.literal};
            if exitflag
                return
            end
        end
        % LAYER 1, multiple scans
        % LAYER 2, simultaneous presses
        [estatus,status,cmd,name,msg,bTrans]= cellfun(@(x) obj.convert_fun(x), obj.literal,'UniformOutput',false);
        obj.literal=vertcat(obj.literal{:});
        msg=vertcat(msg{:});
        estatus=[estatus{:}];
        rmind=estatus ~= 0;
        status(rmind)=[];
        cmd(rmind)=[];
        name(rmind)=[];


        if isempty(cmd) || all(cellfun(@isempty,cmd))
            exitflag=true;
            return
        end
        if bTrans{end}
            obj.change_def([],obj.KeyDef.defMode);
        end
        obj.status=status;
        obj.cmd=cmd;
        obj.name=name;

        exitflag=false;
        CMD=obj.cmd;
        NAME=obj.name;
        STATUS=obj.status;
        LITERAL=obj.literal;
    end
    function [estatus,status,cmd,name,msg,bTrans]=convert_fun(obj,literal)
        estatus=0;
        status=[];
        [cmd,name,msg,bTrans]=cellfun(@(x) obj.KeyDef.read(x),literal,'UniformOutput',false);

        if all(cellfun(@isempty,cmd))
            bTrans=[bTrans{:}];
            cmd=[cmd{:}];
            name=[name{:}];
            estatus=1;
            return
        end
        if ~iscell(cmd{1})
            [cmd,status]=obj.parse_cmd(cmd);
            bTrans=[bTrans{:}];
            if iscell(cmd)
                cmd=[cmd{:}];
            end
            name=[name{:}];
            estatus=2;
            return
        end

        % EXPAND MULTIPLE COMMANDS FOR SINGLE ARG
        CMD={};
        for i = 1:length(cmd)
            if isempty(cmd{i})
                continue
            elseif all(iscell(cmd{i})) && all(cellfun(@iscell,cmd{i}))
                CMD=[CMD; Vec.col(cmd{i})];
            else
                CMD{end+1}=cmd{i};
            end
        end
        cmd=CMD;
        [cmd,status]=cellfun(@obj.parse_cmd, cmd,'UniformOutput',false);

        rmind=cellfun(@(x,y) isempty(x) && isempty(y),cmd, status);
        cmd(rmind)=[];
        status(rmind)=[];
        name(rmind)=[];

        bTrans=[bTrans{:}];
        cmd=vertcat(cmd{:});
        name=[name{:}];
        status=vertcat(status{:});

    end
    function [str,pos,mode,flag, bDiff]=getString(obj,name)
        if nargin < 2 || isempty(name)
            name=obj.aKeyStr;
        end
        KS=obj.KEYSTR.(name);
        str=KS.str;
        pos=KS.pos;
        mode=KS.strMode;
        flag=KS.flag;
        bDiff=KS.bDiff;
        obj.KEYSTR.(name).bDiff=false;
    end
    function OUT=returnString(obj,name)
        if nargin < 2 || isempty(name)
            name=obj.aKeyStr;
        end
        OUT=obj.KEYSTR.(name).return_str();
    end
    function moude=getMode(obj)
        mode=obj.KeyDef.mode;
    end
    function histr=getHistory(obj)
        histr=obj.KeyStr.history;
    end
end
methods(Access=?PsyShell)
    function toggle_def(obj,newName)
        if strcmp(newName,obj.lastDef)
            obj.change_def(obj.lastDef,[]);
        else
            obj.change_def(newName,[]);
        end
    end
    function moude=change_to_lastMode(obj)
        if isempty(obj.lastMode)
            moude='';
            return
        end
        if iscell(obj.lastMode)
            moude=obj.lastMode{end,1};
            obj.lastMode(end)=[];
        else
            moude=obj.lastMode;
            obj.lastMode={};
        end
        while ~isempty(obj.lastMode) && strcmp(obj.KeyDef.mode,obj.lastMode{end})
            moude=obj.lastMode{end,1};
            obj.lastMode(end)=[];
        end
        obj.KeyDef=KeyDef.change(obj.KeyDef, [], moude);
    end
    function change_def(obj,newName,newMode)
        bSuccess=true;
        if strcmp(obj.KeyDef.mode,newMode)
            bSuccess=false;
        elseif strcmp(obj.KeyDef.mode,obj.KeyDef.defMode)
            obj.lastMode=cell(0,1);
        elseif ~ismember(obj.KeyDef.mode,obj.KeyDef.transients)
            obj.lastMode{end+1,1}=obj.KeyDef.mode;
        end
        if ~strcmp(newName,obj.KeyDef.name)
            obj.lastDef=obj.KeyDef.name;
            bSuccess=true;
        end
        if bSuccess
            obj.KeyDef=KeyDef.change(obj.KeyDef, newName, newMode);
        end
    end
end
methods(Access=private)
    function [OUT,status]=parse_cmd(obj,cmd)
        if iscell(cmd{1})
            [OUT,status]=cellfun(@obj.parse_cmd,cmd,'UniformOutput',false);
            %OUT=[OUT{:}];
            return
        end
        % flag, -2 clear, -1=cancel, 1=return, 0 nothing
        cmd=[cmd repmat({''},1,4-length(cmd))];
        OUT=cmd;
        if obj.bListen==0
            if ~(strcmp(cmd{1},'key') && ismember(cmd{2},{'on','toggle'}))
                OUT=[];
                status='0';
                return
            end
        end
        switch cmd{1}
            case 'str'
                [~,bSuccess]=obj.KeyStr.read(cmd(2:end));
                if bSuccess
                    status='s';
                else
                    status='';
                end
            case 'key'
                obj.read_meta(cmd(2:end));
                status='k';
            case 'go'
                status='g';
            case 'ex'
                status='e';
            otherwise
                status='o';
        end
        if isempty(status)
            OUT=[];
        end
    end
    function bind=getDefaultRepWhiteListInd(obj,nKeys)
        bind=false(nKeys,1);
        if ~obj.bPTB
            return
        end
        list={...
                    'shiftL';
                    'shiftR';;
                    'ctlL';
                    'ctlR';
                    'altL';
                    'altR';
                    'guiL';
                    'guiR';
        };
        inds=obj.KeyConverter.keyCodeToScanCode(list);
        bind(inds)=true;
    end
end
methods(Static,Hidden)
    function P=getP()
        PScn=ScanGrabber.getP();
        PStr=KeyStr.getP();
        P={ ...
            'keyDefName'  ,'basic','ischar_e';... % KEY DEF
            'initialMode','','ischar';...            % KEY DEF
            'initialKeyStr','SHELL','ischar_e'; ...
            'bConvert',true,'isBinary';...
            'modList',[],'iscell_e';...
        };
        P=[PStr; PScn; P];
    end
end
end
