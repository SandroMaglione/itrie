import 'package:itrie/itrie.dart';
import 'package:test/test.dart';

void main() {
  group('ITrie', () {
    group('constructors', () {
      test('empty', () {
        final itrie = ITrie<int>.empty();
        expect(itrie.firstOrNull, null);
      });

      test('fromIterable', () {
        final itrie = ITrie<int>.fromIterable([
          ("call", 0),
          ("me", 1),
          ("and", 2),
        ]);
        expect(itrie.toList(), [
          ("and", 2),
          ("call", 0),
          ("me", 1),
        ]);
      });
    });

    group('mutations', () {
      test('insert', () {
        final itrie = ITrie<int>.empty().insert("call", 0).insert("me", 1);
        expect(itrie.elementAtOrNull(0), ("call", 0));
        expect(itrie.elementAtOrNull(1), ("me", 1));
      });

      test('remove', () {
        final itrie = ITrie<int>.empty().insert("call", 0).insert("me", 1);
        expect(itrie.remove("call").toList(), [("me", 1)]);
        expect(itrie.remove("me").toList(), [("call", 0)]);
      });

      test('modify', () {
        final itrie = ITrie<int>.empty().insert("call", 0).insert("me", 1);
        expect(itrie.modify("call", (v) => v + 10).toList(),
            [("call", 10), ("me", 1)]);
        expect(itrie.modify("me", (v) => v + 11).toList(),
            [("call", 0), ("me", 12)]);
        expect(itrie.modify("mea", (v) => v + 12).toList(),
            [("call", 0), ("me", 1)]);
      });
    });

    group('getters', () {
      test('length', () {
        final itrieEmpty = ITrie<int>.empty();
        final itrieInsert = itrieEmpty.insert("call", 0);
        expect(itrieEmpty.length, 0);
        expect(itrieInsert.length, 1);
      });

      test('keys', () {
        final itrie = ITrie<int>.empty()
            .insert("call", 0)
            .insert("me", 1)
            .insert("and", 2);
        expect(itrie.keys.toList(), ["and", "call", "me"]);
      });

      test('values', () {
        final itrie = ITrie<int>.empty()
            .insert("call", 0)
            .insert("me", 1)
            .insert("and", 2);
        expect(itrie.values.toList(), [2, 0, 1]);
      });

      test('withPrefix', () {
        final itrie = ITrie<int>.empty()
            .insert("she", 0)
            .insert("shells", 1)
            .insert("sea", 2)
            .insert("sells", 3)
            .insert("by", 4)
            .insert("the", 5)
            .insert("sea", 6)
            .insert("shore", 7);
        expect(itrie.withPrefix("she").toList(), [("she", 0), ("shells", 1)]);
      });

      test('keysWithPrefix', () {
        final itrie = ITrie<int>.empty()
            .insert("she", 0)
            .insert("shells", 1)
            .insert("sea", 2)
            .insert("sells", 3)
            .insert("by", 4)
            .insert("the", 5)
            .insert("sea", 6)
            .insert("shore", 7);
        expect(itrie.keysWithPrefix("she").toList(), ["she", "shells"]);
      });

      test('valuesWithPrefix', () {
        final itrie = ITrie<int>.empty()
            .insert("she", 0)
            .insert("shells", 1)
            .insert("sea", 2)
            .insert("sells", 3)
            .insert("by", 4)
            .insert("the", 5)
            .insert("sea", 6)
            .insert("shore", 7);
        expect(itrie.valuesWithPrefix("she").toList(), [0, 1]);
      });

      test('longestPrefixOf', () {
        final itrie = ITrie<int>.empty()
            .insert("shells", 0)
            .insert("sells", 1)
            .insert("she", 2);

        expect(itrie.longestPrefixOf("sell"), null);
        expect(itrie.longestPrefixOf("sells"), ("sells", 1));
        expect(itrie.longestPrefixOf("shell"), ("she", 2));
        expect(itrie.longestPrefixOf("shellsort"), ("shells", 0));
      });

      test('get', () {
        final itrie = ITrie<int>.empty()
            .insert("shells", 0)
            .insert("sells", 1)
            .insert("she", 2);

        expect(itrie.get("sell"), null);
        expect(itrie.get("sells"), 1);
        expect(itrie.get("shell"), null);
        expect(itrie.get("she"), 2);
      });
    });

    group('inspect', () {
      test('toString', () {
        final itrie = ITrie<int>.empty().insert("call", 0).insert("me", 1);
        expect(itrie.toString(), "[(call, 0), (me, 1)]");
      });
    });
  });
}
