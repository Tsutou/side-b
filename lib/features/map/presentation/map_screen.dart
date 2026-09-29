import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:side_b/core/design/tokens.dart';
import 'package:side_b/core/localization/app_localizations.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';
import 'package:side_b/features/venues/data/mock_venues.dart';
import 'package:side_b/features/venues/domain/venue.dart';
import 'package:side_b/features/venues/presentation/venue_detail_screen.dart';
import 'package:side_b/shared/widgets/brand_header.dart';

class MapScreen extends StatefulWidget {
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
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _selectedIndex = 0;

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
                locale: widget.locale,
                onLocaleChanged: widget.onLocaleChanged,
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
                padding: const EdgeInsets.fromLTRB(
                  SideBSpacing.lg,
                  SideBSpacing.sm,
                  SideBSpacing.lg,
                  SideBSpacing.display,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final wide = constraints.maxWidth > 760;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _MapIntroduction(copy: copy, wide: wide),
                        const SizedBox(height: SideBSpacing.xl),
                        SizedBox(
                          height:
                              wide
                                  ? 620
                                  : math.max(520, constraints.maxWidth * 1.28),
                          child: _MapPreview(
                            savedVenues: widget.savedVenues,
                            selectedIndex: _selectedIndex,
                            onSelected:
                                (index) =>
                                    setState(() => _selectedIndex = index),
                          ),
                        ),
                        const SizedBox(height: SideBSpacing.xxl),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                copy.t('mapIndexTitle'),
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                            Text(
                              '01—07',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: SideBColors.vermilion),
                            ),
                          ],
                        ),
                        const SizedBox(height: SideBSpacing.md),
                        const Divider(thickness: SideBBorders.strong),
                        const SizedBox(height: SideBSpacing.md),
                        _VenueIndex(
                          savedVenues: widget.savedVenues,
                          columns: wide ? 2 : 1,
                          selectedIndex: _selectedIndex,
                          onSelected:
                              (index) => setState(() => _selectedIndex = index),
                        ),
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

class _MapIntroduction extends StatelessWidget {
  const _MapIntroduction({required this.copy, required this.wide});

  final AppLocalizations copy;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      copy.t('mapTitle'),
      style: Theme.of(
        context,
      ).textTheme.displayLarge?.copyWith(fontSize: wide ? 64 : 48),
    );
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          copy.t('mapComing'),
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: SideBColors.vermilion),
        ),
        const SizedBox(height: SideBSpacing.md),
        Text(copy.t('mapBody'), style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: SideBSpacing.lg),
        const _IssueLine(),
      ],
    );
    if (!wide) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [title, const SizedBox(height: SideBSpacing.lg), details],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(flex: 6, child: title),
        const SizedBox(width: SideBSpacing.xxl),
        Expanded(flex: 4, child: details),
      ],
    );
  }
}

class _IssueLine extends StatelessWidget {
  const _IssueLine();

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(width: 32, height: 3, color: SideBColors.albumYellow),
      const SizedBox(width: SideBSpacing.sm),
      Expanded(
        child: Text(
          'VOL. 01  /  7 ROOMS  /  33⅓ RPM',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    ],
  );
}

class _VenueIndex extends StatelessWidget {
  const _VenueIndex({
    required this.savedVenues,
    required this.columns,
    required this.selectedIndex,
    required this.onSelected,
  });

