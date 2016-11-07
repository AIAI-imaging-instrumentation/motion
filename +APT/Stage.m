classdef (Abstract) Stage < handle

    properties (Abstract = true, Constant = true)
        POS_PER_ENC;
        SAMPLING_INTERVAL;
        CONTINUOUS;
	ISSTEPPER
    end

    properties (Hidden=true, Constant=true)
        MOT_REQ_ENCCOUNTER = hex2dec('040A');
        MOT_SET_GENMOVEPARAMS = hex2dec('043A');
        MOT_GET_MOVEABSPARAMS = hex2dec('0452');
        MOT_SET_MOVERELPARAMS = hex2dec('0445');
        HW_START_UPDATEMSGS = hex2dec('0011');
        MOT_REQ_DCSTATUSUPDATE = hex2dec('0490');
        MOT_SET_EEPROMPARAMS = hex2dec('04B9');
        MOT_REQ_HOMEPARAMS = hex2dec('0441');
        HW_DISCONNECT = hex2dec('0002');
        MOT_MOVE_ABSOLUTE = hex2dec('0453');
        MOT_REQ_GENMOVEPARAMS = hex2dec('043B');
        MOT_GET_GENMOVEPARAMS = hex2dec('043C');
        MOD_GET_CHANENABLESTATE = hex2dec('0212');
        MOT_MOVE_HOMED = hex2dec('0444');
        MOT_SET_ENCCOUNTER = hex2dec('0409');
        MOD_REQ_CHANENABLESTATE = hex2dec('0211');
        MOT_MOVE_STOPPED = hex2dec('0466');
        MOT_REQ_LIMSWITCHPARAMS = hex2dec('0424');
        MOT_MOVE_RELATIVE = hex2dec('0448');
        MOT_REQ_MOVEABSPARAMS = hex2dec('0451');
        MOT_GET_ENCCOUNTER = hex2dec('040B');
        HW_RICHRESPONSE = hex2dec('0081');
        HW_RESPONSE = hex2dec('0080');
        MOT_ACK_DCSTATUSUPDATE = hex2dec('0492');
        MOT_SET_MOVEABSPARAMS = hex2dec('0450');
        HW_STOP_UPDATEMSGS = hex2dec('0012');
        MOD_SET_CHANENABLESTATE = hex2dec('0210');
        MOT_GET_POSCOUNTER = hex2dec('0412');
        MOT_REQ_JOGPARAMS = hex2dec('0417');
        MOT_REQ_MOVERELPARAMS = hex2dec('0446');
        MOT_SET_POSCOUNTER = hex2dec('0410');
        MOT_SET_LIMSWITCHPARAMS = hex2dec('0423');
        MOT_MOVE_STOP = hex2dec('0465');
        MOT_RESUME_ENDOFMOVEMSGS = hex2dec('046C');
        MOT_GET_HOMEPARAMS = hex2dec('0442');
        HW_GET_INFO = hex2dec('0006');
        MOT_REQ_STATUSBITS = hex2dec('0429');
        MOT_GET_STATUSBITS = hex2dec('042A');
        MOT_MOVE_JOG = hex2dec('046A');
        MOT_GET_VELPARAMS = hex2dec('0415');
        MOT_MOVE_VELOCITY = hex2dec('0457');
        MOT_SET_HOMEPARAMS = hex2dec('0440');
        MOD_IDENTIFY = hex2dec('0223');
        MOT_MOVE_COMPLETED = hex2dec('0464');
        MOT_REQ_VELPARAMS = hex2dec('0414');
        MOT_SUSPEND_ENDOFMOVEMSGS = hex2dec('046B');
        HW_REQ_INFO = hex2dec('0005');
        MOT_MOVE_HOME = hex2dec('0443');
        MOT_GET_DCSTATUSUPDATE = hex2dec('0491');
        MOT_SET_VELPARAMS = hex2dec('0413');
        MOT_REQ_POSCOUNTER = hex2dec('0411');
        MOT_GET_MOVERELPARAMS = hex2dec('0447');
        MOT_SET_JOGPARAMS = hex2dec('0416');
        MOT_GET_JOGPARAMS = hex2dec('0418');
        MOT_GET_LIMSWITCHPARAMS = hex2dec('0425');
	HW_NO_FLASH_PROGRAMMING = hex2dec('0018');
        BAUDRATE = 115200
        WORD = @uint16;
        SHORT = @int16;
        DWORD = @uint32;
        LONG = @int32;
        CHAR = @uint8;
        STRCHAR = @int8;
        STATUS_MASK = containers.Map(...
            {'forward hardware limit switch is active' ...
             'reverse hardware limit switch is active' ...
             'in motion, moving forward' ...
             'in motion, moving reverse' ...
             'in motion, jogging forward' ...
             'in motion, jogging reverse' ...
             'in motion, homing' ...
             'homed' ...
             'tracking' ...
             'settled' ...
             'motion error (excessive position error' ...
             'motor current limit reached' ...
             'channel is enabled'}, ...
            [uint32(hex2dec('1')) ...
             uint32(hex2dec('2')) ...
             uint32(hex2dec('10')) ...
             uint32(hex2dec('20')) ...
             uint32(hex2dec('40')) ...
             uint32(hex2dec('80')) ...
             uint32(hex2dec('200')) ...
             uint32(hex2dec('400')) ...
             uint32(hex2dec('1000')) ...
             uint32(hex2dec('2000')) ...
             uint32(hex2dec('4000')) ...
             uint32(hex2dec('01000000')) ...
             uint32(hex2dec('80000000'))])
    end

    properties
        serial;
        velocity;
        position;
        enabled;
    end

    properties (Access=protected)
        dest;
        source;
        channel;
        % timeout;
        channelword;
        reverse_message;
        limswitchparams;
        destdata;
        constants = {'MOT_REQ_ENCCOUNTER', ...
                     'MOT_SET_GENMOVEPARAMS', ...
                     'MOT_GET_MOVEABSPARAMS', ...
                     'MOT_SET_MOVERELPARAMS', ...
                     'HW_START_UPDATEMSGS', ...
                     'MOT_REQ_DCSTATUSUPDATE', ...
                     'MOT_SET_EEPROMPARAMS', ...
                     'MOT_REQ_HOMEPARAMS', ...
                     'HW_DISCONNECT', ...
                     'MOT_MOVE_ABSOLUTE', ...
                     'MOT_REQ_GENMOVEPARAMS', ...
                     'MOT_GET_GENMOVEPARAMS', ...
                     'MOD_GET_CHANENABLESTATE', ...
                     'MOT_MOVE_HOMED', ...
                     'MOT_SET_ENCCOUNTER', ...
                     'MOD_REQ_CHANENABLESTATE', ...
                     'MOT_MOVE_STOPPED', ...
                     'MOT_REQ_LIMSWITCHPARAMS', ...
                     'MOT_MOVE_RELATIVE', ...
                     'MOT_REQ_MOVEABSPARAMS', ...
                     'MOT_GET_ENCCOUNTER', ...
                     'HW_RICHRESPONSE', ...
                     'HW_RESPONSE', ...
                     'MOT_ACK_DCSTATUSUPDATE', ...
                     'MOT_SET_MOVEABSPARAMS', ...
                     'HW_STOP_UPDATEMSGS', ...
                     'MOD_SET_CHANENABLESTATE', ...
                     'MOT_GET_POSCOUNTER', ...
                     'MOT_REQ_JOGPARAMS', ...
                     'MOT_REQ_MOVERELPARAMS', ...
                     'MOT_SET_POSCOUNTER', ...
                     'MOT_SET_LIMSWITCHPARAMS', ...
                     'MOT_MOVE_STOP', ...
                     'MOT_RESUME_ENDOFMOVEMSGS', ...
                     'MOT_GET_HOMEPARAMS', ...
                     'HW_GET_INFO', ...
                     'MOT_REQ_STATUSBITS', ...
                     'MOT_GET_STATUSBITS', ...
                     'MOT_MOVE_JOG', ...
                     'MOT_GET_VELPARAMS', ...
                     'MOT_MOVE_VELOCITY', ...
                     'MOT_SET_HOMEPARAMS', ...
                     'MOD_IDENTIFY', ...
                     'MOT_MOVE_COMPLETED', ...
                     'MOT_REQ_VELPARAMS', ...
                     'MOT_SUSPEND_ENDOFMOVEMSGS', ...
                     'HW_REQ_INFO', ...
                     'MOT_MOVE_HOME', ...
                     'MOT_GET_DCSTATUSUPDATE', ...
                     'MOT_SET_VELPARAMS', ...
                     'MOT_REQ_POSCOUNTER', ...
                     'MOT_GET_MOVERELPARAMS', ...
                     'MOT_SET_JOGPARAMS', ...
                     'MOT_GET_JOGPARAMS', ...
                     'MOT_GET_LIMSWITCHPARAMS', ...
		     'HW_NO_FLASH_PROGRAMMING', ...
                     };
    end

    methods(Access=protected)

        function name = reverse_lookup(obj, code)
	    if ~isKey(obj.reverse_message, double(code));
		    error(sprintf('%f not recogized', double(code)));
	    end
            name = obj.reverse_message(double(code));
        end

        function ack(obj)
            fwrite(obj.serial, obj.MOT_ACK_DCSTATUSUPDATE, 'uint16');
            fwrite(obj.serial, obj.CHAR(hex2dec('00')));
            fwrite(obj.serial, obj.CHAR(hex2dec('00')));
            fwrite(obj.serial, obj.dest);
            fwrite(obj.serial, obj.source);
        end

        function send(obj, cmd, varargin)
	    if ~obj.ISSTEPPER
            	obj.ack()
	    end
            parser = inputParser;
            addOptional(parser, 'param1', obj.CHAR(hex2dec('00')));
            addOptional(parser, 'param2', obj.CHAR(hex2dec('00')));
            addOptional(parser, 'data', []);
            parse(parser, varargin{:});
            fwrite(obj.serial, cmd, 'uint16');
            if isempty(parser.Results.data)
                fwrite(obj.serial, parser.Results.param1);
                fwrite(obj.serial, parser.Results.param2);
                fwrite(obj.serial, obj.dest);
                fwrite(obj.serial, obj.source);
            else
                data = cell2mat(cellfun(@(x) typecast(x, 'uint8'), parser.Results.data, 'UniformOutput', false));
                fwrite(obj.serial, obj.WORD(length(data)), 'uint16');
                fwrite(obj.serial, obj.destdata);
                fwrite(obj.serial, obj.source);

                fwrite(obj.serial, data);
            end
        end

        function [hdr, data] = read(obj, varargin)
            parser = inputParser;
            addOptional(parser, 'expected', []);
            parse(parser, varargin{:});
            rawout = fread(obj.serial, 6, 'uchar');
            hdr = uint8(rawout);
            if hdr(5) > hex2dec('80')
                datalength = double(typecast(hdr(3:4), 'uint16'));
                data = uint8(fread(obj.serial, datalength, 'uchar'));
            else
                data = [];
            end
            if ~isempty(parser.Results.expected)
                msg = typecast(hdr(1:2), 'uint16');
                if msg ~= parser.Results.expected
                    if msg == obj.HW_RICHRESPONSE
                            me = MException('ThorLabs:HardwareError', sprintf('Expected %s, received %s', ...
                                            obj.reverse_lookup(parser.Results.expected), obj.reverse_lookup(msg)));
                    elseif msg == obj.HW_RESPONSE
                            me = MException('Stage:UnexepectedResponse', sprintf('Expected %s, received %s, code %d', ...
                                            obj.reverse_lookup(parser.Results.expected), obj.reverse_lookup(msg), hdr(3:4)));
                    else
                            me = MException('Stage:UnexepectedResponse', sprintf('Expected %s, received %s', ...
                                            obj.reverse_lookup(parser.Results.expected), obj.reverse_lookup(msg)));
                    end
                    throw(me);
                end
            end
        end

        function [msg, code, notes] = parse_HW_RICHRESPONSE(obj, data)
            if data(1) == 0 && data(2) == 0
                msg = obj.reverse_lookup(typecast(data(1:2), 'uint16'));
            else
                msg = 'FAULT CONDITION';
            end
            code = typecast(data(3:4), 'uint16');
            notes = char(data(5:length(data)));
        end

        function info = get_velparams(obj)
            obj.send(obj.MOT_REQ_VELPARAMS, 'param1', obj.CHAR(obj.channel));
            [~, data] = obj.read('expected', obj.MOT_GET_VELPARAMS);
            info = struct;
            info.minvel = typecast(data(3:6), 'int32');
            info.acc = typecast(data(7:10), 'int32');
            info.maxvel = typecast(data(11:14), 'int32');
        end

        function set_velparams(obj, minvel, acc, maxvel)
            data = {obj.channelword, obj.LONG(minvel), obj.LONG(acc), obj.LONG(maxvel)};
            obj.send(obj.MOT_SET_VELPARAMS, 'data', data);
        end

    end
    
    methods
        
        function obj = Stage(port, varargin)
            [~, ~, endianness] = computer();
            assert(endianness == 'L');
            parser = inputParser;
            addOptional(parser, 'dest', 80);
            addOptional(parser, 'source', 1);
            addOptional(parser, 'channel', 1);
            addOptional(parser, 'timeout', 5);
            parse(parser, varargin{:});
            obj.dest = obj.CHAR(parser.Results.dest);
            obj.source = obj.CHAR(parser.Results.source);
            obj.channel = obj.CHAR(parser.Results.channel);
            timeout = parser.Results.timeout;
            obj.channelword = obj.WORD(parser.Results.channel);
            obj.destdata = obj.CHAR(parser.Results.dest + 128);
            obj.reverse_message = containers.Map('KeyType', 'double', 'ValueType', 'char');
            props = obj.constants;
            for keyind = 1:length(props)
                key = props{keyind};
                objkey = obj.(key);
                obj.reverse_message(objkey) = key;
            end
            obj.serial = serial(port, 'baudrate', obj.BAUDRATE, 'Timeout', timeout);
            fopen(obj.serial);
        end
        
        function delete(obj)
            fclose(obj.serial);
        end

        function flush(obj)
            % http://www.mathworks.com/matlabcentral/answers/102268-how-can-i-empty-the-serial-port-buffer-in-matlab-without-using-the-instrument-control-toolbox
            if obj.serial.BytesAvailable > 0
                fread(obj.serial, obj.serial.BytesAvailable);
            end
        end
        
        function identify(obj)
            obj.send(obj.MOD_IDENTIFY);
        end

        function stop(obj)
            obj.send(obj.MOT_MOVE_STOP, 'param1', obj.CHAR(obj.channel));
        end

        function move_rel(obj, dist, varargin)
            obj.move(dist, 'relative', true, varargin{:});
        end

        function move_abs(obj, dist, varargin)
            obj.move(dist, 'relative', false, varargin{:});
        end

        function move(obj, dist, varargin)
            parser = inputParser;
            addOptional(parser, 'relative', true);
            addOptional(parser, 'block', true);
            addOptional(parser, 'timeout', -1);
            parse(parser, varargin{:});
            % dist = obj.LONG(dist / obj.POS_PER_ENC);
            vel = obj.velocity;
            pos = obj.position;
            data = {obj.channelword, obj.LONG(dist / double(obj.POS_PER_ENC))};
            if parser.Results.relative
                if (pos + dist) > obj.POSMAX || (pos + dist) < obj.POSMIN
                    error('move would put stage outside range');
                end
                obj.send(obj.MOT_MOVE_RELATIVE, 'data', data);
                if parser.Results.timeout == -1
                    timeout = abs(dist) / vel * 2.0 + 1.0;
                else
                    timeout = parser.Results.timeout;
                end
            else
                if dist > obj.POSMAX || dist < obj.POSMIN
                    error('move would put stage outside range');
                end
                obj.send(obj.MOT_MOVE_ABSOLUTE, 'data', data);
                if parser.Results.timeout == -1
                    timeout = abs(dist - pos) / vel * 1.02 + 1.0;
                else
                    timeout = parser.Results.timeout;
                end
            end
            if parser.Results.block
                obj.waitmove(timeout)
            end
        end

        function waitmove(obj, timeout)
            oldtimeout = obj.serial.Timeout;
            obj.serial.Timeout = timeout;
            [~, ~] = obj.read('expected', obj.MOT_MOVE_COMPLETED);
            obj.serial.Timeout = oldtimeout;
        end

        function info = status(obj)
            obj.send(obj.MOT_REQ_STATUSBITS, 'param1', obj.CHAR(obj.channel));
            [~, data] = obj.read('expected', obj.MOT_GET_STATUSBITS);
            info = struct;
            status = typecast(data(3:6), 'uint32');
            status_keys = keys(obj.STATUS_MASK);
            info.status = containers.Map('KeyType', 'char', 'ValueType', 'logical');
            for i = 1:length(status_keys)
                info.status(strrep(strrep(status_keys{i}, ' ', '_'), ',', '')) = logical(bitand(obj.STATUS_MASK(status_keys{i}), status));
            end
        end

        function moving = in_motion(obj)
            status = obj.status();
            status = status.status;
            moving = status('in_motion_homing') || status('in_motion_jogging_forward') || ...
                     status('in_motion_jogging_reverse') || status('in_motion_moving_forward') || ...
                     status('in_motion_moving_reverse');
        end

        function en = get.enabled(obj)
            status = obj.status();
            en = status.status('channel_is_enabled');
        end

        function set.enabled(obj, en)
            obj.send(obj.MOD_SET_CHANENABLESTATE, 'param1', obj.channel, 'param2', obj.CHAR(en));
            pause(0.1);
            if en ~= obj.enabled
                error(sprintf('unable to set enabled state to %d', en));
            end
        end

        function vel = get.velocity(obj)
            s = obj.get_velparams();
            vel = double(s.maxvel) * double(obj.POS_PER_ENC) / double(obj.SAMPLING_INTERVAL) / 65536;
        end

        function set.velocity(obj, vel)
            if vel > obj.VELMAX || vel < obj.VELMIN
                error('invalid velocity')
            end
            info = obj.get_velparams();
            maxvel = vel / double(obj.POS_PER_ENC) * double(obj.SAMPLING_INTERVAL) * 65536;
            obj.set_velparams(info.minvel, info.acc, maxvel);
        end

        function pos = get.position(obj)
            obj.send(obj.MOT_REQ_POSCOUNTER, 'param1', obj.channel);
            [~, data] = obj.read('expected', obj.MOT_GET_POSCOUNTER);
            pos = double(typecast(data(3:6), 'int32')) * double(obj.POS_PER_ENC);
        end

        function homed = is_homed(obj)
            s = obj.status();
            homed = s.status('homed');
        end
            
        function info = hwinfo(obj)
            obj.send(obj.HW_REQ_INFO, 'param1', obj.channel);
            [~, data] = obj.read('expected', obj.HW_GET_INFO);
            info = struct();
            info.serial = typecast(data(1:4), func2str(obj.LONG));
            info.model = deblank(char(data(5:12)'));
            info.type = typecast(data(13:14), func2str(obj.WORD));
            info.firmware = struct();
            info.firmware.minor = data(15);
            info.firmware.interim = data(16);
            info.firmware.major = data(17);
            info.notes = deblank(char(data(18:66)'));
            info.hwversion = typecast(data(79:80), func2str(obj.WORD));
            info.modstate = typecast(data(81:82), func2str(obj.WORD));
            info.nchs = typecast(data(83:84), func2str(obj.WORD));
        end

        function info = get.limswitchparams(obj)
            obj.send(obj.MOT_REQ_LIMSWITCHPARAMS, 'param1', obj.CHAR(obj.channel));
            [~, data] = obj.read('expected', obj.MOT_GET_LIMSWITCHPARAMS);
            info = struct;
            info.CWHardLimit = typecast(data(3:4), func2str(obj.WORD));
            info.CCWHardLimit = typecast(data(5:6), func2str(obj.WORD));
            info.CWSoftLimit = typecast(data(7:10), func2str(obj.LONG));
            info.CCWSoftLimit = typecast(data(11:14), func2str(obj.LONG));
            info.SoftwareLimitMode = typecast(data(15:16), func2str(obj.WORD));
        end

        function set.limswitchparams(obj, val)
            data = {obj.channelword, obj.WORD(val.CWHardLimit), obj.WORD(val.CCWHardLimit), ...
                    obj.LONG(val.CWSoftLimit), obj.LONG(val.CCWSoftLimit), obj.WORD(val.SoftwareLimitMode)};
            obj.send(obj.MOT_SET_LIMSWITCHPARAMS, 'data', data);
        end

    end
end
