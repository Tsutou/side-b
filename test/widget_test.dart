import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_b/app/side_b_app.dart';
import 'package:side_b/core/design/tokens.dart';
import 'package:side_b/features/reading/data/curated_articles.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';
import 'package:side_b/features/venues/data/mock_venues.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  Future<void> openJapaneseReading(WidgetTester tester) async {
    await tester.tap(find.text('読む'));
    await tester.pumpAndSettle();
  }

  test('provides Japanese and English venue copy', () {
    final venue = mockVenues.first;

    expect(venue.areaFor('ja'), '神保町');
    expect(venue.areaFor('en'), 'JINBŌCHŌ');
    expect(venue.editorialNoteFor('ja'), '細長い店内で、B面まで通して聴く。');
    expect(
      venue.editorialNoteFor('en'),
      'A narrow room where the second side gets played in full.',
    );
    final mapsUri = venue.googleMapsAreaUri('ja');
    expect(mapsUri.host, 'www.google.com');
    expect(mapsUri.queryParameters['api'], '1');
    expect(mapsUri.queryParameters['query'], '神保町 東京 ミュージックバー');
  });

  test('ships normalized thumbnails for every curated article', () async {
    final assets = [
      for (final article in curatedArticles) article.thumbnailAsset,
      'assets/images/articles/ai-fallback.jpg',
    ];
    for (final asset in assets) {
      final data = await rootBundle.load(asset);
      final thumbnail = img.decodeImage(data.buffer.asUint8List());

      expect(thumbnail, isNotNull, reason: asset);
      expect(thumbnail!.width, 1200, reason: asset);
      expect(thumbnail.height, 675, reason: asset);
    }
  });

  testWidgets('opens on the map-first shell', (tester) async {
    final saved = SavedVenuesController();
    await tester.pumpWidget(SideBApp(savedVenues: saved));
    await tester.pumpAndSettle();

    expect(find.text('SIDE B'), findsOneWidget);
    expect(find.text('次の一軒を、\n地図から。'), findsOneWidget);
    expect(find.text('この地図にある7軒'), findsOneWidget);
    expect(find.text('ROOM 33'), findsWidgets);
    expect(find.text('読む'), findsOneWidget);
    expect(find.text('地図'), findsOneWidget);
    expect(find.text('保存'), findsOneWidget);
    expect(find.textContaining('神保町'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(SegmentedButton<String>), findsOneWidget);
    final context = tester.element(find.byType(Scaffold).first);
    expect(Theme.of(context).useMaterial3, isTrue);
    expect(Theme.of(context).colorScheme.tertiary, SideBColors.albumYellow);
    expect(Theme.of(context).chipTheme.showCheckmark, isTrue);
    final dialogShape =
        Theme.of(context).dialogTheme.shape! as RoundedRectangleBorder;
    expect(
      (dialogShape.borderRadius as BorderRadius).topLeft.x,
      SideBRadii.extraLarge,
    );
  });

  testWidgets('saves a venue and shows it in Saved', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 1800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final saved = SavedVenuesController();
    await tester.pumpWidget(SideBApp(savedVenues: saved));
    await tester.pumpAndSettle();

    await tester.tap(find.text('ROOM 33').last);
    await tester.pumpAndSettle();
    final saveControl = find.byKey(const ValueKey('save-room-33')).first;
    await tester.tap(saveControl);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    expect(find.text('ROOM 33'), findsWidgets);
    expect(find.text('01'), findsOneWidget);
  });

  testWidgets('shows a curated reading shelf from multiple publishers', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1280, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();
    await openJapaneseReading(tester);

    expect(find.text('東京の音を、\n読む。'), findsOneWidget);
    expect(find.text('ARBAN'), findsAtLeastNWidgets(2));
    expect(find.text('VISITOR’S VIEW / 海外から見る東京'), findsOneWidget);
    expect(find.text('RESIDENT ADVISOR'), findsAtLeastNWidgets(2));
    expect(find.byKey(const ValueKey('read-tonlist')), findsOneWidget);
    expect(find.byKey(const ValueKey('read-shelter-film')), findsOneWidget);
    expect(find.text('3本'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('read-thumbnail-tonlist')),
      findsOneWidget,
    );
    expect(find.text('すべて'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('reading-filter-english')),
      findsOneWidget,
    );
  });

  testWidgets('links every published story to its exact Google Maps search', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1280, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();
    await openJapaneseReading(tester);

    expect(curatedArticles, hasLength(3));
    for (final article in curatedArticles) {
      expect(article.googleMapsUri.host, 'www.google.com');
      expect(article.googleMapsUri.path, '/maps/search/');
      expect(article.googleMapsUri.queryParameters['api'], '1');
      expect(article.googleMapsUri.queryParameters['query'], isNotEmpty);
    }
    expect(find.text('店をGoogle Mapsで見る'), findsWidgets);
  });

  testWidgets('filters the reading shelf with editorial bubbles', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1280, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();
    await openJapaneseReading(tester);

    await tester.tap(find.byKey(const ValueKey('reading-filter-english')));
    await tester.pumpAndSettle();

    expect(find.text('1本'), findsOneWidget);
    expect(find.text('VISITOR’S VIEW / 海外から見る東京'), findsOneWidget);
    expect(find.byKey(const ValueKey('read-shelter-film')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('read-tokyo-record-cafe-tour')),
      findsNothing,
    );
    expect(find.text('まず、この一本'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('reading-filter-neighborhood')));
    await tester.pumpAndSettle();

    expect(find.text('0本'), findsOneWidget);
    expect(find.text('まず、この一本'), findsNothing);
    expect(find.text('VISITOR’S VIEW / 海外から見る東京'), findsNothing);
    expect(find.text('読む棚から'), findsNothing);
    expect(find.text('この条件に合う記事はありません。'), findsOneWidget);
  });

  testWidgets('selects a venue from the editorial map', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();

    final marker = find.bySemanticsLabel('KISSA NAGI, 高円寺');
    await tester.ensureVisible(marker);
    await tester.tap(marker);
    await tester.pumpAndSettle();

    expect(find.text('KISSA NAGI'), findsNWidgets(2));
  });

  testWidgets('filters the map with mood bubbles', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('filter-dj')));
    await tester.pumpAndSettle();

    expect(find.text('METER'), findsNWidgets(2));
    expect(find.text('ROOM 33'), findsNothing);
    expect(find.text('01 / 07'), findsOneWidget);
    expect(find.text('ひとり向き'), findsNothing);
  });

  testWidgets('presents the honest 20-minute walking-area handoff', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();

    expect(find.text('徒歩20分圏内'), findsOneWidget);
    expect(find.text('現在地から'), findsOneWidget);
    expect(find.text('場所を指定'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('walking-current-location')));
    await tester.pumpAndSettle();

    expect(find.text('実在店版で対応予定'), findsOneWidget);
    expect(find.textContaining('推定の徒歩時間を事実として表示しません'), findsOneWidget);
  });

  testWidgets('combines mood and genre filters and handles no results', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('filter-quiet')));
    await tester.tap(find.byKey(const ValueKey('filter-jazz')));
    await tester.pumpAndSettle();

    expect(find.text('ROOM 33'), findsNWidgets(2));
    expect(find.text('BLUE HOUR'), findsNothing);
    expect(find.text('01 / 07'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('filter-jazz')));
    await tester.tap(find.byKey(const ValueKey('filter-house')));
    await tester.pumpAndSettle();

    expect(find.text('この組み合わせに合う店はありません。'), findsWidgets);
    expect(find.text('ROOM 33'), findsNothing);
  });

  testWidgets('shows the Google Maps area action on venue details', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1280, 1800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();

    final venueIndex = find.text('ROOM 33').last;
    await tester.tap(venueIndex);
    await tester.pumpAndSettle();

    expect(find.text('このエリアをGoogle Mapsで見る'), findsOneWidget);
  });

  testWidgets('switches the interface to English', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('EN').first);
    await tester.pumpAndSettle();

    expect(find.text('Choose your next room\nfrom the map.'), findsOneWidget);
    await tester.tap(find.text('Read'));
    await tester.pumpAndSettle();
    expect(find.text('Read the sound\nof Tokyo.'), findsOneWidget);
    expect(find.text('Map'), findsOneWidget);
    expect(find.text('VISITOR’S VIEW'), findsOneWidget);
    expect(find.text('RESIDENT ADVISOR'), findsAtLeastNWidgets(2));
    final title = tester.widget<Text>(find.text('Read the sound\nof Tokyo.'));
    expect(title.style?.fontFamily, 'Futura');
    final brand = tester.widget<Text>(find.text('SIDE B'));
    expect(brand.style?.fontFamily, 'Futura');
  });

  testWidgets('remembers the selected English locale', (tester) async {
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('EN').first);
    await tester.pumpAndSettle();
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();

    expect(find.text('Choose your next room\nfrom the map.'), findsOneWidget);
    expect(find.text('EN'), findsWidgets);
  });

  testWidgets('uses Japanese display metrics in the wide reading intro', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();
    await openJapaneseReading(tester);

    final title = tester.widget<Text>(find.text('東京の音を、\n読む。'));

    expect(title.style?.fontSize, 52);
    expect(title.style?.height, 1.05);
    expect(title.style?.letterSpacing, -1);
  });

  testWidgets('fits the Japanese edition on a compact mobile viewport', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();
    await openJapaneseReading(tester);

    expect(find.text('東京の音を、\n読む。'), findsOneWidget);
    expect(find.text('読む棚を絞り込む'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('meets automated accessibility guidelines on the reading shelf', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    try {
      await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
      await tester.pumpAndSettle();
      await openJapaneseReading(tester);

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('reflows the Material 3 map controls at 320 logical pixels', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();

    expect(find.text('徒歩20分圏内'), findsOneWidget);
    expect(find.text('現在地から'), findsOneWidget);
    expect(find.text('場所を指定'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('meets automated accessibility guidelines on the map', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    try {
      await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
      await tester.pumpAndSettle();

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
    } finally {
      semantics.dispose();
    }
  });
}
