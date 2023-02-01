import 'package:flutter_test/flutter_test.dart';

import 'package:version_comparator/version_comparator.dart';

void main() {
  test('Compare app and store version are equals test', () async {
    final result = await VersionComparator.comparedVersion;
    expect(result.isSuccess, true);
    expect(result.data == null, false);
    expect(result.data?.isAppVersionOld ?? true, false);
  });
}
