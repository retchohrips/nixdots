{
  pkgs,
  lib,
  config,
  ...
}: {
  config.boot = let
    sys = config.modules.system;
  in {
    consoleLogLevel = lib.mkForce 3;

    # Always use latest kernel
    kernelPackages = lib.mkOverride 500 pkgs.linuxPackages_xanmod_latest;
    extraModulePackages = with config.boot.kernelPackages; [zenpower];

    supportedFilesystems = ["ntfs" "vfat" "ext4" "btrfs"];

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
      };
      efi.canTouchEfiVariables = true;
    };

    kernelParams =
      (lib.optionals sys.boot.enableKernelTweaks [
        # https://en.wikipedia.org/wiki/Kernel_page-table_isolation
        # auto means kernel will automatically decide the pti state
        "pti=auto" # on | off

        # CPU idle behaviour
        #  poll: slightly improve performance at cost of a hotter system (not recommended)
        #  halt: halt is forced to be used for CPU idle
        #  nomwait: Disable mwait for CPU C-states
        "idle=nomwait" # poll | halt | nomwait

        # enable IOMMU for devices used in passthrough
        # and provide better host performance in virtualization
        "iommu=pt"

        # disable usb autosuspend
        "usbcore.autosuspend=-1"

        # disables resume and restores original swap space
        "noresume"

        # allows systemd to set and save the backlight state
        "acpi_backlight=native" # none | vendor | video | native

        # prevent the kernel from blanking plymouth out of the fb
        "fbcon=nodefer"

        # disable the cursor in vt to get a black screen during intermissions
        "vt.global_cursor_default=0"

        # disable displaying of the built-in Linux logo
        "logo.nologo"
      ])
      ++ (lib.optionals sys.boot.silentBoot [
        # tell the kernel to not be verbose
        "quiet"

        # kernel log message level
        "loglevel=3" # 1: sustem is unusable | 3: error condition | 7: very verbose

        # udev log message level
        "udev.log_level=3"

        # lower the udev log level to show only errors or worse
        "rd.udev.log_level=3"

        # disable systemd status messages
        # rd prefix means systemd-udev will be used instead of initrd
        "systemd.show_status=auto"
        "rd.systemd.show_status=auto"
      ])
      ++ [
        "uvcvideo" # let webcam work
      ];
  };
}
