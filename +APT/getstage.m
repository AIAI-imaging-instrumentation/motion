function s = getstage(type, varargin)
    if strcmp(type, 'rotation')
        target = 'TDC001';
        constructor = @APT.RotationStage;
    elseif strcmp(type, 'linear')
        target = 'TBD001';
        constructor = @APT.LinearStage;
    elseif strcmp(type, 'vertical')
        target = 'MLJ050';
        constructor = @APT.VerticalStage;
    else
        error('Unsupported stage type requested. Allowed types are rotation and linear');
    end
            
    hwinfo = instrhwinfo('serial');
    for i = 1:length(hwinfo.AvailableSerialPorts)
        port = hwinfo.AvailableSerialPorts(i);
        d = APT.DummyStage(port);
        info = d.hwinfo()
        delete(d);
        clear d;
        if strcmp(target, info.model)
            s = constructor(port, varargin{:});
            return
        end
    end
    error('%s stage not found', type);
end
        
