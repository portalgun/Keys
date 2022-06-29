classdef KeyDef_vim < handle & KeyDef
properties(Constant)
    DEFMODE='l'
end
methods(Static)
    function E=getEx()
        E=KeyDef_basic.getEx();
        E(end-4:end,:)=[];
        % TODO
        % flags
        %    e - error transient
        %    t - transient
        %    x - no direct ex
        e = {...
                'd str'    ,{{'str','cancel_str'},{'key','last_mode'}};
                'go'       ,{{'go','goto','$0'},{'key','last_mode'}};

                'ex_return',{{'cmd','ex_return'},{'key','last_mode'}};
                'g first'  ,{{'go','first'},{'key','last_mode'}};
                'g last'   ,{{'go','last'},{'key','last_mode'}};
                ...
                'm n'      ,{'key','mode','n'};
                'm i'      ,{'key','mode','i'};
                'm v'      ,{'key','mode','v'};
                'm g'      ,{'key','mode','g'};
                'm c'      ,{{'key','mode','c'}, {'str','insert_char',''} };
                'm k1'     ,{{'key','mode','k'}, {'str','insert_char','1'}};
                'm k2'     ,{{'key','mode','k'}, {'str','insert_char','2'}};
                'm k3'     ,{{'key','mode','k'}, {'str','insert_char','3'}};
                'm k4'     ,{{'key','mode','k'}, {'str','insert_char','4'}};
                'm k5'     ,{{'key','mode','k'}, {'str','insert_char','5'}};
                'm k6'     ,{{'key','mode','k'}, {'str','insert_char','6'}};
                'm k7'     ,{{'key','mode','k'}, {'str','insert_char','7'}};
                'm k8'     ,{{'key','mode','k'}, {'str','insert_char','8'}};
                'm k9'     ,{{'key','mode','k'}, {'str','insert_char','9'}};
                'm k0'     ,{{'key','mode','k'}, {'str','insert_char','0'}};
        };
        E=[E;e];

    end
    function [D,T]=get()
        D=KeyDef_basic.get();
        d={...
                'g first'         ,'g' ,'g';
                'g last'          ,'n' ,'G';
                'g prev'          ,'n' ,'h';
                'g next'         , 'n' ,'l';
                'g down'          ,'n' ,'j';
                'g down'          ,'n' ,'\D';
                'g up'            ,'n' ,'\U';
                'go'              ,'k' ,'G';
                'm v'             ,'n' ,'v';
                'm v'             ,'i' ,'C-\s';
                'm g'             ,'n' ,'g';
                'm c'             ,'n' ,':';
                'm c'             ,'n' ,';';
                'm k1'            ,'kn' ,'1';
                'm k2'            ,'kn' ,'2';
                'm k3'            ,'kn' ,'3';
                'm k4'            ,'kn' ,'4';
                'm k5'            ,'kn' ,'5';
                'm k6'            ,'kn' ,'6';
                'm k7'            ,'kn' ,'7';
                'm k8'            ,'kn' ,'8';
                'm k9'            ,'kn' ,'9';
                'm k0'            ,'kn' ,'0';
                'm n'             ,'nivkg' ,'\]';
                'd str'           ,'c' ,'\]';
          };
        D=[D; d];
        T='g';

        %
    end
end
end
