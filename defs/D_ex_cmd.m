function D=D_ex_cmd()
    % SUPERSET OF STR
    D=D_ex_str();
    D(end+1,:)={ ...
        %'_cmd_return'        ,{'cmd','ex_return'};
        '_cmd_return'          ,{'cmd','ret'};
    };
    d={...
        %'_cmd_clc'             ,{{'cmd','clc'},{'key','lastMode'}};
        '_cmd_clc'             ,{'cmd','clc'};
        %'hide'                 ,{{'Parent','hide_cmd'},{'key','lastMode'}};
        'hide'                  ,{'Parent','hide_cmd',false};
        '_hide'                 ,{'Parent','hide_cmd',true};
        'key_toggle'            ,{'key','toggle'};
    };
    D=[D; d];
end
