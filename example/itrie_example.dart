import 'dart:convert';
import 'dart:io';

import 'package:itrie/itrie.dart';

void main() async {
  /// Source: https://github.com/dwyl/english-words/blob/master/words.txt
  final file = File('./example/words.txt');
  Stream<String> lines = file.openRead().transform(utf8.decoder).transform(
        LineSplitter(),
      );

  try {
    final sourceList = await lines.toList();
    final selection = sourceList
        .where(
          (key) => key.length >= 2 && RegExp(r'^[A-Za-z]+$').hasMatch(key),
        )
        .map((e) => e.toLowerCase());

    await File('./example/selection.txt')
        .writeAsString(selection.toList().join("\n"));

    final itrie = ITrie<int>.fromIterable(
      selection
          .map(
            (key) => (key.toLowerCase(), key.length),
          )
          .toList(),
    );

    print("Loaded ${itrie.length} words");
    while (true) {
      print("Search a word");
      final line = stdin.readLineSync(encoding: utf8);
      if (line != null) {
        if (line == "q") {
          break;
        }

        print(itrie.get(line));
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}
