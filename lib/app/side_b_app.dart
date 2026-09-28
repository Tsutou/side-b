import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:side_b/app/side_b_shell.dart';
import 'package:side_b/core/design/side_b_theme.dart';
import 'package:side_b/core/localization/app_localizations.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBApp extends StatefulWidget {
  const SideBApp({super.key, this.savedVenues});

  final SavedVenuesController? savedVenues;

  @override
  State<SideBApp> createState() => _SideBAppState();
}

class _SideBAppState extends State<SideBApp> {
  static const _localeKey = 'preferred_locale';

  late final SavedVenuesController _savedVenues;
  Locale _locale = const Locale('ja');

  @override
  void initState() {
    super.initState();
    _savedVenues = widget.savedVenues ?? SavedVenuesController();
    if (widget.savedVenues == null) _savedVenues.load();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final preferences = await SharedPreferences.getInstance();
    final languageCode = preferences.getString(_localeKey);
    if (!mounted || languageCode == null) return;
    setState(() => _locale = Locale(languageCode));
  }

  Future<void> _setLocale(Locale locale) async {
    setState(() => _locale = locale);
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_localeKey, locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIDE B — Tokyo Music Bar Guide',
      theme: SideBTheme.light(_locale),
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: SideBShell(
        savedVenues: _savedVenues,
        locale: _locale,
        onLocaleChanged: _setLocale,
      ),
    );
  }
}
