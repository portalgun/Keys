classdef KeyDef_str_read < handle & KeyDef
methods
    function obj=KeyDef_str_read(chars);
        if ~exist('chars','var') || isempty(chars)
            chars=Str.AlphNum.A;
        end
        
        obj@KeyDef();
        for i = 1:length(chars)
            obj.i(chars(i))={'str','insert_char',chars(i)};
        end
        chars=Str.Num.A;
        for i = 1:length(chars)
            obj.k(chars(i))={'str','insert_char',chars(i)};
        end
        '\nS',{'str','insert_char',newline};
        '\t' ,{'str','insert_char','    '};
        '\s' ,{'str','insert_char',' '};
        '\B' ,{'str','backspace_char',1};
        '\d' ,{'str','delete_char',1};

        '\n' ,{'str','return_str'};
        '\]' ,{'str','cancel_str'};
        '\U' ,{'str','up_history'};
        '\D' ,{'str','down_history'};
        '\L' ,{'str','inc_pos_left'};
        '\R' ,{'str','inc_pos_right'};

    end
end
end
