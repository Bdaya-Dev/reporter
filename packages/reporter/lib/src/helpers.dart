class Grouping<TKey, TVal> extends Iterable<TVal> {
  final TKey key;
  final Iterable<TVal> items;

  Grouping(this.key, this.items);

  @override
  Iterator<TVal> get iterator => items.iterator;
}

extension IterableExt<T> on Iterable<T> {
  Iterable<Grouping<TKey, T>> groupBy<TKey>(
    TKey Function(T item) keySelector,
  ) {
    final res = <TKey, List<T>>{};
    for (final item in this) {
      final key = keySelector(item);
      final list = res[key] ??= <T>[];
      list.add(item);
    }
    return res.entries.map((e) => Grouping(e.key, e.value));
  }
}
