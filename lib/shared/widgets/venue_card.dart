import 'package:flutter/material.dart';
import 'package:side_b/core/design/tokens.dart';
import 'package:side_b/core/localization/app_localizations.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';
import 'package:side_b/features/venues/domain/venue.dart';
import 'package:side_b/features/venues/presentation/venue_detail_screen.dart';
import 'package:side_b/shared/widgets/save_button.dart';

class VenueCard extends StatelessWidget {
  const VenueCard({
    required this.venue,
    required this.savedVenues,
    this.compact = false,
    super.key,
  });

  final Venue venue;
  final SavedVenuesController savedVenues;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    final languageCode = copy.locale.languageCode;
    final detailLabel = '${copy.t('details')}: ${venue.name}';
    void openVenue() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder:
              (_) => VenueDetailScreen(venue: venue, savedVenues: savedVenues),
        ),
      );
    }

    return Stack(
      children: [
        Semantics(
          button: true,
          label: detailLabel,
          onTap: openVenue,
          child: ExcludeSemantics(
            child: InkWell(
              onTap: openVenue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: compact ? 1.35 : 1.1,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            SideBColors.ink.withValues(
                              alpha: compact ? .18 : .05,
                            ),
                            BlendMode.multiply,
                          ),
                          child: Image.asset(
                            'assets/images/listening-room.png',
                            fit: BoxFit.cover,
                            alignment: Alignment(venue.imageAlignment, 0),
                          ),
                        ),
                        Positioned(
                          left: SideBSpacing.sm,
                          top: SideBSpacing.sm,
                          child: Container(
                            color: SideBColors.ivory,
                            padding: const EdgeInsets.symmetric(
                              horizontal: SideBSpacing.xs,
                              vertical: SideBSpacing.xxs,
                            ),
                            child: Text(
                              venue.areaFor(languageCode),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: SideBSpacing.sm),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    '${venue.typeLabelFor(languageCode)}  /  ${venue.genres.take(2).join(' · ')}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: SideBColors.vermilion,
                      letterSpacing: .8,
                    ),
                  ),
                  const SizedBox(height: SideBSpacing.xs),
                  Text(
                    venue.editorialNoteFor(languageCode),
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: compact ? 2 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: SideBSpacing.xs,
          top: SideBSpacing.xs,
          child: SaveButton(
            venueId: venue.id,
            controller: savedVenues,
            inverse: true,
          ),
        ),
      ],
    );
  }
}
