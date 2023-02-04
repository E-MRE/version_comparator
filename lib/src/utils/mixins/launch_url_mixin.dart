import 'package:url_launcher/url_launcher.dart';

import '../enums/error_message.dart';
import '../results/result.dart';

mixin LaunchUrlMixin {
  Future<Result> launchStoreLink(String storeLink) async {
    if (await canLaunchUrl(Uri.parse(storeLink))) {
      final isLaunched = await launchUrl(Uri.parse(storeLink), mode: LaunchMode.externalApplication);
      return isLaunched ? Result.success() : Result.error(message: ErrorMessage.notLaunchUrl.message);
    } else {
      return Result.error(message: ErrorMessage.notLaunchUrl.message);
    }
  }
}
