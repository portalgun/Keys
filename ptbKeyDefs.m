function K  = ptbKeyDefs()
%keycode dictionary
KbName('UnifyKeyNames');

K.period    = KbName('.>');
K.comma     = KbName(',<');
K.space     = KbName('space');
K.enter     = KbName('return');
K.enter     = K.enter(1);
K.escape    = KbName('ESCAPE');
K.shiftL    = KbName('LeftShift'); % maybe OSX specific... left_shift didn't work
K.shiftR    = KbName('RightShift'); % maybe OSX specific... left_shift didn't work
K.Uarrow    = KbName('upArrow');     % INTERVAL 2
K.Darrow    = KbName('downArrow');   % INTERVAL 1
K.Larrow    = KbName('leftArrow');
K.Rarrow    = KbName('rightArrow');
K.tilde     = KbName('`~');
K.LCbracket  = KbName('[{');
K.LCbracket  = KbName(']}');
K.Ralt       = KbName('RightAlt');
K.Lalt       = KbName('LeftAlt');
K.Rgui       = KbName('RightGUI');
K.Lgui       = KbName('LeftGUI');
K.Lctl       = KbName('LeftControl');
K.Rctl       = KbName('RightControl');
if ispc
    K.backspace = KbName('BackSpace');
    K.delete    = KbName('Delete');
    K.colon     = KbName(';');
    K.backslash = KbName('\\');
    K.slash = KbName('/?');
elseif islinux
    K.backspace = KbName('BackSpace');
    K.delete    = KbName('Delete');
    K.colon     = KbName(';:');
    K.backslash = KbName('\|');
    K.slash     = KbName('/?');
elseif ismac
    K.backspace = KbName('DELETE');
    K.delete    = KbName('DeleteForward');
    K.colon     = KbName(';:');
    K.backslash=KbName('\|');
    K.slash = KbName('/?');
end
K.tab       = KbName('tab');
   % KbName('KeyNamesOSX') does not contain 'shift'...
   % So use space + w for the complimentary move to w
K.a         = KbName('a');
K.b         = KbName('b');
K.c         = KbName('c');
K.d         = KbName('d');
K.e         = KbName('e');
K.f         = KbName('f');
K.g         = KbName('g');
K.h         = KbName('h');
K.i         = KbName('i');
K.j         = KbName('j');
K.k         = KbName('k');
K.l         = KbName('l');
K.m         = KbName('m');
K.n         = KbName('n');
K.o         = KbName('o');
K.p         = KbName('p');
K.q         = KbName('q');
K.r         = KbName('r');
K.s         = KbName('s');
K.t         = KbName('t');
K.u         = KbName('u');
K.v         = KbName('v');
K.w         = KbName('w');
K.x         = KbName('x');
K.y         = KbName('y');
K.z         = KbName('z');

K.one       = KbName('1!');
K.two       = KbName('2@');
K.three     = KbName('3#');
K.four      = KbName('4$');
K.five      = KbName('5%');
K.six       = KbName('6^');
K.seven     = KbName('7&');
K.eight     = KbName('8*');
K.nine      = KbName('9(');
K.zero      = KbName('0)');
K.minus     = KbName('-_');
K.equal     = KbName('=+');
