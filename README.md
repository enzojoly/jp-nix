# Japanese NixOS TTY
A minimalist NixOS configuration focusing on Japanese half-width katakana support in the Linux virtual terminal console (TTY1-6).

## PSF1 Font Development

This project centers on creating a custom PSF1 (256 glyph) font supporting half-width katakana, plus some basic mathematical, and essential programming characters and ASCII in the (tty) virtual terminal.
The GUI/Xserver environment is kitted out with NotoFonts-CJK and has the fonts easily, specified in configuration.nix, but the tty console features my custom font "showconsolefont". This project is akin to my own personal experimental CJKTTY.


# \[  .hex -> .bdf -> .psf  \] PIPELINE:
## psf1 by design, 256 glyphs, 16 bit bitmap font

1. Starts with unifont tarball, extracting unifont_all-16.0.01.hex (precompiled bitmap font)
2. Convert to BDF (Bitmap Distribution Format) for intermediate processing
3. Transform to PSF1 with 256-glyph limitation for TTY compatibility

The tty is limited to PSF1 format. The project focus is working with minimal processing power and fleshing out an interoperable Nix experience without GUI first of all.
Other options exist for tty. Aside from leaving the tty, these comprise historical solutions for kana on limited hardware. Frame buffers. 512 glyph and beyond. But this would mean ditching the vanilla tty.
Enhanced graphical processing such as frame buffers, xserver, wayland, etc. would be required to display all Kanji, Hiragana, and full-width Katakana - these are 32 bit hex bitmaps, too complex for the 16bit limit of the tty.
Instead, 16 bit hex bitmaps means half-width katakana and basic unicode are the only option, with a limit of 256 total, with no proper rendering for 32-bit Kanji and Hiragana. Therefore, WIP.

## Implementation Details

### Font Processing
- Uses `hex2bdf` for initial conversion
- Applies custom font properties via sed transformation
- Equivalence (katakana.equivalents) non-extensive but covering all half-width characters;
  full width katakana (but sadly not digraphs since one-many mapping of equivalents is not feasible, and diacritics are not granted individual glyphs in half-width katakana as with full width )
i.e
  
U+30D1 パ 32 bit glyph +  ﾟ => U+FF8A U+FF9F  ﾊﾟ 16 bit glyph + 16 bit glyph (however the bdf2psf docs do state that the equivalence is single-glyph -> single-glyph.
My idea was to combine ﾎ (ho) with ﾞ (dakuten) for ボ or with ﾟ (handakuten) for ポ, since no direct and complete single-glyph equivalent exists for half-width, only the core kana and diacritics, no ready-made digraphs.
\[N.B. This one -> many relationship was interesting and it did compile, though it did not render correctly.\]
- minimal.symb + katakana.equivalents created (EOF blocks)
- Final conversion to PSF1 using `bdf2psf`
- Only supports 16-bit bitmap hex characters (32-bit Unicode not supported)

### Current Functionality
- Working half-width katakana display in TTY1-6
- Japanese keyboard locale
- Very basic system configuration focused on TTY usage
- Xmonad vanilla wm, xserver

### Technical Constraints
The PSF1 format's 256-glyph (16 bit bitmap hex only) limitation means we cannot support:
- Full-width katakana (requires 32-bit bitmap)
- Hiragana (requires 32-bit bitmap)
- Kanji (requires 32-bit bitmap)

- Not only are they technologically out-of-bonds, they are numerous in quantity and it is a struggle/impossible to fit these within the 256 limit.

## Configuration Structure
- Custom font derivation in unifont256-psf1.nix
- Minimal system configuration targeting TTY functionality
- Japanese locale and keyboard settings
- XMonad window manager foundation (development in progress)

## Current Development
Primary focus remains on TTY font rendering and basic system functionality. Window management features and GUI experience have been secondary to TTY font tinkering.

_Note: fundamental TTY Japanese text support work is impossible on vanilla tty/ongoing._
_I am considering developing my own 16 bit bitmap glyphs/advancing through technological history to reach full understanding of the appropraite solution._
