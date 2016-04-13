classdef VerticalStage < APT.HomeableStage

    properties (Constant = true, Hidden=true)
        SAMPLING_INTERVAL = 53.68 / 65536 
        POS_PER_ENC = 1.0 / 409600.0 / 3.0
        CONTINUOUS = false
	ISSTEPPER = true;
    end
    properties (Constant = true)
        POSMAX = 50
        POSMIN = 0
        VELMAX = 3
        VELMIN = 0
    end

    methods
        function obj = VerticalStage(port, varargin)
            obj@APT.HomeableStage(port, varargin{:})
        end
    end

end
