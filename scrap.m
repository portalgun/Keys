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
            case obj.K.slash
                chara='/';
            case obj.K.backslash
                chara= '\';
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
            case '/'
                obj.chara = '?';
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
            case '\t'
                obj.chara = '\tS';
            case '\s'
                obj.chara = '\sS';
            otherwise
                obj.chara = ['S-' obj.chara];
        end
    end
