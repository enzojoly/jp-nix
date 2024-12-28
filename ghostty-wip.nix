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
      export ZIG_GLOBAL_CACHE_DIR=$out
      exec 3>&1
      exec 1>/dev/null 2>/dev/null
      bash nix/build-support/fetch-zig-cache.sh
      exec 1>&3 3>&-
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
    rm -rf $ZIG_GLOBAL_CACHE_DIR
    cp -r --reflink=auto ${zigCache} $ZIG_GLOBAL_CACHE_DIR
    chmod u+rwX -R $ZIG_GLOBAL_CACHE_DIR
  '';

  buildPhase = ''
    runHook preBuild

    exec 3>&1
    exec 1>/dev/null 2>/dev/null

    zig build \
      --prefix $out \
      --system-mode \
      -Doptimize=${optimize} \
      -Dcpu=baseline \
      -Dapp-runtime=gtk \
      $zigBuildFlags \
      --verbose=err

    exec 1>&3 3>&-

    runHook postBuild
  '';

  outputs = ["out" "terminfo" "shell_integration" "vim"];

  postInstall = ''
    terminfo_src=$out/share/terminfo

    mkdir -p "$out/nix-support"

    mkdir -p "$terminfo/share"
    mv "$terminfo_src" "$terminfo/share/terminfo"
    ln -sf "$terminfo/share/terminfo" "$terminfo_src"
    echo "$terminfo" >> "$out/nix-support/propagated-user-env-packages"

    mkdir -p "$shell_integration"
    mv "$out/share/ghostty/shell-integration" "$shell_integration/shell-integration"
    ln -sf "$shell_integration/shell-integration" "$out/share/ghostty/shell-integration"
    echo "$shell_integration" >> "$out/nix-support/propagated-user-env-packages"

    mv $out/share/vim/vimfiles "$vim"
    ln -sf "$vim" "$out/share/vim/vimfiles"
    echo "$vim" >> "$out/nix-support/propagated-user-env-packages"

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
