{ lib, stdenv, fetchurl, perl, bdf2psf }:
stdenv.mkDerivation {
  pname = "unifont-psf";
  version = "16.0.01";
  src = fetchurl {
    url = "https://unifoundry.com/pub/unifont/unifont-16.0.01/unifont-16.0.01.tar.gz";
    hash = "sha256-XWGAuM9TI4yDVNQv/EItrGWsa8vijSdka+BYoEXYelA=";
  };
  nativeBuildInputs = [ perl bdf2psf ];

  buildPhase = ''
            # Convert hex to BDF with explicit width specification
            perl src/hex2bdf font/precompiled/unifont_all-16.0.01.hex > unifont_temp.bdf

            # Create sed script file
            cat > font_properties.sed <<'EOF'
    s/FONT -gnu-unifont-medium-r-normal--16-160-75-75-c-80-iso10646-1/FONT -gnu-unifont-Sans Serif-r-normal--16-160-75-75-c-80-iso10646-1/
    s/PIXEL_SIZE 16/PIXEL_SIZE 16\nSPACING "C"\nPOINT_SIZE 160\nRESOLUTION_X 75\nRESOLUTION_Y 75/
    EOF

            sed -f font_properties.sed unifont_temp.bdf > unifont.bdf
            rm unifont_temp.bdf

            # Verify BDF output
            echo "Checking BDF file contents..."
            head -n 20 unifont.bdf

            # Create optimized symbols file
            cat > minimal.symb <<'EOF'
    # ASCII Basic Latin (Essential)
            U+0020  # SPACE
            U+0021  # EXCLAMATION MARK
            U+0022  # QUOTATION MARK
            U+0023  # NUMBER SIGN
            U+0024  # DOLLAR SIGN
            U+0025  # PERCENT SIGN
            U+0026  # AMPERSAND
            U+0027  # APOSTROPHE
            U+0028  # LEFT PARENTHESIS
            U+0029  # RIGHT PARENTHESIS
            U+002A  # ASTERISK
            U+002B  # PLUS SIGN
            U+002C  # COMMA
            U+002D  # HYPHEN-MINUS
            U+002E  # FULL STOP
            U+002F  # SOLIDUS

    # Numbers
            U+0030  # DIGIT ZERO
            U+0031  # DIGIT ONE
            U+0032  # DIGIT TWO
            U+0033  # DIGIT THREE
            U+0034  # DIGIT FOUR
            U+0035  # DIGIT FIVE
            U+0036  # DIGIT SIX
            U+0037  # DIGIT SEVEN
            U+0038  # DIGIT EIGHT
            U+0039  # DIGIT NINE

    # Upper case Latin
            U+0041  # LATIN CAPITAL LETTER A
            U+0042  # LATIN CAPITAL LETTER B
            U+0043  # LATIN CAPITAL LETTER C
            U+0044  # LATIN CAPITAL LETTER D
            U+0045  # LATIN CAPITAL LETTER E
            U+0046  # LATIN CAPITAL LETTER F
            U+0047  # LATIN CAPITAL LETTER G
            U+0048  # LATIN CAPITAL LETTER H
            U+0049  # LATIN CAPITAL LETTER I
            U+004A  # LATIN CAPITAL LETTER J
            U+004B  # LATIN CAPITAL LETTER K
            U+004C  # LATIN CAPITAL LETTER L
            U+004D  # LATIN CAPITAL LETTER M
            U+004E  # LATIN CAPITAL LETTER N
            U+004F  # LATIN CAPITAL LETTER O
            U+0050  # LATIN CAPITAL LETTER P
            U+0051  # LATIN CAPITAL LETTER Q
            U+0052  # LATIN CAPITAL LETTER R
            U+0053  # LATIN CAPITAL LETTER S
            U+0054  # LATIN CAPITAL LETTER T
            U+0055  # LATIN CAPITAL LETTER U
            U+0056  # LATIN CAPITAL LETTER V
            U+0057  # LATIN CAPITAL LETTER W
            U+0058  # LATIN CAPITAL LETTER X
            U+0059  # LATIN CAPITAL LETTER Y
            U+005A  # LATIN CAPITAL LETTER Z

    # Math and Programming Symbols
            U+003A  # COLON
            U+003B  # SEMICOLON
            U+003C  # LESS-THAN SIGN
            U+003D  # EQUALS SIGN
            U+003E  # GREATER-THAN SIGN
            U+003F  # QUESTION MARK
            U+0040  # COMMERCIAL AT

    # Lower case Latin
            U+0061  # LATIN SMALL LETTER A
            U+0062  # LATIN SMALL LETTER B
            U+0063  # LATIN SMALL LETTER C
            U+0064  # LATIN SMALL LETTER D
            U+0065  # LATIN SMALL LETTER E
            U+0066  # LATIN SMALL LETTER F
            U+0067  # LATIN SMALL LETTER G
            U+0068  # LATIN SMALL LETTER H
            U+0069  # LATIN SMALL LETTER I
            U+006A  # LATIN SMALL LETTER J
            U+006B  # LATIN SMALL LETTER K
            U+006C  # LATIN SMALL LETTER L
            U+006D  # LATIN SMALL LETTER M
            U+006E  # LATIN SMALL LETTER N
            U+006F  # LATIN SMALL LETTER O
            U+0070  # LATIN SMALL LETTER P
            U+0071  # LATIN SMALL LETTER Q
            U+0072  # LATIN SMALL LETTER R
            U+0073  # LATIN SMALL LETTER S
            U+0074  # LATIN SMALL LETTER T
            U+0075  # LATIN SMALL LETTER U
            U+0076  # LATIN SMALL LETTER V
            U+0077  # LATIN SMALL LETTER W
            U+0078  # LATIN SMALL LETTER X
            U+0079  # LATIN SMALL LETTER Y
            U+007A  # LATIN SMALL LETTER Z

    # Programming brackets and symbols
            U+005B  # LEFT SQUARE BRACKET [
            U+005C  # REVERSE SOLIDUS \
            U+005D  # RIGHT SQUARE BRACKET ]
            U+005E  # CIRCUMFLEX ACCENT ^
            U+005F  # LOW LINE _
            U+0060  # GRAVE ACCENT `
            U+007B  # LEFT CURLY BRACKET {
            U+007C  # VERTICAL LINE |
            U+007D  # RIGHT CURLY BRACKET }
            U+007E  # TILDE ~

    # Essential Mathematical Symbols
            U+2208  # ELEMENT OF ∈
            U+220B  # CONTAINS AS MEMBER ∋
            U+2200  # FOR ALL ∀
            U+2203  # THERE EXISTS ∃
            U+00AC  # LOGICAL NOT ¬
            U+222A  # UNION ∪
            U+2229  # INTERSECTION ∩
            U+2286  # SUBSET OF OR EQUAL TO ⊆
            U+2287  # SUPERSET OF OR EQUAL TO ⊇
            U+03BB  # GREEK SMALL LETTER LAMBDA λ
            U+2264  # LESS-THAN OR EQUAL TO ≤
            U+2265  # GREATER-THAN OR EQUAL TO ≥

    # Japanese Quotes and Formatting
            U+300C  # LEFT CORNER BRACKET 「
            U+300D  # RIGHT CORNER BRACKET 」
            U+30FB  # KATAKANA MIDDLE DOT ・
            U+2014  # EM DASH —

            U+65E5 # 日 Ni
            U+672C # 本 Hon
            U+3001 # 、Japanese comma (ideographic comma)
            U+3002 # 。Japanese full stop (ideographic full stop)

    # Basic vowels (5)
            U+3042  # A あ
            U+3044  # I い
            U+3046  # U う
            U+3048  # E え
            U+304A  # O お

    # K-row + G variations (10)
            U+304B  # KA か
            U+304D  # KI き
            U+304F  # KU く
            U+3051  # KE け
            U+3053  # KO こ
            U+304C  # GA が
            U+304E  # GI ぎ
            U+3050  # GU ぐ
            U+3052  # GE げ
            U+3054  # GO ご

    # S-row + Z variations (10)
            U+3055  # SA さ
            U+3057  # SHI し
            U+3059  # SU す
            U+305B  # SE せ
            U+305D  # SO そ
            U+3056  # ZA ざ
            U+3058  # JI じ
            U+305A  # ZU ず
            U+305C  # ZE ぜ
            U+305E  # ZO ぞ

    # T-row + D variations (10)
            U+305F  # TA た
            U+3061  # CHI ち
            U+3064  # TSU つ
            U+3066  # TE て
            U+3068  # TO と
            U+3060  # DA だ
            U+3062  # DI ぢ
            U+3065  # DU づ
            U+3067  # DE で
            U+3069  # DO ど

    # N-row (5)
            U+306A  # NA な
            U+306B  # NI に
            U+306C  # NU ぬ
            U+306D  # NE ね
            U+306E  # NO の

    # H-row + B/P variations (15)
            U+306F  # HA は
            U+3072  # HI ひ
            U+3075  # FU ふ
            U+3078  # HE へ
            U+307B  # HO ほ
            U+3070  # BA ば
            U+3073  # BI び
            U+3076  # BU ぶ
            U+3079  # BE べ
            U+307C  # BO ぼ
            U+3071  # PA ぱ
            U+3074  # PI ぴ
            U+3077  # PU ぷ
            U+307A  # PE ぺ
            U+307D  # PO ぽ

    # M-row (5)
            U+307E  # MA ま
            U+307F  # MI み
            U+3080  # MU む
            U+3081  # ME め
            U+3082  # MO も

    # Y-row (3)
            U+3084  # YA や
            U+3086  # YU ゆ
            U+3088  # YO よ

    # R-row (5)
            U+3089  # RA ら
            U+308A  # RI り
            U+308B  # RU る
            U+308C  # RE れ
            U+308D  # RO ろ

    # W-row + N (3)
            U+308F  # WA わ
            U+3092  # WO を
            U+3093  # N ん

    # Basic vowels (5)
            U+30A2  # A ア
            U+30A4  # I イ
            U+30A6  # U ウ
            U+30A8  # E エ
            U+30AA  # O オ

    # K-row + G variations (10)
            U+30AB  # KA カ
            U+30AD  # KI キ
            U+30AF  # KU ク
            U+30B1  # KE ケ
            U+30B3  # KO コ
            U+30AC  # GA ガ
            U+30AE  # GI ギ
            U+30B0  # GU グ
            U+30B2  # GE ゲ
            U+30B4  # GO ゴ

    # S-row + Z variations (10)
            U+30B5  # SA サ
            U+30B7  # SHI シ
            U+30B9  # SU ス
            U+30BB  # SE セ
            U+30BD  # SO ソ
            U+30B6  # ZA ザ
            U+30B8  # JI ジ
            U+30BA  # ZU ズ
            U+30BC  # ZE ゼ
            U+30BE  # ZO ゾ

    # T-row + D variations (10)
            U+30BF  # TA タ
            U+30C1  # CHI チ
            U+30C4  # TSU ツ
            U+30C6  # TE テ
            U+30C8  # TO ト
            U+30C0  # DA ダ
            U+30C2  # DI ヂ
            U+30C5  # DU ヅ
            U+30C7  # DE デ
            U+30C9  # DO ド

    # N-row (5)
            U+30CA  # NA ナ
            U+30CB  # NI ニ
            U+30CC  # NU ヌ
            U+30CD  # NE ネ
            U+30CE  # NO ノ

    # H-row + B/P variations (15)
            U+30CF  # HA ハ
            U+30D2  # HI ヒ
            U+30D5  # FU フ
            U+30D8  # HE ヘ
            U+30DB  # HO ホ
            U+30D0  # BA バ
            U+30D3  # BI ビ
            U+30D6  # BU ブ
            U+30D9  # BE ベ
            U+30DC  # BO ボ
            U+30D1  # PA パ
            U+30D4  # PI ピ
            U+30D7  # PU プ
            U+30DA  # PE ペ
            U+30DD  # PO ポ

    # M-row (5)
            U+30DE  # MA マ
            U+30DF  # MI ミ
            U+30E0  # MU ム
            U+30E1  # ME メ
            U+30E2  # MO モ

    # Y-row (3)
            U+30E4  # YA ヤ
            U+30E6  # YU ユ
            U+30E8  # YO ヨ

    # R-row (5)
            U+30E9  # RA ラ
            U+30EA  # RI リ
            U+30EB  # RU ル
            U+30EC  # RE レ
            U+30ED  # RO ロ

    # W-row + N (3)
            U+30EF  # WA ワ
            U+30F2  # WO ヲ
            U+30F3  # N ン

    EOF

            # Convert to PSF1 format (256 glyphs)
            bdf2psf unifont.bdf /dev/null minimal.symb 256 unifont.psf

            # Final verification
            if [ ! -f unifont.psf ]; then
                echo "Failed to create PSF file"
                exit 1
            fi

            # Compress the final PSF file
            gzip -9 unifont.psf
  '';

  meta = with lib; {
    description = "Unicode font for the Linux console from GNU Unifont";
    homepage = "https://unifoundry.com/unifont/";
    license = licenses.gpl2Plus;
    platforms = platforms.all;
    maintainers = [ ];
  };

  installPhase = ''
    install -Dm644 unifont.psf.gz $out/share/consolefonts/unifont.psf.gz
  '';
}
