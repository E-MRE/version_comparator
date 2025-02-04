import '../messages/comparator_error_message.dart';
import '../messages/comparator_info_message.dart';
import '../messages/default_comparator_error_message.dart';
import '../messages/default_comparator_info_message.dart';

const String kEmpty = '';
const String kSpace = ' ';
const String kVersionSplitter = '.';
const String kAndroidManufacturer = 'GOOGLE';
const String kHuaweiManufacturer = 'HUAWEI';

const int kDefaultTimeout = 16000;
const int kZero = 0;
const int kHttpStatusOK = 200;

const double kLoadingWidgetSize = 40;
const double kMediumSpace = 16;
const double kTransparentBlack = 0.25;

ComparatorInfoMessage get kInfoMessage =>
    AppConstants.comparatorInfoMessage ?? DefaultComparatorInfoMessage.instance;

ComparatorErrorMessage get kErrorMessage =>
    AppConstants.comparatorErrorMessage ??
    DefaultComparatorErrorMessage.instance;

class AppConstants {
  static ComparatorInfoMessage? comparatorInfoMessage;
  static ComparatorErrorMessage? comparatorErrorMessage;

  static void setInfoMessage(ComparatorInfoMessage infoMessage) {
    comparatorInfoMessage = infoMessage;
  }

  static void setErrorMessage(ComparatorErrorMessage errorMessage) {
    comparatorErrorMessage = errorMessage;
  }
}
