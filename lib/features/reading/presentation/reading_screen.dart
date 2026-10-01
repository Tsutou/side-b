import 'package:flutter/material.dart';
import 'package:side_b/core/design/tokens.dart';
import 'package:side_b/core/localization/app_localizations.dart';
import 'package:side_b/features/reading/data/curated_articles.dart';
import 'package:side_b/features/reading/domain/curated_article.dart';
import 'package:side_b/shared/widgets/brand_header.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({
    required this.locale,
    required this.onLocaleChanged,
    super.key,
  });

  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  ArticleFacet _facet = ArticleFacet.all;

  Future<void> _openUri(BuildContext context, Uri uri, String errorKey) async {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).t(errorKey))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    final featured = curatedArticles.firstWhere((article) => article.featured);
    final filtered =
        curatedArticles.where((article) => article.matches(_facet)).toList();
    final visitorArticles =
        filtered.where((article) => article.visitorPick).toList();
    final rest =
        filtered
            .where((article) => !article.featured && !article.visitorPick)
            .toList();
    return CustomScrollView(
      key: const PageStorageKey('reading'),
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
        SliverToBoxAdapter(child: _ReadingIntro(copy: copy)),
        SliverToBoxAdapter(
          child: _ReadingFilters(
            selected: _facet,
            resultCount: filtered.length,
            onSelected: (facet) => setState(() => _facet = facet),
          ),
        ),
        SliverToBoxAdapter(
          child: _ReadingBody(
            featured: featured,
            showFeatured: featured.matches(_facet),
            visitorArticles: visitorArticles,
            articles: rest,
            onRead: (article) => _openUri(context, article.url, 'readError'),
            onOpenMaps:
                (article) =>
                    _openUri(context, article.googleMapsUri, 'readMapsError'),
          ),
        ),
      ],
    );
  }
}

class _ReadingFilters extends StatelessWidget {
  const _ReadingFilters({
    required this.selected,
    required this.resultCount,
    required this.onSelected,
  });

  final ArticleFacet selected;
  final int resultCount;
  final ValueChanged<ArticleFacet> onSelected;

