classdef key_capture < handle
% reads input
% TODO add cntrl commands
 properties
    keycode
    lastKey=-1

    chara 
    human
    bUseCaps

    pauseLength %length to wait after pressing valid key
    waitLength  %how long to wait for grabbing keys

    startTime
    repTime=.02  %base pause between keys
    holdTime=.5 %holding keys

    shiftCount=0
    ctlCount=0
    altCount=0

    %how sticky?
    shiftRepHold=0
    altRepHold=0
    ctlRepHold=0

    shiftflag
    ctlflag
    altflag=0;

    K
    scanList
    OUT

    time
end
properties(Hidden=true)
    exitflag
    lastTime=0
end
events
    %KeyPressed % FOR TIME
end
methods
    function obj=key_capture(keydefname,bUseCaps,pauseLength)
        if ~isvar('bUseCaps')
            bUseCaps=1;
        end
        if ~isvar('pauseLength')
            pauseLength=.2;
        end
        if ~isvar('type')
            type='';
        end
        obj.bUseCaps=bUseCaps;
        obj.pauseLength=pauseLength;
        switch keydefname
            case 'ptb'
                obj.K = ptbKeyDefs;
        end
        obj.key2scancodes();
    end

    function obj=key2scancodes(obj)
        nKeys = 256;
        obj.scanList = zeros(nKeys,1);

        keys = fieldnames(obj.K);
        for i=1:numel(keys)

            obj.scanList(obj.K.(keys{i}))=1; % note that there are two return keys...

        end

        obj.scanList = logical(obj.scanList);
    end
    function obj=scan2code(obj)
        [ ~, ~, KeyCode ] = KbCheck(-1,obj.K);
        obj.keycode=find(KeyCode);
    end

    function obj=get_key(obj)
        obj.exitflag=0;
        obj.scan2code();

        now=GetSecs;
        if isempty(obj.keycode)
            obj.keycode=-1;
        elseif ~isempty(obj.keycode) && isequal(obj.lastKey,-1)
            obj.startTime=now;
        elseif ~isempty(obj.keycode)
            hold=GetSecs-obj.startTime;
        end
        rep=now-obj.lastTime;

        obj.get_flags();

        %HOLDING DOWN REGULAR KEYS DOESN'T WORK INITIALLY
        bHold=~isequal(obj.lastKey,-1) && isequal(obj.lastKey,obj.keycode);
        if bHold && hold < obj.holdTime
            obj.exitflag=1;
        elseif  bHold && rep < obj.repTime
            obj.exitflag=1;
        else
            obj.lastTime=now;
        end
        %try
        %    disp(repTime)
        %    disp(hold)
        %end
        obj.lastKey=obj.keycode;

        %HANDLE HOLDING DOWN SHIFT
    end
    function obj=get_flags(obj)
        if ~isempty(obj.keycode)
            indCtl=ismember(obj.K.Lctl,obj.keycode) | ismember(obj.K.Rctl,obj.keycode);
            indAlt=ismember(obj.K.Lalt,obj.keycode) | ismember(obj.K.Ralt,obj.keycode);
            indSh =ismember(obj.K.shiftR,obj.keycode) | ismember(obj.K.shiftL,obj.keycode);
            vals=[obj.K.Lctl, obj.K.Lalt, obj.K.Rctl, obj.K.Ralt, obj.K.shiftR, obj.K.shiftL];
            obj.keycode(ismember(obj.keycode,vals))=[];
        else
            indSh=0;
            indAlt=0;
            indCtl=0;
        end
        % FLAGS
        if any(indSh) %|| obj.shiftCount <= obj.shiftRepHold
            obj.shiftCount=obj.shiftCount+1;
            obj.shiftflag=1;
        else
            obj.shiftCount=0;
            obj.shiftflag=0;
        end
        if any(indAlt) %|| obj.altCount <= obj.altRepHold
            obj.altCount=obj.altCount+1;
            obj.altflag=1;
        else
            obj.altCount=0;
            obj.altflag=0;
        end
        if any(indCtl) %|| obj.ctlCount <= obj.ctlRepHold
            obj.ctlCount=obj.ctlCount+1;
            obj.ctlflag=1;
        else
            obj.ctlCount=0;
            obj.ctlflag=0;
        end
    end


    function obj=read(obj)
        obj.chara=[];
        obj.OUT=[];
        obj.get_key();
        if obj.exitflag || isequal(obj.keycode,-1)
            obj.keycode=[];
            return
        end
            
        obj.literal_handler();
        obj.caps_handler();
        obj.alt_handler();
        obj.control_handler();
        obj.human_handler();
        obj.OUT=obj.chara;
        %if ~isempty(obj.chara)
        %    notify(obj,'KeyPressed',obj.OUT);
        %end
    end

    function obj=literal_handler(obj)
        obj.chara=[];
        for i =1:length(obj.keycode)
            chara=[];
            switch obj.keycode(i)
            case obj.K.colon
                chara= ';';
            case obj.K.escape
                chara= '\]';
            case obj.K.enter
                chara='\n';
            case obj.K.tab
                chara= '\t';
            case obj.K.Uarrow
                chara='\U';
            case obj.K.Darrow
                chara='\D';
            case obj.K.Larrow
                chara='\L';
            case obj.K.Rarrow
                chara='\R';
            case obj.K.backslash
                chara= '/';
            case obj.K.space
                chara= '\s';
            case obj.K.backspace
                chara= '\B';
            case obj.K.delete
                chara= '\d';
            case obj.K.period
                chara='.';
            case obj.K.comma
                chara= ',';
            case obj.K.a
                chara= 'a';
            case obj.K.b
                chara='b';
            case obj.K.c
                chara='c';
            case obj.K.d
                chara='d';
            case obj.K.e
                chara='e';
            case obj.K.f
                chara='f';
            case obj.K.g
                chara='g';
            case obj.K.h
                chara='h';
            case obj.K.i
                chara='i';
            case obj.K.j
                chara='j';
            case obj.K.k
                chara='k';
            case obj.K.l
                chara='l';
            case obj.K.m
                chara='m';
            case obj.K.n
                chara='n';
            case obj.K.o
                chara='o';
            case obj.K.p
                chara='p';
            case obj.K.q
                chara='q';
            case obj.K.r
                chara='r';
            case obj.K.s
                chara='s';
            case obj.K.t
                chara='t';
            case obj.K.u
                chara='u';
            case obj.K.v
                chara='v';
            case obj.K.w
                chara='w';
            case obj.K.x
                chara='x';
            case obj.K.y
                chara='y';
            case obj.K.z
                chara='z';
            case obj.K.one
                chara='1';
            case obj.K.two
                chara='2';
            case obj.K.three
                chara='3';
            case obj.K.four
                chara='4';
            case obj.K.five
                chara='5';
            case obj.K.six
                chara='6';
            case obj.K.seven
                chara='7';
            case obj.K.eight
                chara='8';
            case obj.K.nine
                chara='9';
            case obj.K.zero
                chara='0';
            case obj.K.minus
                chara='-';
            case obj.K.equal
                chara='=';
            end
            obj.chara=[obj.chara chara];
        end
        
    end

    function obj=caps_handler(obj)
        if isempty(obj.chara) || obj.shiftflag==0 || ~obj.bUseCaps
            return
        end
        switch obj.chara
            case 'a'
                obj.chara = 'A';
            case 'b'
                obj.chara = 'B';
            case 'c'
                obj.chara = 'C';
            case 'd'
                obj.chara = 'D';
            case 'e'
                obj.chara = 'E';
            case 'f'
                obj.chara = 'F';
            case 'g'
                obj.chara = 'G';
            case 'h'
                obj.chara = 'H';
            case 'i'
                obj.chara = 'I';
            case 'j'
                obj.chara = 'J';
            case 'k'
                obj.chara = 'K';
            case 'l'
                obj.chara = 'L';
            case 'm'
                obj.chara = 'M';
            case 'n'
                obj.chara = 'N';
            case 'o'
                obj.chara = 'O';
            case 'p'
                obj.chara = 'P';
            case 'r'
                obj.chara = 'R';
            case 's'
                obj.chara = 'S';
            case 't'
                obj.chara = 'T';
            case 'u'
                obj.chara = 'U';
            case 'v'
                obj.chara = 'V';
            case 'w'
                obj.chara = 'W';
            case 'x'
                obj.chara = 'X';
            case 'y'
                obj.chara = 'Y';
            case 'z'
                obj.chara = 'Z';
            case '1'
                obj.chara = '!';
            case '2'
                obj.chara = '@';
            case '3'
                obj.chara = '#';
            case '4'
                obj.chara = '$';
            case '5'
                obj.chara = '%';
            case '6'
                obj.chara = '^';
            case '7'
                obj.chara = '&';
            case '8'
                obj.chara = '*';
            case '9'
                obj.chara = '(';
            case '0'
                obj.chara = ')';
            case '-'
                obj.chara = '_';
            case '='
                obj.chara = '+';
            case '.'
                obj.chara = '>';
            case ','
                obj.chara = '<';
            case ';'
                obj.chara = ':';
            otherwise
                obj.chara = ['S-' obj.chara];
        end
    end
    function obj=control_handler(obj)
        if obj.ctlflag;
            obj.chara=['C-' obj.chara];
        end
    end
    function obj=alt_handler(obj)
        if obj.altflag;
            obj.chara=['A-' obj.chara];
        end
    end
    function obj=human_handler(obj);
        chara=obj.chara;
        if isempty(chara)
            return
        end
        Add=[];
        if contains(chara,'A-')
            chara=strrep(chara,'A-','');
            Add=['alt ' Add];
        end
        if contains(chara,'C-')
            chara=strrep(chara,'C-','');
            Add=['control ' Add];
        end
        if contains(chara,'S-')
            chara=strrep(chara,'S-','');
            Add=['shift ' Add];
        end

        switch chara
            case '\n'
                obj.human='return';
            case '\]'
                obj.human='escape';
            case '\B'
                obj.human='backspace';
            case '\d'
                obj.human='delete';
            case '\t'
                obj.human='tab';
            case '\s'
                obj.human='space';
            case '\R'
                obj.human='right arrow';
            case '\L'
                obj.human='left arrow';
            case '\U'
                obj.human='up arrow';
            case '\D'
                obj.human='down arrow';
            otherwise
                obj.human=obj.chara;
        end
        obj.human=[Add obj.human];
    end

end
end
