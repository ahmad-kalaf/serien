import 'package:hive_ce/hive.dart';

part 'serie.g.dart'; // Wird automatisch generiert

/// Repräsentiert eine Serie mit Namen, Anzahl Staffeln, Bewertung und Erscheinungsjahr
@HiveType(typeId: 0)
class Serie extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int anzahlStaffel;

  @HiveField(2)
  int bewertung;

  @HiveField(3)
  DateTime erscheinungsjahr;

  /// Konstruktor für die Klasse Serie
  Serie(this.name, this.anzahlStaffel, this.bewertung, this.erscheinungsjahr);

  @override
  String toString() {
    return '${name.length > 40 ? '${name.substring(0, 40)}...' : name}\nAnzahl Staffeln: $anzahlStaffel\nBewertung (0 bis 5 Sterne): $bewertung\nErstausstrahlung: ${erscheinungsjahr.year}';
  }
}
