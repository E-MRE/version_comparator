import '../../../utils/constants/endpoint_constants.dart';
import 'base_store_model.dart';

class AndroidStoreModel extends BaseStoreModel {
  @override
  final String storeUrl;
  @override
  final String appId;
  @override
  final String versionQuery;

  AndroidStoreModel.custom(
      {required this.storeUrl,
      required this.appId,
      required this.versionQuery});

  AndroidStoreModel(String bundleId)
      : appId = bundleId,
        versionQuery = 'id=$bundleId',
        storeUrl = EndpointConstants.androidStoreUrl;
}
