import 'package:flutter/material.dart';
import 'package:side_b/core/design/tokens.dart';

abstract final class SideBTheme {
  static ThemeData light(Locale locale) {
    final fontFamily = locale.languageCode == 'ja' ? 'NotoSansJP' : 'Futura';
    final colorScheme = ColorScheme.fromSeed(
      seedColor: SideBColors.vermilion,
      brightness: Brightness.light,
    ).copyWith(
      primary: SideBColors.vermilion,
      onPrimary: SideBColors.white,
      primaryContainer: const Color(0xFFF3DAD2),
      onPrimaryContainer: SideBColors.ink,
      secondary: SideBColors.midnight,
      onSecondary: SideBColors.white,
      secondaryContainer: const Color(0xFFDDE1EA),
      onSecondaryContainer: SideBColors.ink,
      surface: SideBColors.ivory,
      onSurface: SideBColors.ink,
      surfaceContainer: SideBColors.paper,
      outline: SideBColors.line,
      outlineVariant: const Color(0xFFD8D0C5),
    );
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: SideBColors.ivory,
    );
    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 62,
          height: .92,
          letterSpacing: -2.4,
          color: SideBColors.ink,
        ),
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 38,
          height: 1.02,
          letterSpacing: -1.2,
          color: SideBColors.ink,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 28,
          height: 1.08,
          letterSpacing: -.6,
          color: SideBColors.ink,
        ),
        titleLarge: const TextStyle(
          fontSize: 18,
          height: 1.25,
          fontWeight: FontWeight.w700,
          color: SideBColors.ink,
        ),
        bodyLarge: const TextStyle(
          fontSize: 17,
          height: 1.55,
          color: SideBColors.ink,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          height: 1.5,
          color: SideBColors.inkSoft,
        ),
        labelLarge: const TextStyle(
          fontSize: 12,
          height: 1.2,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
          color: SideBColors.ink,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: SideBColors.line,
        thickness: SideBBorders.hairline,
        space: 1,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: SideBColors.ink,
        foregroundColor: SideBColors.ivory,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: SideBSizes.bottomNavHeight,
        backgroundColor: SideBColors.ink,
        indicatorColor: SideBColors.albumYellow,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color:
                states.contains(WidgetState.selected)
                    ? SideBColors.ivory
                    : SideBColors.warmGray,
            size: 22,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return base.textTheme.labelMedium?.copyWith(
            color:
                states.contains(WidgetState.selected)
                    ? SideBColors.ivory
                    : SideBColors.warmGray,
            fontWeight: FontWeight.w700,
          );
        }),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(0, 48)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: SideBSpacing.sm),
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) =>
                states.contains(WidgetState.selected)
                    ? SideBColors.ivory
                    : SideBColors.inkSoft,
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) =>
                states.contains(WidgetState.selected)
                    ? SideBColors.vermilion
                    : Colors.transparent,
          ),
          side: const WidgetStatePropertyAll(
            BorderSide(color: SideBColors.line),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SideBRadii.medium),
            ),
          ),
          textStyle: WidgetStatePropertyAll(base.textTheme.labelLarge),
        ),
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(
            Size(SideBSizes.tapTarget, SideBSizes.tapTarget),
          ),
        ),
      ),
      focusColor: SideBColors.vermilion.withValues(alpha: .15),
    );
  }
}
