{
  config,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    consoleLogLevel = 0;
    extraModulePackages = with config.boot.kernelPackages; [
      zenpower
    ];
    supportedFilesystems = ["ntfs"];
  };
}
