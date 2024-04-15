# Build the system config and switch to it when running `just` with no args
default: switch

hostname := `hostname | cut -d "." -f 1`
branch := `git branch --show-current`
commit := `git rev-parse HEAD`

# Build, don't switch
build target_host=hostname flags="":
  nixos-rebuild build --flake .#{{target_host}} {{flags}}

# Build and show trace, but don't swtich
trace target_host=hostname: (build target_host "--show-trace")

# Build and switch
switch target_host=hostname:
  sudo nixos-rebuild switch --flake .#{{target_host}}

check flags="":
  nix flake check {{flags}}

check-trace: (check "--show-trace")

update:
  nix flake update

# Add flake.lock and commit
upgit:
  git add flake.lock
  git commit -m "update flake.lock"
  git push

# Collect garbage
gc:
  nix-collect-garbage -d
  sudo nix-collect-garbage -d
  nix-store --gc
  sudo nix-store --gc
  nix-store --optimise
  sudo nix-store --optimise
