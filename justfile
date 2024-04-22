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
  nh os switch -H {{target_host}}

# Build and switch after boot
boot target_host=hostname:
  nh os boot -H {{target_host}}

# Build and activate, but do not switch (good for testing settings without keeping them)
test target_host=hostname:
  nh os test -H {{target_host}}

check flags="":
  nix flake check {{flags}}

check-trace: (check "--show-trace")

update:
  nh os switch --update

# Add flake.lock and commit
upgit:
  git add flake.lock
  git commit -m "update flake.lock"
  git push

# Collect garbage
clean:
  nh clean all
