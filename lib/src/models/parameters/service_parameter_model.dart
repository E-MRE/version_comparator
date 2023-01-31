import '../../utils/constants/constants.dart';

abstract class ServiceParameterModel {
  final String baseUrl;
  final String endpoint;
  final int timeout;
  final Map<String, String>? header;

  String getUrl();

  Duration get timeoutDuration => Duration(milliseconds: timeout.toInt());

  ServiceParameterModel({
    required this.baseUrl,
    required this.endpoint,
    this.timeout = kDefaultTimeout,
    this.header,
  });
}
