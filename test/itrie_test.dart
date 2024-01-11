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
    });

    group('inspect', () {
      test('toString', () {
        final itrie = ITrie<int>.empty().insert("call", 0).insert("me", 1);
        expect(itrie.toString(), "[(call, 0), (me, 1)]");
      });
    });
  });
}
