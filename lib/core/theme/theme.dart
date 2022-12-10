import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'theme.g.dart';

/// `AppTheme` is a singleton class that extends `ThemeState`;
@LazySingleton()
class AppTheme = ThemeState with _$AppTheme;

// ignore: public_member_api_docs
abstract class ThemeState with Store {
  /// A variable that is being observed by the MobX store.
  @observable
  ThemeMode mode = ThemeMode.system;

  /// A getter that returns a boolean value. It is a computed value
  /// that returns a different value depending on the value of mode.
  @computed
  bool get isDarkMode => mode == ThemeMode.dark;

  /// A getter that returns a ThemeData object. It is a computed value
  /// that returns a different value depending on the value of isDarkMode.
  @computed
  ThemeData get themeData => _getFonts();

  ThemeData _getFonts() {
    if (isDarkMode) {
      return _darkTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(_lightTheme.textTheme),
      );
    }

    return _lightTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(_lightTheme.textTheme),
    );
  }

  ThemeData get _darkTheme => _lightTheme.copyWith(
        brightness: Brightness.dark,
      );

  ThemeData get _lightTheme => ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        primarySwatch: MaterialColor(
          ColorPalette.primary.color.value,
          {
            50: const Color(0x1a8e5ed4),
            100: const Color(0x1a8e5ed4),
            200: const Color(0x338e5ed4),
            300: const Color(0x4d8e5ed4),
            400: const Color(0x668e5ed4),
            500: Color(ColorPalette.primary.color.value),
            600: const Color(0x998e5ed4),
            700: const Color(0xb38e5ed4),
            800: const Color(0xcc8e5ed4),
            900: const Color(0xe68e5ed4)
          },
        ),
        useMaterial3: true,
        primaryColor: ColorPalette.primary.color,
        scaffoldBackgroundColor: ColorPalette.background.color,
        backgroundColor: ColorPalette.background.color,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ThemeRadius.medium.radius),
              ),
            ),
            overlayColor: MaterialStateProperty.all(
              ColorPalette.primary.color.withOpacity(0.3),
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.all(ThemePadding.small.padding),
            ),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
            foregroundColor: MaterialStateProperty.all(
              ColorPalette.text.color,
            ),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.grey.color),
          ),
          labelStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: ColorPalette.primary.color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeRadius.large.radius),
          ),
          actionTextColor: Colors.white,
        ),
      );

  /// `setTheme` is an action that sets the theme mode to the theme mode passed
  /// in
  /// Args:
  ///   themeMode (ThemeMode): The theme mode you want to set.
  @action
  // ignore: use_setters_to_change_properties
  void setTheme(ThemeMode themeMode) {
    mode = themeMode;
  }
}
