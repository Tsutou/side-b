import 'package:flutter/material.dart';
import 'package:side_b/core/design/tokens.dart';
import 'package:side_b/core/localization/app_localizations.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({
    required this.locale,
    required this.onLocaleChanged,
    super.key,
  });

  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    return Semantics(
      container: true,
      header: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          SideBSpacing.lg,
          SideBSpacing.lg,
          SideBSpacing.lg,
          SideBSpacing.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                const masthead = Text(
                  'SIDE B',
                  style: TextStyle(
                    fontFamily: 'Futura',
                    fontSize: 44,
                    height: .85,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -2.4,
                    color: SideBColors.ink,
                  ),
                );
                final languageSwitch = _LanguageSwitch(
                  locale: locale,
                  onChanged: onLocaleChanged,
                );
                if (constraints.maxWidth < 420) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      masthead,
                      const SizedBox(height: SideBSpacing.md),
                      Align(
                        alignment: Alignment.centerRight,
                        child: languageSwitch,
                      ),
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [masthead, const Spacer(), languageSwitch],
                );
              },
            ),
            const SizedBox(height: SideBSpacing.md),
            const Divider(thickness: SideBBorders.strong),
            const SizedBox(height: SideBSpacing.sm),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.center,
              spacing: SideBSpacing.lg,
              runSpacing: SideBSpacing.xs,
              children: [
                Text(
                  copy.t('guide'),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: SideBColors.vermilion,
                  ),
                ),
                Text(
                  '${copy.t('edition')}  /  33⅓ RPM',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageSwitch extends StatelessWidget {
  const _LanguageSwitch({required this.locale, required this.onChanged});

  final Locale locale;
  final ValueChanged<Locale> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: locale.languageCode == 'ja' ? '言語選択' : 'Language selector',
      child: SegmentedButton<String>(
        segments: const [
          ButtonSegment(value: 'en', label: Text('EN')),
          ButtonSegment(value: 'ja', label: Text('JP')),
        ],
        selected: {locale.languageCode},
        showSelectedIcon: false,
        onSelectionChanged: (selection) {
          onChanged(Locale(selection.single));
        },
      ),
    );
  }
}
