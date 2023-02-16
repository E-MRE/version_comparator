import 'comparator_error_message.dart';

class DefaultComparatorErrorMessage extends ComparatorErrorMessage {
  static DefaultComparatorErrorMessage? _instance;
  static DefaultComparatorErrorMessage get instance {
    _instance ??= DefaultComparatorErrorMessage._init();
    return _instance!;
  }

  DefaultComparatorErrorMessage._init();
}
