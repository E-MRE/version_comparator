import '../../../utils/constants/endpoint_constants.dart';
import 'base_store_model.dart';

class IosStoreModel extends BaseStoreModel {
  @override
  final String storeUrl;
  @override
  final String appId;
  @override
  final String versionQuery;

  IosStoreModel.custom({required this.storeUrl, required this.appId, required this.versionQuery});

  IosStoreModel(String bundleId)
      : appId = bundleId,
        versionQuery = 'bundleId=$bundleId',
        storeUrl = EndpointConstants.iosStoreUrl;
}
