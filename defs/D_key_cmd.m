function [K,T]=D_key_cmd()
    K=D_key_str();
    n=size(K,1);
    K(:,2)=repmat({'cmd'},n,1);
    K(end,:)  ={ '_cmd_return',    'cmd','\n' };
    K(end+1,:)={ '_cmd_clc',       'cmd','\C-l' };
    K(end+1,:)={'key_toggle'      ,'cmd','\C-q'};
    T={};
end
