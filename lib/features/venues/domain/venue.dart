enum VenueType { listeningBar, musicBar, jazzBar, djBar, recordBar }

class Venue {
  const Venue({
    required this.id,
    required this.name,
    required this.area,
    required this.type,
    required this.genres,
    required this.signals,
    required this.editorialNote,
    required this.hours,
    required this.price,
    required this.mapX,
    required this.mapY,
    required this.imageAlignment,
  });

  final String id;
  final String name;
  final String area;
  final VenueType type;
  final List<String> genres;
  final List<String> signals;
  final String editorialNote;
  final String hours;
  final String price;
  final double mapX;
  final double mapY;
  final double imageAlignment;

  String get typeLabel => switch (type) {
    VenueType.listeningBar => 'LISTENING BAR',
    VenueType.musicBar => 'MUSIC BAR',
    VenueType.jazzBar => 'JAZZ BAR',
    VenueType.djBar => 'DJ BAR',
    VenueType.recordBar => 'RECORD BAR',
  };
}
