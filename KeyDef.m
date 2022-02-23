classdef KeyDef < handle
% set/run target value/params
properties
    name
    ex
    exrev
    O=struct %other
    Onames=cell(0,1)
    names=struct(); % names of ex commands map container

    bStdMode=1
    mode
    defMode
    OUT
    transients
end
methods
    function obj=KeyDef()
    end
    function obj=init(obj,E,D,modes,T)
        if nargin >= 5
            obj.transients=T;
        end
        obj.ex=containers.Map(E(:,1), E(:,2));
        for i = 1:length(modes)
            d=D(contains(D(:,2),modes{i}),:);
            if isempty(d)
                continue
            end
            try
                obj.(modes{i})=containers.Map(d(:,3),cellfun(@(x) obj.ex(x), d(:,1),'UniformOutput',false));
            catch ME
                k=keys(obj.ex);
                d(~ismember(d(:,1),k),:)
                rethrow(ME);
            end
            obj.names.(modes{i})=containers.Map(d(:,3),d(:,1));
        end
    end
    function obj=new_mode(obj,mod)
        if ismember(mod,obj.stdModes)
            error(['Cannot use mode ' mod ': uses existing std mode name']);
        elseif ismember(mod,obj.Onames)
            error(['Cannot use mode ' mod ': mode already exists']);
        else
            obj.Onames{end+1,1}=mod;
            obj.O.(mod)=containers.Map;
            obj.O.([mod '_rev'])=containers.Map;
        end

    end
    function obj=update_mode(obj,mod)
        if ismember(mod,obj.stdModes);
            obj.bStdMode=1;
            obj.mode=mod;
        elseif ismember(mod,obj.Onames)
            obj.bStdMode=0;
            obj.mode=mod;
        else
            error(['Undefined mode ' mod ]);
        end
    end
    function [CMD,NAME,msg,bTrans]=read(obj,key,moude)
        bTrans=false;
        msg='';
        if nargin > 2 && ~isempty(moude)
            obj.update_mode(muode);
        end
        moude=obj.mode;
        bTrans= ismember(moude,obj.transients);
        try
            if strcmp(moude,'A')
                CMD={'key','any'};
            elseif obj.bStdMode
                CMD=obj.(moude)(key);
            else
                CMD=obj.O.(moude)(key);
            end
        catch ME
            CMD=[];
            NAME=[];
            if strcmp(ME.identifier,'MATLAB:Containers:Map:NoKey')
                msg=['Not a valid key ''' key ''' for mode ' moude ];;
                return
            else
                rethrow(ME);
            end
        end
        if nargout > 1
        %try
            if strcmp(moude,'A')
                NAME='any';
            elseif obj.bStdMode
                NAME=obj.names.(moude)(key);
            else
                NAME=obj.O.names.(moude)(key);
            end
        %catch ME
        %    moude
        %    key
        %    rethrow(ME)
            %NAME=[];
        %end
        end
    end
    function [keys,vals]=get_def_strings(obj)
        if obj.bStdMode
            keys=obj.(obj.mode).keys;
            vals=obj.(obj.mode).values;
        else
            keys=obj.O.(obj.mode).keys;
            vals=obj.O.(obj.mode).values;
        end
        ind=cellfun(@isempty,vals);
        vals(ind)=[];
        keys(ind)=[];
        reps={ ...
                '\B','Backspace' ...
               ;'\D','Delete' ...
               ;'\tS','Shift-Tab' ...
               ;'\t','Tab' ...
               ;'\]','Escape' ...
               ;'\n','Return' ...
        };
        for i = 1:length(keys)
        for j = 1:size(reps,1)
            keys{i}=strrep(keys{i},reps{j,1},reps{j,2});
        end
        end
        for i = 1:length(vals)
            cmds=vals{i};
            if iscell(cmds) && iscell(cmds{1});
                cmds=KeyDef.parse_cmds(cmds);
            elseif iscell(cmds)
                cmds=KeyDef.parse_parts(cmds);
            end
            vals{i}=cmds;
        end

        ind=contains(vals,'insert_char');
        ind=ind | contains(vals,'cancel_str');
        keys(ind)=[];
        vals(ind)=[];
        keys=transpose(keys);
        vals=transpose(vals);
        % NOTE
        %keys=strjoin(keys,newline);
        %vals=strjoin(vals,newline);
    end
end
methods(Static, Access=private)
    function lines=parse_cmds(cmds)
        for i = 1:length(cmds)
            cmd=cmds{i};
            cmds{i}=KeyDef.parse_parts(cmd);
        end
        lines=strjoin(cmds,' & ');
    end
    function line=parse_parts(cmd)
        cmd(ismember(cmd,{'run','set'}))=[];
        for i = length(cmd):-1:1
            if Num.is(cmd{i})
                cmd{i}=num2str(cmd{i});
            end
        end
        line=strjoin(cmd,' ');
    end
end
methods(Static=true)
    function obj=get_def(name)
        if ~startsWith(name,'KeyDef')
            name=['KeyDef_' name];
        end
        if Obj.isSub(name,'KeyDef')
            obj=eval([name ';']);
        else
            error(['Invalid KeyDef ' name '.']);
        end
    end
    function New=change(obj,newName,moude)
        if (~isempty(obj) && (strcmp(obj.name,newName) || isempty(newName)))
            New=obj;
        else
            New=KeyDef.get_def(newName);
        end
        if nargin <= 3 && ~isempty(moude) && ~strcmp(New.mode,moude)
            New.update_mode(moude);
        end
    end
end
end
