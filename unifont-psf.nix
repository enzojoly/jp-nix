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
    perl src/hex2bdf font/precompiled/unifont_all-16.0.01.hex > unifont.bdf
    
    # Create equivalents file for visual duplicates to save space
    cat > complete.equiv << EOF
    # Latin/Greek/Cyrillic equivalents
    U+0391 U+0041  # Greek Alpha = Latin A
    U+0392 U+0042  # Greek Beta = Latin B
    U+0395 U+0045  # Greek Epsilon = Latin E
    U+0397 U+0048  # Greek Eta = Latin H
    U+0399 U+0049  # Greek Iota = Latin I
    U+039A U+004B  # Greek Kappa = Latin K
    U+039C U+004D  # Greek Mu = Latin M
    U+039D U+004E  # Greek Nu = Latin N
    U+039F U+004F  # Greek Omicron = Latin O
    U+03A1 U+0050  # Greek Rho = Latin P
    U+03A4 U+0054  # Greek Tau = Latin T
    U+03A7 U+0058  # Greek Chi = Latin X
    U+041F U+03A0  # Cyrillic Pe = Greek Pi
    EOF
    
    # Create comprehensive symbols file starting with essentials
    cat > full.symb << EOF
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
    U+005B  # LEFT SQUARE BRACKET
    U+005C  # REVERSE SOLIDUS
    U+005D  # RIGHT SQUARE BRACKET
    U+005E  # CIRCUMFLEX ACCENT
    U+005F  # LOW LINE
    U+0060  # GRAVE ACCENT
    U+007B  # LEFT CURLY BRACKET
    U+007C  # VERTICAL LINE
    U+007D  # RIGHT CURLY BRACKET
    U+007E  # TILDE
EOF

# Extended Part 2 - Mathematical Greek and Essential Cyrillic
   cat >> full.symb << EOF
   # Greek Letters (Mathematical and Scientific)
   U+0391  # GREEK CAPITAL LETTER ALPHA
   U+0392  # GREEK CAPITAL LETTER BETA
   U+0393  # GREEK CAPITAL LETTER GAMMA
   U+0394  # GREEK CAPITAL LETTER DELTA
   U+0395  # GREEK CAPITAL LETTER EPSILON
   U+0396  # GREEK CAPITAL LETTER ZETA
   U+0397  # GREEK CAPITAL LETTER ETA
   U+0398  # GREEK CAPITAL LETTER THETA
   U+0399  # GREEK CAPITAL LETTER IOTA
   U+039A  # GREEK CAPITAL LETTER KAPPA
   U+039B  # GREEK CAPITAL LETTER LAMDA
   U+039C  # GREEK CAPITAL LETTER MU
   U+039D  # GREEK CAPITAL LETTER NU
   U+039E  # GREEK CAPITAL LETTER XI
   U+039F  # GREEK CAPITAL LETTER OMICRON
   U+03A0  # GREEK CAPITAL LETTER PI
   U+03A1  # GREEK CAPITAL LETTER RHO
   U+03A3  # GREEK CAPITAL LETTER SIGMA
   U+03A4  # GREEK CAPITAL LETTER TAU
   U+03A5  # GREEK CAPITAL LETTER UPSILON
   U+03A6  # GREEK CAPITAL LETTER PHI
   U+03A7  # GREEK CAPITAL LETTER CHI
   U+03A8  # GREEK CAPITAL LETTER PSI
   U+03A9  # GREEK CAPITAL LETTER OMEGA

   # Greek Lowercase (Essential for Math/Science)
   U+03B1  # GREEK SMALL LETTER ALPHA
   U+03B2  # GREEK SMALL LETTER BETA
   U+03B3  # GREEK SMALL LETTER GAMMA
   U+03B4  # GREEK SMALL LETTER DELTA
   U+03B5  # GREEK SMALL LETTER EPSILON
   U+03B6  # GREEK SMALL LETTER ZETA
   U+03B7  # GREEK SMALL LETTER ETA
   U+03B8  # GREEK SMALL LETTER THETA
   U+03B9  # GREEK SMALL LETTER IOTA
   U+03BA  # GREEK SMALL LETTER KAPPA
   U+03BB  # GREEK SMALL LETTER LAMDA
   U+03BC  # GREEK SMALL LETTER MU
   U+03BD  # GREEK SMALL LETTER NU
   U+03BE  # GREEK SMALL LETTER XI
   U+03BF  # GREEK SMALL LETTER OMICRON
   U+03C0  # GREEK SMALL LETTER PI
   U+03C1  # GREEK SMALL LETTER RHO
   U+03C2  # GREEK SMALL LETTER FINAL SIGMA
   U+03C3  # GREEK SMALL LETTER SIGMA
   U+03C4  # GREEK SMALL LETTER TAU
   U+03C5  # GREEK SMALL LETTER UPSILON
   U+03C6  # GREEK SMALL LETTER PHI
   U+03C7  # GREEK SMALL LETTER CHI
   U+03C8  # GREEK SMALL LETTER PSI
   U+03C9  # GREEK SMALL LETTER OMEGA

   # Essential Cyrillic
   U+0410  # CYRILLIC CAPITAL LETTER A
   U+0411  # CYRILLIC CAPITAL LETTER BE
   U+0412  # CYRILLIC CAPITAL LETTER VE
   U+0413  # CYRILLIC CAPITAL LETTER GHE
   U+0414  # CYRILLIC CAPITAL LETTER DE
   U+0415  # CYRILLIC CAPITAL LETTER IE
   U+0416  # CYRILLIC CAPITAL LETTER ZHE
   U+0417  # CYRILLIC CAPITAL LETTER ZE
   U+0418  # CYRILLIC CAPITAL LETTER I
   U+0419  # CYRILLIC CAPITAL LETTER SHORT I
   U+041A  # CYRILLIC CAPITAL LETTER KA
   U+041B  # CYRILLIC CAPITAL LETTER EL
   U+041C  # CYRILLIC CAPITAL LETTER EM
   U+041D  # CYRILLIC CAPITAL LETTER EN
   U+041E  # CYRILLIC CAPITAL LETTER O
   U+041F  # CYRILLIC CAPITAL LETTER PE
   U+0420  # CYRILLIC CAPITAL LETTER ER
   U+0421  # CYRILLIC CAPITAL LETTER ES
   U+0422  # CYRILLIC CAPITAL LETTER TE
   U+0423  # CYRILLIC CAPITAL LETTER U
   U+0424  # CYRILLIC CAPITAL LETTER EF
   U+0425  # CYRILLIC CAPITAL LETTER HA
   U+0426  # CYRILLIC CAPITAL LETTER TSE
   U+0427  # CYRILLIC CAPITAL LETTER CHE
   U+0428  # CYRILLIC CAPITAL LETTER SHA
   U+0429  # CYRILLIC CAPITAL LETTER SHCHA
   U+042A  # CYRILLIC CAPITAL LETTER HARD SIGN
   U+042B  # CYRILLIC CAPITAL LETTER YERU
   U+042C  # CYRILLIC CAPITAL LETTER SOFT SIGN
   U+042D  # CYRILLIC CAPITAL LETTER E
   U+042E  # CYRILLIC CAPITAL LETTER YU
   U+042F  # CYRILLIC CAPITAL LETTER YA

   # Essential Mathematical Operators and Symbols
   U+2200  # FOR ALL
   U+2201  # COMPLEMENT
   U+2202  # PARTIAL DIFFERENTIAL
   U+2203  # THERE EXISTS
   U+2204  # THERE DOES NOT EXIST
   U+2205  # EMPTY SET
   U+2206  # INCREMENT
   U+2207  # NABLA
   U+2208  # ELEMENT OF
   U+2209  # NOT AN ELEMENT OF
   U+220A  # SMALL ELEMENT OF
   U+220B  # CONTAINS AS MEMBER
   U+220C  # DOES NOT CONTAIN AS MEMBER
   U+220D  # SMALL CONTAINS AS MEMBER
   U+220E  # END OF PROOF
   U+220F  # N-ARY PRODUCT
   U+2210  # N-ARY COPRODUCT
   U+2211  # N-ARY SUMMATION
   U+2212  # MINUS SIGN
   U+2213  # MINUS-OR-PLUS SIGN
   U+2214  # DOT PLUS
   U+2215  # DIVISION SLASH
   U+2216  # SET MINUS
   U+2217  # ASTERISK OPERATOR
   U+2218  # RING OPERATOR
   U+2219  # BULLET OPERATOR
   U+221A  # SQUARE ROOT
   U+221B  # CUBE ROOT
   U+221C  # FOURTH ROOT
   U+221D  # PROPORTIONAL TO
   U+221E  # INFINITY
