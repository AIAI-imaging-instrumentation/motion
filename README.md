# Motion
Motion stage control

## Installation (windows)

1. Download and install the [ftdi drivers](http://www.ftdichip.com/Drivers/CDM/CDM%20v2.12.12%20WHQL%20Certified.exe)
2. Download and install the thorlabs apt software
3. Restart computer
4. Plug in stage(s)
5. For all stages: Device Manager-> usb devices -> APT device -> right click -> properties -> advanced -> Select Enable VCP
6. Unplug and re-plug in the stages
7. In device manager they should appear as COM objects
8. Add imaging_instrumentation/thorlabs_apt to the matlab path

## Setup

1. Plug the stage into the stage controller (linear -> TBD001, rotation -> TDC001)
2. Plug the controller into the stage using a grey USB cord.
3. Plug the controller into the power strip (large power adapter for the linear stage controller, small for the rotation)
4. If using the linear controller, press the enable button on the controller and ensure the enable light is lit

To initialize:

    % linear stage
    s = APT.getstage('linear');
    s.home();
    
    % or

    % rotation stage
    s = APT.getstage('rotation');

    % or

    % vertical stage
    s = APT.getstage('vertical')
    s.home()

## Usage

To move the stage use, `move_rel` or `move_abs` for relative and absolute moves,
respectively

    s.move_abs(10);
    s.move_rel(10);
    
position can be read using

    p = s.position;
    
velocity can be read and set using the `velocity` parameter:

    v = s.velocity;
    s.velocity = 20;

All units are either in millimeters or degrees.

### Advanced usage

Non-blocking moves are supported. After the move command, `waitmove` must be
called with a long enough timeout:

    s.move_rel(10, 'block', false);
    % some matlab code
    s.waitmove(60)
    
## Troubleshooting

Stage errors can cause the communication to become out of sync, resulting in
lots of error messages. To reset, run

    delete(s);
    
and unplug and re-plug in the stage controller, then reinitialize.
