classdef LinearStage < APT.HomeableStage

    properties (Constant = true, Hidden=true)
        SAMPLING_INTERVAL = 102.4 * 10. ^ -6.
        POS_PER_ENC = 1.0 / 2000.0
        CONTINUOUS = false
	ISSTEPPER = false;
    end
    properties (Constant = true)
        POSMAX = 100
        POSMIN = 0
        VELMAX = 500
        VELMIN = 0
    end

    methods
        function obj = LinearStage(port, varargin)
            obj@APT.HomeableStage(port, varargin{:})
            obj.velocity = 10;
        end
    end

end
