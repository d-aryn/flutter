import 'data.dart';
import 'models.dart';
import 'catalogue.dart';
import 'shelf_state.dart';

void main() {
  final library = Library();
  library.open();

  final books = rawBooks.map((json) => Book.fromJson(json)).toList();
  for (final book in books) {
    library.add(book);
  }

  print('--- Library opened at ${library.openedAt} ---\n');

  // Level 3: null safety
  print('Find "Refactoring": ${library.findByTitle('Refactoring')}');
  print('Find "Nonexistent": ${library.findByTitle('Nonexistent')}');
  print('Country of "Refactoring": ${library.countryOf('Refactoring')}');
  print('Country of "Design Patterns": ${library.countryOf('Design Patterns')}');
  print('Country of "Nonexistent": ${library.countryOf('Nonexistent')}');
  print(library.buildReport());
  print(library.buildReport());
  print('');

  // Level 4: collections
  print('All titles: ${library.allTitles}');
  print('Books after 2010: ${library.booksAfter2010.map((b) => b.title).toList()}');
  print('Average pages: ${library.averagePages.toStringAsFixed(1)}');
  print('Books per author: ${library.bookCountByAuthor}');
  print('Distinct authors: ${library.authorNames}');
  print('Genres present: ${library.genresPresent}');
  print('');
  print(library.displayList.join('\n'));
  print('');

  // Level 5: Dart 3 — sealed class + switch expression + records
  final stats = statsOf(books);
  print('Stats: count=${stats.count}, avgPages=${stats.avgPages.toStringAsFixed(1)}');
  print('');

  final states = <ShelfState>[
    const Empty(),
    Ready(books),
    const Broken('Shelf collapsed'),
  ];

  for (final state in states) {
    print(describe(state));
  }
}