  String _label(AppLocalizations copy, ArticleFacet facet) => switch (facet) {
    ArticleFacet.all => copy.t('readFilterAll'),
    ArticleFacet.japanese => copy.t('readFilterJapanese'),
    ArticleFacet.english => copy.t('readFilterEnglish'),
    ArticleFacet.neighborhood => copy.t('readFilterNeighborhood'),
    ArticleFacet.people => copy.t('readFilterPeople'),
    ArticleFacet.sound => copy.t('readFilterSound'),
    ArticleFacet.film => copy.t('readFilterFilm'),
    ArticleFacet.practical => copy.t('readFilterPractical'),
  };

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: SideBSizes.contentMaxWidth),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            SideBSpacing.lg,
            0,
            SideBSpacing.lg,
            SideBSpacing.xl,
          ),
          child: Semantics(
            container: true,
            label: copy.t('readFilterLabel'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        copy.t('readFilterLabel'),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Text(
                      copy.locale.languageCode == 'ja'
                          ? '$resultCount${copy.t('readResultCount')}'
                          : '$resultCount ${copy.t('readResultCount')}',
                      key: const ValueKey('reading-result-count'),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: SideBColors.vermilion,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SideBSpacing.sm),
                Wrap(
                  spacing: SideBSpacing.xs,
                  runSpacing: SideBSpacing.xs,
                  children: [
                    for (final facet in ArticleFacet.values)
                      FilterChip(
                        key: ValueKey('reading-filter-${facet.name}'),
                        label: Text(_label(copy, facet)),
                        selected: selected == facet,
                        onSelected: (_) => onSelected(facet),
                        tooltip: _label(copy, facet),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReadingIntro extends StatelessWidget {
  const _ReadingIntro({required this.copy});
  final AppLocalizations copy;

  @override
  Widget build(BuildContext context) {
    final isJapanese = copy.locale.languageCode == 'ja';
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: SideBSizes.contentMaxWidth),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            SideBSpacing.lg,
            SideBSpacing.lg,
            SideBSpacing.lg,
            SideBSpacing.xl,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 760;
              final title = Text(
                copy.t('readTitle'),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isJapanese ? (wide ? 52 : 42) : (wide ? 64 : 48),
                  height: isJapanese ? 1.05 : .94,
                  letterSpacing: isJapanese ? -1 : -2.4,
                ),
              );
              final note = Container(
                decoration: BoxDecoration(
                  color: SideBColors.albumYellow,
                  borderRadius: BorderRadius.circular(SideBRadii.extraLarge),
                ),
                padding: const EdgeInsets.all(SideBSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      copy.t('readKicker'),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: SideBColors.oxblood,
                      ),
                    ),
                    const SizedBox(height: SideBSpacing.sm),
                    Text(
                      copy.t('readBody'),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
              if (!wide) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    title,
                    const SizedBox(height: SideBSpacing.lg),
                    note,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(flex: 6, child: title),
                  const SizedBox(width: SideBSpacing.xxl),
                  Expanded(flex: 4, child: note),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ReadingBody extends StatelessWidget {
  const _ReadingBody({
    required this.featured,
    required this.showFeatured,
    required this.visitorArticles,
    required this.articles,
    required this.onRead,
    required this.onOpenMaps,
  });

  final CuratedArticle featured;
  final bool showFeatured;
  final List<CuratedArticle> visitorArticles;
  final List<CuratedArticle> articles;
  final ValueChanged<CuratedArticle> onRead;
  final ValueChanged<CuratedArticle> onOpenMaps;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: SideBSizes.contentMaxWidth),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            SideBSpacing.lg,
            0,
            SideBSpacing.lg,
            SideBSpacing.display,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showFeatured) ...[
                _SectionLabel(number: '01', label: copy.t('readFeatured')),
                const SizedBox(height: SideBSpacing.md),
                _FeaturedArticle(
                  article: featured,
                  onRead: onRead,
                  onOpenMaps: onOpenMaps,
                ),
                const SizedBox(height: SideBSpacing.xxl),
              ],
              if (visitorArticles.isNotEmpty) ...[
                _SectionLabel(number: '02', label: copy.t('readVisitor')),
                const SizedBox(height: SideBSpacing.sm),
                Text(
                  copy.t('readVisitorBody'),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: SideBSpacing.md),
                _ArticleGrid(
                  articles: visitorArticles,
                  onRead: onRead,
                  onOpenMaps: onOpenMaps,
                ),
                const SizedBox(height: SideBSpacing.xxl),
              ],
              if (articles.isNotEmpty) ...[
                _SectionLabel(number: '03', label: copy.t('readShelf')),
                const SizedBox(height: SideBSpacing.md),
                _ArticleGrid(
                  articles: articles,
                  onRead: onRead,
                  onOpenMaps: onOpenMaps,
                ),
              ],
              if (!showFeatured && visitorArticles.isEmpty && articles.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: SideBSpacing.xxl,
                  ),
                  child: Text(
                    copy.t('readFilterEmpty'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              const SizedBox(height: SideBSpacing.xl),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: SideBSpacing.md),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.open_in_new, size: 18),
                      const SizedBox(width: SideBSpacing.sm),
                      Expanded(
                        child: Text(
                          copy.t('readDisclosure'),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticleGrid extends StatelessWidget {
  const _ArticleGrid({
    required this.articles,
    required this.onRead,
    required this.onOpenMaps,
  });

  final List<CuratedArticle> articles;
  final ValueChanged<CuratedArticle> onRead;
  final ValueChanged<CuratedArticle> onOpenMaps;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final columns = constraints.maxWidth >= 760 ? 2 : 1;
      final cardWidth =
          columns == 2
              ? (constraints.maxWidth - SideBSpacing.lg) / 2
              : constraints.maxWidth;
      return Wrap(
        spacing: SideBSpacing.lg,
        runSpacing: SideBSpacing.lg,
        children: [
          for (final article in articles)
            SizedBox(
              width: cardWidth,
              child: _ArticleCard(
                article: article,
                onRead: onRead,
                onOpenMaps: onOpenMaps,
              ),
            ),
        ],
      );
    },
  );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.number, required this.label});
  final String number;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(
        number,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: SideBColors.vermilion),
      ),
      const SizedBox(width: SideBSpacing.md),
      Expanded(child: Divider(color: Theme.of(context).colorScheme.outline)),
      const SizedBox(width: SideBSpacing.md),
      Flexible(
        flex: 3,
        child: Text(
          label,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    ],
  );
}

class _FeaturedArticle extends StatelessWidget {
  const _FeaturedArticle({
    required this.article,
    required this.onRead,
    required this.onOpenMaps,
  });
  final CuratedArticle article;
  final ValueChanged<CuratedArticle> onRead;
  final ValueChanged<CuratedArticle> onOpenMaps;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    final languageCode = copy.locale.languageCode;
    return Card(
      color: SideBColors.midnight,
      child: Padding(
        padding: const EdgeInsets.all(SideBSpacing.xl),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 720;
            final artwork = SizedBox(
              width: wide ? 320 : double.infinity,
              child: _ArticleThumbnail(article: article, featured: true),
            );
            final content = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ArticleMeta(article: article, onDark: true),
                const SizedBox(height: SideBSpacing.md),
                Text(
                  article.titleFor(languageCode),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: SideBColors.white,
                    fontSize: wide ? 32 : 26,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: SideBSpacing.md),
                Text(
                  article.noteFor(languageCode),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: SideBColors.ivory),
                ),
                const SizedBox(height: SideBSpacing.lg),
                _Tags(article: article, onDark: true),
                const SizedBox(height: SideBSpacing.lg),
                Wrap(
                  spacing: SideBSpacing.sm,
                  runSpacing: SideBSpacing.sm,
                  children: [
                    FilledButton.icon(
                      key: ValueKey('maps-${article.id}'),
                      onPressed: () => onOpenMaps(article),
                      icon: const Icon(Icons.map_outlined),
                      label: Text(copy.t('readMaps')),
                      style: FilledButton.styleFrom(
                        backgroundColor: SideBColors.albumYellow,
                        foregroundColor: SideBColors.ink,
                      ),
                    ),
                    OutlinedButton.icon(
                      key: ValueKey('read-${article.id}'),
                      onPressed: () => onRead(article),
                      icon: const Icon(Icons.north_east),
                      label: Text(copy.t('readArticle')),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: SideBColors.ivory,
                        side: const BorderSide(color: SideBColors.ivory),
                      ),
                    ),
                  ],
                ),
              ],
            );
            if (!wide) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  artwork,
                  const SizedBox(height: SideBSpacing.lg),
                  content,
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                artwork,
                const SizedBox(width: SideBSpacing.xl),
                Expanded(child: content),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({
    required this.article,
    required this.onRead,
    required this.onOpenMaps,
  });
  final CuratedArticle article;
  final ValueChanged<CuratedArticle> onRead;
  final ValueChanged<CuratedArticle> onOpenMaps;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    final languageCode = copy.locale.languageCode;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ArticleThumbnail(article: article),
          Padding(
            padding: const EdgeInsets.all(SideBSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ArticleMeta(article: article),
                const SizedBox(height: SideBSpacing.md),
                Text(
                  article.titleFor(languageCode),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 20, height: 1.3),
                ),
                const SizedBox(height: SideBSpacing.sm),
                Text(
                  article.noteFor(languageCode),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: SideBSpacing.md),
                _Tags(article: article),
                const SizedBox(height: SideBSpacing.sm),
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: SideBSpacing.xs,
                  runSpacing: SideBSpacing.xs,
                  children: [
                    FilledButton.tonalIcon(
                      key: ValueKey('maps-${article.id}'),
                      onPressed: () => onOpenMaps(article),
                      icon: const Icon(Icons.map_outlined, size: 18),
                      label: Text(copy.t('readMaps')),
                    ),
                    TextButton.icon(
                      key: ValueKey('read-${article.id}'),
                      onPressed: () => onRead(article),
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.north_east, size: 18),
                      label: Text(copy.t('readArticle')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleThumbnail extends StatelessWidget {
  const _ArticleThumbnail({required this.article, this.featured = false});

  final CuratedArticle article;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(SideBRadii.medium),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                article.thumbnailAsset,
                key: ValueKey('read-thumbnail-${article.id}'),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const _AiThumbnailFallback(),
              ),
              ColoredBox(color: SideBColors.midnight.withValues(alpha: .14)),
              Positioned(
                left: SideBSpacing.md,
                right: SideBSpacing.md,
                bottom: SideBSpacing.md,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: SideBColors.midnight.withValues(alpha: .86),
                            borderRadius: BorderRadius.circular(
                              SideBRadii.round,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SideBSpacing.sm,
                              vertical: SideBSpacing.xs,
                            ),
                            child: Text(
                              article.source.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(
                                context,
                              ).textTheme.labelSmall?.copyWith(
                                color: SideBColors.white,
                                fontWeight: FontWeight.w700,
                                letterSpacing: .8,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (featured) ...[
                      const SizedBox(width: SideBSpacing.sm),
                      const Text(
                        '33⅓',
                        style: TextStyle(
                          fontFamily: 'Futura',
                          color: SideBColors.albumYellow,
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          height: .9,
                          letterSpacing: -1.5,
                          shadows: [
                            Shadow(color: SideBColors.midnight, blurRadius: 8),
                          ],
                        ),
                      ),
                    ],
                    if (article.thumbnailKind ==
                        ArticleThumbnailKind.aiGenerated) ...[
                      const SizedBox(width: SideBSpacing.sm),
                      const _AiImageBadge(),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AiThumbnailFallback extends StatelessWidget {
  const _AiThumbnailFallback();

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      Image.asset(
        'assets/images/articles/ai-fallback.jpg',
        fit: BoxFit.cover,
        filterQuality: FilterQuality.medium,
      ),
      const Positioned(
        top: SideBSpacing.sm,
        right: SideBSpacing.sm,
        child: _AiImageBadge(),
      ),
    ],
  );
}

class _AiImageBadge extends StatelessWidget {
  const _AiImageBadge();

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: SideBColors.albumYellow,
      borderRadius: BorderRadius.circular(SideBRadii.round),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SideBSpacing.sm,
        vertical: SideBSpacing.xs,
      ),
      child: Text(
        'AI VISUAL',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: SideBColors.ink,
          fontWeight: FontWeight.w800,
          letterSpacing: .6,
        ),
      ),
    ),
  );
}

class _ArticleMeta extends StatelessWidget {
  const _ArticleMeta({required this.article, this.onDark = false});
  final CuratedArticle article;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final color = onDark ? SideBColors.albumYellow : SideBColors.vermilion;
    final secondary = onDark ? SideBColors.ivory : SideBColors.inkSoft;
    return Wrap(
      spacing: SideBSpacing.sm,
      runSpacing: SideBSpacing.xs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          article.source.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
        ),
        Text(
          '${article.author}  /  ${article.dateLabel}',
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: secondary, letterSpacing: .5),
        ),
      ],
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags({required this.article, this.onDark = false});
  final CuratedArticle article;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final languageCode = AppLocalizations.of(context).locale.languageCode;
    return Wrap(
      spacing: SideBSpacing.xs,
      runSpacing: SideBSpacing.xs,
      children: [
        for (final tag in article.tagsFor(languageCode))
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SideBSpacing.sm,
              vertical: SideBSpacing.xs,
            ),
            decoration: BoxDecoration(
              color:
                  onDark
                      ? SideBColors.white.withValues(alpha: .08)
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(SideBRadii.round),
              border: Border.all(
                color:
                    onDark
                        ? SideBColors.white.withValues(alpha: .3)
                        : Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            child: Text(
              tag,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: onDark ? SideBColors.ivory : SideBColors.inkSoft,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
