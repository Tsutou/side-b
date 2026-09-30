class CuratedArticle {
  const CuratedArticle({
    required this.id,
    required this.source,
    required this.author,
    required this.dateLabel,
    required this.titleJa,
    required this.titleEn,
    required this.noteJa,
    required this.noteEn,
    required this.tagsJa,
    required this.tagsEn,
    required this.url,
    this.featured = false,
    this.visitorPick = false,
  });

  final String id;
  final String source;
  final String author;
  final String dateLabel;
  final String titleJa;
  final String titleEn;
  final String noteJa;
  final String noteEn;
  final List<String> tagsJa;
  final List<String> tagsEn;
  final Uri url;
  final bool featured;
  final bool visitorPick;

  String titleFor(String languageCode) =>
      languageCode == 'ja' ? titleJa : titleEn;

  String noteFor(String languageCode) => languageCode == 'ja' ? noteJa : noteEn;

  List<String> tagsFor(String languageCode) =>
      languageCode == 'ja' ? tagsJa : tagsEn;
}
