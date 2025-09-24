import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The theme of the application - defined colors, text styles and some further ui settings
const Color _primary = Color(0xFF675496);
ThemeData lightTheme = ThemeData(
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return _primary;
      }
      return Colors.transparent;
    }),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Color(0xFFF3F3F3),
    labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: _primary),
  ),
  listTileTheme: const ListTileThemeData(
    textColor: Colors.black,
    contentPadding: EdgeInsets.zero,
    titleTextStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    subtitleTextStyle: TextStyle(fontSize: 10),
  ),

  // textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: )),
  cardTheme: CardTheme(
    surfaceTintColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    color: const Color(0xFFFFF6E4),
    elevation: 0,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFEF7FF),
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  ),

  /*
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: _secondary,
  ),

   */
  // fontFamily: GoogleFonts.roboto().fontFamily,
  // regular: normal, medium: bold,
  textTheme: const TextTheme(
    // title
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.1,
    ),
    // display
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.normal,
      letterSpacing: -0.25,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
    ),
    // headline
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
    ),
    // body
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.4,
    ),
    // label
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
  ),

  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return _primary;
      }
      return null;
    }),
    overlayColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return null;
    }),
    thumbColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return null;
    }),
  ),
  fontFamily: GoogleFonts.roboto().fontFamily,
  //iconTheme: const IconThemeData(size: 20),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        return Color(0xFFFEF7FF);
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        return Color(0xFF675496);
      }),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    ),
  ),
  disabledColor: Colors.grey,
  dividerColor: const Color(0xFFD8D5CD),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFFEF7FF),
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: _primary,
    primary: const Color(0xFF675496),
    onPrimary: const Color(0xFFFFFFFF),
    primaryContainer: const Color(0xFFC8B3FD),
    onPrimaryContainer: const Color(0xFF4E3B7B),
    secondary: const Color(0xFF5D5D72),
    onSecondary: const Color(0xFFFFFFFF),
    secondaryContainer: const Color(0x66E2E0F9),
    onSecondaryContainer: const Color(0xFF444559),

    tertiary: const Color(0xFF7D5260),

    onTertiary: const Color(0xFFFFD8E4),

    onTertiaryContainer: const Color(0xFF7D5260),
    tertiaryContainer: const Color(0xFFFFD8E4),
    error: const Color(0xFFBA1A1A),

    onError: const Color(0xFFFFFFFF),
    errorContainer: const Color(0xFFFFDAD6),
    onErrorContainer: const Color(0xFF7D2B25),
    surface: const Color(0xFFFEF7FF),
    onSurface: const Color(0xFF1D1B20),
    onSurfaceVariant: const Color(0xFF49454E),
    surfaceContainer: const Color(0xFFFFFFFF),
    inverseSurface: const Color(0xFF322F35),
    onInverseSurface: const Color(0xFFF5EFF7),

    inversePrimary: const Color(0xFFD0BCFE),
    outline: const Color(0xFF7A757F),
    outlineVariant: const Color(0xFFCAC4CF),
  ),
);
