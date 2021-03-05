classdef Key < handle %& trlInt
properties
    mode
    CAPTURE
    STR

    def
    defName

    key
    cmd
    package
    OUT

    PAR

    eParamCanChange
    eMessageGenerated


end
properties(Hidden=true)
    bPtb
    bStatus
    bMeta=0
    bPsycho=0
end
events
    newKeyset % trlInt
    newMode  % trlInt
    % WITH META
    ParamNeedChange
    ParamNeedRun
end
methods
    function obj=Key(PARorOpts)
        if ~exist('PARorOpts','var')
            PAR=[];
            Opts=[];
        elseif isa(PARorOpts,'psycho')
            PAR=PARorOpts;
            Opts=PAR.OPTS; % XXX
            obj.PAR=pointer(PAR);
            obj.bPsycho=1;
        else
            PAR=[];
            Opts=PARorOpts;
        end
        Opts=obj.parse_Opts(Opts);

        obj.CAPTURE= key_capture(Opts.keyDefRead, Opts.bUseKeyCaps, Opts.pauseLength);

        obj.STR=key_str(Opts.initialStrMode,Opts.initialStr,Opts.initialPos);

        obj.change_keyset(Opts.keyDefName);
        obj.change_mode(Opts.initialMode);
        obj.mode=Opts.initialMode;


        if ~isempty(PAR) && isprop(PAR,'META') && ~isa(PAR.META,'meta_param')
            obj.bMeta=1;
            obj.eParamCanChange=addlistener(PAR.META,'ParamCanChange',@(src,data) get_package(obj,src,data));
            obj.eMessageGenerated=addlistener(PAR.META,'MessageGenerated',@(src,data)    read_message(obj,src,data));

        end

    end
    function Opts=parse_Opts(obj,Opts)
        names={...
                  'keyDefName'  ,'basic'    ,'ischar_e';...
                  'bUseKeyCaps' ,1  ,'isnumeric';...
                  'pauseLength' ,0.2,'isnumeric';...
                  'initialStrMode' ,'str','ischar';...
                  'initialStr' ,'','ischar';...
                  'initialPos' ,1,'isint';...
                  'initialMode','n','ischar';...
                  'bPtb',1,'isbinary';...
              };
        Opts=parse([],Opts,names);
        Opts.keyDefRead='ptb';
        %if Opts.ptb
        %    Opts.keyDefRead='ptb';
        %else
        %    Opts.keyDefRead='basic';
        %end
    end
    function obj=update(obj,t,i)
        update@trlInt(obj,t,i);
        obj.change_keyset(obj.newName);
        obj.change_mode(obj.newName);
    end
    function obj=change_keyset(obj,newName)
        if ~isempty(newName) && (isempty(obj.def) || ~strcmp(obj.defName, newName))
            obj.def=key_def.get_def(newName);
            obj.defName=newName;
        end
    end
    function obj=change_mode(obj,newMode)
        if ~isempty(newMode) && ~strcmp(obj.def.mode,newMode)
            obj.def.update_mode(newMode);
            obj.mode=newMode;
        end
    end
    function obj=read(obj,varargin)
        obj.OUT=[];
        obj.key=[];
        obj.cmd=[];
        % varargin{1} = keyset
        % varargin{2} = mode
        if length(varargin) == 1
            obj.change_keyset(varargin{1});
        elseif length(varargin) == 2
            obj.change_keyset(varargin{1});
            obj.change_mode(varargin{2});
        end

        obj.CAPTURE.read(); %KeyPressed
        if ~isempty(obj.CAPTURE.OUT)
            obj.key=obj.CAPTURE.OUT;
            obj.cmd=obj.def.get(obj.key);
            % command target value
        else
            return
        end
        if isempty(obj.cmd)
            return
        end

        if iscell(obj.cmd{1})
            tmp=cell(length(obj.cmd),1);
            for i = 1:length(obj.cmd)
                obj.parse(obj.cmd{i});
                tmp{i}=obj.OUT;
            end
            ind=cellfun(@isempty,tmp);
            tmp(ind)=[];
            if numel(tmp)==1
                tmp=tmp{1};
            end
            obj.OUT=tmp;
        else
            obj.parse(obj.cmd);
        end
    end
    function obj=parse(obj,cmd)
        if strcmp(cmd{2},'str')
            obj.STR.read(cmd);
            obj.OUT={'set',cmd{2},obj.STR.str,obj.STR.pos,obj.STR.flag};
            % flag, -2 clear, -1=cancel, 1=return, 0 nothing
        elseif strcmp(cmd{2},'mode')
            obj.change_mode(cmd{3});
            obj.OUT=[];
        elseif ~isempty(cmd)
            obj.parse_other(cmd); % speaks with meta for set, psycho for run
        % STRINGS & MODES
        end
    end
    function obj=parse_other(obj,cmd)
        obj.bStatus=0;

        if strcmp(cmd{1},'run') || strcmp(cmd{1},'go')
            obj.bStatus=2;
            %obj.package=cmd(2:end);
            notify(obj,'ParamNeedRun'); % TO META -> ParamCanChange -> set_cmd
            %notify(obj,'ParamNeedRun',cmd); % TO META -> ParamCanChange -> set_cmd
            obj.OUT=cmd;
        elseif ismember(cmd{1},{'rotate','rotatedn','rotateup','toggle','inc','incup','incdn','set'})
            obj.bStatus=1;
            notify(obj,'ParamNeedChange'); % TO META -> ParamCanChange -> set_cmd
            obj.OUT=cmd;
            % atuo runs set cmd if successful
        end
    end
    function obj=get_package(obj,~,package)
        obj.package=package;
        obj.bStatus=1;
    end
    %function obj=read_message(obj,~,message)
    %    % codes
    %    %1 = locked
    %    %2 = unhandled command
    %    code=message{1};
    %    text=message{2};
    %    % TODO
    %end


end
end