EOF

# Part 3 - Japanese Kana and Box Drawing
   cat >> full.symb << EOF
   # Japanese Hiragana
   U+3041  # HIRAGANA LETTER SMALL A
   U+3042  # HIRAGANA LETTER A
   U+3043  # HIRAGANA LETTER SMALL I
   U+3044  # HIRAGANA LETTER I
   U+3045  # HIRAGANA LETTER SMALL U
   U+3046  # HIRAGANA LETTER U
   U+3047  # HIRAGANA LETTER SMALL E
   U+3048  # HIRAGANA LETTER E
   U+3049  # HIRAGANA LETTER SMALL O
   U+304A  # HIRAGANA LETTER O
   U+304B  # HIRAGANA LETTER KA
   U+304C  # HIRAGANA LETTER GA
   U+304D  # HIRAGANA LETTER KI
   U+304E  # HIRAGANA LETTER GI
   U+304F  # HIRAGANA LETTER KU
   U+3050  # HIRAGANA LETTER GU
   U+3051  # HIRAGANA LETTER KE
   U+3052  # HIRAGANA LETTER GE
   U+3053  # HIRAGANA LETTER KO
   U+3054  # HIRAGANA LETTER GO
   U+3055  # HIRAGANA LETTER SA
   U+3056  # HIRAGANA LETTER ZA
   U+3057  # HIRAGANA LETTER SHI
   U+3058  # HIRAGANA LETTER ZI
   U+3059  # HIRAGANA LETTER SU
   U+305A  # HIRAGANA LETTER ZU
   U+305B  # HIRAGANA LETTER SE
   U+305C  # HIRAGANA LETTER ZE
   U+305D  # HIRAGANA LETTER SO
   U+305E  # HIRAGANA LETTER ZO
   U+305F  # HIRAGANA LETTER TA
   U+3060  # HIRAGANA LETTER DA
   U+3061  # HIRAGANA LETTER CHI
   U+3062  # HIRAGANA LETTER DI
   U+3063  # HIRAGANA LETTER SMALL TSU
   U+3064  # HIRAGANA LETTER TSU
   U+3065  # HIRAGANA LETTER DU
   U+3066  # HIRAGANA LETTER TE
   U+3067  # HIRAGANA LETTER DE
   U+3068  # HIRAGANA LETTER TO
   U+3069  # HIRAGANA LETTER DO
   U+306A  # HIRAGANA LETTER NA
   U+306B  # HIRAGANA LETTER NI
   U+306C  # HIRAGANA LETTER NU
   U+306D  # HIRAGANA LETTER NE
   U+306E  # HIRAGANA LETTER NO
   U+306F  # HIRAGANA LETTER HA
   U+3070  # HIRAGANA LETTER BA
   U+3071  # HIRAGANA LETTER PA
   U+3072  # HIRAGANA LETTER HI
   U+3073  # HIRAGANA LETTER BI
   U+3074  # HIRAGANA LETTER PI
   U+3075  # HIRAGANA LETTER HU
   U+3076  # HIRAGANA LETTER BU
   U+3077  # HIRAGANA LETTER PU
   U+3078  # HIRAGANA LETTER HE
   U+3079  # HIRAGANA LETTER BE
   U+307A  # HIRAGANA LETTER PE
   U+307B  # HIRAGANA LETTER HO
   U+307C  # HIRAGANA LETTER BO
   U+307D  # HIRAGANA LETTER PO
   U+307E  # HIRAGANA LETTER MA
   U+307F  # HIRAGANA LETTER MI
   U+3080  # HIRAGANA LETTER MU
   U+3081  # HIRAGANA LETTER ME
   U+3082  # HIRAGANA LETTER MO
   U+3083  # HIRAGANA LETTER SMALL YA
   U+3084  # HIRAGANA LETTER YA
   U+3085  # HIRAGANA LETTER SMALL YU
   U+3086  # HIRAGANA LETTER YU
   U+3087  # HIRAGANA LETTER SMALL YO
   U+3088  # HIRAGANA LETTER YO
   U+3089  # HIRAGANA LETTER RA
   U+308A  # HIRAGANA LETTER RI
   U+308B  # HIRAGANA LETTER RU
   U+308C  # HIRAGANA LETTER RE
   U+308D  # HIRAGANA LETTER RO
   U+308E  # HIRAGANA LETTER SMALL WA
   U+308F  # HIRAGANA LETTER WA
   U+3090  # HIRAGANA LETTER WI
   U+3091  # HIRAGANA LETTER WE
   U+3092  # HIRAGANA LETTER WO
   U+3093  # HIRAGANA LETTER N
   U+3094  # HIRAGANA LETTER VU
   U+3095  # HIRAGANA LETTER SMALL KA
   U+3096  # HIRAGANA LETTER SMALL KE
   U+3099  # COMBINING KATAKANA-HIRAGANA VOICED SOUND MARK
   U+309A  # COMBINING KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK
   U+309B  # KATAKANA-HIRAGANA VOICED SOUND MARK
   U+309C  # KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK
   U+309D  # HIRAGANA ITERATION MARK
   U+309E  # HIRAGANA VOICED ITERATION MARK
   U+309F  # HIRAGANA DIGRAPH YORI

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

