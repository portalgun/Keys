function [K,T]= D_key_view_viewer()
    K={...
       % TODO escape transient
       % list transinet
       % rm pause as mode


       %% LIMITED
       'prev_trial'      ,'limi',  '\C-b';
       'prev_trial'      ,'rsp',   '\C-b';
       'prev_trial'      ,'normal','\C-b';
       'next_trial'      ,'rsp','   \C-f';
       'next_trial'      ,'limi','  \C-f';
       'next_trial'      ,'normal','\C-f';
       'redo_trial'      ,'normal','\C-r';
       'redo_trial'      ,'rsp','\C-r';
       'redo_trial'      ,'limi','\C-r';
       '_start_debug'     ,'limi', '\C-z';
       '_start_debug'     ,'rsp',  '\C-z';

       'pause'         ,'limi','p';
       'pause'         ,'rsp','p';
       'pause'         ,'normal','p';
       'pause'         ,'stm','p';
       'pause'         ,'filter','p';

       '_cmd'          ,'limi',':';
       '_cmd'          ,'rsp',':';
       '_cmd'          ,'normal',':';
       '_cmd'          ,'stm',':';
       '_cmd'          ,'filter',':';

       '_cmd'          ,'limi',':';
       '_cmd'          ,'rsp',':';
       '_cmd'          ,'normal',':';
       '_cmd'          ,'stm',':';
       '_cmd'          ,'filter',':';

       '_cmd_clc'      ,'normal','\C-l';
       '_cmd_clc'      ,'cmd','\C-l';
       '_cmd_esc_dwim'  ,'cmd','\]';
       '_cmd_fullscreen', 'cmd','\C-f';
     %'_str_cancel'           ,'str','\]'; XXX
     %'_str_cancel'           ,{'str','cancel_str'};

       'help'          ,'limi','?';
       'help'          ,'rsp','?';
       'help'          ,'normal','?';
       'help'          ,'stm','?';
       'help'          ,'filter','?';

       'quit'          ,'limi','q';
       'quit'          ,'rsp','q';
       'quit'          ,'normal','q';
       'quit'          ,'stm','q';
       'quit'          ,'filter','q';

       '_cont_y'       ,'cont','\U';
       '_cont_n'       ,'cont','\D';
       '_cont_n'       ,'cont','\]';

       'help_cmd'      ,'help','c';
       'help_key'      ,'help','k';
       'close'         ,'help','\]';

       '_quit_y'       ,'quit','y';
       '_quit_n'       ,'quit','n';
       '_quit_n'       ,'quit','\]';

        '_yn_y'        ,'yn','y';
        '_yn_n'        ,'yn','n';
        '_yn_n'        ,'yn','\]';

        'inc_flag'     ,'rsp','\n';
        'dec_flag'     ,'rsp','\d';
        'reset_flag'   ,'rsp','\B';


       %% PSYINT
       '_redo_mode'      ,'normal','r';
       %'go_to_trial'     ,'normal','g';  XXX num mode
       %'go_n_trial'      ,'normal','g';  XXX num mode

       'redo_trial'      ,'redo','t';
       'redo_int'        ,'redo','i';
       'redo_sub'        ,'redo','s';

       'key_toggle'      ,'normal','\C-q';

       %% NORMAL
       '_normal_mode'    ,'cmd','\C-g';
       '_normal_mode'    ,'filter','\]';
       '_normal_mode'    ,'filter-t','\]';
       '_normal_mode'    ,'stm-t','\]';
       '_normal_mode'    ,'stm-td','\]';
       '_normal_mode'    ,'stm-tb','\]';


       'filter_next'     ,'normal','l';
       'filter_prev'     ,'normal','h';
       'unselect_el'     ,'normal','\]';

       '_move_mode'      ,'select','\n';
       '_select_mode'      ,'move','\]';
       'move_left'    ,'move','h';
       'move_right'   ,'move','l';
       'move_up'      ,'move','k';
       'move_down'    ,'move','j';
       'move_forward' ,'move','f';
       'move_backward','move','b';
       %'move_los',     'move','\t';

        %% FILTER
       '_filter_mode'    ,'normal','f';
       '_filter-d_mode'  ,'filter','d';
       'unfilter'        ,'filter-d','f';

       'unsort'          ,'filter-d','o';

       'filter_next'     ,'filter','l';
       'filter_prev'     ,'filter','h';
       'filter_first'    ,'filter','$';
       'filter_last'     ,'filter','0';
       '_filter-t_mode'  ,'filter','t';
       'filter_mode_t'   ,'filter-t','m';

       %% SELECT
       '_select_mode'    ,'normal','s';
       'select_el_up'    ,'select','k';
       'select_el_down'  ,'select','j';
       'select_el_left'  ,'select','h';
       'select_el_right' ,'select','l';
       'unselect_el'     ,'select','u';
       '_normal_mode'    ,'select','\]';
       'select_el_up_int'    ,'select','K';
       'select_el_down_int'  ,'select','J';
       'select_el_left_int'  ,'select','H';
       'select_el_right_int' ,'select','L';

       %% PARAM
       '_param_mode'      ,'select','p';
       'param_inc_line'   ,'param','j';
       'param_dec_line'   ,'param','k';
       'param_inc'        ,'param','l';
       'param_dec'        ,'param','h';
       '_select_mode'     ,'param','\]';

       %% EDIT
       '_edit_mode'      ,'param','\n';

       %% PTCH OPTS
       'show_all'        ,'normal','a';
       'hide_all'        ,'normal','A';
       'show_int'        ,'normal','i';

       %% FLAG
       'flag_bad_t'        ,'filter','\n';
       'flag_bad_t'        ,'normal','j';
       'flag_poor_t'       ,'filter','\n';
       'flag_poor_t'       ,'normal','k';
       'flag_other_inc'    ,'filter','\t';
       'flag_other_inc'    ,'normal','\t';
       'flag_other_dec'    ,'filter','\tS';
       'flag_other_dec'    ,'normal','\tS';

       %% PtchOpts
       %'stm_restore'     ,'stm','R';

       %'_stm-t_mode'     ,'stm','t';
       %'rms_t'           ,'stm-t','r';
       %'flat_t'          ,'stm-t','f';
       %'window_t'        ,'stm-t','w';

       %'_stm-td_mode'    ,'stm-t','d';
       %'disparity_t'     ,'stm-td','i';
       %'disparity_t'     ,'stm-td','s';
       %'dc_t'            ,'stm-td','c';

       %'_stm-tb_mode'    ,'stm-t','b';
       %'binoRmsFix_t'    ,'stm-tb','f';
       %'binoRMS_t'       ,'stm-tb','t';

       %% IM
       %'im_restore'      ,'stm','R';
       %'im_select_t'     ,'stm','\t';
       %'im_mode_t'       ,'stm','m';
       %'im_zer_t'        ,'stm','0';
    };

    T={...
       'filter-t';
       'stm-t';
       'stm-td';
       'stm-tb';
    };
end
