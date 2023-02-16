import 'comparator_info_message.dart';

class DefaultComparatorInfoMessage extends ComparatorInfoMessage {
  static DefaultComparatorInfoMessage? _instance;
  static DefaultComparatorInfoMessage get instance {
    _instance ??= DefaultComparatorInfoMessage._init();
    return _instance!;
  }

  DefaultComparatorInfoMessage._init();
}
