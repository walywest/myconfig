{pkgs, ...}:
{
	#FIX: libudev seems to be handled by systemd
  	#NOTE: bunch of crap that i needed for the shadps4 emulator to work
    
  # environment.systemPackages = with pkgs; [
	# systemd
	# libudev-zero
	# udev
	#   		alsa-lib
	#   		pulseaudio
	#   		openal
	#   		openssl
	#   		zlib
	# #FIX: we got a warning concerning the SLD2
	#   		SDL2
	#   		jack2
	#   		sndio
	#   		qt6.qtbase
	#   		qt6.qttools
	#   		qt6.qtmultimedia
	#   		vulkan-headers
	#   		vulkan-validation-layers
	#   		libedit
	#   		libevdev
    # ];

}
