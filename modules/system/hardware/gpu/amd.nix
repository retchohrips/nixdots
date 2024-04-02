{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf (builtins.elem config.modules.device.gpu.type ["amd"]) {
    boot = {
      initrd.kernelModules = ["amdgpu"]; # load amdgpu kernel module as early as initrd
      kernelModules = ["amdgpu"];
    };

    environment.systemPackages = [pkgs.nvtopPackages.amd];

    # enables AMDVLK & OpenCL support
    hardware.opengl = {
      extraPackages = with pkgs; [
        amdvlk

        # mesa
        mesa

        # vulkan
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer
      ];

      extraPackages32 = [pkgs.driversi686Linux.amdvlk];
    };
  };
}
