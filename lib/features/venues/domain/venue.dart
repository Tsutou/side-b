enum VenueType { listeningBar, musicBar, jazzBar, djBar, recordBar }

class Venue {
  const Venue({
    required this.id,
    required this.name,
    required this.area,
    required this.areaJa,
    required this.type,
    required this.genres,
    required this.signals,
    required this.signalsJa,
    required this.editorialNote,
    required this.editorialNoteJa,
    required this.hours,
    required this.price,
    required this.mapX,
    required this.mapY,
    required this.imageAlignment,
    required this.imageAsset,
  });

  final String id;
  final String name;
  final String area;
  final String areaJa;
  final VenueType type;
  final List<String> genres;
  final List<String> signals;
  final List<String> signalsJa;
  final String editorialNote;
  final String editorialNoteJa;
  final String hours;
  final String price;
  final double mapX;
  final double mapY;
  final double imageAlignment;
  final String imageAsset;

  String get typeLabel => switch (type) {
    VenueType.listeningBar => 'LISTENING BAR',
    VenueType.musicBar => 'MUSIC BAR',
    VenueType.jazzBar => 'JAZZ BAR',
    VenueType.djBar => 'DJ BAR',
    VenueType.recordBar => 'RECORD BAR',
  };

  String areaFor(String languageCode) => languageCode == 'ja' ? areaJa : area;

  String typeLabelFor(String languageCode) {
    if (languageCode != 'ja') return typeLabel;
    return switch (type) {
      VenueType.listeningBar => 'リスニングバー',
      VenueType.musicBar => 'ミュージックバー',
      VenueType.jazzBar => 'ジャズバー',
      VenueType.djBar => 'DJバー',
      VenueType.recordBar => 'レコードバー',
    };
  }

  String editorialNoteFor(String languageCode) =>
      languageCode == 'ja' ? editorialNoteJa : editorialNote;

  List<String> signalsFor(String languageCode) =>
      languageCode == 'ja' ? signalsJa : signals;
}
