classdef ScanGrabber < handle
% reads input
% TODO add cntrl commands
properties
    holdCrit %initial time before repeating
    repCrit  %base pause between keys

    blackListInd % XXX NED TO CONSTRUCT THESE
    whiteListInd
    repWhiteListInd % XXX

    scanInd
    repTime
    holdTime

    nKeys
end
properties(Constant)
end
properties(Access=private)
    fls
    zer
end
events
    %KeyPressed % FOR TIME
end
methods
    function obj=ScanGrabber(varargin)
        obj=Args.parse(obj,ScanGrabber.getP,varargin{:});
        obj.fls=false(1,obj.nKeys);
        obj.zer=zeros(1,obj.nKeys);

        % REP WHITELIST
        if isempty(obj.repWhiteListInd)
            obj.repWhiteListInd=obj.fls;
        elseif ~numel(obj.repWhiteListInd) == obj.nKeys
            error('blackListInd is not the correct size');
        elseif size(obj.repWhiteListInd,1)==obj.nKeys
            obj.repWhiteListInd=obj.repWhiteListInd';
        end

        % BLACKLIST
        if isempty(obj.blackListInd)
            obj.whiteListInd=~obj.fls;
        elseif numel(obj.blackListInd) == obj.nKeys
            obj.whileListInd=obj.blackListInd;
        else
            error('blackListInd is not the correct size');
        end

        obj.holdTime=obj.zer;
        obj.repTime=obj.zer;
        obj.scanInd=obj.fls;
    end
    function [exitflag,outScanInd,keyTime]=read(obj)
        outScanInd=[];
        [keyIsDown, keyTime, nScanInd, deltaSecs] = KbCheck(-1);
        if ~keyIsDown || ~any(nScanInd(~obj.repWhiteListInd)) % mod keys do nothing by themselves
            keyTime=nan;
            obj.holdTime=obj.zer;
            obj.repTime=obj.zer;
            obj.scanInd=obj.fls;
            exitflag=1;
            return
        end
        lastScanInd=obj.scanInd;

        % FIRST - first keypress
        bFirst = nScanInd & ~lastScanInd;

        heldInd=lastScanInd & nScanInd;

        % Update New Hold
        newHoldTime=obj.holdTime;
        newHoldTime(heldInd)=newHoldTime(heldInd)+deltaSecs;
        newHoldTime(~heldInd)=0;

        % SECOND - passing holdCrit
        bSecond=(newHoldTime >= obj.holdCrit) & (obj.holdTime < obj.holdCrit);
        obj.holdTime=newHoldTime;
        heldInd=obj.holdTime >= obj.holdCrit;

        % UPDATE REPTIME -- AFTER HOLD
        obj.repTime(heldInd)=obj.repTime(heldInd)+deltaSecs;
        obj.repTime(~heldInd)=0;
        bThird=(obj.repTime > obj.repCrit);
        obj.repTime(bThird)=0; % RESET UNTIL NEXT

        % COMBINE
        outScanInd= (bFirst | bSecond | bThird)  | (nScanInd & obj.repWhiteListInd);

        obj.scanInd=nScanInd;
        exitflag=0;
    end

end
methods(Static,Hidden)
    function P=getP()
              %'holdCrit',0.2, 'isnumeric';
              %'repCrit',0.035, 'isnumeric';
        P={...
              'holdCrit',0.2, 'isnumeric';
              'repCrit',0.035, 'isnumeric';
              'blackListInd',[],'Binary_a_e';
              'repWhiteListInd',[],'';
              'nKeys',256,'Num.isInt';
          };

            %'repWhiteListInd',[],'Num.isBinary_a_e';
    end
end
end
