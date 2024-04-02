{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf (builtins.elem config.modules.device.cpu.type ["intel"]) {
    hardware.cpu.intel.updateMicrocode = true;
    boot = {
      kernelModules = ["kvm-intel"];
      kernelParams = ["i915.fastboot=1" "enable_gvt=1"];
    };

    environment.systemPackages = with pkgs; [intel-gpu-tools];
  };
}
