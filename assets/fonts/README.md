# Offline Horus fonts

Official Google Fonts sources, licensed under SIL Open Font License 1.1. Each family has its upstream OFL text in this directory.

Sources: https://github.com/google/fonts/tree/main/ofl

Cairo, Inter, Outfit, Cinzel and Noto Sans SC variable font sources were instantiated with FontTools at the weights in these filenames; Share Tech Mono and Tajawal use upstream static TTF files. All fonts include the original source glyph repertoire. Arabic glyph U+0627 is present in Cairo/Tajawal; Chinese glyph U+4E2D is present in Noto Sans SC.

Files follow the Google Fonts Flutter asset naming convention. The entire directory is declared as a Flutter asset. Runtime fetching is disabled in lib/main.dart and test/flutter_test_config.dart. No font file existed in the pre-EDIT Git snapshot; these assets support its original font families offline.
