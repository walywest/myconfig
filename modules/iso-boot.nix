# ISO Boot Entries Module
# This module safely adds GRUB entries for booting ISO files
# Emergency: If system fails to boot, select "NixOS" entry or use rescue mode

{ config, lib, pkgs, ... }:

let
  # Define your ISO files here - modify paths as needed
  isoFiles = {
    ubuntu = {
      name = "Ubuntu 25.04 Desktop";
      path = "/home/dumbledoor/Downloads/ubuntu-25.04-desktop-amd64.iso";
      description = "Ubuntu 25.04 Desktop Live ISO";
    };
    gparted = {
      name = "GParted Live";
      path = "/home/dumbledoor/Downloads/gparted-live-1.7.0-8-amd64.iso";
      description = "GParted Live for partition management";
    };
  };

in {
  # Add ISO entries to GRUB configuration
  boot.loader.grub.extraEntries = lib.mkAfter ''
    # === ISO Boot Entries ===
    # SAFETY: These entries are added AFTER NixOS entries
    # If ISO boot fails, NixOS entries will still be available
    
    menuentry "Ubuntu 25.04 Desktop (ISO)" {
      # Search for the root filesystem containing the ISO
      search --set=root --fs-uuid 6135003a-4f5b-4e90-868b-eef599c6742b
      set isofile="/home/dumbledoor/Downloads/ubuntu-25.04-desktop-amd64.iso"
      
      # Check if ISO file exists before attempting boot
      if [ -f "$isofile" ]; then
        echo "Loading Ubuntu ISO..."
        loopback loop $isofile
        linux (loop)/casper/vmlinuz boot=casper iso-scan/filename=$isofile quiet splash
        initrd (loop)/casper/initrd
      else
        echo "ERROR: ISO file not found at $isofile"
        echo "Press any key to return to menu..."
        read
      fi
    }
    
    menuentry "GParted Live (ISO)" {
      # Search for the root filesystem containing the ISO
      search --set=root --fs-uuid 6135003a-4f5b-4e90-868b-eef599c6742b
      set isofile="/home/dumbledoor/Downloads/gparted-live-1.7.0-8-amd64.iso"
      
      # Check if ISO file exists before attempting boot
      if [ -f "$isofile" ]; then
        echo "Loading GParted Live ISO..."
        loopback loop $isofile
        linux (loop)/live/vmlinuz boot=live union=overlay username=user config components quiet noswap noeject ip= net.ifnames=0 nosplash findiso=$isofile
        initrd (loop)/live/initrd.img
      else
        echo "ERROR: ISO file not found at $isofile"
        echo "Press any key to return to menu..."
        read
      fi
    }
    
    # === Emergency Recovery Options ===
    menuentry "Emergency: Memory Test (memtest86+)" {
      linux16 /boot/memtest86+/memtest.bin
    }
    
    menuentry "Emergency: Boot from USB/CD" {
      # Attempt to boot from removable media
      search --set=root --file /EFI/BOOT/BOOTX64.EFI
      chainloader /EFI/BOOT/BOOTX64.EFI
    }
    
    menuentry "Emergency: UEFI Firmware Setup" {
      fwsetup
    }
  '';

  # Add memtest86+ for memory testing (useful for troubleshooting)
  boot.loader.grub.memtest86.enable = true;

  # Add a systemd service to verify ISO files exist
  systemd.services.iso-boot-check = {
    description = "Verify ISO files for boot entries";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "check-iso-files" ''
        echo "=== ISO Boot Entry Status ==="
        ${lib.concatStringsSep "\n" (
          lib.mapAttrsToList (key: iso: ''
            if [ -f "${iso.path}" ]; then
              echo "✓ ${iso.name}: Available"
              ls -lh "${iso.path}"
            else
              echo "✗ ${iso.name}: MISSING at ${iso.path}"
              echo "  Boot entry will show error message"
            fi
          '') isoFiles
        )}
        echo "=========================="
      '';
    };
  };

  # Add a helpful script for managing ISO boot entries
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "iso-boot-status" ''
      echo "ISO Boot Entry Status:"
      systemctl status iso-boot-check --no-pager -l
    '')
    
    (writeShellScriptBin "iso-boot-help" ''
      echo "ISO Boot Entry Help:"
      echo "==================="
      echo "• Boot entries are added to GRUB menu after NixOS entries"
      echo "• If ISO file is missing, entry will show error and return to menu"
      echo "• Emergency options are available in GRUB menu"
      echo ""
      echo "Available ISOs:"
      echo "  Ubuntu 25.04 Desktop - Full Ubuntu live environment"
      echo "  GParted Live - Partition management and disk utilities"
      echo ""
      echo "Commands:"
      echo "  iso-boot-status  - Check if ISO files are available"
      echo "  nixos-rebuild switch - Apply configuration changes"
      echo ""
      echo "Emergency Recovery:"
      echo "  1. Select 'NixOS' entry from GRUB menu"
      echo "  2. Use 'Emergency: Boot from USB/CD' for external media"
      echo "  3. Use 'Emergency: UEFI Firmware Setup' to access BIOS"
      echo ""
      echo "Partition Resizing with GParted:"
      echo "  1. Boot into GParted Live from GRUB menu"
      echo "  2. Use GParted GUI to resize partitions safely"
      echo "  3. Apply changes and reboot to NixOS"
    '')
  ];
}