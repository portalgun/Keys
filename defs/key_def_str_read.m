classdef key_def_str_read < handle & key_def
methods
    function obj=key_def_str_read();
        obj@key_def()
        chars=strV;
        for i = 1:length(chars)
            obj.i(chars(i))={'set','str','insert_char',chars(i)};
        end
        chars=numV;
        for i = 1:length(chars)
            obj.k(chars(i))={'set','str','insert_char',chars(i)};
        end
        obj.i('\nS')={'set','str','insert_char',newline};
        obj.i('\t')={'set','str','insert_char','    '};
        obj.i('\s')={'set','str','insert_char',' '};
        obj.i('\B')={'set','str','backspace_char',1};
        obj.i('\d')={'set','str','delete_char',1};

        obj.i('\n')={'set','str','return_str'};
        obj.i('\]')={'set','str','cancel_str'};
        obj.i('\U')={'run','str','up_history'};
        obj.i('\D')={'run','str','down_history'};
        obj.i('\L')={'run','str','inc_pos_left'};
        obj.i('\R')={'run','str','inc_pos_right'};

    end
end
end