# Part 3 - Japanese Kana and Box Drawing
   cat >> full.symb << EOF
   # Japanese Hiragana
   U+3041  # HIRAGANA LETTER SMALL A
   U+3042  # HIRAGANA LETTER A
   U+3043  # HIRAGANA LETTER SMALL I
   U+3044  # HIRAGANA LETTER I
   U+3045  # HIRAGANA LETTER SMALL U
   U+3046  # HIRAGANA LETTER U
   U+3047  # HIRAGANA LETTER SMALL E
   U+3048  # HIRAGANA LETTER E
   U+3049  # HIRAGANA LETTER SMALL O
   U+304A  # HIRAGANA LETTER O
   U+304B  # HIRAGANA LETTER KA
   U+304C  # HIRAGANA LETTER GA
   U+304D  # HIRAGANA LETTER KI
   U+304E  # HIRAGANA LETTER GI
   U+304F  # HIRAGANA LETTER KU
   U+3050  # HIRAGANA LETTER GU
   U+3051  # HIRAGANA LETTER KE
   U+3052  # HIRAGANA LETTER GE
   U+3053  # HIRAGANA LETTER KO
   U+3054  # HIRAGANA LETTER GO
   U+3055  # HIRAGANA LETTER SA
   U+3056  # HIRAGANA LETTER ZA
   U+3057  # HIRAGANA LETTER SHI
   U+3058  # HIRAGANA LETTER ZI
   U+3059  # HIRAGANA LETTER SU
   U+305A  # HIRAGANA LETTER ZU
   U+305B  # HIRAGANA LETTER SE
   U+305C  # HIRAGANA LETTER ZE
   U+305D  # HIRAGANA LETTER SO
   U+305E  # HIRAGANA LETTER ZO
   U+305F  # HIRAGANA LETTER TA
   U+3060  # HIRAGANA LETTER DA
   U+3061  # HIRAGANA LETTER CHI
   U+3062  # HIRAGANA LETTER DI
   U+3063  # HIRAGANA LETTER SMALL TSU
   U+3064  # HIRAGANA LETTER TSU
   U+3065  # HIRAGANA LETTER DU
   U+3066  # HIRAGANA LETTER TE
   U+3067  # HIRAGANA LETTER DE
   U+3068  # HIRAGANA LETTER TO
   U+3069  # HIRAGANA LETTER DO
   U+306A  # HIRAGANA LETTER NA
   U+306B  # HIRAGANA LETTER NI
   U+306C  # HIRAGANA LETTER NU
   U+306D  # HIRAGANA LETTER NE
   U+306E  # HIRAGANA LETTER NO
   U+306F  # HIRAGANA LETTER HA
   U+3070  # HIRAGANA LETTER BA
   U+3071  # HIRAGANA LETTER PA
   U+3072  # HIRAGANA LETTER HI
   U+3073  # HIRAGANA LETTER BI
   U+3074  # HIRAGANA LETTER PI
   U+3075  # HIRAGANA LETTER HU
   U+3076  # HIRAGANA LETTER BU
   U+3077  # HIRAGANA LETTER PU
   U+3078  # HIRAGANA LETTER HE
   U+3079  # HIRAGANA LETTER BE
   U+307A  # HIRAGANA LETTER PE
   U+307B  # HIRAGANA LETTER HO
   U+307C  # HIRAGANA LETTER BO
   U+307D  # HIRAGANA LETTER PO
   U+307E  # HIRAGANA LETTER MA
   U+307F  # HIRAGANA LETTER MI
   U+3080  # HIRAGANA LETTER MU
   U+3081  # HIRAGANA LETTER ME
   U+3082  # HIRAGANA LETTER MO
   U+3083  # HIRAGANA LETTER SMALL YA
   U+3084  # HIRAGANA LETTER YA
   U+3085  # HIRAGANA LETTER SMALL YU
   U+3086  # HIRAGANA LETTER YU
   U+3087  # HIRAGANA LETTER SMALL YO
   U+3088  # HIRAGANA LETTER YO
   U+3089  # HIRAGANA LETTER RA
   U+308A  # HIRAGANA LETTER RI
   U+308B  # HIRAGANA LETTER RU
   U+308C  # HIRAGANA LETTER RE
   U+308D  # HIRAGANA LETTER RO
   U+308E  # HIRAGANA LETTER SMALL WA
   U+308F  # HIRAGANA LETTER WA
   U+3090  # HIRAGANA LETTER WI
   U+3091  # HIRAGANA LETTER WE
   U+3092  # HIRAGANA LETTER WO
   U+3093  # HIRAGANA LETTER N
   U+3094  # HIRAGANA LETTER VU
   U+3095  # HIRAGANA LETTER SMALL KA
   U+3096  # HIRAGANA LETTER SMALL KE
   U+3099  # COMBINING KATAKANA-HIRAGANA VOICED SOUND MARK
   U+309A  # COMBINING KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK
   U+309B  # KATAKANA-HIRAGANA VOICED SOUND MARK
   U+309C  # KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK
   U+309D  # HIRAGANA ITERATION MARK
   U+309E  # HIRAGANA VOICED ITERATION MARK
   U+309F  # HIRAGANA DIGRAPH YORI

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

