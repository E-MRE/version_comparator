library version_comparator;

import 'dart:io';

import 'package:version_comparator/src/models/entities/entity_model.dart';
import 'package:version_comparator/src/models/entities/store_model.dart';
import 'package:version_comparator/src/models/version_response_model.dart';
import 'package:version_comparator/src/services/abstracts/json_to_version_response_service.dart';
import 'package:version_comparator/src/services/abstracts/version_compare_service.dart';
import 'package:version_comparator/src/services/concretes/android_version_compare_manager.dart';
import 'package:version_comparator/src/services/concretes/custom_version_compare_manager.dart';
import 'package:version_comparator/src/utils/results/data_result.dart';

abstract class BaseVersionComparator {
  VersionCompareService? get versionComparator;

  Future<DataResult<VersionResponseModel>> customVersionCompare<TData extends EntityModel<TData>>({
    required TData parseModel,
    required String currentAppVersion,
    required JsonToVersionResponseService jsonToVersionResponseService,
    required BaseStoreModel store,
    required String? query,
  });
}

class VersionComparator extends BaseVersionComparator {
  @override
  VersionCompareService? versionComparator;

  Future<DataResult<VersionResponseModel>> comparePlatformSpecific() async {
    if (Platform.isAndroid) {
      versionComparator = AndroidVersionCompareManager.httpService();

      return await versionComparator!.getVersion();
    }

    throw Exception('Other platforms is not supported');
  }

  @override
  Future<DataResult<VersionResponseModel>> customVersionCompare<TData extends EntityModel<TData>>({
    required TData parseModel,
    required String currentAppVersion,
    required JsonToVersionResponseService jsonToVersionResponseService,
    required BaseStoreModel store,
    required String? query,
  }) async {
    versionComparator = CustomVersionCompareManager.httpService(
        parseModel: parseModel,
        currentAppVersion: currentAppVersion,
        jsonToResponseService: jsonToVersionResponseService,
        store: store,
        query: query);

    return await versionComparator!.getVersion();
  }
}
