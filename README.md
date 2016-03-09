# motion
Motion stage control

## Installation (windows)

Dowload and install http://www.ftdichip.com/Drivers/CDM/CDM%20v2.12.12%20WHQL%20Certified.exe

Download and install the thorlabs apt software

Restart computer

plug in stage(s)

Device Manager-> usb devices ->APT device -> right click -> properties -> advanced -> Select Enable VCP

Do this for both stages.

Unplug and replug in the stages

In device manager they should appear as COM objects

Add imaging_instrumentation/thorlabs_apt to the matlab path

run 

    s = APT.getstage('rotation')
  
or

    s = APT.getstage('linear')
