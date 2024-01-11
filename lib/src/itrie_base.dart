class _Node<V> {
  final String key;
  int count;
  V? value;

  final _Node<V>? left;
  final _Node<V>? mid;
  final _Node<V>? right;

  _Node({
    required this.key,
    required this.count,
    this.value,
    this.left,
    this.mid,
    this.right,
  });
}

class ITrieIterator<V, T> implements Iterator<T> {
  List<(_Node<V>, String, bool)> stack = [];
  late T _current;

  final ITrie<V> _trie;
  final T Function(String key, V value) mapF;
  final bool Function(String key, V value) filterF;

  ITrieIterator(this._trie, this.mapF, this.filterF) {
    final root = _trie._root;
    if (root != null) {
      stack.add((root, "", false));
    }
  }

  @override
  T get current => _current;

  @override
  bool moveNext() {
    while (stack.isNotEmpty) {
      final (node, keyString, isAdded) = stack.removeLast();

      if (isAdded) {
        final value = node.value;
        if (value != null) {
          final key = keyString + node.key;
          if (filterF(key, value)) {
            _current = mapF(key, value);
            return true;
          }
        }
      } else {
        _addToStack(node, keyString);
      }
    }

    return false;
  }

  void _addToStack(_Node<V> node, String keyString) {
    final right = node.right;
    if (right != null) {
      stack.add((right, keyString, false));
    }

    final mid = node.mid;
    if (mid != null) {
      stack.add((mid, keyString + node.key, false));
    }
    stack.add((node, keyString, true));

    final left = node.left;
    if (left != null) {
      stack.add((left, keyString, false));
    }
  }
}

class ITrie<V> extends Iterable<(String, V)> {
  final _Node<V>? _root;
  int? count;

  ITrie._(this._root);

  factory ITrie.empty() => ITrie._(null);
  factory ITrie.fromIterable(Iterable<(String, V)> entries) {
    ITrie<V> itrie = ITrie.empty();
    for (final (key, value) in entries) {
      itrie = itrie.insert(key, value);
    }
    return itrie;
  }

  @override
  Iterator<(String, V)> get iterator => ITrieIterator(
        this,
        (key, value) => (key, value),
        (_, __) => true,
      );

  ITrie<V> insert(String key, V value) {
    if (key.isEmpty) return this;

    // -1:left | 0:mid | 1:right
    final List<int> dStack = [];
    final List<_Node<V>> nStack = [];

    _Node<V> n = _root ?? _Node(key: key[0], count: 0);
    final count = n.count + 1;
    int cIndex = 0;

    while (cIndex < key.length) {
      final c = key[cIndex];
      nStack.add(n);

      final compare = c.compareTo(n.key);
      if (compare > 0) {
        dStack.add(1);

        final right = n.right;
        if (right == null) {
          n = _Node(key: c, count: count);
        } else {
          n = right;
        }
      } else if (compare < 0) {
        dStack.add(-1);

        final left = n.left;
        if (left == null) {
          n = _Node(key: c, count: count);
        } else {
          n = left;
        }
      } else {
        final mid = n.mid;
        if (cIndex == key.length - 1) {
          n.value = value;
        } else if (mid == null) {
          dStack.add(0);
          n = _Node(key: key[cIndex + 1], count: count);
        } else {
          dStack.add(0);
          n = mid;
        }

        cIndex += 1;
      }
    }

    // Rebuild path to leaf node (Path-copying immutability)
    for (int s = nStack.length - 2; s >= 0; --s) {
      final n2 = nStack[s];
      final d = dStack[s];
      if (d < 0) {
        // left
        nStack[s] = _Node(
          key: n2.key,
          count: count,
          value: n2.value,
          left: nStack[s + 1],
          mid: n2.mid,
          right: n2.right,
        );
      } else if (d > 0) {
        // right
        nStack[s] = _Node(
          key: n2.key,
          count: count,
          value: n2.value,
          left: n2.left,
          mid: n2.mid,
          right: nStack[s + 1],
        );
      } else {
        // mid
        nStack[s] = _Node(
            key: n2.key,
            count: count,
            value: n2.value,
            left: n2.left,
            mid: nStack[s + 1],
            right: n2.right);
      }
    }

    nStack[0].count = count;
    return ITrie._(nStack[0]);
  }

  @override
  String toString() {
    return toList().toString();
  }
}
