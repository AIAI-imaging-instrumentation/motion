classdef HomeableStage < APT.Stage

    methods
        function obj = HomeableStage(port, varargin)
            obj@APT.Stage(port, varargin{:})
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
