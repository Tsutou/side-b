import 'package:flutter/material.dart';
import 'package:side_b/core/design/tokens.dart';
import 'package:side_b/core/localization/app_localizations.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';
import 'package:side_b/features/venues/data/mock_venues.dart';
import 'package:side_b/shared/widgets/brand_header.dart';
import 'package:side_b/shared/widgets/venue_card.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({
    required this.savedVenues,
    required this.locale,
    required this.onLocaleChanged,
    required this.onBrowse,
    super.key,
  });

  final SavedVenuesController savedVenues;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;
  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: savedVenues,
      builder: (context, _) {
        final venues =
            mockVenues
                .where((venue) => savedVenues.contains(venue.id))
                .toList();
        return CustomScrollView(
          key: const PageStorageKey('saved'),
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
                    padding: const EdgeInsets.fromLTRB(
                      SideBSpacing.lg,
                      SideBSpacing.xl,
                      SideBSpacing.lg,
                      SideBSpacing.lg,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            copy.t('savedCount'),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        Text(
                          venues.length.toString().padLeft(2, '0'),
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(color: SideBColors.vermilion),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (venues.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptySaved(onBrowse: onBrowse),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  SideBSpacing.lg,
                  SideBSpacing.lg,
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
                          venue: venues[index],
                          savedVenues: savedVenues,
                          compact: true,
                        ),
                        childCount: venues.length,
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class _EmptySaved extends StatelessWidget {
  const _EmptySaved({required this.onBrowse});
  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SideBSpacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.bookmark_border,
                size: 44,
                color: SideBColors.vermilion,
                semanticLabel: copy.t('emptySavedIcon'),
              ),
              const SizedBox(height: SideBSpacing.lg),
              Text(
                copy.t('emptySaved'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: SideBSpacing.sm),
              Text(
                copy.t('emptySavedBody'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: SideBSpacing.xl),
              OutlinedButton(
                onPressed: onBrowse,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(180, SideBSizes.tapTarget),
                  foregroundColor: SideBColors.ink,
                  side: const BorderSide(color: SideBColors.ink),
                ),
                child: Text(
                  copy.t('backToDiscover').toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
