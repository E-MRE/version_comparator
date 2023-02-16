import '../../services/abstracts/version_convert_service.dart';
import '../entities/entity_model.dart';
import '../entities/store/base_store_model.dart';

class CustomVersionCompareParameterModel<TData extends EntityModel<TData>> {
  final TData parseModel;
  final String currentAppVersion;
  final VersionConvertService versionConvertService;
  final BaseStoreModel store;
  final String? Function(TData parseModel)? updateLinkGetter;

  CustomVersionCompareParameterModel({
    required this.parseModel,
    required this.currentAppVersion,
    required this.versionConvertService,
    required this.store,
    this.updateLinkGetter,
  });
}
