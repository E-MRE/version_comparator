library version_comparator;

import 'dart:io';

import 'package:version_comparator/src/models/version_response_model.dart';
import 'package:version_comparator/src/services/concretes/android_version_compare_manager.dart';
import 'package:version_comparator/src/utils/results/data_result.dart';

class VersionComparator {
  static VersionComparator? _instance;

  VersionComparator._init();

  static Future<DataResult<VersionResponseModel>> get comparedVersion {
    _instance ??= VersionComparator._init();
    return _instance!._compareVersion();
  }

  Future<DataResult<VersionResponseModel>> _compareVersion() async {
    if (Platform.isAndroid) {
      final comparatorService = AndroidVersionCompareManager.httpService();

      return await comparatorService.getVersion();
    }

    throw Exception('Other platforms is not supported');
  }
}
