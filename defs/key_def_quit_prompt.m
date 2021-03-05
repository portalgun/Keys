classdef key_def_quit_prompt < handle & key_def
methods
    function obj=key_def_quit_prompt();
        obj@key_def();
        obj.i('Y')  =  {'set','str','insert_char','Y'};
        obj.i('n')  =  {'set','str','insert_char','n'};
        obj.i('m')  =  {'set','str','insert_char','m'};
        obj.i('c')  =  {'set','str','insert_char','c'};
        obj.i('\B')={'set','str','backspace_char'};
        obj.i('\d')={'set','str','delete_char'};
        obj.i('\L')={'run','str','inc_pos_left'};
        obj.i('\R')={'run','str','inc_pos_right'};
        obj.n('\]')={'run','str','cancel_str'};
        obj.i('\n')={'run','str','return_str'};
        obj.i('\]')={'run','str','cancel_str'};
    end
end
end
