import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:side_b/core/design/tokens.dart';
import 'package:side_b/core/localization/app_localizations.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';
import 'package:side_b/features/venues/data/mock_venues.dart';
import 'package:side_b/features/venues/domain/venue.dart';
import 'package:side_b/features/venues/presentation/venue_detail_screen.dart';
import 'package:side_b/shared/widgets/brand_header.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({
    required this.savedVenues,
    required this.locale,
    required this.onLocaleChanged,
    super.key,
  });

  final SavedVenuesController savedVenues;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    return CustomScrollView(
      key: const PageStorageKey('map'),
      slivers: [
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: SideBSizes.contentMaxWidth,
              ),
              child: BrandHeader(
                locale: locale,
                onLocaleChanged: onLocaleChanged,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: SideBSizes.contentMaxWidth,
              ),
              child: Padding(
                padding: const EdgeInsets.all(SideBSpacing.lg),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final wide = constraints.maxWidth > 720;
                    final intro = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          copy.t('mapComing'),
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: SideBColors.vermilion),
                        ),
                        const SizedBox(height: SideBSpacing.xl),
                        Text(
                          copy.t('mapTitle'),
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(fontSize: wide ? 56 : 46),
                        ),
                        const SizedBox(height: SideBSpacing.lg),
                        Text(
                          copy.t('mapBody'),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    );
                    final map = AspectRatio(
                      aspectRatio: wide ? 1.15 : 1,
                      child: _MapPreview(savedVenues: savedVenues),
                    );
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (wide)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(flex: 7, child: map),
                              const SizedBox(width: SideBSpacing.xxl),
                              Expanded(flex: 4, child: intro),
                            ],
                          )
                        else ...[
                          intro,
                          const SizedBox(height: SideBSpacing.xl),
                          map,
                        ],
                        const SizedBox(height: SideBSpacing.xxl),
                        const Divider(thickness: SideBBorders.strong),
                        const SizedBox(height: SideBSpacing.lg),
                        Text(
                          copy.t('mapIndexTitle'),
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: SideBColors.vermilion),
                        ),
                        const SizedBox(height: SideBSpacing.md),
                        _VenueIndex(
                          savedVenues: savedVenues,
                          columns: wide ? 2 : 1,
                        ),
                        const SizedBox(height: SideBSpacing.display),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _VenueIndex extends StatelessWidget {
  const _VenueIndex({required this.savedVenues, required this.columns});

  final SavedVenuesController savedVenues;
  final int columns;

  @override
  Widget build(BuildContext context) {
    final languageCode = AppLocalizations.of(context).locale.languageCode;
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            columns == 1
                ? constraints.maxWidth
                : (constraints.maxWidth - SideBSpacing.lg) / columns;
        return Wrap(
          spacing: SideBSpacing.lg,
          runSpacing: SideBSpacing.xs,
          children: [
            for (final entry in mockVenues.asMap().entries)
              SizedBox(
                width: itemWidth,
                child: _VenueIndexItem(
                  number: entry.key + 1,
                  venue: entry.value,
                  languageCode: languageCode,
                  savedVenues: savedVenues,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _VenueIndexItem extends StatelessWidget {
  const _VenueIndexItem({
    required this.number,
    required this.venue,
    required this.languageCode,
    required this.savedVenues,
  });

  final int number;
  final Venue venue;
  final String languageCode;
  final SavedVenuesController savedVenues;

  @override
  Widget build(BuildContext context) {
    void openVenue() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder:
              (_) => VenueDetailScreen(venue: venue, savedVenues: savedVenues),
        ),
      );
    }

    final label =
        '$number. ${venue.name}, ${venue.areaFor(languageCode)}, ${venue.price}';
    return Semantics(
      button: true,
      label: label,
      onTap: openVenue,
      child: ExcludeSemantics(
        child: InkWell(
          onTap: openVenue,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: SideBSizes.tapTarget),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: SideBSpacing.xs),
              child: Row(
                children: [
                  SizedBox(
                    width: 34,
                    child: Text(
                      number.toString().padLeft(2, '0'),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: SideBColors.vermilion,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          venue.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: SideBSpacing.xxs),
                        Text(
                          venue.areaFor(languageCode),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: SideBSpacing.sm),
                  Text(
                    venue.price,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(width: SideBSpacing.xs),
                  const Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MapPreview extends StatelessWidget {
  const _MapPreview({required this.savedVenues});
  final SavedVenuesController savedVenues;

  @override
  Widget build(BuildContext context) => Container(
    color: SideBColors.ink,
    child: LayoutBuilder(
      builder: (context, constraints) {
        final languageCode = AppLocalizations.of(context).locale.languageCode;
        return Stack(
          children: [
            const Positioned.fill(
              child: CustomPaint(painter: _TokyoLinesPainter()),
            ),
            ...mockVenues.asMap().entries.map((entry) {
              final venue = entry.value;
              void openVenue() {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder:
                        (_) => VenueDetailScreen(
                          venue: venue,
                          savedVenues: savedVenues,
                        ),
                  ),
                );
              }

              return Positioned(
                left: venue.mapX * constraints.maxWidth,
                top: venue.mapY * constraints.maxHeight,
                child: FractionalTranslation(
                  translation: const Offset(-.5, -.5),
                  child: Semantics(
                    button: true,
                    label: '${venue.name}, ${venue.areaFor(languageCode)}',
                    onTap: openVenue,
                    child: ExcludeSemantics(
                      child: Tooltip(
                        message:
                            '${venue.name} / ${venue.areaFor(languageCode)}',
                        child: InkWell(
                          onTap: openVenue,
                          borderRadius: BorderRadius.circular(SideBRadii.round),
                          child: SizedBox.square(
                            dimension: SideBSizes.tapTarget,
                            child: Center(
                              child: Container(
                                width: entry.key == 0 ? 44 : 34,
                                height: entry.key == 0 ? 44 : 34,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      entry.key == 0
                                          ? SideBColors.vermilion
                                          : SideBColors.ivory,
                                  border: Border.all(
                                    color: SideBColors.ink,
                                    width: 2,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${entry.key + 1}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelLarge?.copyWith(
                                    color:
                                        entry.key == 0
                                            ? SideBColors.white
                                            : SideBColors.ink,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            Positioned(
              left: SideBSpacing.md,
              bottom: SideBSpacing.md,
              child: Text(
                'TOKYO / SCHEMATIC',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: SideBColors.ivory),
              ),
            ),
          ],
        );
      },
    ),
  );
}

class _TokyoLinesPainter extends CustomPainter {
  const _TokyoLinesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    final street =
        Paint()
          ..color = SideBColors.warmGray.withValues(alpha: .28)
          ..strokeWidth = 1;
    final river =
        Paint()
          ..color = SideBColors.ivory.withValues(alpha: .45)
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke;
    for (var i = -2; i < 11; i++) {
      final y = size.height * i / 8;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y + size.height * .35),
        street,
      );
    }
    for (var i = 0; i < 10; i++) {
      final x = size.width * i / 9;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x - size.width * .22, size.height),
        street,
      );
    }
    final path = Path()..moveTo(size.width * .68, 0);
    for (var i = 0; i <= 20; i++) {
      final y = size.height * i / 20;
      final x = size.width * (.65 + math.sin(i * .8) * .04);
      path.lineTo(x, y);
    }
    canvas.drawPath(path, river);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_TokyoLinesPainter oldDelegate) => false;
}
