classdef KeyDef_quit_prompt < handle & KeyDef
methods
    function obj=KeyDef_quit_prompt();
        obj@KeyDef();
        obj.i('Y') = {'str','insert_char','Y'};
        obj.i('n') = {'str','insert_char','n'};
        obj.i('m') = {'str','insert_char','m'};
        obj.i('c') = {'str','insert_char','c'};
        obj.i('\B')={'str','backspace_char'};
        obj.i('\d')={'str','delete_char'};
        obj.i('\L')={'str','inc_pos_left'};
        obj.i('\R')={'str','inc_pos_right'};
        obj.n('\]')={'str','cancel_str'};
        obj.i('\n')={'str','return_str'};
        obj.i('\]')={'str','cancel_str'};
    end
end
end
