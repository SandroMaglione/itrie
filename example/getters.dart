import 'package:itrie/itrie.dart';

void main() {
  final itrie = ITrie<int>.empty();

  final getV = itrie.get("key");
  final longestPrefixOf = itrie.longestPrefixOf("keys");
  final withPrefix = itrie.withPrefix("ke");
  final keysWithPrefix = itrie.keysWithPrefix("ke");
  final valuesWithPrefix = itrie.valuesWithPrefix("ke");
  final keys = itrie.keys;
  final values = itrie.values;
  final length = itrie.length;
  final has = itrie.has("key");
}
