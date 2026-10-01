import 'package:flutter/material.dart';
import 'package:side_b/core/design/tokens.dart';

abstract final class SideBTheme {
  static ThemeData light(Locale locale) {
    final isJapanese = locale.languageCode == 'ja';
    final fontFamily = isJapanese ? 'ZenKakuGothicNew' : 'Futura';
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
      tertiary: SideBColors.albumYellow,
      onTertiary: SideBColors.ink,
      tertiaryContainer: const Color(0xFFF6E3A6),
      onTertiaryContainer: SideBColors.ink,
      surface: SideBColors.ivory,
      onSurface: SideBColors.ink,
      onSurfaceVariant: SideBColors.inkSoft,
      surfaceContainerLowest: SideBColors.paper,
      surfaceContainerLow: const Color(0xFFFAF4E5),
      surfaceContainer: SideBColors.paper,
      surfaceContainerHigh: const Color(0xFFEDE4D3),
      surfaceContainerHighest: const Color(0xFFE2D7C4),
      outline: SideBColors.line,
      outlineVariant: const Color(0xFFD8D0C5),
      surfaceTint: SideBColors.vermilion,
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
          height: isJapanese ? 1.05 : .92,
          letterSpacing: isJapanese ? -1 : -2.4,
          color: SideBColors.ink,
        ),
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 38,
          height: isJapanese ? 1.1 : 1.02,
          letterSpacing: isJapanese ? -.4 : -1.2,
          color: SideBColors.ink,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 28,
          height: isJapanese ? 1.18 : 1.08,
          letterSpacing: isJapanese ? -.2 : -.6,
          color: SideBColors.ink,
        ),
        titleLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          height: 1.25,
          fontWeight: FontWeight.w700,
          color: SideBColors.ink,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 17,
          height: 1.55,
          color: SideBColors.ink,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          height: 1.5,
          color: SideBColors.inkSoft,
        ),
        labelLarge: TextStyle(
          fontFamily: fontFamily,
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
        surfaceTintColor: SideBColors.vermilion,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLow,
        surfaceTintColor: colorScheme.surfaceTint,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SideBRadii.large),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surfaceContainerHigh,
        surfaceTintColor: colorScheme.surfaceTint,
        elevation: 6,
        iconColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SideBRadii.extraLarge),
        ),
        titleTextStyle: base.textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: base.textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        actionsPadding: const EdgeInsets.fromLTRB(
          SideBSpacing.lg,
          0,
          SideBSpacing.lg,
          SideBSpacing.md,
        ),
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
                    ? SideBColors.ink
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
                    ? colorScheme.onPrimaryContainer
                    : SideBColors.inkSoft,
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) =>
                states.contains(WidgetState.selected)
                    ? colorScheme.primaryContainer
                    : colorScheme.surfaceContainerLow,
          ),
          side: WidgetStatePropertyAll(
            BorderSide(color: colorScheme.outlineVariant),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SideBRadii.large),
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
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size(0, SideBSizes.tapTarget),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: SideBSpacing.lg,
              vertical: SideBSpacing.sm,
            ),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SideBRadii.large),
            ),
          ),
          textStyle: WidgetStatePropertyAll(base.textTheme.labelLarge),
          animationDuration: SideBMotion.quick,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size(0, SideBSizes.tapTarget),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: SideBSpacing.lg,
              vertical: SideBSpacing.sm,
            ),
          ),
          side: WidgetStatePropertyAll(BorderSide(color: colorScheme.outline)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SideBRadii.large),
            ),
          ),
          textStyle: WidgetStatePropertyAll(base.textTheme.labelLarge),
          animationDuration: SideBMotion.quick,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size(SideBSizes.tapTarget, SideBSizes.tapTarget),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SideBRadii.large),
            ),
          ),
          textStyle: WidgetStatePropertyAll(base.textTheme.labelLarge),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerLow,
        selectedColor: colorScheme.tertiaryContainer,
        checkmarkColor: colorScheme.onTertiaryContainer,
        showCheckmark: true,
        side: BorderSide(color: colorScheme.outlineVariant),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SideBRadii.large),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: SideBSpacing.xs,
          vertical: SideBSpacing.xxs,
        ),
        labelStyle: base.textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        secondaryLabelStyle: base.textTheme.labelLarge?.copyWith(
          color: colorScheme.onTertiaryContainer,
        ),
        pressElevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: base.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SideBRadii.medium),
        ),
      ),
      focusColor: SideBColors.vermilion.withValues(alpha: .15),
    );
  }
}
