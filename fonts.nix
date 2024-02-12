{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    inter
    commit-mono

    (stdenv.mkDerivation {
      pname = "symbols-nerd-font";
      version = "3.1.1";
      src = fetchFromGitHub {
        owner = "ryanoasis";
        repo = "nerd-fonts";
        rev = "v3.1.1";
        sha256 = "sha256-M7BNPdS8TF0VIaFRREQyQ3Idj3chw3Ih7J71g+cQ3CU=";
        sparseCheckout = [
          "10-nerd-font-symbols.conf"
          "patched-fonts/NerdFontsSymbolsOnly"
        ];
      };
      dontConfigure = true;
      dontBuild = true;
      installPhase = ''
        runHook preInstall

        fontconfigdir="$out/etc/fonts/conf.d"
        install -d "$fontconfigdir"
        install 10-nerd-font-symbols.conf "$fontconfigdir"

        fontdir="$out/share/fonts/truetype"
        install -d "$fontdir"
        install "patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFont-Regular.ttf" "$fontdir"

        runHook postInstall
      '';
      enableParallelBuilding = true;
    })
  ];
}