  final SavedVenuesController savedVenues;
  final int columns;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

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
                  selected: entry.key == selectedIndex,
                  onSelected: () => onSelected(entry.key),
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
    required this.selected,
    required this.onSelected,
  });

  final int number;
  final Venue venue;
  final String languageCode;
  final SavedVenuesController savedVenues;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    void openVenue() {
      onSelected();
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
        child: Material(
          color: selected ? SideBColors.paper : Colors.transparent,
          child: InkWell(
            onTap: openVenue,
            child: AnimatedContainer(
              duration: SideBMotion.quick,
              constraints: const BoxConstraints(minHeight: 116),
              padding: const EdgeInsets.symmetric(
                horizontal: SideBSpacing.sm,
                vertical: SideBSpacing.md,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: selected ? SideBColors.vermilion : SideBColors.line,
                    width: selected ? 3 : 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 46,
                    child: Text(
                      number.toString().padLeft(2, '0'),
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(color: SideBColors.vermilion),
                    ),
                  ),
                  const SizedBox(width: SideBSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                venue.name,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Text(
                              venue.price,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: SideBSpacing.xxs),
                        Text(
                          '${venue.areaFor(languageCode)} / ${venue.typeLabelFor(languageCode)}',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: SideBColors.vermilion),
                        ),
                        const SizedBox(height: SideBSpacing.xs),
                        Text(
                          venue.editorialNoteFor(languageCode),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: SideBSpacing.sm),
                  const Padding(
                    padding: EdgeInsets.only(top: SideBSpacing.xxs),
                    child: Icon(Icons.north_east, size: 18),
                  ),
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
  const _MapPreview({
    required this.savedVenues,
    required this.selectedIndex,
    required this.onSelected,
  });

  final SavedVenuesController savedVenues;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => Container(
    color: SideBColors.ink,
    child: LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 620;
        final languageCode = AppLocalizations.of(context).locale.languageCode;
        final markerHeight = constraints.maxHeight - (compact ? 174 : 0);
        final selectedVenue = mockVenues[selectedIndex];
        return ClipRect(
          child: Stack(
            children: [
              const Positioned.fill(
                child: CustomPaint(painter: _TokyoLinesPainter()),
              ),
              const _DistrictLabels(),
              ...mockVenues.asMap().entries.map((entry) {
                final venue = entry.value;
                final isSelected = entry.key == selectedIndex;
                final semanticsLabel =
                    '${venue.name}, ${venue.areaFor(languageCode)}';
                return Positioned(
                  left: venue.mapX * constraints.maxWidth,
                  top: venue.mapY * markerHeight,
                  child: FractionalTranslation(
                    translation: const Offset(-.5, -.5),
                    child: Semantics(
                      button: true,
                      selected: isSelected,
                      label: semanticsLabel,
                      onTap: () => onSelected(entry.key),
                      child: ExcludeSemantics(
                        child: Tooltip(
                          message: semanticsLabel,
                          child: InkWell(
                            onTap: () => onSelected(entry.key),
                            borderRadius: BorderRadius.circular(
                              SideBRadii.round,
                            ),
                            child: SizedBox.square(
                              dimension: SideBSizes.tapTarget,
                              child: Center(
                                child: AnimatedContainer(
                                  duration: SideBMotion.quick,
                                  width: isSelected ? 46 : 34,
                                  height: isSelected ? 46 : 34,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        isSelected
                                            ? SideBColors.vermilion
                                            : SideBColors.ivory,
                                    border: Border.all(
                                      color:
                                          isSelected
                                              ? SideBColors.albumYellow
                                              : SideBColors.ink,
                                      width: isSelected ? 4 : 2,
                                    ),
                                    boxShadow:
                                        isSelected
                                            ? const [
                                              BoxShadow(
                                                color: Color(0x66000000),
                                                blurRadius: 18,
                                              ),
                                            ]
                                            : null,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${entry.key + 1}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelLarge?.copyWith(
                                      color:
                                          isSelected
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
                top: SideBSpacing.md,
                child: _MapPlate(selectedIndex: selectedIndex),
              ),
              Positioned(
                left: compact ? 0 : null,
                right: 0,
                bottom: 0,
                width: compact ? null : 340,
                height: compact ? 174 : 226,
                child: AnimatedSwitcher(
                  duration: SideBMotion.standard,
                  transitionBuilder:
                      (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                  child: _SelectedVenue(
                    key: ValueKey(selectedVenue.id),
                    venue: selectedVenue,
                    number: selectedIndex + 1,
                    languageCode: languageCode,
                    savedVenues: savedVenues,
                    compact: compact,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

class _MapPlate extends StatelessWidget {
  const _MapPlate({required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) => Container(
    color: SideBColors.albumYellow,
    padding: const EdgeInsets.symmetric(
      horizontal: SideBSpacing.sm,
      vertical: SideBSpacing.xs,
    ),
    child: Text(
      'TOKYO / ${(selectedIndex + 1).toString().padLeft(2, '0')} OF 07',
      style: Theme.of(context).textTheme.labelLarge,
    ),
  );
}

class _SelectedVenue extends StatelessWidget {
  const _SelectedVenue({
    required this.venue,
    required this.number,
    required this.languageCode,
    required this.savedVenues,
    required this.compact,
    super.key,
  });

  final Venue venue;
  final int number;
  final String languageCode;
  final SavedVenuesController savedVenues;
  final bool compact;

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

    return Semantics(
      button: true,
      label: '${venue.name}, ${venue.areaFor(languageCode)}',
      onTap: openVenue,
      child: ExcludeSemantics(
        child: Material(
          color: SideBColors.paper,
          child: InkWell(
            onTap: openVenue,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: compact ? 132 : 126,
                  child: Image.asset(
                    venue.imageAsset,
                    fit: BoxFit.cover,
                    alignment: Alignment(venue.imageAlignment, 0),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(SideBSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${number.toString().padLeft(2, '0')} / ${venue.areaFor(languageCode)}',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: SideBColors.vermilion),
                        ),
                        const SizedBox(height: SideBSpacing.xs),
                        Text(
                          venue.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: SideBSpacing.xs),
                        Expanded(
                          child: Text(
                            venue.editorialNoteFor(languageCode),
                            maxLines: compact ? 3 : 5,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                venue.genres.take(2).join(' / '),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            const Icon(Icons.north_east, size: 18),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DistrictLabels extends StatelessWidget {
  const _DistrictLabels();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelLarge?.copyWith(
      color: SideBColors.ivory.withValues(alpha: .78),
      fontSize: 10,
    );
    return Stack(
      children: [
        Positioned(left: 34, top: 94, child: Text('WEST', style: style)),
        Positioned(right: 34, top: 86, child: Text('EAST', style: style)),
        Positioned(
          left: 28,
          bottom: 246,
          child: Text('SETAGAYA', style: style),
        ),
        Positioned(right: 28, bottom: 250, child: Text('SUMIDA', style: style)),
      ],
    );
  }
}

class _TokyoLinesPainter extends CustomPainter {
  const _TokyoLinesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.clipRect(Offset.zero & size);

    final district =
        Paint()..color = SideBColors.midnight.withValues(alpha: .7);
    canvas.drawCircle(
      Offset(size.width * .27, size.height * .34),
      size.shortestSide * .28,
      district,
    );
    canvas.drawCircle(
      Offset(size.width * .79, size.height * .24),
      size.shortestSide * .2,
      district,
    );

    final street =
        Paint()
          ..color = SideBColors.warmGray.withValues(alpha: .25)
          ..strokeWidth = 1;
    final arterial =
        Paint()
          ..color = SideBColors.albumYellow.withValues(alpha: .42)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
    final river =
        Paint()
          ..color = SideBColors.ivory.withValues(alpha: .5)
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

    for (var i = -2; i < 12; i++) {
      final y = size.height * i / 9;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y + size.height * .35),
        street,
      );
    }
    for (var i = 0; i < 12; i++) {
      final x = size.width * i / 11;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x - size.width * .22, size.height),
        street,
      );
    }

    final loop = Rect.fromCenter(
      center: Offset(size.width * .47, size.height * .49),
      width: size.width * .46,
      height: size.height * .52,
    );
    canvas.drawOval(loop, arterial);

    final riverPath = Path()..moveTo(size.width * .68, -10);
    for (var i = 0; i <= 24; i++) {
      final y = size.height * i / 24;
      final x = size.width * (.66 + math.sin(i * .72) * .035);
      riverPath.lineTo(x, y);
    }
    canvas.drawPath(riverPath, river);

    final center = Offset(size.width * .47, size.height * .49);
    final rings =
        Paint()
          ..color = SideBColors.vermilion.withValues(alpha: .2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
    for (final radius in [54.0, 86.0, 124.0]) {
      canvas.drawCircle(center, radius, rings);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_TokyoLinesPainter oldDelegate) => false;
}
