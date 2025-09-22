# ISO Boot Entry Safety Guide

## What Was Done

1. **Created backup**: `configuration.nix.backup-YYYYMMDD-HHMMSS`
2. **Added module**: `modules/iso-boot.nix` - Declarative ISO boot entries
3. **Updated includes**: Added iso-boot.nix to modules/includes.nix
4. **Added safety features**: Emergency recovery options in GRUB

## Safety Features Implemented

### 1. Boot Order Safety
- ISO entries are added AFTER NixOS entries using `lib.mkAfter`
- NixOS will always be the default boot option
- If ISO boot fails, you can still boot NixOS normally

### 2. Error Handling
- GRUB checks if ISO file exists before attempting boot
- If ISO is missing, shows error message and returns to menu
- No system hang or boot failure

### 3. Emergency Recovery Options
- "Emergency: Boot from USB/CD" - Boot from external media
- "Emergency: UEFI Firmware Setup" - Access BIOS/UEFI
- "Emergency: Memory Test" - Hardware diagnostics
- Standard NixOS entries remain unchanged

### 4. Monitoring
- `iso-boot-check` service verifies ISO files on boot
- `iso-boot-status` command to check ISO availability
- `iso-boot-help` command for guidance

## Emergency Recovery Procedures

### If System Won't Boot
1. **Power on** and wait for GRUB menu
2. **Select "NixOS"** entry (should be first/default)
3. **If NixOS won't boot**: Select "Emergency: Boot from USB/CD"
4. **Last resort**: Select "Emergency: UEFI Firmware Setup"

### If ISO Entry Causes Issues
1. Boot into NixOS normally
2. Remove ISO entry: `sudo nano /etc/nixos/modules/iso-boot.nix`
3. Comment out the problematic menuentry
4. Rebuild: `sudo nixos-rebuild switch`

### Complete Rollback
```bash
# Restore from backup
sudo cp configuration.nix.backup-* configuration.nix

# Remove ISO module from includes
sudo nano modules/includes.nix
# Remove line: ./iso-boot.nix

# Rebuild system
sudo nixos-rebuild switch
```

## Testing the Configuration

### Before Applying
```bash
# Test configuration syntax
sudo nixos-rebuild dry-build

# Check what will change
sudo nixos-rebuild build
```

### After Applying
```bash
# Check ISO status
iso-boot-status

# View GRUB entries (after reboot)
# Look for "Ubuntu 25.04 Desktop (ISO)" in GRUB menu
```

## File Locations

- **Main config**: `configuration.nix`
- **ISO module**: `modules/iso-boot.nix`
- **Includes**: `modules/includes.nix`
- **Backups**: `configuration.nix.backup-*`
- **ISO file**: `/home/dumbledoor/Downloads/ubuntu-25.04-desktop-amd64.iso`

## Commands Added

- `iso-boot-status` - Check ISO file availability
- `iso-boot-help` - Show help information

## Important Notes

1. **ISO file must exist** at the specified path for boot entry to work
2. **Moving/deleting ISO** will cause boot entry to show error (but won't break system)
3. **NixOS entries** are always preserved and available
4. **Emergency options** are always available in GRUB menu
5. **Configuration is declarative** - changes require `nixos-rebuild switch`

## Next Steps

1. Test the configuration: `sudo nixos-rebuild dry-build`
2. Apply if test passes: `sudo nixos-rebuild switch`
3. Reboot and verify GRUB menu shows new entries
4. Test ISO boot entry (optional)