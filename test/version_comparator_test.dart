import 'package:flutter_test/flutter_test.dart';
import 'package:version_comparator/src/models/entities/empty_entity_model.dart';
import 'package:version_comparator/src/models/entities/huawei/huawei_version_entity_model.dart';
import 'package:version_comparator/src/models/entities/ios_version_entity_model.dart';
import 'package:version_comparator/src/models/entities/store_model.dart';
import 'package:version_comparator/src/models/parameters/custom_version_compare_parameter_model.dart';
import 'package:version_comparator/src/services/concretes/android_json_to_version_response_manager.dart';
import 'package:version_comparator/src/services/concretes/huawei_json_to_version_response_manager.dart';
import 'package:version_comparator/src/services/concretes/ios_json_to_version_response_manager.dart';

import 'package:version_comparator/version_comparator.dart';

void main() {
  test('Compare equality of Android app version and store version with customVersionCompare test', () async {
    final parameter = CustomVersionCompareParameterModel(
      currentAppVersion: 'ADD_YOUR_DOWNLOADED_APP_VERSION',
      store: StoreModel.android(),
      query: 'id=ADD_YOUR_APP_ID',
      parseModel: EmptyEntityModel.empty(),
      jsonToResponseService: AndroidJsonToVersionResponseManager(),
    );

    final result = await VersionComparator().customVersionCompare(parameter);

    expect(result.isSuccess, true);
    expect(result.data == null, false);
    expect(result.data?.isAppVersionOld ?? true, false);
  });

  test('Compare equality of iOS app version and store version with customVersionCompare test', () async {
    final parameter = CustomVersionCompareParameterModel(
      currentAppVersion: 'ADD_YOUR_DOWNLOADED_APP_VERSION',
      store: StoreModel.ios(),
      query: 'bundleId=ADD_YOUR_APP_ID',
      parseModel: IosVersionEntityModel(),
      jsonToResponseService: IosJsonToVersionResponseManager(),
      updateLinkGetter: (parseModel) => parseModel.storeUrl,
    );

    final result = await VersionComparator().customVersionCompare(parameter);

    expect(result.isSuccess, true);
    expect(result.data == null, false);
    expect(result.data?.isAppVersionOld ?? true, false);
  });

  test('Compare equality of Huawei app version and store version with customVersionCompare test', () async {
    final parameter = CustomVersionCompareParameterModel(
      currentAppVersion: '1.0.22',
      store: StoreModel.huawei('C105568597'),
      query: 'method=internal.getTabDetail&uri=app%7CC105568597',
      parseModel: HuaweiVersionEntityModel.empty(),
      jsonToResponseService: HuaweiJsonToVersionResponseManager(),
      updateLinkGetter: (parseModel) => parseModel.storeUrl('C105568597'),
    );

    final result = await VersionComparator().customVersionCompare(parameter);

    expect(result.isSuccess, true);
    expect(result.data == null, false);
    expect(result.data?.isAppVersionOld ?? true, false);
  });
}
