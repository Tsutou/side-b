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
      'editorsNoteBody':
          'Not every bar with good music is a music bar. This first edition follows the rooms where the system, the selector, and the record shelf shape the night.',
      'mockNotice': 'FICTIONAL EDITION — ALL VENUES AND DETAILS ARE MOCK DATA',
      'lateSection': 'Quiet after ten',
      'lateIntro': 'Low light, careful selections, no need to bring a crowd.',
      'allPlaces': 'THE INDEX',
      'allPlacesBody':
          'Seven fictional addresses for the first SIDE B prototype.',
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
      'heroImageLabel':
          'Original painted illustration of a fictional Tokyo listening bar',
      'detailImageLabel': 'Fictional interior photograph',
      'mockPlaceLabel': 'FICTIONAL PLACE / MOCK DATA',
    },
    'ja': {
      'discover': '見つける',
      'map': '地図',
      'saved': '保存',
      'guide': '東京ミュージックバーガイド',
      'edition': '東京 / 2026年 秋',
      'heroKicker': 'VOL. 01 — 夜の東京',
      'heroTitle': '聴くために、\n訪れたい場所。',
      'heroBody': 'レコードを聴いて、雨宿りして。帰り道に寄りたい7軒。',
      'editorsNote': '編集ノート',
      'editorsNoteBody':
          '音のいい店が、すべてミュージックバーとは限りません。創刊号では、音響と選曲、レコード棚が夜の過ごし方をつくる店を訪ねます。',
      'mockNotice': '架空の特集 — 店舗と掲載情報はすべてモックデータです',
      'lateSection': '22時から静かな店',
      'lateIntro': '照明は暗め、選曲は丁寧。ひとりでも立ち寄れる店。',
      'allPlaces': 'INDEX',
      'allPlacesBody': 'SIDE Bの最初の試作号に掲載した、7つの架空の店。',
      'save': '保存する',
      'unsave': '保存から外す',
      'emptySaved': 'まだ保存した店はありません。',
      'emptySavedBody': '「見つける」で気になる店を保存すると、ここに表示されます。',
      'backToDiscover': 'ガイドを見る',
      'mapTitle': '音を聴きに行く、\n東京の小さな地図。',
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
      'heroImageLabel': '架空の東京のリスニングバーを描いたオリジナルイラスト',
      'detailImageLabel': '架空の店内写真',
      'mockPlaceLabel': '架空の店舗 / モックデータ',
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
