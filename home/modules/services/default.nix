{lib, ...}: let
  inherit (builtins) filter map toString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;
in {
  imports = filter (hasSuffix ".nix") (
    map toString (filter (path: path != ./default.nix) (listFilesRecursive ./.))
  );
}
