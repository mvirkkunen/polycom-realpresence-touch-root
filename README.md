# Root your Polycom RealPresence Touch

These tablets are obsolete hardware, but physically quite nice. Features
include:

- Bleeding edge Android 4.2.2 operating system
- Plentiful ~0.6GB of RAM
- Massive 8GB internal storage 
- As far as I can tell, no wi-fi, bluetooth, camera, microphone, or other common
  features on tablets. Great for your top secret secure environment!
- Power and networking via PoE (only)

Knowing this, if you still want to play with one and make it do something
besides control a quarterly shareholder meeting, follow these instructions. You
will need a FAT formatted thumbdrive and a MicroUSB cable.

## Howto

Use at your own risk!

1. Clone or download a .zip copy of this repository
2. Copy the `vega` directory to the root directory of a thumbdrive and plug it
   into the tablet
3. Open the Administration tab on the tablet
    * If you don't know the password, you can factory reset the tablet by
      holding down the reset button in one of the holes in the back with a paper
      clip while plugging it in
4. Go to Software Update, enter `/storage/usb0` as the Server Address and tap
   Check for Software Updates
5. The updater should tell you that an update to version `2.2.2.8-1337` is
   available. Tap Download and Install Software (N.b. no software will actually
   be updated)
6. The software update screen pops up and soon informs you that an error
   occurred. Press OK to reboot the device.
7. Plug the tablet into a computer with Android tools installed using a MicroUSB
   cable
8. You can now use `adb shell` to get a root shell and make the tablet do
   something more useful
    * Pro tip: You can start the standard Android launcher by running `am start
      -n com.android.launcher/com.android.launcher2.Launcher`
    * Because so much hardware is missing, some standard apps will not work
      properly, e.g. some tabs in the Settings app will just crash.

Technically you could make the fake update run something else besides just
enabling ADB, modify `package.sh` if you'd like to run something else and then
rerun it to regenerate the update.

## .plcm files

In case somebody is interested, the ".plcm" file format is just simple
obfuscation. They seem to have planned to encrypt their updates, but changed
their mind.

The files are simply the header `PLCM.V1.00` in ASCII (checked by the updater),
followed by 512 bytes of presumably random data (ignored by the updater), and
then the actual file contents (usually a tar archive). Absolutely pointless.
