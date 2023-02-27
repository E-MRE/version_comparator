extension StringExtension on String? {
  bool get isNullOrEmpty {
    if (this == null) return true;

    return this!.isEmpty;
  }

  bool get isNotNullAndNotEmpty => !isNullOrEmpty;
}
