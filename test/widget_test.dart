import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_b/app/side_b_app.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';
import 'package:side_b/features/venues/data/mock_venues.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('provides Japanese and English venue copy', () {
    final venue = mockVenues.first;

    expect(venue.areaFor('ja'), '神保町');
    expect(venue.areaFor('en'), 'JINBŌCHŌ');
    expect(venue.editorialNoteFor('ja'), '細長い店内で、B面まで通して聴く。');
    expect(
      venue.editorialNoteFor('en'),
      'A narrow room where the second side gets played in full.',
    );
  });

  testWidgets('shows the editorial discover shell and mock-data notice', (
    tester,
  ) async {
    final saved = SavedVenuesController();
    await tester.pumpWidget(SideBApp(savedVenues: saved));
    await tester.pumpAndSettle();

    expect(find.text('SIDE B'), findsOneWidget);
    expect(find.text('音を聴きに、\n行きたい店。'), findsOneWidget);
    final title = tester.widget<Text>(find.text('音を聴きに、\n行きたい店。'));
    expect(title.style?.fontFamily, 'NotoSansJP');
    expect(find.textContaining('架空の特集'), findsOneWidget);
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

  testWidgets('switches the interface to English', (tester) async {
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('EN').first);
    await tester.pumpAndSettle();

    expect(find.text('Places worth\nlistening to.'), findsOneWidget);
    expect(find.text('Map'), findsOneWidget);
    expect(find.textContaining('JINBŌCHŌ'), findsWidgets);
    final title = tester.widget<Text>(find.text('Places worth\nlistening to.'));
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

    expect(find.text('Places worth\nlistening to.'), findsOneWidget);
    expect(find.text('EN'), findsWidgets);
  });

  testWidgets('uses Japanese display metrics in the wide hero', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(SideBApp(savedVenues: SavedVenuesController()));
    await tester.pumpAndSettle();

    final title = tester.widget<Text>(find.text('音を聴きに、\n行きたい店。'));

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

    expect(find.text('音を聴きに、\n行きたい店。'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
