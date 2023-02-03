import 'package:flutter_test/flutter_test.dart';
import 'package:version_comparator/src/models/entities/empty_entity_model.dart';
import 'package:version_comparator/src/models/entities/huawei/huawei_version_entity_model.dart';
import 'package:version_comparator/src/models/entities/ios_version_entity_model.dart';
import 'package:version_comparator/src/models/entities/store/android_store_model.dart';
import 'package:version_comparator/src/models/entities/store/huawei_store_model.dart';
import 'package:version_comparator/src/models/entities/store/ios_store_model.dart';
import 'package:version_comparator/src/models/parameters/custom_version_compare_parameter_model.dart';
import 'package:version_comparator/src/services/concretes/android_json_to_version_response_manager.dart';
import 'package:version_comparator/src/services/concretes/huawei_json_to_version_response_manager.dart';
import 'package:version_comparator/src/services/concretes/ios_json_to_version_response_manager.dart';

import 'package:version_comparator/version_comparator.dart';

void main() {
  test('Compare equality of Android app version and store version with customVersionCompare test', () async {
    final parameter = CustomVersionCompareParameterModel(
      currentAppVersion: 'ADD_YOUR_DOWNLOADED_APP_VERSION',
      store: AndroidStoreModel('ADD_YOUR_APP_ID'),
      parseModel: EmptyEntityModel.empty(),
      jsonToResponseService: AndroidJsonToVersionResponseManager(),
    );

    final result = await VersionComparator.instance.customCompare(parameterModel: parameter);

    expect(result.isSuccess, true);
    expect(result.data == null, false);
    expect(result.data?.isAppVersionOld ?? true, false);
  });

  test('Compare equality of iOS app version and store version with customVersionCompare test', () async {
    final parameter = CustomVersionCompareParameterModel(
      currentAppVersion: 'ADD_YOUR_DOWNLOADED_APP_VERSION',
      store: IosStoreModel('ADD_YOUR_APP_ID'),
      parseModel: IosVersionEntityModel(),
      jsonToResponseService: IosJsonToVersionResponseManager(),
      updateLinkGetter: (parseModel) => parseModel.storeUrl,
    );

    final result = await VersionComparator.instance.customCompare(parameterModel: parameter);

    expect(result.isSuccess, true);
    expect(result.data == null, false);
    expect(result.data?.isAppVersionOld ?? true, false);
  });

  test('Compare equality of Huawei app version and store version with customVersionCompare test', () async {
    final parameter = CustomVersionCompareParameterModel(
      currentAppVersion: '[ADD_YOUR_DOWNLOADED_APP_VERSION]',
      store: HuaweiStoreModel('[ADD_YOUR_APP_ID_FROM_APP_GALLERY]'),
      parseModel: HuaweiVersionEntityModel.empty(),
      jsonToResponseService: HuaweiJsonToVersionResponseManager(),
      updateLinkGetter: (parseModel) => parseModel.storeUrl('[ADD_YOUR_APP_ID_FROM_APP_GALLERY]'),
    );

    final result = await VersionComparator.instance.customCompare(parameterModel: parameter);

    expect(result.isSuccess, true);
    expect(result.data == null, false);
    expect(result.data?.isAppVersionOld ?? true, false);
  });
}
