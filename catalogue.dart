import 'models.dart';

class Library {
  final List<LibraryItem> items = [];

  void add(LibraryItem item) => items.add(item);

  // Level 3: null safety 

  Book? findByTitle(String title) {
    for (final item in items) {
      if (item is Book && item.title == title) return item;
    }
    return null;
  }

  String countryOf(String title) =>
      findByTitle(title)?.author.country ?? 'unknown';

  late final DateTime openedAt;

  void open() {
    openedAt = DateTime.now();
  }

  String? _cachedReport;

  String buildReport() {
    return _cachedReport ??= _generateReport();
  }

  String _generateReport() {
    final count = items.length;
    return 'Library has $count item(s).';
  }

  // Level 4: collections 

  List<String> get allTitles => items.map((i) => i.title).toList();

  List<Book> get booksAfter2010 =>
      items.whereType<Book>().where((b) => b.year > 2010).toList();

  double get averagePages {
    final books = items.whereType<Book>().toList();
    return books.isEmpty
        ? 0
        : books.fold<int>(0, (sum, b) => sum + b.pages) / books.length;
  }

  Map<String, int> get bookCountByAuthor =>
      items.whereType<Book>().fold<Map<String, int>>({}, (map, b) {
        map[b.author.name] = (map[b.author.name] ?? 0) + 1;
        return map;
      });

  Set<String> get authorNames =>
      items.whereType<Book>().map((b) => b.author.name).toSet();

  Set<Genre> get genresPresent =>
      items.whereType<Book>().map((b) => b.genre).toSet();


  List<String> get displayList {
    final books = items.whereType<Book>().toList();
    return [
      'CATALOGUE',
      for (final b in books) '${b.title} (${b.year})',
      ...authorNames,
      if (books.any((b) => b.pages == 0)) '(incomplete data)',
    ];
  }
}