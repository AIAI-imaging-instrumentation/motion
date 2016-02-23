classdef DummyStage < APT.Stage

    properties (Constant = true)
        POS_PER_ENC = 1.0;
        MAXVEL = 1.0;  % Degrees per sec
        MINVEL = 1.0;  % Degrees per sec
        SAMPLING_INTERVAL = 1.0;
        CONTINUOUS = true;
    end

    methods
        function obj = DummyStage(port, varargin)
            obj@APT.Stage(port, varargin{:})
        end
        
        function move_rel(obj, varargin)
            error('Cannot move dummy stage')
        end
        
        function move_abs(obj, varargin)
            error('Cannot move dummy stage')
        end
        
        function move(obj, varargin)
            error('Cannot move dummy stage')
        end

    end

end
