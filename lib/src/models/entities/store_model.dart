import '../../utils/constants/endpoint_constants.dart';

abstract class BaseStoreModel {
  final String baseUrl;
  final String endpoint;

  BaseStoreModel({required this.baseUrl, required this.endpoint});
}

class StoreModel extends BaseStoreModel {
  StoreModel.custom({required super.baseUrl, required super.endpoint});

  StoreModel.android()
      : super(
          baseUrl: EndpointConstants.androidStoreBaseUrl,
          endpoint: EndpointConstants.androidAppEndpoint,
        );

  StoreModel.ios()
      : super(
          baseUrl: EndpointConstants.iosStoreBaseUrl,
          endpoint: EndpointConstants.iosAppEndpoint,
        );

  StoreModel.huawei(String appId)
      : super(
          baseUrl: EndpointConstants.huaweiVersionControlBaseUrl,
          endpoint: EndpointConstants.huaweiVersionControlEndpoint,
        );
}
