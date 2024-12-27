{ lib
, pkgs
, stdenv
, fetchFromGitHub
, fetchurl
, zig
, pkg-config
, gtk4
, libadwaita
, glib
, libGL
, wrapGAppsHook4
, gsettings-desktop-schemas
, bzip2
, expat
, fontconfig
, freetype
, harfbuzz
, libpng
, oniguruma
, zlib
, libX11
, libXcursor
, libXi
, libXrandr
, git
, gnused
}:

let
  deps = {
    libxev = fetchurl {
      url = "https://github.com/mitchellh/libxev/archive/db6a52bafadf00360e675fefa7926e8e6c0e9931.tar.gz";
      hash = "sha256-4GT5wkfkZnIjNv20yDiWEzHAhbIiwHHJfS7A4u/LoNQ=";
    };
    zig-objc = fetchurl {
      url = "https://github.com/mitchellh/zig-objc/archive/9b8ba849b0f58fe207ecd6ab7c147af55b17556e.tar.gz";
      hash = "sha256-H+HIbh2T23uzrsg9/1/vl9Ir1HCAa2pzeTx6zktJH9Q=";
    };
    zig-js = fetchurl {
      url = "https://github.com/mitchellh/zig-js/archive/d0b8b0a57c52fbc89f9d9fecba75ca29da7dd7d1.tar.gz";
      hash = "sha256-fyNeCVbC9UAaKJY6JhAZlT0A479M/AKYMPIWEZbDWD0=";
    };
    ziglyph = fetchurl {
      url = "https://deps.files.ghostty.org/ziglyph-b89d43d1e3fb01b6074bc1f7fc980324b04d26a5.tar.gz";
      hash = "sha256-cse98+Ft8QUjX+P88yyYfaxJOJGQ9M7Ymw7jFxDz89k=";
    };
    glslang = fetchurl {
      url = "https://github.com/KhronosGroup/glslang/archive/refs/tags/14.2.0.tar.gz";
      hash = "sha256-FKLtu1Ccs+UamlPj9eQ12/WXFgS0uDPmPmB26MCpl7U=";
    };
    spirv-cross = fetchurl {
      url = "https://github.com/KhronosGroup/SPIRV-Cross/archive/476f384eb7d9e48613c45179e502a15ab95b6b49.tar.gz";
      hash = "sha256-tStvz8Ref6abHwahNiwVVHNETizAmZVVaxVsU7pmV+M=";
    };
    zlib = fetchurl {
      url = "https://github.com/madler/zlib/archive/refs/tags/v1.3.1.tar.gz";
      hash = "sha256-F+iIY/NgBnKrSRgvIXKBtvxNPHYr3jYZNeQ2qVIU0Fw=";
    };
    wuffs = fetchurl {
      url = "https://github.com/google/wuffs/archive/refs/tags/v0.4.0-alpha.8.tar.gz";
      hash = "sha256-P3fpKYaiOpZffe2uNDkC43MFntV38Cl2XpHFF50r80Q=";
    };
    utfcpp = fetchurl {
      url = "https://github.com/nemtrif/utfcpp/archive/refs/tags/v4.0.5.tar.gz";
      hash = "sha256-/8ZooxDndgfTk/PBizJxXyI9oerExNbgV5oR345rWc8=";
    };
    sentry-native = fetchurl {
      url = "https://github.com/getsentry/sentry-native/archive/refs/tags/0.7.8.tar.gz";
      hash = "sha256-KsZJfMjWGo0xCT5HrduMmyxFsWsHBbszSoNbZCPDGN8=";
    };
    oniguruma = fetchurl {
      url = "https://github.com/kkos/oniguruma/archive/refs/tags/v6.9.9.tar.gz";
      hash = "sha256-ABqhIC54RI9MC/GkjHblVodrNvFtks4yB+zP1h2Z8qA=";
    };
    breakpad = fetchurl {
      url = "https://github.com/getsentry/breakpad/archive/b99f444ba5f6b98cac261cbb391d8766b34a5918.tar.gz";
      hash = "sha256-bMqYlD0amQdmzvYQd8Ca/1k4Bj/heh7+EijlQSttatk=";
    };
    libpng = fetchurl {
      url = "https://github.com/glennrp/libpng/archive/refs/tags/v1.6.43.tar.gz";
      hash = "sha256-/syVtGzwXo4/yKQUdQ4LparQDYnp/fF16U/wQcrxoDo=";
    };
    harfbuzz = fetchurl {
      url = "https://github.com/harfbuzz/harfbuzz/archive/refs/tags/8.4.0.tar.gz";
      hash = "sha256-nxygiYE7BZRK0c6MfgGCEwJtNdybq0gKIeuHaDg5ZVY=";
    };
    freetype = fetchurl {
      url = "https://github.com/freetype/freetype/archive/refs/tags/VER-2-13-2.tar.gz";
      hash = "sha256-QnIB9dUVFnDQXB9bRb713aHy592XHvVPD+qqf/0quQw=";
    };
    highway = fetchurl {
      url = "https://github.com/google/highway/archive/refs/tags/1.1.0.tar.gz";
      hash = "sha256-NUqLRTm1iOcLmOxwhEJz4/J0EwLEw3e8xOgbPRhm98k=";
    };
    fontconfig = fetchurl {
      url = "https://deps.files.ghostty.org/fontconfig-2.14.2.tar.gz";
      hash = "sha256-O6LdkhWHGKzsXKrxpxYEO1qgVcJ7CB2RSvPMtA3OilU=";
    };
    libxml2 = fetchurl {
      url = "https://github.com/GNOME/libxml2/archive/refs/tags/v2.11.5.tar.gz";
      hash = "sha256-bCgFni4+60K1tLFkieORamNGwQladP7jvGXNxdiaYhU=";
    };
    imgui = fetchurl {
      url = "https://github.com/ocornut/imgui/archive/e391fe2e66eb1c96b1624ae8444dc64c23146ef4.tar.gz";
      hash = "sha256-oF/QHgTPEat4Hig4fGIdLkIPHmBEyOJ6JeYD6pnveGA=";
    };
    mach-glfw = fetchurl {
      url = "https://github.com/mitchellh/mach-glfw/archive/37c2995f31abcf7e8378fba68ddcf4a3faa02de0.tar.gz";
      hash = "sha256-HhXIvWUS8/CHWY4VXPG2ZEo+we8XOn3o5rYJCQ1n8Nk=";
    };
    iterm2-themes = fetchurl {
      url = "https://github.com/mbadolato/iTerm2-Color-Schemes/archive/d6c42066b3045292e0b1154ad84ff22d6863ebf7.tar.gz";
      hash = "sha256-s6us3PkOPmQCtLS9QNPM7BDLt7x+37KbmYF9d4NMD/c=";
    };
    libvaxis = fetchurl {
      url = "https://github.com/rockorager/libvaxis/archive/6d729a2dc3b934818dffe06d2ba3ce02841ed74b.tar.gz";
      hash = "sha256-OCNs6Gl2ruq5dBm4uIxs93hoXw/+n+x1+bIDfQGDx3s=";
    };
    zf = fetchurl {
      url = "https://github.com/natecraddock/zf/archive/ed99ca18b02dda052e20ba467e90b623c04690dd.tar.gz";
      hash = "sha256-/oLryY3VQfjbtQi+UP+n6FJTVA/YxIetjO+6Ovrh6/E=";
    };
    z2d = fetchurl {
      url = "https://github.com/vancluever/z2d/archive/4638bb02a9dc41cc2fb811f092811f6a951c752a.tar.gz";
      hash = "sha256-P0UJ54RO/vVyDa+UkBl+QEOjzoMMEFSOTexQP/uBXfc=";
    };
  };
