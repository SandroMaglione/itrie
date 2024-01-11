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

    group('inspect', () {
      test('toString', () {
        final itrie = ITrie<int>.empty().insert("call", 0).insert("me", 1);
        expect(itrie.toString(), "[(call, 0), (me, 1)]");
      });
    });
  });
}
