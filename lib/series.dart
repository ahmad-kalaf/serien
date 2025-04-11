import 'package:hive_ce/hive.dart';

part 'series.g.dart'; // Automatically generated

/// Represents a series with name, number of seasons, rating, and release year
@HiveType(typeId: 0)
class Series extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int numberOfSeasons;

  @HiveField(2)
  int rating;

  @HiveField(3)
  DateTime releaseYear;

  /// Constructor for the Series class
  Series(this.name, this.numberOfSeasons, this.rating, this.releaseYear);

  @override
  String toString() {
    return '${name.length > 40 ? '${name.substring(0, 40)}...' : name}\nNumber of Seasons: $numberOfSeasons\nRating (0 to 5 stars): $rating\nFirst Broadcast: ${releaseYear.year}';
  }
}
