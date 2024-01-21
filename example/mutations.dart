import 'package:itrie/itrie.dart';

void main() {
  final itrie = ITrie<int>.empty();

  final insert = itrie.insert("key", 10);
  final remove = itrie.remove("key");
  final modify = itrie.modify("key", (value) => value + 1);
  final insertMany = itrie.insertMany([("key2", 20)]);
  final removeMany = itrie.removeMany(["key"]);
}
