{
  programs.btop = {
    enable = true;
    settings = {
      theme_background = false; # Makes btop transparent
      disks_filter = "exclude=/nix/store";
      show_gpu_info = "On";
      swap_disk = false;
      vim_keys = true;
      shown_boxes = "proc cpu mem net gpu0 gpu1";
    };
  };
}
