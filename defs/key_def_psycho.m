classdef key_def_psycho < handle & key_def
methods
    function obj=key_def_psycho()
       obj@key_set();

       obj.n'\n')  = 'flag_toggle'; %return
       obj.n'\]')  = 'escape';      %escape

        %n('\B')  =
       obj.n'\t')  = 'info_toggle';
        %n('\tS') =
        %n('\s')  =
        %n('\sS')  =

        %n('a')   =
       obj.n'b')   = 'bg_menu_toggle';
        %n('c')   = 'ch_menu_toggle';
        %n('d')   = 'ch_shape_toggle';
       obj.n'e')   = 'exp';
       obj.n'f')   = 'flag';
       obj.n'g')   = 'go_trial';
       obj.n'h')   = 'left';
       obj.n'i')   = 'insert_mode';
       obj.n'j')   = 'down';
       obj.n'k')   = 'up';
       obj.n'l')   = 'right';
       obj.n'm')   = 'mask';
        %n('n')   =
       obj.n'o')   = 'sort_menu_toggle';
       obj.n'p')   = 'plate_menu_toggle';
        %q
       obj.n'r')   = 'redraw';
       obj.n's')   = 'stim';
        %n('t')   = 'std_or_cmp_toggle';
       obj.n'u')   = 'ui_menu_toggle';
        %n('v')   =
        %n('w')   = 'win_menu_toggle';
        %n('x')   =
        %n('y')   =
        %n('z')   = 'pause';

        %n('A')   =
        %n('B')   =
        %n('C')   =
        %n('D')   =
        %n('E')   =
        %n('F')   =
        %n('G')   =
       obj.n'H')   = 'previous_mod';
        %n('I')   =
       obj.n'J')   = 'down_mod';
       obj.n'K')   = 'up_mod';
       obj.n'L')   = 'next_mod';
        %n('M')   =
        %n('N')   =
        %n('O')   =
        %P
        %Q
        %n('R')   =
        %n('S')   =
        %n('T')   =
        %n('U')   =
        %n('V')   =
        %n('W')   =
        %n('X')   =
        %n('Y')   =
        %n('Z')   =
        %n('1')   =
        %n('2')   =
        %n('3')   =
        %n('4')   =
        %n('5')   =
        %n('6')   =
        %n('7')   =
        %n('9')   =
        %n('0')   =
        %n('!')   =
        %n('@')   =
        %n('#')   =
        %n('$')   =
        %n('%')   =
        %n('^')   =
        %n('*')   =
        %n('(')   =
        %n(')')   =
        %n('[')   =
        %n(']')   =
        %n('{')   =
        %n('}')   =
       obj.n'+')   = 'zoom_reset';
       obj.n'-')   = 'zoom_out';
       obj.n'=')   = 'zoom_in';
       obj.n':')   = 'cmd_menu_toggle';
        %n('.')   =
        %n(',')   =
        %n('\')   =
        % (?)
        % XXX
        % anchor toggle
        % probe toggle


       obj.i'\t')       = 'next_fld';
       obj.i'\tS')      = 'prev_fld';

       obj.e'\R')        = 'next';
       obj.e'\L')        = 'previous';
       obj.e'\n')        = 'flag_toggle';
       obj.e'\]')        = 'quit_prompt';
    end
end
