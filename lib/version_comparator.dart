library version_comparator;

import 'dart:io';

import 'package:version_comparator/src/models/entities/entity_model.dart';
import 'package:version_comparator/src/models/parameters/custom_version_compare_parameter_model.dart';
import 'package:version_comparator/src/models/version_response_model.dart';
import 'package:version_comparator/src/services/abstracts/version_compare_service.dart';
import 'package:version_comparator/src/services/concretes/android_version_compare_manager.dart';
import 'package:version_comparator/src/services/concretes/custom_version_compare_manager.dart';
import 'package:version_comparator/src/utils/results/data_result.dart';

abstract class BaseVersionComparator {
  VersionCompareService? _versionComparator;
  VersionCompareService? get versionComparator => _versionComparator;

  void setVersionComparator(VersionCompareService service) {
    _versionComparator = service;
  }

  Future<DataResult<VersionResponseModel>> customVersionCompare<TData extends EntityModel<TData>>(
    CustomVersionCompareParameterModel<TData> parameterModel,
  ) async {
    setVersionComparator(CustomVersionCompareManager.httpService(
      parseModel: parameterModel.parseModel,
      currentAppVersion: parameterModel.currentAppVersion,
      jsonToResponseService: parameterModel.jsonToResponseService,
      store: parameterModel.store,
      query: parameterModel.query,
    ));

    return await versionComparator!.getVersion();
  }
}

class VersionComparator extends BaseVersionComparator {
  Future<DataResult<VersionResponseModel>> comparePlatformSpecific() async {
    if (Platform.isAndroid) {
      setVersionComparator(AndroidVersionCompareManager.httpService());

      return await versionComparator!.getVersion();
    }

    throw Exception('Other platforms is not supported');
  }
}
