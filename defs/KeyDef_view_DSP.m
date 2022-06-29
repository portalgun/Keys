                %% VIEWER
                't patchORbuff'      ,{'Viewer','toggle','ptchORbuff',{'ptch','buff'}};

                %% MODES
                'm ch'               ,{'key','mode','C'};
                'm toggle'           ,{'key','mode','t'};
                'm stm'              ,{'key','mode','s'};
                'm rm'               ,{'key','mode','d'};
                'm del'              ,{'key','mode','D'};
                'm reload'           ,{'key','mode','r'};
                ...
                'r view'             ,{'Viewer','reload'};
                'r parts'            ,{'Viewer','re_init_parts'};
                ...
        };
        E=[E; e];
