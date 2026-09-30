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
      'read': 'Read',
      'map': 'Map',
      'saved': 'Saved',
      'guide': 'TOKYO MUSIC BAR GUIDE',
      'edition': 'TOKYO / AUTUMN 2026',
      'heroKicker': 'VOL. 01 — TOKYO AFTER DARK',
      'heroTitle': 'Where will you\nlisten tonight?',
      'heroBody':
          'Choose your next room by its sound, mood, neighborhood, and price.',
      'exploreMap': 'SEE ALL 7 ON THE MAP',
      'editorsNote': 'EDITOR’S NOTE',
      'editorsNoteBody':
          'Good background music is not enough. SIDE B looks for rooms where the system, the selector, and the record shelf give you a reason to go.',
      'mockNotice': 'PROTOTYPE ISSUE — EVERY VENUE AND DETAIL IS FICTIONAL',
      'lateSection': 'After ten, on your own',
      'lateIntro':
          'Three low-lit rooms for careful selections and a quiet drink alone.',
      'allPlaces': 'CHOOSE YOUR NEXT ROOM',
      'allPlacesBody':
          'Compare all seven by sound, neighborhood, and price—then save the ones you want to remember.',
      'save': 'Save venue',
      'unsave': 'Remove from saved',
      'emptySaved': 'No rooms saved yet.',
      'emptySavedBody': 'Save any venue from the guide to keep it here.',
      'backToDiscover': 'Browse all 7',
      'mapTitle': 'Choose your next room\nfrom the map.',
      'mapBody':
          'See how the seven fictional venues in this prototype sit across Tokyo. Verified maps and directions will come with real venue data.',
      'mapComing': 'MAP PREVIEW / FICTIONAL LOCATIONS',
      'mapIndexTitle': '7 ROOMS ON THIS MAP',
      'walkingRangeLabel': 'WITHIN A 20-MINUTE WALK',
      'walkingRangeBody':
          'Start from your current location or choose another point. Only verified walking routes will count.',
      'walkingCurrent': 'USE MY LOCATION',
      'walkingChoose': 'CHOOSE A PLACE',
      'walkingUnavailableTitle': 'Available with the real venue guide',
      'walkingUnavailableBody':
          'These seven venues and their map positions are fictional, so SIDE B will not present estimated walking times as fact. This control will use verified venue coordinates and walking-route durations when the first real edition is published.',
      'walkingUnavailableAction': 'Got it',
      'filterLabel': 'FILTER THE MAP',
      'filterMoodLabel': 'MOOD',
      'filterGenreLabel': 'GENRE',
      'filterAll': 'All',
      'filterQuiet': 'Quiet',
      'filterLate': 'Late night',
      'filterVinyl': 'Vinyl',
      'filterDj': 'DJ',
      'filterJazz': 'Jazz',
      'filterSoul': 'Soul',
      'filterCityPop': 'City pop',
      'filterAmbient': 'Ambient',
      'filterHouse': 'House',
      'filterRock': 'Rock',
      'filterEmpty': 'No rooms match this combination.',
      'mapsArea': 'VIEW THIS AREA IN GOOGLE MAPS',
      'venueDataNote':
          'This venue and every detail on this page are fictional prototype data. They do not describe a real business.',
      'sideBNote': 'WHY SIDE B PICKED IT',
      'hours': 'HOURS',
      'price': 'PRICE',
      'sound': 'SOUND',
      'area': 'AREA',
      'details': 'Open venue details',
      'savedCount': 'SAVED FOR LATER',
      'emptySavedIcon': 'No saved venues',
      'heroImageLabel':
          'Original painted illustration of a fictional Tokyo listening bar',
      'detailImageLabel': 'Fictional interior photograph',
      'mockPlaceLabel': 'FICTIONAL VENUE / PROTOTYPE DATA',
      'readKicker': 'SIDE B READING ROOM / TOKYO + VISITOR',
      'readTitle': 'Read the sound\nof Tokyo.',
      'readBody':
          'Personal walks, owner interviews, and films that reveal how a room finds its sound.',
      'readFeatured': 'START HERE',
      'readShelf': 'FROM THE READING SHELF',
      'readVisitor': 'VISITOR’S VIEW',
      'readVisitorBody':
          'English-language guides and long reads for seeing Tokyo’s listening culture from outside—and finding a way in.',
      'readArticle': 'READ THE ORIGINAL',
      'readDisclosure':
          'Links open the original publishers. SIDE B adds only its own short editorial note; article text and images are not reproduced here.',
      'readError': 'Could not open the article.',
    },
    'ja': {
      'discover': 'ガイド',
      'read': '読む',
      'map': '地図',
      'saved': '保存',
      'guide': '東京ミュージックバーガイド',
      'edition': '東京 / 2026年 秋',
      'heroKicker': 'VOL. 01 — 夜の東京',
      'heroTitle': '今夜、音を聴きに\nどこへ行く？',
      'heroBody': '選曲、店の空気、街、予算から、次の一軒を選べます。',
      'exploreMap': '地図から7軒を見る',
      'editorsNote': '編集ノート',
      'editorsNoteBody':
          'BGMがいいだけの店は、ここには載せません。音響、選曲、レコード棚まで含めて、音を目当てに出かけたくなる店を選びます。',
      'mockNotice': 'プロトタイプ号 — 掲載店と情報はすべて架空です',
      'lateSection': 'ひとりで聴きたい、22時以降',
      'lateIntro': '照明は暗め。選曲は丁寧。ひとりで静かに飲める3軒。',
      'allPlaces': '次の一軒を選ぶ',
      'allPlacesBody': '音、街、予算を見比べて、気になる店を保存できます。',
      'save': '保存する',
      'unsave': '保存から外す',
      'emptySaved': '気になる店は、まだありません。',
      'emptySavedBody': 'ガイドで見つけた店を保存すると、ここに並びます。',
      'backToDiscover': '7軒から選ぶ',
      'mapTitle': '次の一軒を、\n地図から。',
      'mapBody': '掲載した7軒の位置関係を眺めるためのプレビューです。実在する店を掲載する段階で、正確な地図と経路案内を加えます。',
      'mapComing': '地図プレビュー / 架空の位置',
      'mapIndexTitle': 'この地図にある7軒',
      'walkingRangeLabel': '徒歩20分圏内',
      'walkingRangeBody': '現在地、または指定した場所を起点に、徒歩ルートが20分以内の店だけを表示します。',
      'walkingCurrent': '現在地から',
      'walkingChoose': '場所を指定',
      'walkingUnavailableTitle': '実在店版で対応予定',
      'walkingUnavailableBody':
          '現在の7軒と地図上の位置は架空のため、推定の徒歩時間を事実として表示しません。実在店の正確な座標と徒歩ルートを接続した段階で、この絞り込みを有効にします。',
      'walkingUnavailableAction': '了解',
      'filterLabel': '地図を絞り込む',
      'filterMoodLabel': '気分',
      'filterGenreLabel': 'ジャンル',
      'filterAll': 'すべて',
      'filterQuiet': '静か',
      'filterLate': '深夜',
      'filterVinyl': 'レコード',
      'filterDj': 'DJ',
      'filterJazz': 'ジャズ',
      'filterSoul': 'ソウル',
      'filterCityPop': 'シティポップ',
      'filterAmbient': 'アンビエント',
      'filterHouse': 'ハウス',
      'filterRock': 'ロック',
      'filterEmpty': 'この組み合わせに合う店はありません。',
      'mapsArea': 'このエリアをGoogle Mapsで見る',
      'venueDataNote': '掲載内容はプロトタイプ用の架空データです。実在する店舗についての記述ではありません。',
      'sideBNote': 'この店を選んだ理由',
      'hours': '営業時間',
      'price': '予算',
      'sound': '音楽',
      'area': 'エリア',
      'details': '店舗詳細を開く',
      'savedCount': 'あとで行きたい店',
      'emptySavedIcon': '保存した店はまだありません',
      'heroImageLabel': '架空の東京のリスニングバーを描いたオリジナルイラスト',
      'detailImageLabel': '架空の店内写真',
      'mockPlaceLabel': '架空の店舗 / モックデータ',
      'readKicker': 'SIDE B READING ROOM / TOKYO + VISITOR',
      'readTitle': '東京の音を、\n読む。',
      'readBody': '街を歩いた人の記録、店主への取材、音を追った映像。店へ行く前と、帰った後に読みたいものを集めました。',
      'readFeatured': 'まず、この一本',
      'readShelf': '読む棚から',
      'readVisitor': 'VISITOR’S VIEW / 海外から見る東京',
      'readVisitorBody': '英語の街案内とロングリードを、旅の計画と、海外から見た東京の音楽文化を知る手がかりに。',
      'readArticle': '元の記事を読む',
      'readDisclosure': 'リンク先は各媒体のページです。SIDE Bは短い編集メモだけを加え、記事本文や画像は転載していません。',
      'readError': '記事を開けませんでした。',
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
