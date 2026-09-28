import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  const AppLocalizations(this.locale);
  final Locale locale;

  static const supportedLocales = [Locale('en'), Locale('ja')];
  static const delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const _values = <String, Map<String, String>>{
    'en': {
      'discover': 'Discover',
      'map': 'Map',
      'saved': 'Saved',
      'guide': 'TOKYO MUSIC BAR GUIDE',
      'edition': 'TOKYO / AUTUMN 2026',
      'heroKicker': 'VOL. 01 — AFTER DARK',
      'heroTitle': 'Places worth\nlistening to.',
      'heroBody': 'Seven rooms for records, rain, and the long way home.',
      'editorsNote': 'EDITOR’S NOTE',
      'mockNotice': 'FICTIONAL EDITION — ALL VENUES AND DETAILS ARE MOCK DATA',
      'lateSection': 'Quiet after ten',
      'lateIntro': 'Low light, careful selections, no need to bring a crowd.',
      'allPlaces': 'THE INDEX',
      'save': 'Save venue',
      'unsave': 'Remove from saved',
      'emptySaved': 'Nothing tucked away yet.',
      'emptySavedBody': 'Save a room from Discover and it will wait here.',
      'backToDiscover': 'Browse the guide',
      'mapTitle': 'A map for\nthe listening city.',
      'mapBody':
          'A spatial preview of this fictional first edition. Live maps and directions arrive with verified place data.',
      'mapComing': 'MAP PREVIEW / NOT LIVE',
      'venueDataNote':
          'This is a fictional venue created for product demonstration. Details are not real-world claims.',
      'sideBNote': 'SIDE B NOTE',
      'hours': 'HOURS',
      'price': 'PRICE',
      'sound': 'SOUND',
      'area': 'AREA',
      'details': 'Open venue details',
      'savedCount': 'SAVED PLACES',
    },
    'ja': {
      'discover': '見つける',
      'map': '地図',
      'saved': '保存',
      'guide': '東京ミュージックバーガイド',
      'edition': '東京 / 2026年 秋',
      'heroKicker': 'VOL. 01 — 夜の東京',
      'heroTitle': '聴くために、\n訪れたい場所。',
      'heroBody': 'レコードと雨、少し遠回りして帰る夜のための7軒。',
      'editorsNote': '編集ノート',
      'mockNotice': '架空の特集 — 店舗と掲載情報はすべてモックデータです',
      'lateSection': '22時から静かな店',
      'lateIntro': '暗い照明、丁寧な選曲。誰かを誘わなくてもいい場所。',
      'allPlaces': 'INDEX',
      'save': '保存する',
      'unsave': '保存から外す',
      'emptySaved': 'まだ、何もありません。',
      'emptySavedBody': 'Discoverで気になる店を保存すると、ここに残ります。',
      'backToDiscover': 'ガイドを見る',
      'mapTitle': '音を聴く街の、\n小さな地図。',
      'mapBody': 'この架空の創刊号に掲載した場所の位置関係です。実在データの検証後に地図と経路案内を接続します。',
      'mapComing': '地図プレビュー / 未接続',
      'venueDataNote': 'この店舗はプロダクト検証用の架空データです。実在店舗についての記述ではありません。',
      'sideBNote': 'SIDE B 編集ノート',
      'hours': '営業時間',
      'price': '予算',
      'sound': '音楽',
      'area': 'エリア',
      'details': '店舗詳細を開く',
      'savedCount': '保存した場所',
    },
  };

  String t(String key) =>
      _values[locale.languageCode]?[key] ?? _values['en']![key]!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture(AppLocalizations(locale));

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
