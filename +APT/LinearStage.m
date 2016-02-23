classdef LinearStage < APT.Stage

    properties (Constant = true, Hidden=true)
        SAMPLING_INTERVAL = 102.4 * 10. ^ -6.
        POS_PER_ENC = 1.0 / 2000.0
        CONTINUOUS = false
    end
    properties (Constant = true)
        POSMAX = 100
        POSMIN = 0
        VELMAX = 500
        VELMIN = 0
    end

    methods
        function obj = LinearStage(port, varargin)
            obj@APT.Stage(port, varargin{:})
            obj.velocity = 10;
        end

        function home(obj, varargin)
            parser = inputParser;
            addOptional(parser, 'timeout', 60);
            parse(parser, varargin{:});
            oldtimeout = obj.serial.Timeout;
            obj.serial.Timeout = parser.Results.timeout;
            obj.send(obj.MOT_MOVE_HOME, 'param1', obj.CHAR(obj.channel))
            obj.read('expected', obj.MOT_MOVE_HOMED);
            obj.serial.Timeout = oldtimeout;
            
        end
    end

end