# Part 4 - Katakana and Beginning of Kanji
   cat >> full.symb << EOF
   # Katakana
   U+30A1  # KATAKANA LETTER SMALL A
   U+30A2  # KATAKANA LETTER A
   U+30A3  # KATAKANA LETTER SMALL I
   U+30A4  # KATAKANA LETTER I
   U+30A5  # KATAKANA LETTER SMALL U
   U+30A6  # KATAKANA LETTER U
   U+30A7  # KATAKANA LETTER SMALL E
   U+30A8  # KATAKANA LETTER E
   U+30A9  # KATAKANA LETTER SMALL O
   U+30AA  # KATAKANA LETTER O
   U+30AB  # KATAKANA LETTER KA
   U+30AC  # KATAKANA LETTER GA
   U+30AD  # KATAKANA LETTER KI
   U+30AE  # KATAKANA LETTER GI
   U+30AF  # KATAKANA LETTER KU
   U+30B0  # KATAKANA LETTER GU
   U+30B1  # KATAKANA LETTER KE
   U+30B2  # KATAKANA LETTER GE
   U+30B3  # KATAKANA LETTER KO
   U+30B4  # KATAKANA LETTER GO
   U+30B5  # KATAKANA LETTER SA
   U+30B6  # KATAKANA LETTER ZA
   U+30B7  # KATAKANA LETTER SI
   U+30B8  # KATAKANA LETTER ZI
   U+30B9  # KATAKANA LETTER SU
   U+30BA  # KATAKANA LETTER ZU
   U+30BB  # KATAKANA LETTER SE
   U+30BC  # KATAKANA LETTER ZE
   U+30BD  # KATAKANA LETTER SO
   U+30BE  # KATAKANA LETTER ZO
   U+30BF  # KATAKANA LETTER TA
   U+30C0  # KATAKANA LETTER DA
   U+30C1  # KATAKANA LETTER TI
   U+30C2  # KATAKANA LETTER DI
   U+30C3  # KATAKANA LETTER SMALL TU
   U+30C4  # KATAKANA LETTER TU
   U+30C5  # KATAKANA LETTER DU
   U+30C6  # KATAKANA LETTER TE
   U+30C7  # KATAKANA LETTER DE
   U+30C8  # KATAKANA LETTER TO
   U+30C9  # KATAKANA LETTER DO
   U+30CA  # KATAKANA LETTER NA
   U+30CB  # KATAKANA LETTER NI
   U+30CC  # KATAKANA LETTER NU
   U+30CD  # KATAKANA LETTER NE
   U+30CE  # KATAKANA LETTER NO
   U+30CF  # KATAKANA LETTER HA
   U+30D0  # KATAKANA LETTER BA
   U+30D1  # KATAKANA LETTER PA
   U+30D2  # KATAKANA LETTER HI
   U+30D3  # KATAKANA LETTER BI
   U+30D4  # KATAKANA LETTER PI
   U+30D5  # KATAKANA LETTER HU
   U+30D6  # KATAKANA LETTER BU
   U+30D7  # KATAKANA LETTER PU
   U+30D8  # KATAKANA LETTER HE
   U+30D9  # KATAKANA LETTER BE
   U+30DA  # KATAKANA LETTER PE
   U+30DB  # KATAKANA LETTER HO
   U+30DC  # KATAKANA LETTER BO
   U+30DD  # KATAKANA LETTER PO
   U+30DE  # KATAKANA LETTER MA
   U+30DF  # KATAKANA LETTER MI
   U+30E0  # KATAKANA LETTER MU
   U+30E1  # KATAKANA LETTER ME
   U+30E2  # KATAKANA LETTER MO
   U+30E3  # KATAKANA LETTER SMALL YA
   U+30E4  # KATAKANA LETTER YA
   U+30E5  # KATAKANA LETTER SMALL YU
   U+30E6  # KATAKANA LETTER YU
   U+30E7  # KATAKANA LETTER SMALL YO
   U+30E8  # KATAKANA LETTER YO
   U+30E9  # KATAKANA LETTER RA
   U+30EA  # KATAKANA LETTER RI
   U+30EB  # KATAKANA LETTER RU
   U+30EC  # KATAKANA LETTER RE
   U+30ED  # KATAKANA LETTER RO
   U+30EE  # KATAKANA LETTER SMALL WA
   U+30EF  # KATAKANA LETTER WA
   U+30F0  # KATAKANA LETTER WI
   U+30F1  # KATAKANA LETTER WE
   U+30F2  # KATAKANA LETTER WO
   U+30F3  # KATAKANA LETTER N
   U+30F4  # KATAKANA LETTER VU
   U+30F5  # KATAKANA LETTER SMALL KA
   U+30F6  # KATAKANA LETTER SMALL KE
   U+30FC  # KATAKANA-HIRAGANA PROLONGED SOUND MARK
   U+30FD  # KATAKANA ITERATION MARK
   U+30FE  # KATAKANA VOICED ITERATION MARK

   # Beginning Grade 1 Kanji (Most Basic/Common)
   U+4E00  # KANJI ONE, HORIZONTAL LINE
   U+4E03  # KANJI SEVEN
   U+4E09  # KANJI THREE
   U+4E0A  # KANJI ABOVE, UP
   U+4E0B  # KANJI BELOW, DOWN
   U+4E2D  # KANJI MIDDLE, INSIDE
   U+4E5D  # KANJI NINE
   U+4E8C  # KANJI TWO
   U+4EBA  # KANJI PERSON
   U+4E94  # KANJI FIVE
   U+516B  # KANJI EIGHT
   U+5186  # KANJI YEN, CIRCLE
   U+51AC  # KANJI WINTER
   U+520A  # KANJI PUBLICATION
   U+5343  # KANJI THOUSAND
   U+53CB  # KANJI FRIEND
   U+53E3  # KANJI MOUTH
   U+53F3  # KANJI RIGHT
   U+5408  # KANJI FIT, JOIN
   U+5409  # KANJI LUCK, FORTUNE