in
stdenv.mkDerivation rec {
  pname = "ghostty";
  version = "1.0.1";
  src = fetchFromGitHub {
    owner = "ghostty-org";
    repo = "ghostty";
    rev = "v${version}";
    sha256 = "AHI1Z4mfgXkNwQA8xYq4tS0/BARbHL7gQUT41vCxQTM=";
  };

  nativeBuildInputs = [
    zig
    pkg-config
    git
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

  preBuildPhases = [ "setupZigCache" "patchPhase" ];

setupZigCache = ''
    export HOME=$TMPDIR
    export XDG_CACHE_HOME=$TMPDIR/.cache
    mkdir -p $XDG_CACHE_HOME/zig/p

    # Copy all tarballs into place with original filenames
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: path: ''
      cp ${path} $XDG_CACHE_HOME/zig/p/$(basename ${path})
      echo "Copied ${name} to $XDG_CACHE_HOME/zig/p/$(basename ${path})"
    '') deps)}

    # Create local package directories
    cd $PWD
    mkdir -p pkg/{cimgui,fontconfig,freetype,harfbuzz,highway,libpng,macos,oniguruma,opengl,sentry,simdutf,utfcpp,wuffs,zlib,glslang,spirv-cross,apple-sdk}
  '';

  patchPhase = ''
    # Add substituteInPlace to PATH
    export PATH="${pkgs.gnused}/bin:$PATH"

    # Patch main build.zig.zon file
    substituteInPlace build.zig.zon \
      --replace-fail 'https://github.com/mitchellh/libxev/archive/db6a52bafadf00360e675fefa7926e8e6c0e9931.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/db6a52bafadf00360e675fefa7926e8e6c0e9931.tar.gz" \
      --replace-fail 'https://github.com/mitchellh/zig-objc/archive/9b8ba849b0f58fe207ecd6ab7c147af55b17556e.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/9b8ba849b0f58fe207ecd6ab7c147af55b17556e.tar.gz" \
      --replace-fail 'https://github.com/mitchellh/zig-js/archive/d0b8b0a57c52fbc89f9d9fecba75ca29da7dd7d1.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/d0b8b0a57c52fbc89f9d9fecba75ca29da7dd7d1.tar.gz" \
      --replace-fail 'https://deps.files.ghostty.org/ziglyph-b89d43d1e3fb01b6074bc1f7fc980324b04d26a5.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/ziglyph-b89d43d1e3fb01b6074bc1f7fc980324b04d26a5.tar.gz" \
      --replace-fail 'https://github.com/mbadolato/iTerm2-Color-Schemes/archive/d6c42066b3045292e0b1154ad84ff22d6863ebf7.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/d6c42066b3045292e0b1154ad84ff22d6863ebf7.tar.gz" \
      --replace-fail 'https://github.com/KhronosGroup/glslang/archive/refs/tags/14.2.0.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/14.2.0.tar.gz" \
      --replace-fail 'https://github.com/KhronosGroup/SPIRV-Cross/archive/476f384eb7d9e48613c45179e502a15ab95b6b49.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/476f384eb7d9e48613c45179e502a15ab95b6b49.tar.gz" \
      --replace-fail 'https://github.com/madler/zlib/archive/refs/tags/v1.3.1.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/v1.3.1.tar.gz" \
      --replace-fail 'https://github.com/google/wuffs/archive/refs/tags/v0.4.0-alpha.8.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/v0.4.0-alpha.8.tar.gz" \
      --replace-fail 'https://github.com/nemtrif/utfcpp/archive/refs/tags/v4.0.5.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/v4.0.5.tar.gz" \
      --replace-fail 'https://github.com/getsentry/sentry-native/archive/refs/tags/0.7.8.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/0.7.8.tar.gz" \
      --replace-fail 'https://github.com/kkos/oniguruma/archive/refs/tags/v6.9.9.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/v6.9.9.tar.gz" \
      --replace-fail 'https://github.com/getsentry/breakpad/archive/b99f444ba5f6b98cac261cbb391d8766b34a5918.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/b99f444ba5f6b98cac261cbb391d8766b34a5918.tar.gz" \
      --replace-fail 'https://github.com/glennrp/libpng/archive/refs/tags/v1.6.43.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/v1.6.43.tar.gz" \
      --replace-fail 'https://github.com/harfbuzz/harfbuzz/archive/refs/tags/8.4.0.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/8.4.0.tar.gz" \
      --replace-fail 'https://github.com/freetype/freetype/archive/refs/tags/VER-2-13-2.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/VER-2-13-2.tar.gz" \
      --replace-fail 'https://github.com/google/highway/archive/refs/tags/1.1.0.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/1.1.0.tar.gz" \
      --replace-fail 'https://deps.files.ghostty.org/fontconfig-2.14.2.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/fontconfig-2.14.2.tar.gz" \
      --replace-fail 'https://github.com/GNOME/libxml2/archive/refs/tags/v2.11.5.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/v2.11.5.tar.gz" \
      --replace-fail 'https://github.com/ocornut/imgui/archive/e391fe2e66eb1c96b1624ae8444dc64c23146ef4.tar.gz' \
                "file://$XDG_CACHE_HOME/zig/p/e391fe2e66eb1c96b1624ae8444dc64c23146ef4.tar.gz" \
      --replace-fail 'git+https://github.com/rockorager/libvaxis/?ref=main#6d729a2dc3b934818dffe06d2ba3ce02841ed74b' \
                "file://$XDG_CACHE_HOME/zig/p/6d729a2dc3b934818dffe06d2ba3ce02841ed74b.tar.gz" \
      --replace-fail 'git+https://github.com/natecraddock/zf/?ref=main#ed99ca18b02dda052e20ba467e90b623c04690dd' \
                "file://$XDG_CACHE_HOME/zig/p/ed99ca18b02dda052e20ba467e90b623c04690dd.tar.gz" \
      --replace-fail 'git+https://github.com/vancluever/z2d?ref=v0.4.0#4638bb02a9dc41cc2fb811f092811f6a951c752a' \
                "file://$XDG_CACHE_HOME/zig/p/4638bb02a9dc41cc2fb811f092811f6a951c752a.tar.gz"

    # Patch all package build.zig.zon files
    for pkg_dir in pkg/*; do
      if [ -f "$pkg_dir/build.zig.zon" ]; then
        substituteInPlace "$pkg_dir/build.zig.zon" \
          --replace-fail 'https://' "file://$XDG_CACHE_HOME/zig/p/" \
          --replace-fail '.path = "./' '.path = "'
      fi
    done

    # Debug output
    echo "Contents of zig cache directory:"
    ls -la $XDG_CACHE_HOME/zig/p/
  '';

  buildPhase = ''
    zig build -Doptimize=ReleaseFast
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp zig-out/bin/ghostty $out/bin/
  '';

  meta = with lib; {
    description = "A terminal emulator with GPU acceleration";
    homepage = "https://github.com/ghostty-org/ghostty";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [];
  };
}

#TEST
setupZigCache = ''
    export HOME=$TMPDIR
    export XDG_CACHE_HOME=$TMPDIR/.cache
    mkdir -p $XDG_CACHE_HOME/zig/p

    pwd
    echo "=== build.zig.zon content ==="
    cat build.zig.zon
    echo "=== end build.zig.zon content ==="

    ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: path: ''
      cp ${path} $XDG_CACHE_HOME/zig/p/
      echo "Copied ${name}: ${path}"
    '') deps)}
  '';

  buildPhase = ''
    zig build -Doptimize=ReleaseFast
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp zig-out/bin/ghostty $out/bin/
  '';

  meta = with lib; {
    description = "A terminal emulator with GPU acceleration";
    homepage = "https://github.com/ghostty-org/ghostty";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [];
  };


# TEST RESULTS

Running phase: setupZigCache
/build/source
=== build.zig.zon content ===
.{
    .name = "ghostty",
    .version = "1.0.0",
    .paths = .{""},
    .dependencies = .{
        // Zig libs
        .libxev = .{
            .url = "https://github.com/mitchellh/libxev/archive/db6a52bafadf00360e675fefa7926e8e6c0e9931.tar.gz",
            .hash = "12206029de146b685739f69b10a6f08baee86b3d0a5f9a659fa2b2b66c9602078bbf",
        },
        .mach_glfw = .{
            .url = "https://github.com/mitchellh/mach-glfw/archive/37c2995f31abcf7e8378fba68ddcf4a3faa02de0.tar.gz",
            .hash = "12206ed982e709e565d536ce930701a8c07edfd2cfdce428683f3f2a601d37696a62",
            .lazy = true,
        },
        .zig_objc = .{
            .url = "https://github.com/mitchellh/zig-objc/archive/9b8ba849b0f58fe207ecd6ab7c147af55b17556e.tar.gz",
            .hash = "1220e17e64ef0ef561b3e4b9f3a96a2494285f2ec31c097721bf8c8677ec4415c634",
        },
        .zig_js = .{
            .url = "https://github.com/mitchellh/zig-js/archive/d0b8b0a57c52fbc89f9d9fecba75ca29da7dd7d1.tar.gz",
            .hash = "12205a66d423259567764fa0fc60c82be35365c21aeb76c5a7dc99698401f4f6fefc",
        },
        .ziglyph = .{
            .url = "https://deps.files.ghostty.org/ziglyph-b89d43d1e3fb01b6074bc1f7fc980324b04d26a5.tar.gz",
            .hash = "12207831bce7d4abce57b5a98e8f3635811cfefd160bca022eb91fe905d36a02cf25",
        },

        // C libs
        .cimgui = .{ .path = "./pkg/cimgui" },
        .fontconfig = .{ .path = "./pkg/fontconfig" },
        .freetype = .{ .path = "./pkg/freetype" },
        .harfbuzz = .{ .path = "./pkg/harfbuzz" },
        .highway = .{ .path = "./pkg/highway" },
        .libpng = .{ .path = "./pkg/libpng" },
        .macos = .{ .path = "./pkg/macos" },
        .oniguruma = .{ .path = "./pkg/oniguruma" },
        .opengl = .{ .path = "./pkg/opengl" },
        .sentry = .{ .path = "./pkg/sentry" },
        .simdutf = .{ .path = "./pkg/simdutf" },
        .utfcpp = .{ .path = "./pkg/utfcpp" },
        .wuffs = .{ .path = "./pkg/wuffs" },
        .zlib = .{ .path = "./pkg/zlib" },

        // Shader translation
        .glslang = .{ .path = "./pkg/glslang" },
        .spirv_cross = .{ .path = "./pkg/spirv-cross" },

        // Other
        .apple_sdk = .{ .path = "./pkg/apple-sdk" },
        .iterm2_themes = .{
            .url = "https://github.com/mbadolato/iTerm2-Color-Schemes/archive/d6c42066b3045292e0b1154ad84ff22d6863ebf7.tar.gz",
            .hash = "12204358b2848ffd993d3425055bff0a5ba9b1b60bead763a6dea0517965d7290a6c",
        },
        .vaxis = .{
            .url = "git+https://github.com/rockorager/libvaxis/?ref=main#6d729a2dc3b934818dffe06d2ba3ce02841ed74b",
            .hash = "12200df4ebeaed45de26cb2c9f3b6f3746d8013b604e035dae658f86f586c8c91d2f",
        },
        .zf = .{
            .url = "git+https://github.com/natecraddock/zf/?ref=main#ed99ca18b02dda052e20ba467e90b623c04690dd",
            .hash = "1220edc3b8d8bedbb50555947987e5e8e2f93871ca3c8e8d4cc8f1377c15b5dd35e8",
        },
        .z2d = .{
            .url = "git+https://github.com/vancluever/z2d?ref=v0.4.0#4638bb02a9dc41cc2fb811f092811f6a951c752a",
            .hash = "12201f0d542e7541cf492a001d4d0d0155c92f58212fbcb0d224e95edeba06b5416a",
        },
    },
}
=== end build.zig.zon content ===
Copied breakpad: /nix/store/i0630csi2c11h8kwzmkinafh8mh1sxg6-b99f444ba5f6b98cac261cbb391d8766b34a5918.tar.gz
Copied fontconfig: /nix/store/07lshlbhwf358w4bqcdby2kvypvrdzmh-fontconfig-2.14.2.tar.gz
Copied freetype: /nix/store/j82nk0ax2zidkrlbqwx4d2qdn8sy460y-VER-2-13-2.tar.gz
Copied glslang: /nix/store/cv5rsl52v4gmbzklz50gkng48dpnxyw9-14.2.0.tar.gz
Copied harfbuzz: /nix/store/4y2grx5j25fh5myiqmqk6mrhr30w4pkd-8.4.0.tar.gz
Copied highway: /nix/store/928jcf617fr7ljg8gq1cqsm0gr2dbp3i-1.1.0.tar.gz
Copied imgui: /nix/store/5cmgh8gfzc2vklm15734h41i14sdvsah-e391fe2e66eb1c96b1624ae8444dc64c23146ef4.tar.gz
Copied iterm2-themes: /nix/store/31b38abi2vm0ja8qwy2709k9pnqy2zcl-d6c42066b3045292e0b1154ad84ff22d6863ebf7.tar.gz
Copied libpng: /nix/store/2wgnvlxmbx0855d2s8mwsa5gnfpgwzn4-v1.6.43.tar.gz
Copied libvaxis: /nix/store/d6vfql5gj8zjfkmx5ddiv3h9sr2snqq9-6d729a2dc3b934818dffe06d2ba3ce02841ed74b.tar.gz
Copied libxev: /nix/store/4icj2ippdv8l1z035pvj51cdmvbrpw5n-db6a52bafadf00360e675fefa7926e8e6c0e9931.tar.gz
Copied libxml2: /nix/store/3n9ds8d9hq9fajg13gskw5nkg7kmg4yv-v2.11.5.tar.gz
Copied mach-glfw: /nix/store/f8b5542j5bxhigay732fm91i5np5z86a-37c2995f31abcf7e8378fba68ddcf4a3faa02de0.tar.gz
Copied oniguruma: /nix/store/7zqmym10asif0asiz6585hzhszx3s3zx-v6.9.9.tar.gz
Copied sentry-native: /nix/store/l535vwp9iw0hkv2a9p3gbb8yial0if1n-0.7.8.tar.gz
Copied spirv-cross: /nix/store/dml09wp69lml8dwpp6ypbl91whxs5fwj-476f384eb7d9e48613c45179e502a15ab95b6b49.tar.gz
Copied utfcpp: /nix/store/r90arcp220avqykds0k165f7jspwn32d-v4.0.5.tar.gz
Copied wuffs: /nix/store/06qxvgxpl01krhhsbvrwqx9nh8y3vbjr-v0.4.0-alpha.8.tar.gz
Copied z2d: /nix/store/jh8gzla1kpfnyipv5fg57dj93cx53wgb-4638bb02a9dc41cc2fb811f092811f6a951c752a.tar.gz
Copied zf: /nix/store/9f99vhzfkwndfj4igzm104nzgifpiwpc-ed99ca18b02dda052e20ba467e90b623c04690dd.tar.gz
Copied zig-js: /nix/store/a3myjmz0xg6b76ghyfaw2c2pkp6pn9j5-d0b8b0a57c52fbc89f9d9fecba75ca29da7dd7d1.tar.gz
Copied zig-objc: /nix/store/dbfbc84acf6w5zncmn789sgwp9qkypgd-9b8ba849b0f58fe207ecd6ab7c147af55b17556e.tar.gz
Copied ziglyph: /nix/store/a3ka7vxmp4b224gwl8xsxjykkzarhxwa-ziglyph-b89d43d1e3fb01b6074bc1f7fc980324b04d26a5.tar.gz
Copied zlib: /nix/store/m4mk7kn5ahwy3fngpxzmd734d0z1vj3w-v1.3.1.tar.gz
Running phase: buildPhase
