import '../constants/constants.dart';

mixin VersionConverterMixin {
  int convertToInt(String version, {int defaultValue = kZero}) {
    if (version.isEmpty) return defaultValue;

    final versionList = version.split(kVersionSplitter);
    int convertedVersion = kZero;

    int multiplier = 1;
    int digitValue = 10;

    for (var element in versionList) {
      final value = int.tryParse(element);
      if (value == null) continue;

      convertedVersion += (value * multiplier);
      multiplier *= digitValue;
    }

    return convertedVersion;
  }
}
