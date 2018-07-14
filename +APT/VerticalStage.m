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

        % these values taken from what thorlabs user sends ot the stage
        HOMEDIRECTION = APT.HomeableStage.CHAR(2)
        HOMELIMITSWITCH = APT.HomeableStage.CHAR(1)
        HOMEVELOCITY = APT.HomeableStage.LONG(65958132)
        HOMEOFFSETDISTANCE = APT.HomeableStage.LONG(245760)

    end

    methods
        function obj = VerticalStage(port, varargin)
            obj@APT.HomeableStage(port, varargin{:})
            data = {obj.CHAR(obj.channel), obj.HOMEDIRECTION, obj.HOMELIMITSWITCH, obj.HOMEVELOCITY, obj.HOMEOFFSETDISTANCE};
            obj.send(obj.MOT_SET_HOMEPARAMS, 'data', data);
        end
    end

end
