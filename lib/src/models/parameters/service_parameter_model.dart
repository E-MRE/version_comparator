import '../../utils/constants/constants.dart';

abstract class ServiceParameterModel {
  final String url;
  final int timeout;
  final Map<String, String>? header;

  String getUrl();

  Duration get timeoutDuration => Duration(milliseconds: timeout.toInt());

  ServiceParameterModel({
    required this.url,
    this.timeout = kDefaultTimeout,
    this.header,
  });
}
