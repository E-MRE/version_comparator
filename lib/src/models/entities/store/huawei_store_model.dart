import '../../../utils/constants/endpoint_constants.dart';
import 'base_store_model.dart';

class HuaweiStoreModel extends BaseStoreModel {
  @override
  final String storeUrl;
  @override
  final String appId;
  @override
  final String versionQuery;

  HuaweiStoreModel.custom(
      {required this.storeUrl,
      required this.appId,
      required this.versionQuery});

  HuaweiStoreModel(this.appId)
      : versionQuery = 'method=internal.getTabDetail&uri=app%7C$appId',
        storeUrl = EndpointConstants.huaweiVersionControlUrl;
}
