classdef key_def_vim < handle & key_def_emacs
%reamp any left right up down movement
%remap escape
methods
    function obj =key_def_vim()
        obj@key_def_emacs();

        obj.i('\]')={'run','mode','n'};

        obj.n('i')   ={'run','mode','i'};
        obj.n('\]')  ={'run','str','cancel_str'};
        obj.n('v')   ={'run','mode','v'};
        obj.n('g')   ={'run','mode','g'};
        obj.n(':')   ={'run','mode','c'}; % XXX fix, semicolon works
        obj.n('G')   ={'run','go','last'};

        obj.n('h')   ={'go','prev'};
        obj.n('j')   ={'go','down'};
        obj.n('k')   ={'go','up'};
        obj.n('l')   ={'go','next'};

        obj.n('1')   ={{'run','mode','k'}, {'set','str','insert_char','1'}};
        obj.n('2')   ={{'run','mode','k'}, {'set','str','insert_char','2'}};
        obj.n('3')   ={{'run','mode','k'}, {'set','str','insert_char','3'}};
        obj.n('4')   ={{'run','mode','k'}, {'set','str','insert_char','4'}};
        obj.n('5')   ={{'run','mode','k'}, {'set','str','insert_char','5'}};
        obj.n('6')   ={{'run','mode','k'}, {'set','str','insert_char','6'}};
        obj.n('7')   ={{'run','mode','k'}, {'set','str','insert_char','7'}};
        obj.n('8')   ={{'run','mode','k'}, {'set','str','insert_char','8'}};
        obj.n('9')   ={{'run','mode','k'}, {'set','str','insert_char','9'}};
        obj.n('0')   ={{'run','mode','k'}, {'set','str','insert_char','0'}};

        obj.k('G')   ={{'run','str','return_str'},{'run','mode','n'},{'go','go'}};
        %obj.k('\]')  ={{'run','str','cancel_str'},{'run','mode','n'}};
        obj.k('\]')  ={{'run','str','cancel_str'},{'run','mode','n'}};

        obj.c=obj.i;
        obj.c('\n')={{'set','str','return_str'},{'run',':'},{'run','mode','n'}};
        %obj.c('\n')={'set','str','return_str'};
        obj.c('\]')={{'set','str','cancel_str'},{'run','mode','n'}};

        obj.g('g')={{'run','mode','n'}, {'run','first'}};


        % a
        % p P
        % u C-r
        % w, e, b ;
        % g, z
        % y, c, s, d, r,
        % t f
        % / n p
        % x

    end
end
end
