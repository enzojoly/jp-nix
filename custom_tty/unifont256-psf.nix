{ lib, stdenv, fetchurl, perl, bdf2psf }:
stdenv.mkDerivation {
  pname = "unifont256-psf1-16.0.0.1";
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

            # Latin a-zA-Z
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
                    U+2014  # EM DASH —

            # Katakana (16 bit)
        	    U+FF61  # HALFWIDTH IDEOGRAPHIC FULL STOP ｡
        	    U+FF62  # HALFWIDTH LEFT CORNER BRACKET ｢
        	    U+FF63  # HALFWIDTH RIGHT CORNER BRACKET ｣
        	    U+FF64  # HALFWIDTH IDEOGRAPHIC COMMA ､
        	    U+FF65  # HALFWIDTH KATAKANA MIDDLE DOT ･
        	    U+FF71  # HALFWIDTH KATAKANA LETTER A ｱ
        	    U+FF72  # HALFWIDTH KATAKANA LETTER I ｲ
        	    U+FF73  # HALFWIDTH KATAKANA LETTER U ｳ
        	    U+FF74  # HALFWIDTH KATAKANA LETTER E ｴ
        	    U+FF75  # HALFWIDTH KATAKANA LETTER O ｵ
        	    U+FF76  # HALFWIDTH KATAKANA LETTER KA ｶ
        	    U+FF77  # HALFWIDTH KATAKANA LETTER KI ｷ
        	    U+FF78  # HALFWIDTH KATAKANA LETTER KU ｸ
        	    U+FF79  # HALFWIDTH KATAKANA LETTER KE ｹ
        	    U+FF7A  # HALFWIDTH KATAKANA LETTER KO ｺ
        	    U+FF7B  # HALFWIDTH KATAKANA LETTER SA ｻ
        	    U+FF7C  # HALFWIDTH KATAKANA LETTER SI ｼ
        	    U+FF7D  # HALFWIDTH KATAKANA LETTER SU ｽ
        	    U+FF7E  # HALFWIDTH KATAKANA LETTER SE ｾ
        	    U+FF7F  # HALFWIDTH KATAKANA LETTER SO ｿ
        	    U+FF80  # HALFWIDTH KATAKANA LETTER TA ﾀ
        	    U+FF81  # HALFWIDTH KATAKANA LETTER TI ﾁ
        	    U+FF82  # HALFWIDTH KATAKANA LETTER TU ﾂ
        	    U+FF83  # HALFWIDTH KATAKANA LETTER TE ﾃ
        	    U+FF84  # HALFWIDTH KATAKANA LETTER TO ﾄ
        	    U+FF85  # HALFWIDTH KATAKANA LETTER NA ﾅ
        	    U+FF86  # HALFWIDTH KATAKANA LETTER NI ﾆ
        	    U+FF87  # HALFWIDTH KATAKANA LETTER NU ﾇ
        	    U+FF88  # HALFWIDTH KATAKANA LETTER NE ﾈ
        	    U+FF89  # HALFWIDTH KATAKANA LETTER NO ﾉ
        	    U+FF8A  # HALFWIDTH KATAKANA LETTER HA ﾊ
        	    U+FF8B  # HALFWIDTH KATAKANA LETTER HI ﾋ
        	    U+FF8C  # HALFWIDTH KATAKANA LETTER HU ﾌ
        	    U+FF8D  # HALFWIDTH KATAKANA LETTER HE ﾍ
        	    U+FF8E  # HALFWIDTH KATAKANA LETTER HO ﾎ
        	    U+FF8F  # HALFWIDTH KATAKANA LETTER MA ﾏ
        	    U+FF90  # HALFWIDTH KATAKANA LETTER MI ﾐ
        	    U+FF91  # HALFWIDTH KATAKANA LETTER MU ﾑ
        	    U+FF92  # HALFWIDTH KATAKANA LETTER ME ﾒ
        	    U+FF93  # HALFWIDTH KATAKANA LETTER MO ﾓ
        	    U+FF94  # HALFWIDTH KATAKANA LETTER YA ﾔ
        	    U+FF95  # HALFWIDTH KATAKANA LETTER YU ﾕ
        	    U+FF96  # HALFWIDTH KATAKANA LETTER YO ﾖ
        	    U+FF97  # HALFWIDTH KATAKANA LETTER RA ﾗ
        	    U+FF98  # HALFWIDTH KATAKANA LETTER RI ﾘ
        	    U+FF99  # HALFWIDTH KATAKANA LETTER RU ﾙ
        	    U+FF9A  # HALFWIDTH KATAKANA LETTER RE ﾚ
        	    U+FF9B  # HALFWIDTH KATAKANA LETTER RO ﾛ
        	    U+FF9C  # HALFWIDTH KATAKANA LETTER WA ﾜ
        	    U+FF9D  # HALFWIDTH KATAKANA LETTER N  ﾝ
        	    U+FF66  # HALFWIDTH KATAKANA LETTER WO ｦ
        	    U+FF67  # HALFWIDTH KATAKANA LETTER SMALL A ｧ
        	    U+FF68  # HALFWIDTH KATAKANA LETTER SMALL I ｨ
        	    U+FF69  # HALFWIDTH KATAKANA LETTER SMALL U ｩ
        	    U+FF6A  # HALFWIDTH KATAKANA LETTER SMALL E ｪ
        	    U+FF6B  # HALFWIDTH KATAKANA LETTER SMALL O ｫ
        	    U+FF6C  # HALFWIDTH KATAKANA LETTER SMALL YA ｬ
        	    U+FF6D  # HALFWIDTH KATAKANA LETTER SMALL YU ｭ
        	    U+FF6E  # HALFWIDTH KATAKANA LETTER SMALL YO ｮ
        	    U+FF6F  # HALFWIDTH KATAKANA LETTER SMALL TU ｯ
    	    U+FF9E  # HALFWIDTH KATAKANA VOICED SOUND MARK ﾞ
    	    U+FF9F  # HALFWIDTH KATAKANA SEMI-VOICED SOUND MARK ﾟ

            # Hiragana (32bit)
                    U+3042  # A あ
                    U+3044  # I い
                    U+3046  # U う
                    U+3048  # E え
                    U+304A  # O お
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
                    U+306A  # NA な
                    U+306B  # NI に
                    U+306C  # NU ぬ
                    U+306D  # NE ね
                    U+306E  # NO の
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
                    U+307E  # MA ま
      #              U+307F  # MI み
      #             U+3080  # MU む
      #             U+3081  # ME め
      #             U+3082  # MO も
      #             U+3084  # YA や
      #             U+3086  # YU ゆ
      #             U+3088  # YO よ
      #             U+3089  # RA ら
      #             U+308A  # RI り
      #             U+308B  # RU る
      #             U+308C  # RE れ
      #             U+308D  # RO ろ
      #             U+3092  # WO を
      #             U+3093  # N ん

    # Box Drawing (Essential for TUI)
    		U+2500  # BOX DRAWINGS LIGHT HORIZONTAL
    		U+2501  # BOX DRAWINGS HEAVY HORIZONTAL
    		U+2502  # BOX DRAWINGS LIGHT VERTICAL
    		U+2503  # BOX DRAWINGS HEAVY VERTICAL
    		U+2504  # BOX DRAWINGS LIGHT TRIPLE DASH HORIZONTAL
    		U+2505  # BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL
    		U+2506  # BOX DRAWINGS LIGHT TRIPLE DASH VERTICAL
    		U+2507  # BOX DRAWINGS HEAVY TRIPLE DASH VERTICAL
    		U+2508  # BOX DRAWINGS LIGHT QUADRUPLE DASH HORIZONTAL
    		U+2509  # BOX DRAWINGS HEAVY QUADRUPLE DASH HORIZONTAL
    		U+250A  # BOX DRAWINGS LIGHT QUADRUPLE DASH VERTICAL
    		U+250B  # BOX DRAWINGS HEAVY QUADRUPLE DASH VERTICAL
    		U+250C  # BOX DRAWINGS LIGHT DOWN AND RIGHT
    		U+250D  # BOX DRAWINGS DOWN LIGHT AND RIGHT HEAVY
    		U+250E  # BOX DRAWINGS DOWN HEAVY AND RIGHT LIGHT
    		U+250F  # BOX DRAWINGS HEAVY DOWN AND RIGHT
    		U+2510  # BOX DRAWINGS LIGHT DOWN AND LEFT
    		U+2511  # BOX DRAWINGS DOWN LIGHT AND LEFT HEAVY
    		U+2512  # BOX DRAWINGS DOWN HEAVY AND LEFT LIGHT
    		U+2513  # BOX DRAWINGS HEAVY DOWN AND LEFT
    		U+2514  # BOX DRAWINGS LIGHT UP AND RIGHT
    		U+2515  # BOX DRAWINGS UP LIGHT AND RIGHT HEAVY
    		U+2516  # BOX DRAWINGS UP HEAVY AND RIGHT LIGHT
    		U+2517  # BOX DRAWINGS HEAVY UP AND RIGHT
    		U+2518  # BOX DRAWINGS LIGHT UP AND LEFT
    		U+2519  # BOX DRAWINGS UP LIGHT AND LEFT HEAVY
    		U+251A  # BOX DRAWINGS UP HEAVY AND LEFT LIGHT
    		U+251B  # BOX DRAWINGS HEAVY UP AND LEFT
    		U+251C  # BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    		U+251D  # BOX DRAWINGS VERTICAL LIGHT AND RIGHT HEAVY
    EOF

    # Create equivalence file for Katakana
    		cat > katakana.equivalents <<'EOF'
    		U+30A2 U+FF71  # A ア -> ｱ
    		U+30A4 U+FF72  # I イ -> ｲ
    		U+30A6 U+FF73  # U ウ -> ｳ
    		U+30A8 U+FF74  # E エ -> ｴ
    		U+30AA U+FF75  # O オ -> ｵ
    		U+30AB U+FF76  # KA カ -> ｶ
    		U+30AD U+FF77  # KI キ -> ｷ
    		U+30AF U+FF78  # KU ク -> ｸ
    		U+30B1 U+FF79  # KE ケ -> ｹ
    		U+30B3 U+FF7A  # KO コ -> ｺ
    		U+30B5 U+FF7B  # SA サ -> ｻ
    		U+30B7 U+FF7C  # SHI シ -> ｼ
    		U+30B9 U+FF7D  # SU ス -> ｽ
    		U+30BB U+FF7E  # SE セ -> ｾ
    		U+30BD U+FF7F  # SO ソ -> ｿ
    		U+30BF U+FF80  # TA タ -> ﾀ
    		U+30C1 U+FF81  # CHI チ -> ﾁ
    		U+30C4 U+FF82  # TSU ツ -> ﾂ
    		U+30C6 U+FF83  # TE テ -> ﾃ
    		U+30C8 U+FF84  # TO ト -> ﾄ
    		U+30CA U+FF85  # NA ナ -> ﾅ
    		U+30CB U+FF86  # NI ニ -> ﾆ
    		U+30CC U+FF87  # NU ヌ -> ﾇ
    		U+30CD U+FF88  # NE ネ -> ﾈ
    		U+30CE U+FF89  # NO ノ -> ﾉ
    		U+30CF U+FF8A  # HA ハ -> ﾊ
    		U+30D2 U+FF8B  # HI ヒ -> ﾋ
    		U+30D5 U+FF8C  # FU フ -> ﾌ
    		U+30D8 U+FF8D  # HE ヘ -> ﾍ
    		U+30DB U+FF8E  # HO ホ -> ﾎ
    		U+30DE U+FF8F  # MA マ -> ﾏ
    		U+30DF U+FF90  # MI ミ -> ﾐ
    		U+30E0 U+FF91  # MU ム -> ﾑ
    		U+30E1 U+FF92  # ME メ -> ﾒ
    		U+30E2 U+FF93  # MO モ -> ﾓ
    		U+30E4 U+FF94  # YA ヤ -> ﾔ
    		U+30E6 U+FF95  # YU ユ -> ﾕ
    		U+30E8 U+FF96  # YO ヨ -> ﾖ
    		U+30E9 U+FF97  # RA ラ -> ﾗ
    		U+30EA U+FF98  # RI リ -> ﾘ
    		U+30EB U+FF99  # RU ル -> ﾙ
    		U+30EC U+FF9A  # RE レ -> ﾚ
    		U+30ED U+FF9B  # RO ロ -> ﾛ
    		U+30EF U+FF9C  # WA ワ -> ﾜ
    		U+30F3 U+FF9D  # N ン -> ﾝ
    		U+30F2 U+FF66  # WO ヲ -> ｦ

    # Punctuation
    		U+3002 U+FF61  # 。-> ｡ (Full stop/period)
    		U+300C U+FF62  # 「-> ｢ (Left corner bracket)
    		U+300D U+FF63  # 」-> ｣ (Right corner bracket)
    		U+3001 U+FF64  # 、-> ､ (Comma)
    		U+30FB U+FF65  # ・-> ･ (Middle dot)

    # Small Kana
    		U+30A1 U+FF67  # ァ -> ｧ (Small A)
    		U+30A3 U+FF68  # ィ -> ｨ (Small I)
    		U+30A5 U+FF69  # ゥ -> ｩ (Small U)
    		U+30A7 U+FF6A  # ェ -> ｪ (Small E)
    		U+30A9 U+FF6B  # ォ -> ｫ (Small O)
    		U+30E3 U+FF6C  # ャ -> ｬ (Small YA)
    		U+30E5 U+FF6D  # ュ -> ｭ (Small YU)
    		U+30E7 U+FF6E  # ョ -> ｮ (Small YO)
    		U+30C3 U+FF6F  # ッ -> ｯ (Small TSU)

    EOF

                    # Convert to PSF1 format (256 glyphs)
    		bdf2psf unifont.bdf katakana.equivalents minimal.symb 256 unifont.psf

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