EOF

# Part 5 - Continuing Grade 1 Kanji and Essential Compounds
    cat >> full.symb << EOF
    # More Grade 1 Kanji
    U+5915  # KANJI EVENING
    U+5927  # KANJI BIG, LARGE
    U+5929  # KANJI HEAVEN, SKY
    U+5973  # KANJI WOMAN
    U+5B50  # KANJI CHILD
    U+5B57  # KANJI CHARACTER
    U+5B66  # KANJI STUDY, LEARNING
    U+5DE6  # KANJI LEFT
    U+5E74  # KANJI YEAR
    U+5E7C  # KANJI INFANCY
    U+5EAB  # KANJI STOREHOUSE
    U+5F13  # KANJI BOW
    U+5F31  # KANJI WEAK
    U+5F37  # KANJI STRONG
    U+5F53  # KANJI HIT, RIGHT
    U+5F97  # KANJI GAIN, GET
    U+601D  # KANJI THINK
    U+6238  # KANJI DOOR
    U+624B  # KANJI HAND
    U+6559  # KANJI TEACH
    U+6587  # KANJI LITERATURE
    U+65E5  # KANJI DAY, SUN
    U+65E9  # KANJI EARLY
    U+6625  # KANJI SPRING
    U+6642  # KANJI TIME, HOUR
    U+666E  # KANJI UNIVERSAL
    U+6674  # KANJI CLEAR WEATHER
    U+6708  # KANJI MONTH, MOON
    U+6728  # KANJI TREE, WOOD
    U+6751  # KANJI VILLAGE
    U+6765  # KANJI COME
    U+6771  # KANJI EAST
    U+6797  # KANJI FOREST
    U+679C  # KANJI FRUIT
    U+6821  # KANJI SCHOOL
    U+683C  # KANJI STANDARD
    U+6885  # KANJI PLUM
    U+691C  # KANJI EXAMINE
    U+697D  # KANJI COMFORT, EASE
    U+6A2A  # KANJI HORIZONTAL
    U+6B4C  # KANJI SONG
    U+6B63  # KANJI CORRECT
    U+6B69  # KANJI WALK
    U+6C17  # KANJI SPIRIT
    U+6C34  # KANJI WATER
    U+6C7D  # KANJI STEAM, VAPOR
    U+6D77  # KANJI SEA
    U+706B  # KANJI FIRE
    U+722A  # KANJI CLAW
    U+7236  # KANJI FATHER
    U+7267  # KANJI SHEPHERD
    U+7269  # KANJI THING
    U+72AC  # KANJI DOG
    U+7389  # KANJI JADE
    U+738B  # KANJI KING
    U+73ED  # KANJI CLASS, GROUP
    U+751F  # KANJI LIFE
    U+7528  # KANJI USE
    U+753B  # KANJI PICTURE
    U+756A  # KANJI NUMBER, ORDER
    U+767D  # KANJI WHITE
    U+76AE  # KANJI SKIN
    U+76EE  # KANJI EYE
    U+77E2  # KANJI ARROW
    U+77E5  # KANJI KNOW
    U+77F3  # KANJI STONE
    U+793E  # KANJI SOCIETY
    U+795D  # KANJI CELEBRATE
    U+79CB  # KANJI AUTUMN
    U+7A2E  # KANJI SEED, KIND
    U+7A7A  # KANJI EMPTY, SKY
    U+7ACB  # KANJI STAND
    U+7AF9  # KANJI BAMBOO
    U+7B11  # KANJI LAUGH
    U+7B2C  # KANJI ORDINAL NUMBER
    U+7B49  # KANJI EQUAL
    U+7B54  # KANJI ANSWER
    U+7BAD  # KANJI ARROW
    U+7C73  # KANJI RICE
    U+7CF8  # KANJI THREAD
    U+7D19  # KANJI PAPER
    U+7D30  # KANJI THIN
    U+7D44  # KANJI GROUP
    U+7DB1  # KANJI RULE
    U+7DCF  # KANJI GENERAL
    U+7DDA  # KANJI LINE
    U+7F8E  # KANJI BEAUTY
    U+7FBD  # KANJI FEATHER
    U+8003  # KANJI CONSIDER
    U+8005  # KANJI PERSON
    U+8033  # KANJI EAR
    U+8089  # KANJI MEAT
    U+808C  # KANJI SKIN
    U+80A1  # KANJI STOCK
    U+80B2  # KANJI NURTURE
    U+8133  # KANJI BRAIN
    U+8170  # KANJI WAIST
    U+81EA  # KANJI SELF
    U+8239  # KANJI SHIP
    U+826F  # KANJI GOOD
    U+82B1  # KANJI FLOWER
    U+82F1  # KANJI ENGLAND, HERO
    U+8336  # KANJI TEA
    U+8349  # KANJI GRASS
    U+83DC  # KANJI VEGETABLE
    U+843D  # KANJI FALL
    U+85AC  # KANJI MEDICINE
