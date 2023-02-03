import '../../utils/constants/endpoint_constants.dart';

abstract class BaseStoreModel {
  final String storeUrl;

  BaseStoreModel({required this.storeUrl});
}

class StoreModel extends BaseStoreModel {
  StoreModel.custom({required super.storeUrl});

  StoreModel.android() : super(storeUrl: EndpointConstants.androidStoreUrl);

  StoreModel.ios() : super(storeUrl: EndpointConstants.iosStoreUrl);

  StoreModel.huawei(String appId) : super(storeUrl: EndpointConstants.huaweiVersionControlUrl);
}
