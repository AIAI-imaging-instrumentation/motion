classdef RotationStage < APT.Stage

    properties (Constant = true, Hidden=true)
        POS_PER_ENC = 360.0 / 12288.0 / 48.0;
        SAMPLING_INTERVAL = 2048.0 / (6.0 * 10.0^6.0);
        CONTINUOUS = true;
        ISSTEPPER = false;
    end
    properties (Constant = true)
        POSMAX = inf
        POSMIN = -inf
        VELMAX = 6
        VELMIN = 0.3667
    end

    methods
        function obj = RotationStage(port, varargin)
            obj@APT.Stage(port, varargin{:})
        end
    end

end
