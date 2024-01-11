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

  @override
  // TODO: implement current
  T get current => throw UnimplementedError();

  @override
  bool moveNext() {
    // TODO: implement moveNext
    throw UnimplementedError();
  }
}

class ITrie<V> extends Iterable<V> {
  @override
  Iterator<V> get iterator => ITrieIterator();
}
