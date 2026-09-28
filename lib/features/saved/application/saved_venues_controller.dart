import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedVenuesController extends ChangeNotifier {
  static const _key = 'saved_venue_ids';
  final Set<String> _ids = {};

  Set<String> get ids => Set.unmodifiable(_ids);
  bool contains(String venueId) => _ids.contains(venueId);

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    _ids
      ..clear()
      ..addAll(preferences.getStringList(_key) ?? const []);
    notifyListeners();
  }

  Future<void> toggle(String venueId) async {
    _ids.contains(venueId) ? _ids.remove(venueId) : _ids.add(venueId);
    notifyListeners();
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(_key, _ids.toList(growable: false));
  }
}
