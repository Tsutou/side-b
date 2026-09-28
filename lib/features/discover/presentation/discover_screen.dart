import 'package:flutter/material.dart';
import 'package:side_b/core/design/tokens.dart';
import 'package:side_b/core/localization/app_localizations.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';
import 'package:side_b/features/venues/data/mock_venues.dart';
import 'package:side_b/features/venues/presentation/venue_detail_screen.dart';
import 'package:side_b/shared/widgets/brand_header.dart';
import 'package:side_b/shared/widgets/save_button.dart';
import 'package:side_b/shared/widgets/venue_card.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({
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
      key: const PageStorageKey('discover'),
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
        SliverToBoxAdapter(child: _MockNotice(label: copy.t('mockNotice'))),
        SliverToBoxAdapter(child: _Hero(savedVenues: savedVenues)),
        SliverToBoxAdapter(
          child: _EditorialNote(
            title: copy.t('editorsNote'),
            body: copy.t('editorsNoteBody'),
          ),
        ),
        SliverToBoxAdapter(
          child: _SectionHeading(
            title: copy.t('lateSection'),
            body: copy.t('lateIntro'),
            issue: '01—03',
          ),
        ),
        SliverToBoxAdapter(child: _FeaturedGrid(savedVenues: savedVenues)),
        SliverToBoxAdapter(
          child: _SectionHeading(
            title: copy.t('allPlaces'),
            body: copy.t('allPlacesBody'),
            issue: '04—07',
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            SideBSpacing.lg,
            0,
            SideBSpacing.lg,
            SideBSpacing.display,
          ),
          sliver: SliverLayoutBuilder(
            builder: (context, constraints) {
              final columns =
                  constraints.crossAxisExtent >= 800
                      ? 3
                      : constraints.crossAxisExtent >= 520
                      ? 2
                      : 1;
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: SideBSpacing.lg,
                  mainAxisSpacing: SideBSpacing.xl,
                  childAspectRatio: columns == 1 ? 1.05 : .68,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => VenueCard(
                    venue: mockVenues[index + 3],
                    savedVenues: savedVenues,
                    compact: true,
                  ),
                  childCount: mockVenues.length - 3,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MockNotice extends StatelessWidget {
  const _MockNotice({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    color: SideBColors.midnight,
    padding: const EdgeInsets.symmetric(
      horizontal: SideBSpacing.lg,
      vertical: SideBSpacing.xs,
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: SideBColors.white,
        letterSpacing: 1,
      ),
    ),
  );
}

class _Hero extends StatelessWidget {
  const _Hero({required this.savedVenues});
  final SavedVenuesController savedVenues;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    final languageCode = copy.locale.languageCode;
    final venue = mockVenues.first;
    final isJapanese = copy.locale.languageCode == 'ja';
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: SideBSizes.contentMaxWidth),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            SideBSpacing.lg,
            SideBSpacing.lg,
            SideBSpacing.lg,
            0,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 960;
              final copyBlock = Container(
                color: SideBColors.albumYellow,
                padding: EdgeInsets.all(
                  isWide ? SideBSpacing.xxl : SideBSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      copy.t('heroKicker'),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: SideBColors.oxblood,
                      ),
                    ),
                    const SizedBox(height: SideBSpacing.xl),
                    Text(
                      copy.t('heroTitle'),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: SideBColors.ink,
                        fontSize:
                            isJapanese
                                ? (isWide ? 44 : 40)
                                : (isWide ? 58 : 45),
                        height: isJapanese ? 1.08 : null,
                        letterSpacing: isJapanese ? 0 : null,
                      ),
                    ),
                    const SizedBox(height: SideBSpacing.lg),
                    Text(
                      copy.t('heroBody'),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: SideBColors.ink),
                    ),
                    const SizedBox(height: SideBSpacing.lg),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${venue.name} / ${venue.areaFor(languageCode)}',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: SideBColors.ink),
                          ),
                        ),
                        SaveButton(venueId: venue.id, controller: savedVenues),
                      ],
                    ),
                  ],
                ),
              );
              final image = Semantics(
                image: true,
                label: copy.t('heroImageLabel'),
                child: Material(
                  color: SideBColors.ink,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Ink.image(
                        image: const AssetImage(
                          'assets/images/listening-bar-illustration.png',
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
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
                        ),
                      ),
                      const Positioned(
                        left: SideBSpacing.md,
                        top: SideBSpacing.md,
                        child: _RecordStamp(),
                      ),
                      Positioned(
                        left: SideBSpacing.md,
                        right: SideBSpacing.md,
                        bottom: SideBSpacing.md,
                        child: Text(
                          '${venue.name}  /  ${venue.areaFor(languageCode)}',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: SideBColors.paper),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              if (isWide) {
                return SizedBox(
                  height: 680,
                  child: Row(
                    children: [
                      Expanded(flex: 7, child: image),
                      Expanded(flex: 4, child: copyBlock),
                    ],
                  ),
                );
              }
              return Column(
                children: [
                  AspectRatio(aspectRatio: 1.35, child: image),
                  copyBlock,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RecordStamp extends StatelessWidget {
  const _RecordStamp();

  @override
  Widget build(BuildContext context) => Container(
    width: 82,
    height: 82,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: SideBColors.ink.withValues(alpha: .9),
      border: Border.all(color: SideBColors.albumYellow, width: 2),
    ),
    alignment: Alignment.center,
    child: Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: SideBColors.vermilion,
      ),
      alignment: Alignment.center,
      child: Text(
        '33⅓\nSIDE B',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontFamily: 'Futura',
          color: SideBColors.paper,
          height: 1.05,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

class _EditorialNote extends StatelessWidget {
  const _EditorialNote({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 760),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SideBSpacing.lg,
          vertical: SideBSpacing.display,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final label = Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: SideBColors.vermilion),
            );
            final note = Text(
              body,
              style: Theme.of(context).textTheme.headlineMedium,
            );
            if (constraints.maxWidth < 560) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label,
                  const SizedBox(height: SideBSpacing.md),
                  note,
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 112, child: label),
                const SizedBox(width: SideBSpacing.xl),
                Expanded(child: note),
              ],
            );
          },
        ),
      ),
    ),
  );
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.title,
    required this.body,
    required this.issue,
  });
  final String title;
  final String body;
  final String issue;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: SideBSizes.contentMaxWidth),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          SideBSpacing.lg,
          SideBSpacing.xxl,
          SideBSpacing.lg,
          SideBSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            const SizedBox(height: SideBSpacing.md),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Text(
                  issue,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: SideBColors.vermilion,
                  ),
                ),
              ],
            ),
            const SizedBox(height: SideBSpacing.sm),
            Text(body, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    ),
  );
}

class _FeaturedGrid extends StatelessWidget {
  const _FeaturedGrid({required this.savedVenues});
  final SavedVenuesController savedVenues;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: SideBSizes.contentMaxWidth),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SideBSpacing.lg),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 680) {
              return Column(
                children:
                    mockVenues
                        .take(3)
                        .map(
                          (venue) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: SideBSpacing.xl,
                            ),
                            child: VenueCard(
                              venue: venue,
                              savedVenues: savedVenues,
                            ),
                          ),
                        )
                        .toList(),
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: VenueCard(
                    venue: mockVenues[0],
                    savedVenues: savedVenues,
                  ),
                ),
                const SizedBox(width: SideBSpacing.lg),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      VenueCard(
                        venue: mockVenues[1],
                        savedVenues: savedVenues,
                        compact: true,
                      ),
                      const SizedBox(height: SideBSpacing.xl),
                      VenueCard(
                        venue: mockVenues[2],
                        savedVenues: savedVenues,
                        compact: true,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}
