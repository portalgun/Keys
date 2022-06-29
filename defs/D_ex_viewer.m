function E=D_ex_viewer()
    E={ ...
        %'pause'              ,{{'key','mode','pause'},{'Parent','pause_prompt'}};
        %'unpause'            ,{{'Parent','close_prompt'},{'key','lastMode'}};

        %'key_toggle'         ,{'key','toggle'};

        %% LIMITED
        'hide'               ,{'Parent','hide_cmd'};

        'pause'              ,{'Parent','toggle_pause'}; % l/n:p
        '_cmd'               ,{'Parent','show_cmd'}; % l/n::
        '_cmd_esc_dwim'      ,{'Parent','cmd_esc_dwim'};
        '_cmd_fullscreen'    ,{'Parent','cmd_full_screen'};
        '_start_debug'       ,{'Parent','debug_mode'};

        '_cont_y'            ,{{'Parent','close_prompt'},{'Parent','set','exitflag',0}};
        '_cont_n'            ,{{'Parent','close_prompt'},{'Parent','set','exitflag',1}};

        '_yn_y'              ,{{'Parent','set','key',1},{'key','lastMode'}};
        '_yn_n'              ,{{'Parent','set','key',0},{'key','lastMode'}};


        'help'               ,{{'key','mode','help'},{'Parent','help_prompt'}};
        'help_cmd'           ,{{'key','mode','help'},{'Parent','cmd_help_prompt'}};
        'help_key'           ,{{'key','mode','help'},{'Parent','key_help_prompt'}};

        'quit'               ,{{'key','mode','quit'},{'Parent','exit_prompt'}};
        '_quit_y'            ,{{'Parent','close_prompt'},{'key','lastMode'},{'Parent','set','exitflag',1}};
        '_quit_n'            ,{{'Parent','close_prompt'},{'key','lastMode'}};

        'close'              ,{{'Parent','close_prompt'},{'key','lastMode'}};

        'inc_flag'           ,{'Parent','inc_rsp_flag'};
        'dec_flag'           ,{'Parent','dec_rsp_flag'};
        'reset_flag'         ,{'Parent','reset_rsp_flag'};

        %% NORMAL
        '_normal_mode'       ,{'key','mode','normal'};

        %% PSYINT
        '_redo_mode'         ,{'key','mode','redo'};
        'go_to_trial'        ,{'PsyInt','goto',{'$',1,1}};
        'go_n_trail'         ,{'PsyInt','go',  {'$',[],[]}};
        'prev_trial'         ,{'PsyInt','go',  { -1,[],[]}};
        'next_trial'         ,{'PsyInt','go',  {  1,[],[]}};
        'next_sub'           ,{'Parent','set','bNext',true};

        'redo_trial'         ,{'PsyInt','go',  {  0,[],[]}};
        'redo_int'           ,{'PsyInt','go',  {  0, 0,[]}};
        'redo_sub'           ,{'PsyInt','go',  {  0, 0, 0}};


        %% FILTER
        '_filter_mode'       ,{'key','mode','filter'}; % n:f
        '_filter-d_mode'     ,{'key','mode','filter-d'}; % f:d  TRANSIENT
        'filter'             ,{'Filter','filter','$0'};
        'unfilter'           ,{'Filter','unfilter'};        % f-d:f
        'filter_rm'          ,{'Filter','rmFilter','$0'};

        'sort'               ,{'Filter','sort',  '$0',false};
        'sortrev'            ,{'Filter','sort',  '$0',true};
        'unsort'             ,{'Filter','unsort'};            % f-d:o
        'sort_rm'            ,{'Filter','rmSort','$0'};

        'filter_next'        ,{'Filter','next'};  % f:l
        'filter_prev'        ,{'Filter','prev'};  % f:h
        'filter_first'       ,{'Filter','first'}; % f:$
        'filter_last'        ,{'Filter','last'};  %  f:0
        'filter_goto'        ,{'Filter','goto','$0'};
        '_filter-t_mode'     ,{'key','mode','filter-t'}; % n:f
        'filter_mode_t'      ,{'Filter','toggleMode'}; % f:m


        %% MOVE
        '_move_mode'         ,{'key','mode','move'};
        'move_left'          ,{'Im','move_left',1};
        'move_right'         ,{'Im','move_right',1};
        'move_up'            ,{'Im','move_up',1};
        'move_down'          ,{'Im','move_down',1};
        'move_forward'       ,{'Im','move_forward',1};
        'move_backward'      ,{'Im','move_backward',1};
        'move_los'           ,{'Im','move_los',1};

        %% SELECT
        '_select_mode'       ,{{'key','mode','select'},{'Psy','select_init'}};
        'select_el_up'       ,{'Psy','select_nearest','u'};
        'select_el_down'     ,{'Psy','select_nearest','d'};
        'select_el_left'     ,{'Psy','select_nearest','l'};
        'select_el_right'    ,{'Psy','select_nearest','r'};
        'select_el_up_int'       ,{'Psy','select_nearest_interior','u'};
        'select_el_down_int'     ,{'Psy','select_nearest_interior','d'};
        'select_el_left_int'     ,{'Psy','select_nearest_interior','l'};
        'select_el_right_int'    ,{'Psy','select_nearest_interior','r'};
        'unselect_el'        ,{'Psy','unselect'};

        %% PARAM
        '_param_mode'          ,{{'key','mode','param'},{'Psy','activate_selected'}};    % n:s
        'param_inc_line'       ,{'Psy','inc_selected_line'};
        'param_dec_line'       ,{'Psy','dec_selected_line'};
        'param_inc'            ,{'Psy','inc_selected_opt',1};
        'param_dec'            ,{'Psy','inc_selected_opt',-1};
        'param_inc_shift'      ,{'Psy','inc_selected_opt',2};
        'param_dec_shift'      ,{'Psy','dec_selected_opt',-2};

        %% stm edit
        '_edit_mode'           ,{{'key','mode','cmd'},{'Psy','enter_edit'}};

        %% PTCH OPTS
        'show_all'           ,{'Parent','show_util'};    %n:~
        'hide_all'           ,{'Parent','hide_util'};    %n:`
        'show_int'           ,{'Parent','show_intInfo'}; %n:i

        %% FLAG
        'flag_poor_t'         ,{'Flags','toggle_poor'};    % l/n: ret
        'flag_bad_t'         ,{'Flags','toggle_bad'};    % l/n: ret
        'flag_other_inc'     ,{'Flags','inc_other'};  % l/n: shift/return
        'flag_other_dec'     ,{'Flags','dec_other'};  % l/n: shift/return
        'flag_other_reset'   ,{'Flags','reset_other'};  % l/n: shift/return
        'flag_save'          ,{'Flags','save'};
        'flag_reset'         ,{'Flags','reset'};


        %% Stm


        '_stm-t_mode'        ,{'key','mode','stm-t'};  % - s:t TRANSIENT
        'stm_restore'        ,{'stmOpts','restore'};   % s:r
        'rms_t'              ,{'PtchOpts','toggle','rmsFix',{0,'@o.rmsFix'}}; % -t:r
        'flat_t'             ,{'PtchOpts','toggle','bFlat'};                  % s-t:f
        'window_t'           ,{'PtchOpts','toggle','bWindow'};                % s-t:w

        '_stm-td_mode'       ,{'key','mode','stm-td'}; % - s-t:d TRANSIENT
        'disparity_t'        ,{'PtchOpts','toggle','trgtInfo.trgtDsp',{0,'@o.trgtInfo.trgtDsp'}}; %s-td:s
        'dc_t'               ,{'PtchOpts','toggle','dcFix' ,{0,'@o.dcFix'}};              % s-td:c

        '_stm-tb_mode'       ,{'key','mode','stm-tb'};                                    % s-t:b TRANSIENT
        'binoRmsFix_t'       ,{'PtchOpts','toggle','monoORbinoFix',{'mono','bino'}};      % s-tb:f
        'binoRMS_t'          ,{'PtchOpts','toggle','monoORbinoContrast',{'mono','bino'}}; % s-tb:t
        ...
        'disparity_set'      ,{'PtchOpts','set','trgtInfo.trgtDsp','$'};
        'rms_set'            ,{'PtchOpts','set','rmsFix','$'};
        'dc_set'             ,{'PtchOpts','set','dcFix','$'};

        %% IM
        'im_restore'         ,{'Im','restore'}; %
        'im_select_t'        ,{'Im','toggle','names'}; % s:\t
        'im_mode_t'          ,{'Im','toggle','opts.(@selName).mode',{'sng','sbs','ana'}}; % s:m
        'im_zer_t'           ,{'Im','toggle','opts.(@selName).bZer'}; % s:0
        ...
        'im_WHpix_set'       ,{'Im','toggle','opts.(@selName).WHpix','$'};
        'im_XYpix_set'       ,{'Im','toggle','opts.(@selName).XYpix','$'};
        'im_stmMult_set'     ,{'Im','toggle','opts.(@selName).stmMult','$'};
        'im_duration_set'    ,{'Im','toggle','opts.(@selName).duration','$'};

        %% PLOT XXX
        '_zoom_mode'         ,{'key','mode','zoom'};    % n:z
        'plot_clim'          ,{'Plot','set','clim','$','$'};
        'plot_zoom_in'       ,{'Plot','zoom_in'};  % z:+
        'plot_zoom_out'      ,{'Plot','zoom_out'}; % z:-
        'plot_zoom_reset'    ,{'Plot','zoom_reset'}; % z:=

        %% ? XXX
        'ptch_relaod'        ,{'Viewer','Reload'};

    };
end
