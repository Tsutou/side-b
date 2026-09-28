import 'package:flutter/material.dart';
import 'package:side_b/core/design/tokens.dart';
import 'package:side_b/core/localization/app_localizations.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    required this.venueId,
    required this.controller,
    this.inverse = false,
    super.key,
  });

  final String venueId;
  final SavedVenuesController controller;
  final bool inverse;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final isSaved = controller.contains(venueId);
        final label = AppLocalizations.of(
          context,
        ).t(isSaved ? 'unsave' : 'save');
        return Semantics(
          key: ValueKey('save-$venueId'),
          button: true,
          label: label,
          toggled: isSaved,
          onTap: () => controller.toggle(venueId),
          child: ExcludeSemantics(
            child: Tooltip(
              message: label,
              child: IconButton(
                onPressed: () => controller.toggle(venueId),
                icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
                color: inverse ? SideBColors.ivory : SideBColors.ink,
                iconSize: 22,
                style:
                    inverse
                        ? IconButton.styleFrom(
                          backgroundColor: SideBColors.ink.withValues(
                            alpha: .82,
                          ),
                          hoverColor: SideBColors.vermilion,
                          focusColor: SideBColors.vermilion,
                        )
                        : null,
                constraints: const BoxConstraints(
                  minWidth: SideBSizes.tapTarget,
                  minHeight: SideBSizes.tapTarget,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
