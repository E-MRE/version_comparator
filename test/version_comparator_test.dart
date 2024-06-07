import 'package:flutter_test/flutter_test.dart';
import 'package:version_comparator/version_comparator.dart';

void main() {
  test(
      'Compare equality of Android app version and store version with customVersionCompare test',
      () async {
    final result = await VersionComparator.instance.customCompare(
      localVersion: 'ADD_YOUR_APP_LOCAL_VERSION',
      store: AndroidStoreModel('ADD_YOUR_BUNDLE_ID'),
      customUpdateLink: (responseBody) => 'Custom app update link. (Optional)',
      onConvertVersion: (responseBody) =>
          'Convert store version from response.body',
    );

    expect(result.isSuccess, true);
    expect(result.data == null, false);
    expect(result.data?.isAppVersionOld ?? true, false);
  });

  test(
      'Compare equality of iOS app version and store version with customVersionCompare test',
      () async {
    final result = await VersionComparator.instance.customCompare(
      localVersion: 'ADD_YOUR_APP_LOCAL_VERSION',
      store: IosStoreModel('ADD_YOUR_BUNDLE_ID'),
      customUpdateLink: (responseBody) => 'Custom app update link. (Optional)',
      onConvertVersion: (responseBody) =>
          'Convert store version from response.body',
    );

    expect(result.isSuccess, true);
    expect(result.data == null, false);
    expect(result.data?.isAppVersionOld ?? true, false);
  });

  test(
      'Compare equality of Huawei app version and store version with customVersionCompare test',
      () async {
    final result = await VersionComparator.instance.customCompare(
      localVersion: 'ADD_YOUR_APP_LOCAL_VERSION',
      store: HuaweiStoreModel('ADD_YOUR_HUAWEI_APP_ID_FROM_APP_GALLERY'),
      customUpdateLink: (responseBody) => 'Custom app update link. (Optional)',

      ///convert response body for app version. You can convert response body using HuaweiVersionConverter for Huawei
      onConvertVersion: (responseBody) =>
          'Convert store version from response.body',

      ///get interface code from HuaweiVersionComparatorManager.
      ///interface code format --> '$interfaceCode_${DateTime.now().millisecondsSinceEpoch}'
      customHeader: Map.fromEntries([
        const MapEntry('Interface-Code', 'ADD_INTERFACE_CODE_WITH_TIMESTAMP')
      ]),
    );

    expect(result.isSuccess, true);
    expect(result.data == null, false);
    expect(result.data?.isAppVersionOld ?? true, false);
  });
}
