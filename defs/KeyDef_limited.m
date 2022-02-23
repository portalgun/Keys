classdef KeyDef_limited < handle & KeyDef
properties
    A=containers.Map % ANY
    l=containers.Map % limited
    c=containers.Map % command

    q=containers.Map % Quit prompt
    h=containers.Map % help
    e=containers.Map % continue
    I=containers.Map % info
    p=containers.Map % pause
end
properties(Constant)
    stdModes={'A','l','q','c','h','C','I','p'}
end
methods
    function obj=KeyDef_limited()
        obj.name='limited';
        obj.mode='l';
        obj.defMode='l';

        E=KeyDef_limited.getEx();
        [D,T]=KeyDef_limited.get();
        modes=KeyDef_limited.stdModes;
        obj.init(E,D,modes,T);
    end
end
methods(Static)
    function E=getEx();
        E=KeyDef_basic.getEx();
        e={...

                'q'                  ,{{'key','mode','q'},{'Parent','exit_prompt'}};
                'p'                  ,{{'key','mode','q'},{'Parent','pause_prompt'}};

                'q y'                ,{'Parent','set','exitflag',1};

                'e y'                ,{{'Parent','close_prompt'},{'Parent','set','exitflag',0}};
                'e n'                ,{{'Parent','close_prompt'},{'Parent','set','exitflag',1}};

                'debug'              ,{{'Parent','toggle_debug'}}; %XXX

                '?'                 ,{{'key','mode','I'},{'Parent','key_help_prompt'}};
                'help'              ,{{'key','mode','I'},{'Parent','cmd_help_prompt'}};

                'p esc'              ,{{'Parent','close_prompt'},{'key','last_mode'}};

        };
        E=[E; e];
    end
    function [D,T]=get()
        D={...
              'q'             ,'l',  '\]';
              'p'             ,'l',  'p';
              'debug'         ,'l',  '!';
              '?'          ,'l',  '/';

              'q y'           ,'q',  'y';

              'e y'           ,'c',  'y';
              'e n'           ,'c',  'n';

              'p esc'         ,'Iqp', '\]';
              'p esc'         ,'p',  'p'; % NOT WORKING?
              'p esc'         ,'q',  'n';

        };
        T='';
    end
end
end

