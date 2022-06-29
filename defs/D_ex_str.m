function e=D_ex_str()
        char=num2cell(Str.A);
        f={'str','insert_char'};
        E=[cellfun(@(x) {['_str_i_' x], [f x]},char,'UniformOutput',false)];
        E=vertcat(E{:});
        e={...
                '_str_i_space'          ,{'str','insert_char',' '};
                '_str_i_newline'        ,{'str','insert_char',newline};
                '_str_i_tab'            ,{'str','insert_char','    '};
                '_str_backspace'        ,{'str','backspace_char',1};
                '_str_delete'           ,{'str','delete_char',1};
                '_str_return'           ,{'str','return_str'};
                '_str_cancel'           ,{'str','cancel_str'};
                '_str_left'             ,{'str','inc_pos_left'};
                '_str_right'            ,{'str','inc_pos_right'};
                ...
                '_str_back-word'        ,{'str','back-word'};
                '_str_forward-word'     ,{'str','forward-word'};
                '_str_kill-word-back'   ,{'str','kill-word-back'};
                '_str_kill-line-forwad' ,{'str','kill-line-forward'};
                '_str_paste'            ,{'str','paste'};
                '_str_line-first'       ,{'str','change_pos',1};
                '_str_line-end'         ,{'str','change_pos',nan};
                ...
                '_str_up-history'       ,{'str','up_history'};
                '_str_down-history'     ,{'str','down_history'};
        };
        e=[E;e];
end
