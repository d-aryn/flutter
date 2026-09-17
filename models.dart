class Author {
  final String name;
  final String? country;

  const Author(this.name, this.country);

  @override
  String toString() => country != null ? '$name ($country)' : name;
}

enum Genre {
  craft('Craft'),
  theory('Theory'),
  unknown('Unknown');

  final String label;
  const Genre(this.label);

  static Genre fromString(String? raw) {
    switch (raw) {
      case 'craft':
        return Genre.craft;
      case 'theory':
        return Genre.theory;
      default:
        return Genre.unknown;
    }
  }
}

abstract class LibraryItem {
  final String title;
  final int year;

  const LibraryItem(this.title, this.year);

  String describe();

  bool get isOld => year < 2000;
}

mixin Borrowable on LibraryItem {
  String borrowLabel() => 'Borrow "$title"';
}

class Book extends LibraryItem with Borrowable {
  final int pages;
  final Author author;
  final Genre genre;
  final String? description;

  const Book({
    required String title,
    required int year,
    required this.pages,
    required this.author,
    required this.genre,
    this.description,
  }) : super(title, year);

  factory Book.fromJson(Map<String, dynamic> json) {
    final authorName = json['author'] as String? ?? 'Unknown';
    final country = json['country'] as String?;

    return Book(
      title: json['title'] as String? ?? 'Untitled',
      year: json['year'] as int? ?? 0,
      pages: json['pages'] as int? ?? 0,
      author: Author(authorName, country),
      genre: Genre.fromString(json['genre'] as String?),
      description: json['description'] as String?,
    );
  }

  bool get isLong => pages > 400;

  Book copyWith({
    String? title,
    int? year,
    int? pages,
    Author? author,
    Genre? genre,
    String? description,
  }) {
    return Book(
      title: title ?? this.title,
      year: year ?? this.year,
      pages: pages ?? this.pages,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
    );
  }

  @override
  String describe() => '$title by $author (${genre.label})';

  @override
  String toString() =>
      '$title ($year) by $author — ${genre.label}, $pages pages';
}

class Magazine extends LibraryItem {
  final int issue;

  const Magazine(String title, int year, this.issue) : super(title, year);

  @override
  String describe() => '$title — Issue #$issue ($year)';
}

class Ghost implements LibraryItem {
  @override
  final String title;

  @override
  final int year;

  const Ghost(this.title, this.year);

  @override
  String describe() => '??? ($title, $year) — nobody knows';

  @override
  bool get isOld => year < 2000;
}