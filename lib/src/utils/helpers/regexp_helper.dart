class RegExpHelper {
  static RegExp get androidVersionRegExp => RegExp(r',\[\[\["([0-9,\.]*)"]],');
  static RegExp get androidVersionWithAlphabetRegExp => RegExp(r'<div class="reAt0">[0-9.a-zA-Z]+<\/div>');
  static RegExp get onlyNumericVersionRegExp => RegExp(r'[0-9.]');

  static bool isVersionOnlyNumeric(String version) {
    return onlyNumericVersionRegExp.allMatches(version).length == version.length;
  }
}
