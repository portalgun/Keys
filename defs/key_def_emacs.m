classdef key_def_emacs < handle & key_def_str_read 
methods
    function obj =key_def_emacs()
        obj@key_def_str_read();
        obj.i('A-b')={'run','str','back-word'};
        obj.i('A-f')={'run','str','forward-word'};
        obj.i('C-w')={'run','str','kill-word-back'};
        obj.i('C-k')={'run','str','kill-line-forward'};
        obj.i('C-y')={'run','str','paste'};
        obj.i('C-p')={'run','str','up_history'};
        obj.i('C-n')={'run','str','down_history'};
        obj.i('C-a')={'run','str','change_pos',1};
        obj.i('C-e')={'run','str','change_pos',nan};
        obj.i('C-\s')={'run','mode','v'};
    end
end
end
