import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:side_b/core/design/tokens.dart';
import 'package:side_b/core/localization/app_localizations.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';
import 'package:side_b/features/venues/data/mock_venues.dart';
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
                    if (wide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 4, child: intro),
                          const SizedBox(width: SideBSpacing.xxl),
                          Expanded(flex: 6, child: map),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        intro,
                        const SizedBox(height: SideBSpacing.xl),
                        map,
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
              return Positioned(
                left: venue.mapX * constraints.maxWidth,
                top: venue.mapY * constraints.maxHeight,
                child: FractionalTranslation(
                  translation: const Offset(-.5, -.5),
                  child: Semantics(
                    button: true,
                    label: '${venue.name}, ${venue.areaFor(languageCode)}',
                    child: Tooltip(
                      message: '${venue.name} / ${venue.areaFor(languageCode)}',
                      child: InkWell(
                        onTap:
                            () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder:
                                    (_) => VenueDetailScreen(
                                      venue: venue,
                                      savedVenues: savedVenues,
                                    ),
                              ),
                            ),
                        borderRadius: BorderRadius.circular(SideBRadii.round),
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
  }

  @override
  bool shouldRepaint(_TokyoLinesPainter oldDelegate) => false;
}
