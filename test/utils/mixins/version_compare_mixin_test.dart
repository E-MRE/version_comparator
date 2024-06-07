import 'package:flutter_test/flutter_test.dart';
import 'package:version_comparator/src/utils/mixins/version_compare_mixin.dart';

void main() {
  test(
    'old app version (1.0.0) and up to date store version (1.0.20) compare test',
    () {
      final mockCompareMixin = MockComparator();
      const currentVersion = '1.0.0';
      const storeVersion = '1.0.20';

      expect(
          mockCompareMixin.isCurrentVersionOld(
              currentVersion: currentVersion, storeVersion: storeVersion),
          true);
    },
  );

  test(
    'equals app version and store version (1.0.0) compare test',
    () {
      final mockCompareMixin = MockComparator();
      const currentVersion = '1.0.0';
      const storeVersion = '1.0.0';

      expect(
          mockCompareMixin.isCurrentVersionOld(
              currentVersion: currentVersion, storeVersion: storeVersion),
          false);
    },
  );

  test(
    'higher app version (1.0.20) and old store version (1.0.0) compare test',
    () {
      final mockCompareMixin = MockComparator();
      const currentVersion = '1.0.20';
      const storeVersion = '1.0.0';

      expect(
          mockCompareMixin.isCurrentVersionOld(
              currentVersion: currentVersion, storeVersion: storeVersion),
          false);
    },
  );

  test(
    'old app version (1.0.0-abc) and up to date store version (1.0.20-abc) compare test',
    () {
      final mockCompareMixin = MockComparator();
      const currentVersion = '1.0.0-abc';
      const storeVersion = '1.0.20-abc';

      expect(
          mockCompareMixin.isCurrentVersionOld(
              currentVersion: currentVersion, storeVersion: storeVersion),
          true);
    },
  );

  test(
    'equals app version and store version (1.0.0-abc) compare test',
    () {
      final mockCompareMixin = MockComparator();
      const currentVersion = '1.0.0-abc';
      const storeVersion = '1.0.0-abc';

      expect(
          mockCompareMixin.isCurrentVersionOld(
              currentVersion: currentVersion, storeVersion: storeVersion),
          false);
    },
  );

  test(
    'higher app version (1.0.20-abc) and old store version (1.0.0-abc) compare test. Its expected version is old because string parameters is not equals',
    () {
      final mockCompareMixin = MockComparator();
      const currentVersion = '1.0.20-abc';
      const storeVersion = '1.0.0-abc';

      expect(
          mockCompareMixin.isCurrentVersionOld(
              currentVersion: currentVersion, storeVersion: storeVersion),
          true);
    },
  );
}

class MockComparator with VersionCompareMixin {}
