classdef ExDef < handle
methods
    function obj=ExDef()
        chars=num2cell(Vec.col(Str.A));
        C=[chars ic cellfun(@(x) {'str','insert_char',x},chars,'UniformOutput',false)];

        c={...
                'back-word'        ,{'str','back-word'};
                'forward-word'     ,{'str','forward-word'};
                'kill-word-back'   ,{'str','kill-word-back'};
                'kill-line-forwad' ,{'str','kill-line-forward'};
                'paste'            ,{'str','paste'};
                'line-first'       ,{'str','change_pos',1};
                'line-end'         ,{'str','change_pos',nan};
                ...
                'i \n'             ,{'str','insert_char',newline};
                'i \t'             ,{'str','insert_char','    '};
                'i \s'             ,{'str','insert_char',' '};
                'i \B'             ,{'str','backspace_char',1};
                'i \d'             ,{'str','delete_char',1};
                'return'           ,{'str','return_str'};
                'd str'            ,{'str','cancel_str'};
                'left'             ,{'str','inc_pos_left'};
                'right'            ,{'str','inc_pos_right'};
                'up-history'       ,{'str','up_history'};
                'down-history'     ,{'str','down_history'};
                'up-history'       ,{'str','up_history'};
                'g prev'           ,{'go','prev'};
                'g down'           ,{'go','down'};
                'g up'             ,{'go','up'};
                'g next'           ,{'go','next'};
                ...
                'g first'          ,{'go','first'};
                'g last'           ,{'go','last'};
                'go'               ,{'go','go'};
          };
    end
end
end
