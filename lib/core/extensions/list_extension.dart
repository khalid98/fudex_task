extension ListExtension<T> on List<T> {
  bool get isEmptyOrNull {
    if (this == null || this.isEmpty) {
      return true; // Null or empty list has no valid extension
    }
    return false; // Valid extension found
  }
}