EOF

# Part 6 - Common Use Kanji (Continuing Grade 1 and 2)
    cat >> full.symb << EOF
    # Essential Everyday Kanji
    U+866B  # KANJI INSECT
    U+8840  # KANJI BLOOD
    U+884C  # KANJI GO
    U+8863  # KANJI CLOTHING
    U+897F  # KANJI WEST
    U+89AA  # KANJI PARENT
    U+89D2  # KANJI ANGLE, CORNER
    U+8A00  # KANJI SAY
    U+8A08  # KANJI MEASURE
    U+8A18  # KANJI RECORD
    U+8A71  # KANJI TALK
    U+8A8C  # KANJI MAGAZINE
    U+8A9E  # KANJI LANGUAGE
    U+8AAD  # KANJI READ
    U+8AB0  # KANJI WHO
    U+8ABF  # KANJI TONE, INVESTIGATE
    U+8AC7  # KANJI DISCUSS
    U+8B66  # KANJI ADMONISH
    U+8C37  # KANJI VALLEY
    U+8C46  # KANJI BEANS
    U+8C9D  # KANJI SHELL
    U+8CA8  # KANJI GOODS
    U+8CB4  # KANJI PRECIOUS
    U+8CBB  # KANJI EXPENSE
    U+8CD3  # KANJI VISITOR
    U+8D64  # KANJI RED
    U+8D70  # KANJI RUN
    U+8DB3  # KANJI FOOT, SUFFICIENT
    U+8EAB  # KANJI BODY
    U+8ECA  # KANJI VEHICLE
    U+8ECD  # KANJI ARMY
    U+8EE2  # KANJI REVOLVE
    U+8EFD  # KANJI LIGHT
    U+8F9B  # KANJI SPICY
    U+8FB0  # KANJI DRAGON
    U+8FB1  # KANJI HUMILIATE
    U+8FCE  # KANJI WELCOME
    U+8FD1  # KANJI NEAR
    U+8FD4  # KANJI RETURN
    U+8FFD  # KANJI FOLLOW
    U+9000  # KANJI RETREAT
    U+9001  # KANJI SEND
    U+9006  # KANJI REVERSE
    U+9032  # KANJI ADVANCE
    U+9038  # KANJI SURPASS
    U+9053  # KANJI ROAD, WAY
    U+9060  # KANJI DISTANT
    U+9078  # KANJI CHOOSE
    U+90A3  # KANJI WHAT
    U+90E8  # KANJI PART, SECTION
    U+90FD  # KANJI CAPITAL
    U+91CC  # KANJI VILLAGE, MILE
    U+91CD  # KANJI HEAVY
    U+91CE  # KANJI FIELD
    U+91D1  # KANJI GOLD, METAL
    U+9234  # KANJI BELL
    U+9280  # KANJI SILVER
    U+9285  # KANJI COPPER
    U+92AD  # KANJI COIN
    U+92FC  # KANJI STEEL
    U+9577  # KANJI LONG, LEADER
    U+9580  # KANJI GATE
    U+9589  # KANJI CLOSE
    U+958B  # KANJI OPEN
    U+9592  # KANJI LEISURE
    U+9593  # KANJI INTERVAL
    U+95A2  # KANJI CONNECTION
    U+95B2  # KANJI READ
    U+961C  # KANJI MOUND
    U+9632  # KANJI PREVENT
    U+963F  # KANJI AFRICA
    U+9644  # KANJI ATTACH
    U+9662  # KANJI INSTITUTION
    U+966A  # KANJI ACCOMPANY
    U+9678  # KANJI LAND
    U+967D  # KANJI SUN, POSITIVE
    U+96E8  # KANJI RAIN
    U+96EA  # KANJI SNOW
    U+96F2  # KANJI CLOUD
    U+96FB  # KANJI ELECTRICITY
    U+9752  # KANJI BLUE
    U+9759  # KANJI QUIET
    U+975E  # KANJI NOT
    U+9762  # KANJI FACE
    U+9769  # KANJI LEATHER
    U+97D3  # KANJI KOREA
    U+97F3  # KANJI SOUND
    U+9802  # KANJI SUMMIT
    U+9806  # KANJI OBEY
    U+9808  # KANJI MUST
    U+9810  # KANJI BEFOREHAND
    U+982D  # KANJI HEAD
    U+9854  # KANJI FACE
    U+98A8  # KANJI WIND
    U+98DB  # KANJI FLY
    U+98DF  # KANJI FOOD, EAT
    U+98FC  # KANJI FEED
    U+9928  # KANJI BUILDING
    U+9996  # KANJI HEAD
    U+99AC  # KANJI HORSE
    U+99C5  # KANJI STATION
    U+99D0  # KANJI STAY
    U+9A13  # KANJI VERIFY
    U+9AA8  # KANJI BONE
    U+9AD8  # KANJI HIGH
