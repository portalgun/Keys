classdef KeyDef < handle
% TODO NUM esc

% set/run target value/params
properties
    name
    modes

    defMode
    mode

    ex
    cmds
    ex2cmd

    keys=struct()
    key2cmd=struct()
    key2ex=struct()


    OUT
    transients % one command then back to last non-transient
    bAny=false
    bNum

end
properties(Constant)
    NUMS=num2cell(Str.Num.intA);
end
methods
    function obj=KeyDef()
        if strcmp(class(obj),'KeyDef')
            return
        end
        obj.init();
    end
    function obj=init(obj)
        obj.name=obj.getName;

        [E,D,obj.transients]=obj.get_defs();
        obj.mode=obj.DEFMODE;
        obj.defMode=obj.DEFMODE;

        obj.modes=unique(D(:,2));

        % EX
        obj.ex=E(:,1);
        obj.cmds=E(:,2);
        for i=1:length(obj.cmds)
            if iscell(obj.cmds{i}{1})
                for j= 1:length(obj.cmds{i})
                    obj.cmds{i}{j}=[obj.cmds{i}{j} repmat({''},1,4-length(obj.cmds{i}{j}))];
                end
            else
                obj.cmds{i}=[obj.cmds{i} repmat({''},1,4-length(obj.cmds{i}))];
            end
        end
        obj.ex2cmd=containers.Map(obj.ex, obj.cmds);

        % KEYS
        n=length(obj.modes);
        k=cell(n,2);
        kc=cell(n,2);
        ke=cell(n,2);
        obj.bNum=false(n,1);
        for i = 1:n
            d=D(contains(D(:,2),obj.modes{i}),:);
            if isempty(d)
                continue
            end

            k{i,1}=obj.modes{i};
            k{i,2}=d(:,3);


            e=d(:,1);
            kc{i,1}=obj.modes{i};
            try
                t=cellfun(@(x) obj.ex2cmd(x), e,'UniformOutput',false);
                %kc{i,2}=containers.Map(d(:,3),t);
                kc{i,2}=dict(1,d(:,3),t);
            catch ME
                e(~ismember(e,keys(obj.ex2cmd)))
                rethrow(ME);
            end

            ke{i,1}=obj.modes{i};
            ke{i,2}=dict(1,d(:,3),e);

            obj.bNum(i)=~any(ismember(d(:,3),Str.Num.intA));
        end
        obj.key2cmd=dict(1,kc(:,1),kc(:,2));
        obj.keys=dict(1,k(:,1),k(:,2));
        obj.key2ex=dict(1,ke(:,1),ke(:,2));

        %obj.key2cmd.(obj.modes{i})=
        %obj.keys.(obj.modes{i})=k;
        %obj.key2ex.(obj.modes{i})=
        if ~ismember('A',obj.modes)
            obj.bAny=true;
            obj.modes{end+1}='A';
            obj.bNum(end+1)=false;
        end
    end
    function [E,K,T]=get_defs(obj)
        n=length(obj.EXDEPS);
        E=cell(n,1);
        for i = 1:length(obj.EXDEPS)
            name=obj.EXDEPS{i};
            exStr=['D_ex_' name];
            if isempty(which(exStr))
                error(['Undefined ex files definition: ' exStr]);
            end
            try
                E{i}=eval([exStr ';']);
            catch ME
                disp(exStr)
                rethrow(ME);
            end
        end
        E=vertcat(E{:});

        n=length(obj.KEYDEPS);
        K=cell(n,1);
        T=cell(n,1);
        for i = 1:n
            name=obj.KEYDEPS{i};
            keyStr=['D_key_' name];
            if isempty(which(exStr))
                error(['Undefined key files definition: ' keyStr]);
            end
            try
                [K{i},T{i}]=eval([keyStr ';']);
            catch ME
                disp(keyStr)
                rethrow(ME);
            end
        end
        K=vertcat(K{:});
        T=vertcat(T{:});
    end
    function [CMD,NAME,msg,bTrans]=read(obj,key,moude)
        if nargin < 3 || isempty(moude)
            moude=obj.mode;
        end
        if ~ismember(moude,obj.modes)
            error(['Unhanlded mode: ' moude]);
        end
        if ~(strcmp(moude,'A') && obj.bAny) && ~ismember(key,obj.keys{moude})
            msg=['Unhanlded key ''' key ''' for mode ' moude];
            CMD='';
            NAME='';
            bTrans=0;
            return
            %error(msg)
        end
        if nargin > 2 && ~isempty(moude)
            obj.update_mode(muode);
        end

        ind=ismember(obj.modes,moude);
        bNum=obj.bNum(ind) && ismember(key,obj.NUMS);
        msg='';
        bTrans=ismember(moude,obj.transients);
        if strcmp(moude,'A') && obj.bAny
            CMD={'key','any'};
        elseif bNum
            CMD={'key','num', key};
        else
            CMD=obj.key2cmd{moude}{key};
        end
        if nargout > 1
            if strcmp(moude,'A') && obj.bAny
                NAME='any';
            elseif bNum
                NAME='num';
            else
                NAME=obj.key2ex{moude}{key};
            end
        end
    end
    function obj=update_mode(obj,moude)
        if ~ismember(moude,obj.modes)
            error(['Undefined mode ' moude ]);
        end
        obj.mode=moude;
    end
    function obj=new_mode(obj,moude,keys,ex)
        % XXX not used
        % keys = d3
        % ex   = d1
        if ~ismember(moude,obj.modes)
            error(['Cannot use mode ' moude ': mode already exists']);
        end
        obj.modes{end+1,1}=moude;
        obj.key2cmd{moude}=containers.Map(keys,cellfun(@(x) obj.ex2cmd(x), obj.ex,'UniformOutput',false));
        obj.key2ex{moude}=containers.Map(keys,ex);

    end
%% STRINGS
    function name=getName(obj)
        name=strrep(class(obj),'KeyDef_','');
    end
    function out=get_modes_key_table(obj,modeExclude)
        if nargin < 2
            modeExclude=[];
        end
        [keys,vals,mods]=get_key_strings(obj,modeExclude);
        n=cellfun(@numel,keys);
        mods=repelem(mods,n,1);
        keys=vertcat(keys{:});
        vals=vertcat(vals{:});
        T=[mods,keys,vals];
        K={'mode','key','command'};
        T=Table(T,K);
        out=T.string;
    end
    function out=get_mode_key_table(obj)
        [keys,vals]=obj.get_mode_key_strings(obj.mode);
        T=[keys,vals];
        K={'key','command'};
        T=Table(T,K);
        out=T.string;
    end
    function [keys,vals,modes]=get_key_strings(obj,modeExclude)
        if nargin < 2 || isempty(modeExclude)
            modeExclude={''};
        end
        keys=cell(length(obj.modes),1);
        vals=cell(length(obj.modes),1);
        modes=obj.modes;
        for i = 1:length(obj.modes)
            if (strcmp(obj.modes{i},'A') && obj.bAny) || strcmp(obj.modes{i},modeExclude)
                continue
            end
            [keys{i,1},vals{i,1}]=obj.get_mode_key_strings(obj.modes{i});
        end
    end
    function [keys,vals]=get_mode_key_strings(obj,moude)
        if nargin < 2
            moude=obj.mode;
        end
        if ~ismember(moude,obj.modes)
            error(['Unhandled mode: ' moude ]);
        end
        keys=obj.key2cmd{moude}.keys;
        vals=obj.key2cmd.(moude).values;
        ind=cellfun(@isempty,vals);
        vals(ind)=[];
        keys(ind)=[];
        reps={ ...
                '\B','Backspace' ...
               ;'\d','Delete' ...
               ;'\tS','Shift-Tab' ...
               ;'\t','Tab' ...
               ;'\]','Escape' ...
               ;'\n','Return' ...
               ;'\U','Up'
               ;'\D','Down'
               ;'\L','Left'
               ;'\R','Right'
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
        for i = length(cmd):-1:1
            if Num.is(cmd{i})
                cmd{i}=num2str(cmd{i});
            end
        end
        cmd(ismember(cmd,{'run','set'}))=[];
        line=strjoin(cmd,' ');
    end
end
methods(Static=true)
    function E=getEx()
        E={};
    end
    function [D,T]=get()
        D={};
        T={};
    end
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
