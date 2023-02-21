import 'package:flutter/material.dart';

import '../../../version_comparator.dart';
import '../../utils/mixins/launch_url_mixin.dart';

abstract class VersionDialogService with LaunchUrlMixin {
  Future<T?> showVersionDialog<T>({
    required BuildContext context,
    required VersionResponseModel versionModel,
    T? popResult,
    bool isUpdateRequired = false,
    bool isCancelActionVisible = true,
    VoidCallback? onAfterPopDialog,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
  });

  Future<T?> showCustomContentVersionDialog<T>({
    required BuildContext context,
    required VersionResponseModel versionModel,
    required Widget content,
    T? popResult,
    bool isUpdateRequired = false,
    bool isCancelActionVisible = true,
    VoidCallback? onAfterPopDialog,
  });

  Future<T?> showCustomVersionDialog<T>({
    required BuildContext context,
    required Widget dialog,
    bool isDismissible = true,
  });
}
