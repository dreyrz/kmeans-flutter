mixin ListUtils<T> {
  T? firstOrNull(List<T> list) {
    if (list.isEmpty) {
      return null;
    } else {
      return list.first;
    }
  }

  T? lastOrNull(List<T> list) {
    if (list.isEmpty) {
      return null;
    } else {
      return list.last;
    }
  }
}
