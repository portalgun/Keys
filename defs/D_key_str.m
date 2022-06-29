function [K,T]=D_key_str()
    char=num2cell(Str.A);
    K=[cellfun(@(x) {['_str_i_' x], 'str', x },char,'UniformOutput',false)];
    K=vertcat(K{:});
    k={ ...
         '_str_i_space'          ,'str','\s' ;
         '_str_i_newline'        ,'str','\nS';
         '_str_i_tab'            ,'str','\t' ;
         '_str_backspace'        ,'str','\B' ;
         '_str_delete'           ,'str','\d' ;
         %'_str_cancel'           ,'str','\]'; XXX
         '_str_right'            ,'str','\R' ;
         '_str_right'            ,'str','\C-f' ;
         '_str_left'             ,'str','\L' ;
         '_str_left'             ,'str','\C-b' ;
         ...
         '_str_back-word'        ,'str','\A-b';
         '_str_forward-word'     ,'str','\A-f';
         '_str_paste'            ,'str','\C-y';
         '_str_kill-word-back'   ,'str','\C-w';
         '_str_kill-line-forwad' ,'str','\C-k';
         '_str_line-first'       ,'str','\C-a';
         '_str_line-end'         ,'str','\C-e';
         ...
         '_str_up-history'       ,'str','\U';
         '_str_up-history'       ,'str','\C-p';
         '_str_down-history'     ,'str','\D' ;
         '_str_down-history'     ,'str','\C-n';
          ...
         '_str_return'           ,'str','\n' ;
    };
    K=[K;k];
    T={};
end
