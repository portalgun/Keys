classdef KeyDef_basic < handle & KeyDef
properties
    i=containers.Map
    c=containers.Map
end
properties(Constant)
    stdModes={'i','c'};
end
methods(Static)
    function E=getEx();
        char=num2cell(Str.A);
        f={'str','insert_char'};
        E=[cellfun(@(x) {['i ' x], [f x]},char,'UniformOutput',false)];
        E=vertcat(E{:});

        e={...

                'i \n'             ,{'str','insert_char',newline};
                'i \t'             ,{'str','insert_char','    '};
                'i \s'             ,{'str','insert_char',' '};
                'i \B'             ,{'str','backspace_char',1};
                'i \d'             ,{'str','delete_char',1};
                'return'           ,{'str','return_str'};
                'left'             ,{'str','inc_pos_left'};
                'right'            ,{'str','inc_pos_right'};
                'up-history'       ,{'str','up_history'};
                'down-history'     ,{'str','down_history'};
                'up-history'       ,{'str','up_history'};
                ...
                'back-word'        ,{'str','back-word'};
                'forward-word'     ,{'str','forward-word'};
                'kill-word-back'   ,{'str','kill-word-back'};
                'kill-line-forwad' ,{'str','kill-line-forward'};
                'paste'            ,{'str','paste'};
                'line-first'       ,{'str','change_pos',1};
                'line-end'         ,{'str','change_pos',nan};
                'g prev'           ,{'go','prev'};
                'g down'           ,{'go','down'};
                'g up'             ,{'go','up'};
                'g next'           ,{'go','next'};
                ...
                'd str'            ,{'str','cancel_str'};
                'g first'          ,{'go','first'};
                'g last'           ,{'go','last'};
                'go'               ,{'go','goto'};
                'ex_return'        ,{'cmd','ex_return'};
        };
        E=[E;e];
    end
    function [D,T]=get()
        char=num2cell(Str.A);
        D=[cellfun(@(x) {['i ' x], 'ic', x },char,'UniformOutput',false)];
        D=vertcat(D{:});
        d={ ...
            'i \n'            ,'ic' ,'\nS';
            'i \t'            ,'ic' ,'\t' ;
            'i \s'            ,'ic' ,'\s' ;
            'i \B'            ,'ic' ,'\B' ;
            'i \d'            ,'ic' ,'\d' ;
            'return'          ,'i'  ,'\n';
            'ex_return'       ,'c' ,'\n' ;
            'd str'           ,'ic' ,'\]';
            'up-history'      ,'ic' ,'\U';
            'down-history'    ,'ic' ,'\D' ;
            'g next'          ,'ic,' ,'\R' ;
            'g prev'          ,'ic' ,'\L' ;
            ...
            'g prev'          ,'ic'  ,'C-b' ;
            'g next'          ,'ic,' ,'C-f' ;
            'paste'           ,'ic' ,'C-y';
            'back-word'       ,'ic' ,'A-b';
            'forward-word'    ,'ic' ,'A-f';
            'kill-word-back'  ,'ic' ,'C-w';
            'kill-line-forwad','ic' ,'C-k';
            'line-first'      ,'ic' ,'C-a';
            'line-end'        ,'ic' ,'C-e';
            'up-history'      ,'ic' ,'C-p';
            'down-history'    ,'ic' ,'C-n';
        };
        D=[D;d];
        T='';

    end
end
end
