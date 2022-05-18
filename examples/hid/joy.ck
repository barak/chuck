//-----------------------------------------------------------------------------
// name: joy.ck
// desc: basic joystick/gamepad input
//
// note: select between joysticks by specifying device number;
//       to see a list of devices and their numbers, either...
//       1) view the Device Browser window in miniAudicle (select
//          "Human Interface Devices" in the drop-down menu)
//       OR 2) from the command line:
//          > chuck --probe
//-----------------------------------------------------------------------------

// HID input and HID message
Hid hi;
HidMsg msg;

// which joystick
0 => int device;
// get from command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// open joystick 0, exit on fail
if( !hi.openJoystick( device ) ) me.exit();

<<< "joystick '" + hi.name() + "' ready", "" >>>;

// infinite event loop
while( true )
{
    // wait on HidIn as event
    hi => now;

    // messages received
    while( hi.recv( msg ) )
    {
        // joystick axis motion
        if( msg.isAxisMotion() )
        {
            <<< "joystick axis", msg.which, ":", msg.axisPosition >>>;
        }
        
        // joystick button down
        else if( msg.isButtonDown() )
        {
            <<< "joystick button", msg.which, "down" >>>;
        }
        
        // joystick button up
        else if( msg.isButtonUp() )
        {
            <<< "joystick button", msg.which, "up" >>>;
        }
        
        // joystick hat/POV switch/d-pad motion
        else if( msg.isHatMotion() )
        {
            <<< "joystick hat", msg.which, ":", msg.idata >>>;
        }
    }
}
