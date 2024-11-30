extension StringExtension on String? {
  bool get isEmptyOrNull {
    if (this == null || this!.isEmpty) {
      return true; // Null or empty string has no valid extension
    }
    return false; // Valid extension found
  }
}
