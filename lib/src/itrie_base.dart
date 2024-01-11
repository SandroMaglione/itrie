class _Node<V> {
  final String key;
  final int count;
  final V? value;
  final _Node<V>? left;
  final _Node<V>? mid;
  final _Node<V>? right;
  const _Node({
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
  _Node<V>? _root;
  int? count;

  @override
  Iterator<(String, V)> get iterator => ITrieIterator(
        this,
        (key, value) => (key, value),
        (_, __) => true,
      );
}
