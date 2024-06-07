import 'package:url_launcher/url_launcher.dart';

import '../constants/constants.dart';
import '../results/result.dart';

mixin LaunchUrlMixin {
  Future<Result> launchStoreLink(String storeLink) async {
    if (await canLaunchUrl(Uri.parse(storeLink))) {
      final isLaunched = await launchUrl(Uri.parse(storeLink),
          mode: LaunchMode.externalApplication);
      return isLaunched
          ? Result.success()
          : Result.error(message: kErrorMessage.notLaunchUrl);
    } else {
      return Result.error(message: kErrorMessage.notLaunchUrl);
    }
  }
}
