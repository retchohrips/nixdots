{inputs, ...}: {
  nix = {
    # Collect garbage
    gc = {
      automatic = true;
      options = "--delete-older-than 1w";
      dates = "weekly";
    };

    # Automatic store optimisation
    optimise = {
      automatic = true;
      dates = ["03:45"];
    };
  };
  # Automatic updates
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # Print build logs
    ];
    dates = "2:00";
    randomizedDelaySec = "45min";
  };
}
