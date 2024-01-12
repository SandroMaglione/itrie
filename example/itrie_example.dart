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
    final itrie = ITrie<int>.fromIterable(
      await lines
          .map(
            (key) => (key.toLowerCase(), key.length),
          )
          .toList(),
    );

    while (true) {
      print("Search a word\n");
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