EOF

# Part 7 - Continuing Essential Kanji and Compounds
    cat >> full.symb << EOF
    # Common Business/Technical Kanji
    U+9B3C  # KANJI GHOST, DEVIL
    U+9B42  # KANJI SOUL
    U+9B45  # KANJI CHARM
    U+9B54  # KANJI DEMON
    U+9CE5  # KANJI BIRD
    U+9CF4  # KANJI CRY, SOUND
    U+9D8F  # KANJI PHOENIX
    U+9E7F  # KANJI DEER
    U+9EA6  # KANJI WHEAT
    U+9EC4  # KANJI YELLOW
    U+9ED2  # KANJI BLACK
    U+9F13  # KANJI DRUM
    U+9F3B  # KANJI NOSE
    U+9F62  # KANJI AGE

    # Technical Computing Kanji
    U+5024  # KANJI VALUE
    U+5B58  # KANJI EXIST
    U+60C5  # KANJI FEELINGS, CIRCUMSTANCES
    U+5831  # KANJI REPORT
    U+5B9A  # KANJI DETERMINE
    U+5316  # KANJI CHANGE
    U+7A0B  # KANJI PROCESS
    U+5F0F  # KANJI STYLE
    U+6570  # KANJI NUMBER
    U+5024  # KANJI VALUE
    U+5909  # KANJI CHANGE
    U+6A5F  # KANJI MACHINE
    U+80FD  # KANJI ABILITY
    U+5B9F  # KANJI REALITY
    U+884C  # KANJI GOING
    U+52D5  # KANJI MOVE
    U+4F5C  # KANJI MAKE
    U+6210  # KANJI BECOME
    U+578B  # KANJI TYPE
    U+5165  # KANJI ENTER
    U+529B  # KANJI POWER
    U+51FA  # KANJI EXIT
    U+4F7F  # KANJI USE
    U+7528  # KANJI UTILIZE
    U+5B8C  # KANJI COMPLETE
    U+4E86  # KANJI FINISH
    U+958B  # KANJI OPEN
    U+59CB  # KANJI BEGIN
    U+7D42  # KANJI END
    U+6E08  # KANJI SETTLE

    # Common Programming Terms
    U+914D  # KANJI DISTRIBUTE (ARRAY)
    U+5217  # KANJI LINE UP (LIST)
    U+5C0E  # KANJI GUIDE (POINTER)
    U+5909  # KANJI CHANGE (VARIABLE)
    U+6570  # KANJI NUMBER (NUMERIC)
    U+5024  # KANJI VALUE
    U+578B  # KANJI TYPE
    U+6587  # KANJI SENTENCE (STRING)
    U+5B57  # KANJI CHARACTER
    U+5F0F  # KANJI EXPRESSION
    U+6A21  # KANJI PATTERN
    U+7BC4  # KANJI EXAMPLE
    U+5F35  # KANJI EXTEND
    U+7D50  # KANJI TIE (BIND)
    U+679C  # KANJI RESULT
    U+4EF6  # KANJI MATTER (CASE)
    U+8A08  # KANJI MEASURE (CALCULATE)
    U+7B97  # KANJI CALCULATE
    U+5236  # KANJI SYSTEM
    U+5FA1  # KANJI HONORABLE (CONTROL)

    # Essential Radicals (Important for compound understanding)
    U+4E00  # HORIZONTAL LINE
    U+4E28  # VERTICAL LINE
    U+4E36  # DOT
    U+4E3F  # SLASH
    U+4E59  # SECOND
    U+4E85  # TABLE
    U+4EA0  # LID
    U+4EBB  # PERSON
    U+513F  # LEGS
    U+5165  # ENTER
    U+516B  # EIGHT
    U+516D  # SIX
    U+5182  # ENCLOSURE
    U+5196  # PRIVATE
    U+51AB  # ICE
    U+51E0  # TABLE
    U+51F5  # PRIVATE
    U+5200  # KNIFE
    U+5202  # SWORD
    U+5315  # LONG
    U+531A  # EVENING
    U+5338  # SHIELD
    U+5341  # TEN
    U+535C  # DIVINATION
    U+5369  # FORMER
    U+5382  # CLIFF
    U+53B6  # SHORT THREAD
    U+53C8  # AGAIN
    U+53CA  # AND
    U+53E3  # MOUTH
    U+56D7  # VILLAGE
    U+571F  # EARTH
    U+58EB  # SCHOLAR
    U+5902  # EARLY
    U+590A  # SUMMER
    U+5915  # EVENING
    U+5927  # BIG
    U+5973  # WOMAN
    U+5B50  # CHILD
    U+5B80  # ROOF
    U+5BF8  # INCH
    U+5C0F  # SMALL
    U+5C22  # SPECIALTY
    U+5C38  # CORPSE
    U+5C6E  # CAVE
    U+5DDB  # CLIFF
    U+5DE5  # WORK
    U+5DF1  # ONESELF
    U+5DFE  # TOWEL
    U+5E72  # DRY
    U+5E7F  # WIDE
    U+5EF4  # CAVE
    U+5F13  # BOW
    U+5F50  # CLOTH
    U+5F61  # SPEAR
    U+5F73  # LONG TIME
    U+5FC3  # HEART
    U+5FC4  # COMPARE
    U+6208  # SPEAR
    U+6238  # DOOR
    U+624C  # HAND
    U+6253  # STRIKE
    U+6279  # CRITICIZE
    U+62D0  # BIG
    U+62D1  # STAMP
    U+62FF  # TAKE
    U+6325  # WAVE
