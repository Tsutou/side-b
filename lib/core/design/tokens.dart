import 'package:flutter/material.dart';

abstract final class SideBColors {
  static const ink = Color(0xFF191816);
  static const inkSoft = Color(0xFF34312D);
  static const ivory = Color(0xFFF3ECD9);
  static const paper = Color(0xFFFFF9EA);
  static const vermilion = Color(0xFFB9452C);
  static const albumYellow = Color(0xFFD6A62E);
  static const midnight = Color(0xFF20283A);
  static const oxblood = Color(0xFF6D2D24);
  static const warmGray = Color(0xFF8A8278);
  static const line = Color(0xFFB9B0A3);
  static const moss = Color(0xFF4E5745);
  static const white = Color(0xFFFFFFFF);
}

abstract final class SideBSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
  static const display = 72.0;
}

abstract final class SideBRadii {
  static const small = 2.0;
  static const medium = 8.0;
  static const round = 999.0;
}

abstract final class SideBBorders {
  static const hairline = 1.0;
  static const strong = 2.0;
}

abstract final class SideBShadows {
  static const floating = [
    BoxShadow(color: Color(0x22000000), blurRadius: 24, offset: Offset(0, 8)),
  ];
}

abstract final class SideBMotion {
  static const quick = Duration(milliseconds: 140);
  static const standard = Duration(milliseconds: 240);
}

abstract final class SideBSizes {
  static const contentMaxWidth = 1120.0;
  static const tapTarget = 48.0;
  static const bottomNavHeight = 72.0;
}
