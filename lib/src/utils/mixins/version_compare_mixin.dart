import '../constants/constants.dart';
import '../helpers/regexp_helper.dart';

mixin VersionCompareMixin {
  bool isCurrentVersionOld({required String currentVersion, required String storeVersion, int defaultValue = kZero}) {
    if (currentVersion.isEmpty || storeVersion.isEmpty) return true;

    final convertedCurrentVersion = _convertVersion(currentVersion, defaultValue);
    final convertedStoreVersion = _convertVersion(storeVersion, defaultValue);

    if (convertedCurrentVersion is int && convertedStoreVersion is int) {
      return _isIntVersionOld(convertedCurrentVersion, convertedStoreVersion);
    } else if (convertedCurrentVersion is List<String> && convertedStoreVersion is List<String>) {
      return _isListVersionOld(convertedCurrentVersion, convertedStoreVersion);
    } else {
      return true;
    }
  }

  bool _isIntVersionOld(int currentVersion, int storeVersion) {
    return storeVersion > currentVersion;
  }

  bool _isListVersionOld(List<String> currentVersion, List<String> storeVersion) {
    if (currentVersion.length != storeVersion.length) return true;

    for (var index = 0; index < currentVersion.length; index++) {
      final currentVersionNumber = int.tryParse(currentVersion[index]);
      final storeVersionNumber = int.tryParse(storeVersion[index]);

      if (currentVersionNumber != null && storeVersionNumber != null) {
        if (_isIntVersionOld(currentVersionNumber, storeVersionNumber)) return true;
      } else {
        if (currentVersion[index].toLowerCase() != storeVersion[index].toLowerCase()) return true;
      }
    }

    return false;
  }

  Object _convertVersion(String version, int defaultValue) {
    final isVersionNumeric = RegExpHelper.isVersionOnlyNumeric(version);

    return isVersionNumeric
        ? _convertToInt(version, defaultValue: defaultValue)
        : _convertToList(version, defaultValue: defaultValue.toString());
  }

  int _convertToInt(String version, {int defaultValue = kZero}) {
    final versionList = _convertToList(version, defaultValue: defaultValue.toString());
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

  List<String> _convertToList(String version, {String defaultValue = kEmpty}) {
    // in this dart version, trim() is not working. Alternative solution is replacing
    final trimVersion = version.replaceAll(kSpace, kEmpty);

    final list = trimVersion.split(kVersionSplitter);
    return list.isEmpty ? [defaultValue] : list.reversed.toList();
  }
}