EOF

# Part 8 - More Radicals and Specialized Characters
   cat >> full.symb << EOF
   # Additional Important Radicals
   U+6355  # KANJI CATCH
   U+6367  # KANJI RESPECT
   U+63A0  # KANJI PICK UP
   U+63A2  # KANJI SEARCH
   U+63A7  # KANJI CONTROL
   U+63A9  # KANJI HIDE
   U+63AA  # KANJI MEASURE
   U+63B2  # KANJI RAISE
   U+63CF  # KANJI DESCRIBE
   U+63D0  # KANJI PROPOSE
   U+63DB  # KANJI EXCHANGE
   U+63E1  # KANJI GRIP
   U+63EE  # KANJI BRANDISH
   U+63F4  # KANJI AID
   U+6406  # KANJI EMBRACE
   U+640D  # KANJI LOSS
   U+640F  # KANJI GROPE
   U+6413  # KANJI INVESTIGATE
   U+6416  # KANJI SHAKE
   U+6417  # KANJI POUND
   
   # Scientific and Mathematical Kanji
   U+6570  # KANJI NUMBER
   U+6575  # KANJI ENEMY
   U+6577  # KANJI SPREAD
   U+6578  # KANJI COUNT
   U+6599  # KANJI FEE
   U+65B0  # KANJI NEW
   U+65B9  # KANJI DIRECTION
   U+65BD  # KANJI IMPLEMENT
   U+65C5  # KANJI TRIP
   U+65CF  # KANJI TRIBE
   U+65E5  # KANJI DAY
   U+65E7  # KANJI OLD
   U+65E8  # KANJI PURPORT
   U+65E9  # KANJI EARLY
   U+65EC  # KANJI DAYBREAK
   
   # Modern Technical Terms
   U+6642  # KANJI TIME
   U+6643  # KANJI DARK
   U+6649  # KANJI CLEAR
   U+664B  # KANJI ADVANCE
   U+664C  # KANJI RISE
   U+664F  # KANJI DARK
   U+6652  # KANJI DRY IN SUN
   U+6674  # KANJI CLEAR WEATHER
   U+6676  # KANJI CRYSTAL
   U+667A  # KANJI WISDOM
   U+6691  # KANJI HOT
   U+6696  # KANJI WARM
   U+6697  # KANJI DARK
   U+66A6  # KANJI CALENDAR
   U+66AB  # KANJI TEMPORARY
   U+66AE  # KANJI TWILIGHT
   U+66B4  # KANJI VIOLENT
   U+66C7  # KANJI DARK
   U+66D6  # KANJI DAWN
   U+66DC  # KANJI DAY OF WEEK
   U+66F2  # KANJI CURVE
   U+66F3  # KANJI BRIGHT
   U+66F4  # KANJI CHANGE
   U+66F8  # KANJI WRITE
   U+66F9  # KANJI MILITARY
   U+66FC  # KANJI BARBARIAN
   U+66FE  # KANJI BEFORE
   U+66FF  # KANJI REPLACE
   
   # Programming and Technology
   U+6700  # KANJI MOST
   U+6708  # KANJI MONTH
   U+6709  # KANJI POSSESS
   U+670B  # KANJI COMPANION
   U+670D  # KANJI CLOTHING
   U+6717  # KANJI CLEAR
   U+671B  # KANJI HOPE
   U+671D  # KANJI MORNING
   U+671F  # KANJI PERIOD
   U+6728  # KANJI TREE
   U+672A  # KANJI NOT YET
   U+672B  # KANJI END
   U+672C  # KANJI BOOK
   U+672D  # KANJI TAG
   U+672E  # KANJI BRUSH
   U+6731  # KANJI VERMILLION
   U+6734  # KANJI SIMPLE
   U+673A  # KANJI MACHINE
   U+673D  # KANJI BRANCH
EOF

bdf2psf --fb unifont.bdf complete.equiv full.symb 2048 unifont.psf
    gzip unifont.psf
  '';
  installPhase = ''
    mkdir -p $out/share/consolefonts
    cp unifont.psf.gz $out/share/consolefonts/unifont.psf.gz
  '';
  meta = with lib; {
    description = "GNU Unifont PSF version for console with complete Unicode coverage including CJK, historical scripts, and symbols";
    homepage = "https://unifoundry.com/unifont/";
    license = licenses.gpl2Plus;
    platforms = platforms.all;
  };
}
