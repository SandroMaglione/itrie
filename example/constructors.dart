import 'package:itrie/itrie.dart';

void main() {
  /// Empty [ITrie] with [int] values
  final empty = ITrie<int>.empty();
  final copy = empty.insert("key", 10);

  /// From [Iterable] containing a record of `(String, T)`
  final fromIterable = ITrie.fromIterable([("key", 10)]);
}
