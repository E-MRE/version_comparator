import 'package:flutter_test/flutter_test.dart';
import 'package:version_comparator/src/models/entities/empty_entity_model.dart';
import 'package:version_comparator/src/models/entities/store_model.dart';
import 'package:version_comparator/src/models/parameters/custom_version_compare_parameter_model.dart';
import 'package:version_comparator/src/services/concretes/android_json_to_version_response_manager.dart';

import 'package:version_comparator/version_comparator.dart';

void main() {
  test('Compare equality of Android app version and store version with customVersionCompare test', () async {
    final parameter = CustomVersionCompareParameterModel(
      currentAppVersion: '1.0',
      store: StoreModel.android(),
      query: 'id=com.ebg.qrbarcode',
      parseModel: EmptyEntityModel.empty(),
      jsonToResponseService: AndroidJsonToVersionResponseManager(),
    );

    final result = await VersionComparator().customVersionCompare(parameter);

    expect(result.isSuccess, true);
    expect(result.data == null, false);
    expect(result.data?.isAppVersionOld ?? true, false);
  });
}
