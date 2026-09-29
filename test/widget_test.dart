import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_b/app/side_b_app.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';
import 'package:side_b/features/venues/data/mock_venues.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  Future<void> openJapaneseGuide(WidgetTester tester) async {
    await tester.tap(find.text('ガイド'));
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

  testWidgets('opens on the map-first shell', (tester) async {
    final saved = SavedVenuesController();
    await tester.pumpWidget(SideBApp(savedVenues: saved));
    await tester.pumpAndSettle();

    expect(find.text('SIDE B'), findsOneWidget);
    expect(find.text('次の一軒を、\n地図から。'), findsOneWidget);
    expect(find.text('この地図にある7軒'), findsOneWidget);
    expect(find.text('ROOM 33'), findsWidgets);
    expect(find.text('ガイド'), findsOneWidget);
    expect(find.text('地図'), findsOneWidget);
    expect(find.text('保存'), findsOneWidget);
    expect(find.textContaining('神保町'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(SegmentedButton<String>), findsOneWidget);
    final context = tester.element(find.byType(Scaffold).first);
    expect(Theme.of(context).useMaterial3, isTrue);
  });

  testWidgets('saves a venue and shows it in Saved', (tester) async {
    final saved = SavedVenuesController();
    await tester.pumpWidget(SideBApp(savedVenues: saved));
    await tester.pumpAndSettle();
    await openJapaneseGuide(tester);

    final saveControl = find.byKey(const ValueKey('save-room-33')).first;
    await tester.ensureVisible(saveControl);
    await tester.pumpAndSettle();
    await tester.tap(saveControl);
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    expect(find.text('ROOM 33'), findsWidgets);
    expect(find.text('01'), findsOneWidget);
  });

  testWidgets('opens the map from the primary hero action', (tester) async {
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();
    await openJapaneseGuide(tester);

    final mapAction = find.text('地図から7軒を見る');
    await tester.ensureVisible(mapAction);
    await tester.pumpAndSettle();
    await tester.tap(mapAction);
    await tester.pumpAndSettle();

    expect(find.text('次の一軒を、\n地図から。'), findsOneWidget);
    expect(find.text('地図プレビュー / 架空の位置'), findsOneWidget);
  });

  testWidgets('selects a venue from the editorial map', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
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
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('EN').first);
    await tester.pumpAndSettle();

    expect(find.text('Choose your next room\nfrom the map.'), findsOneWidget);
    await tester.tap(find.text('Discover'));
    await tester.pumpAndSettle();
    expect(find.text('Where will you\nlisten tonight?'), findsOneWidget);
    expect(find.text('Map'), findsOneWidget);
    expect(find.textContaining('JINBŌCHŌ'), findsWidgets);
    final title = tester.widget<Text>(
      find.text('Where will you\nlisten tonight?'),
    );
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

  testWidgets('uses Japanese display metrics in the wide hero', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();
    await openJapaneseGuide(tester);

    final title = tester.widget<Text>(find.text('今夜、音を聴きに\nどこへ行く？'));

    expect(title.style?.fontSize, 44);
    expect(title.style?.height, 1.08);
    expect(title.style?.letterSpacing, 0);
  });

  testWidgets('fits the Japanese edition on a compact mobile viewport', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();
    await openJapaneseGuide(tester);

    expect(find.text('今夜、音を聴きに\nどこへ行く？'), findsOneWidget);
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
