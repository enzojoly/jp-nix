{ lib
, stdenv
, bzip2
, expat
, fontconfig
, freetype
, harfbuzz
, libpng
, oniguruma
, zlib
, libGL
, libX11
, libXcursor
, libXi
, libXrandr
, glib
, gtk4
, libadwaita
, wrapGAppsHook4
, gsettings-desktop-schemas
, git
, ncurses
, pkg-config
, zig_0_13
, pandoc
, fetchFromGitHub
, revision ? "dirty"
, optimize ? "ReleaseFast"
}:

let
  zigCacheHash = "sha256-lS5v5VdFCLnIyCq9mp7fd2pXhQmkkDFHHVdg4pf37PA=";

  src = fetchFromGitHub {
    owner = "ghostty-org";
    repo = "ghostty";
    rev = "v1.0.0";
    hash = "sha256-AHI1Z4mfgXkNwQA8xYq4tS0/BARbHL7gQUT41vCxQTM=";
  };

zigCache = stdenv.mkDerivation {
    pname = "ghostty-cache";
    version = "1.0.0";

    inherit src;

    nativeBuildInputs = [ git zig_0_13 ];

    dontConfigure = true;
    dontUseZigBuild = true;
    dontUseZigInstall = true;
    dontFixup = true;

    buildPhase = ''
      # Set cache directory to output
      export ZIG_GLOBAL_CACHE_DIR=$out

      # Redirect output to prevent empty lines
      bash nix/build-support/fetch-zig-cache.sh 2>&1 > /dev/null || exit 1
    '';

    outputHashMode = "recursive";
    outputHash = zigCacheHash;
  };

in stdenv.mkDerivation (finalAttrs: {
  pname = "ghostty";
  version = "1.0.0";

  inherit src;

  nativeBuildInputs = [
    git
    ncurses
    pandoc
    pkg-config
    zig_0_13
    wrapGAppsHook4
  ];

  buildInputs = [
    libGL
    bzip2
    expat
    fontconfig
    freetype
    harfbuzz
    libpng
    oniguruma
    zlib

    libX11
    libXcursor
    libXi
    libXrandr

    libadwaita
    gtk4
    glib
    gsettings-desktop-schemas
  ];

  dontConfigure = true;

  zigBuildFlags = "-Dversion-string=${finalAttrs.version}-${revision}-nix";

  preBuild = ''
    # Clear and setup zig cache
    rm -rf $ZIG_GLOBAL_CACHE_DIR
    cp -r --reflink=auto ${zigCache} $ZIG_GLOBAL_CACHE_DIR
    chmod u+rwX -R $ZIG_GLOBAL_CACHE_DIR
  '';

buildPhase = ''
    runHook preBuild

    # Redirect all output except errors
    zig build \
      --prefix $out \
      --system-mode \
      -Doptimize=${optimize} \
      -Dcpu=baseline \
      -Dapp-runtime=gtk \
      $zigBuildFlags \
      --verbose=err 2>&1 > >(grep -v '^$' >&2)

    runHook postBuild
  '';

  outputs = ["out" "terminfo" "shell_integration" "vim"];

  postInstall = ''
    terminfo_src=$out/share/terminfo

    mkdir -p "$out/nix-support"

    # Setup terminfo
    mkdir -p "$terminfo/share"
    mv "$terminfo_src" "$terminfo/share/terminfo"
    ln -sf "$terminfo/share/terminfo" "$terminfo_src"
    echo "$terminfo" >> "$out/nix-support/propagated-user-env-packages"

    # Setup shell integration
    mkdir -p "$shell_integration"
    mv "$out/share/ghostty/shell-integration" "$shell_integration/shell-integration"
    ln -sf "$shell_integration/shell-integration" "$out/share/ghostty/shell-integration"
    echo "$shell_integration" >> "$out/nix-support/propagated-user-env-packages"

    # Setup vim files
    mv $out/share/vim/vimfiles "$vim"
    ln -sf "$vim" "$out/share/vim/vimfiles"
    echo "$vim" >> "$out/nix-support/propagated-user-env-packages"

    # Install icons and desktop files
    mkdir -p $out/share/applications
    cp dist/linux/app.desktop $out/share/applications/com.mitchellh.ghostty.desktop

    mkdir -p $out/share/icons/hicolor/{16x16,32x32,128x128,256x256,512x512}/apps
    cp images/icons/icon_16.png $out/share/icons/hicolor/16x16/apps/com.mitchellh.ghostty.png
    cp images/icons/icon_32.png $out/share/icons/hicolor/32x32/apps/com.mitchellh.ghostty.png
    cp images/icons/icon_128.png $out/share/icons/hicolor/128x128/apps/com.mitchellh.ghostty.png
    cp images/icons/icon_256.png $out/share/icons/hicolor/256x256/apps/com.mitchellh.ghostty.png
    cp images/icons/icon_512.png $out/share/icons/hicolor/512x512/apps/com.mitchellh.ghostty.png
  '';

  postFixup = ''
    patchelf --add-rpath "${lib.makeLibraryPath [libX11]}" "$out/bin/.ghostty-wrapped"
  '';

  meta = with lib; {
    description = "A fast, feature-rich terminal emulator";
    homepage = "https://github.com/ghostty-org/ghostty";
    license = licenses.mit;
    platforms = ["x86_64-linux" "aarch64-linux"];
    mainProgram = "ghostty";
  };
})
