import 'package:flutter/material.dart';
import 'package:side_b/core/design/tokens.dart';
import 'package:side_b/core/localization/app_localizations.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';
import 'package:side_b/features/venues/domain/venue.dart';
import 'package:side_b/shared/widgets/save_button.dart';

class VenueDetailScreen extends StatelessWidget {
  const VenueDetailScreen({
    required this.venue,
    required this.savedVenues,
    super.key,
  });

  final Venue venue;
  final SavedVenuesController savedVenues;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    final languageCode = copy.locale.languageCode;
    return Scaffold(
      backgroundColor: SideBColors.ivory,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: SideBColors.ink,
              foregroundColor: SideBColors.ivory,
              title: const Text(
                'SIDE B',
                style: TextStyle(
                  fontFamily: 'Futura',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
              ),
              actions: [
                SaveButton(
                  venueId: venue.id,
                  controller: savedVenues,
                  inverse: true,
                ),
                const SizedBox(width: SideBSpacing.xs),
              ],
            ),
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: SideBSizes.contentMaxWidth,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth >= 760;
                      final image = Semantics(
                        image: true,
                        label: '${copy.t('detailImageLabel')}: ${venue.name}',
                        child: Image.asset(
                          'assets/images/listening-room.png',
                          fit: BoxFit.cover,
                          alignment: Alignment(venue.imageAlignment, 0),
                        ),
                      );
                      final text = Padding(
                        padding: EdgeInsets.all(
                          wide ? SideBSpacing.xxl : SideBSpacing.lg,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              copy.t('mockPlaceLabel'),
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: SideBColors.vermilion),
                            ),
                            const SizedBox(height: SideBSpacing.lg),
                            Text(
                              venue.name,
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(fontSize: wide ? 64 : 50),
                            ),
                            const SizedBox(height: SideBSpacing.sm),
                            Text(
                              '${venue.areaFor(languageCode)}  /  ${venue.typeLabelFor(languageCode)}',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: SideBSpacing.xl),
                            Text(
                              venue.editorialNoteFor(languageCode),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      );
                      if (wide) {
                        return SizedBox(
                          height: 580,
                          child: Row(
                            children: [
                              Expanded(flex: 6, child: image),
                              Expanded(flex: 4, child: text),
                            ],
                          ),
                        );
                      }
                      return Column(
                        children: [
                          AspectRatio(aspectRatio: 1.2, child: image),
                          text,
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      SideBSpacing.lg,
                      SideBSpacing.xl,
                      SideBSpacing.lg,
                      SideBSpacing.display,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Divider(),
                        const SizedBox(height: SideBSpacing.xl),
                        Wrap(
                          spacing: SideBSpacing.xxl,
                          runSpacing: SideBSpacing.lg,
                          children: [
                            _Fact(
                              label: copy.t('area'),
                              value: venue.areaFor(languageCode),
                            ),
                            _Fact(label: copy.t('hours'), value: venue.hours),
                            _Fact(label: copy.t('price'), value: venue.price),
                            _Fact(
                              label: copy.t('sound'),
                              value: venue.genres.join(' / '),
                            ),
                          ],
                        ),
                        const SizedBox(height: SideBSpacing.xxl),
                        Text(
                          copy.t('sideBNote'),
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: SideBColors.vermilion),
                        ),
                        const SizedBox(height: SideBSpacing.sm),
                        Text(
                          venue.editorialNoteFor(languageCode),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: SideBSpacing.xl),
                        Wrap(
                          spacing: SideBSpacing.xs,
                          runSpacing: SideBSpacing.xs,
                          children:
                              venue
                                  .signalsFor(languageCode)
                                  .map((signal) => _Signal(label: signal))
                                  .toList(),
                        ),
                        const SizedBox(height: SideBSpacing.xxl),
                        Container(
                          color: SideBColors.ink,
                          padding: const EdgeInsets.all(SideBSpacing.lg),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: SideBColors.vermilion,
                                size: 22,
                              ),
                              const SizedBox(width: SideBSpacing.sm),
                              Expanded(
                                child: Text(
                                  copy.t('venueDataNote'),
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: SideBColors.ivory),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 150,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: SideBColors.inkSoft),
        ),
        const SizedBox(height: SideBSpacing.xs),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

class _Signal extends StatelessWidget {
  const _Signal({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Chip(
    label: Text(label),
    backgroundColor: Colors.transparent,
    side: const BorderSide(color: SideBColors.ink),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(SideBRadii.small),
    ),
    labelStyle: Theme.of(context).textTheme.labelLarge,
  );
}
