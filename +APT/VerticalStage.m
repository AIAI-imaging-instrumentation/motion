classdef VerticalStage < APT.HomeableStage

    properties (Constant = true, Hidden=true)
        SAMPLING_INTERVAL = 65536 * 53.68
        POS_PER_ENC = 1.0 / 409600.0 / 3.0
        CONTINUOUS = false
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
