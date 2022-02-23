classdef KeyCmd
properties
    cmd
    status
    OUT
end
methods
    function obj=keyCmd()
    end
    function [cmd,dest]=read(obj,cmd)
        obj.cmd=cmd;
        tmp=cell(length(cmd),1);
        for i = 1:length(cmd)
            obj.parse(cmd{i});
            tmp{i}=obj.OUT;
        end
        ind=cellfun(@isempty,tmp);
        tmp(ind)=[];
        if numel(tmp)==1
            tmp=tmp{1};
        end
        obj.OUT=tmp;
    end
    function [OUT,dest]=parse(obj,cmd)
        obj.status='';

        OUT=cmd;
        switch
            case 'str'
                OUT=obj.KeyStr.read(cmd);
                obj.status='s';
            case 'key'
                case 'str'
                obj.change_mode(cmd{3});
                obj.status='k';
            case 'go'
                obj.status='g';
            case 'ex'
                obj.status='e'; % XXX
            otherwise
                obj.status='o';
    end

end
end
