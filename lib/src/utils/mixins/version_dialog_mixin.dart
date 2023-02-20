import 'package:flutter/material.dart';

import '../../models/version_response_model.dart';
import '../../services/abstracts/version_dialog_service.dart';

mixin VersionDialogMixin {
  VersionDialogService get dialogService;

  Future<T?> showSimpleVersionDialog<T>(
    BuildContext context,
    VersionResponseModel versionModel, {
    T? result,
    bool isUpdateRequired = false,
  }) async {
    return await dialogService.showVersionDialog<T>(
      context: context,
      popResult: result,
      versionModel: versionModel,
      isUpdateRequired: isUpdateRequired,
    );
  }
}
